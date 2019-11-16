{------------------------------------
  功能说明：
            1、座位图类TSeatPlan
                  描述：显示座位图
                  前置条件：A车辆品牌id
                            B座位状态seatsStatus（TDictionary<Word,String>）
                  输出：TWinControl
            2、座位图选择类TSeatPlanSelect
                  描述：显示座位图并提供选择座位功能
                  前置条件：A车辆品牌id
                            B座位状态seatsStatus（TDictionary<Word,String>）
                            C座位类型seatstype(TDictionary<Word, string>)
                            D可选座位总数 FselectSeatNum
                            E可选座位状态FselectSeatStatus:TList<string>;
                            F可选座位类型FselectSeattype:string;（普通座、豪华座、普通卧、豪华卧。。）
                            G【已选座位FselectedSeats:TList<Word>;】
                            H【选座位完成事件FOnSelectComplete: TNotifyEvent;】
                  输出：选中的座位号列表（TList<Word>）
            3、座位图编辑类TSeatPlanEdit
                  描述：显示座位图并提供编辑功能
            4、座位图装饰类TVehicleSeatPlanDecorator
                  描述：加上显示车头和车尾的功能

  创建日期：2011.2.25
  作者：ice
  版权：nova
-------------------------------------}
unit SeatPlan;

interface
uses Messages, Windows, SysUtils, Classes, Variants,
  Types, Graphics, Menus, Controls, Forms, StdCtrls, Mask,db,  ExtCtrls,
  Grids,Generics.Collections,Generics.Defaults,jpeg,Math,jsonClientDataSet,UDMPublic,PubFn,
  UFrmsetVehicleSpace,services, GdiPlus, GdiPlusHelpers;

type
  TSeatSelectEvent = procedure(seatno:word;ticketno:String;beforChecked:boolean;var afterChecked:boolean) of object;
  TSeatOnSelectEvent = procedure(seatno:word) of object;
  TOnSelectRowChangeEvent = procedure(acol,arow: Integer) of object;
  TStatusPicturePosition = (splefttop,sprighttop,sprightbottom,spleftbottom);
  TVehiclespace = class
    id:Int64;
    name:string;
    picture:TJPEGImage;
    ispassengerseat:Boolean;
    seattype:string;
  end;
  TVehicleseatplandetail = class
    id:int64;
    rowno:Byte;
    colno:Byte;
    width:Word;
    height:Word;
    space:TVehiclespace;
    seatno:Word;
    remarks:String;
    createby:Int64;
    createtime:String;
    updateby:Int64;
    updatetime:String;
  end;
  IVehicleSeatPlan = interface
    ['{C85309D7-F39F-4362-8A60-191ACCE5AB4D}']
    function getVehicleseatplandetail(row,col:Byte):TVehicleseatplandetail;
    function setParent(parent:TWinControl):TWinControl;

    function getShowspacename: Boolean;
    function getShowspacepicture: Boolean;
    procedure setShowspacename(const Value: Boolean);
    procedure setShowspacepicture(const Value: Boolean);
    function getSeatsStatus: TDictionary<Word, string>;
    procedure setSeatsStatus(const Value: TDictionary<Word, String>);
    function getSeatsTickettype: TDictionary<Word, string>;
    procedure setSeatsTickettype(const Value: TDictionary<Word, String>);
    function getBrandModelid: Int64;
    procedure setBrandModelid(const Value: Int64);
    function getActualwidth: Integer;
    function getActualheight: Integer;

    //座位状态：0空位、1锁定、2已售、3固定留位、4自动取消留位、5不自动取消留位、6选中、7检票、8开运量  取数据字典
    //0 1 3 4 5 都是空位  0无右下角的状态小图
    //2 7 8 都是已售 2无右下角的状态小图
    property seatsStatus:TDictionary<Word,String> read getSeatsStatus write setSeatsStatus;
    //座位已售票种 Q B X
    property seatsTickettype:TDictionary<Word,String> read getSeatsTickettype write setSeatsTickettype;
    //是否显示空间图片
    property showspacepicture:Boolean read getShowspacepicture write setShowspacepicture;
    //是否显示空间名称
    property showspacename:Boolean read getShowspacename write setShowspacename;
    //实际宽度
    property actualwidth:Integer read getActualwidth;
    //实际高度
    property actualheight:Integer read getActualheight;
    //品牌型号ID
    property brandModelid:Int64 read getBrandModelid write setBrandModelid;
  end;
  TSeatPlan = class(TStringGrid,IVehicleSeatPlan)
  private
    FBrandModelid:Int64;
    FBrandModelSeatnum:integer;//用于与实际座位数对比

    Fvehicleseatplandetails:TList<TVehicleseatplandetail>;
    Fshowspacepicture:Boolean;
    Fshowspacename:Boolean;
    FseatsState:TDictionary<Word, String>;
    FseatsTickettype:TDictionary<Word, String>;  //座位售票票种
    FFrmsetVehicleSpace: TFrmsetVehicleSpace;

    Fdefaultcellwidth:integer;
    Fdefaultcellheight:integer;
    Fdefaultcolcount:integer;
    Fseatshint:TDictionary<Word,String>;  //座位的提示信息
    BalloonHint:TBalloonHint;
    cellhint:String;
    curhintcol,curhintrow:integer;
    FOnSelectRowChangeEvent:TOnSelectRowChangeEvent;
    FStatusPicturePosition:TStatusPicturePosition;
    FCellBottomlinenum:Integer; //单元格底部文字行数
    procedure setvehicleseatplandetails(avalue: TList<TVehicleseatplandetail>);
    procedure initDefaultSeatPlan;//当无座位图时，根据SeatsStatus画出默认的座位表
    function getSeatshint: TDictionary<Word,String>;
    procedure setSeatshint(const Value: TDictionary<Word,String>);

  protected
    FisLocateTriggerSelectEvent:Boolean; //是否自动定位选中
    function getdisplaypicture(row,col:Byte):TGraphic;dynamic;//按位置取出要显示的大图
    function getStatusPicture(row,col:Byte):TBitmap; dynamic; //按位置取出要显示的小图
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    function SelectCell(ACol, ARow: Integer): Boolean; override;
    //取出底部字符串
    function getCellBottomText(ACol, ARow: Integer):string;dynamic;
    procedure showcellhint(ACol, ARow: Longint);
    property vehicleseatplandetails:TList<TVehicleseatplandetail> read Fvehicleseatplandetails write setvehicleseatplandetails;
    //选择行改变事件
    property OnSelectRowChangeEvent:TOnSelectRowChangeEvent read FOnSelectRowChangeEvent write FOnSelectRowChangeEvent;
    //在一个区域中智能输出文本
    procedure DrawTextInRectIntelligence(text:string;rect:TRect);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //取当前选中的框的座位号
    function getFocusCellSeatNo():Word;
    //按位置取出座位号
    function getSeatNo(row,col:Byte):Word;
    //按位置取出要显示的座位号信息（座位号或备注）
    function getSeatNoStr(row,col:Byte):String;overload;
    //按座位号取出要显示的座位号信息（座位号或备注）
    function getSeatNoStr(_seatno:Word):String;overload;

    function getVehicleseatplandetail(row,col:Byte):TVehicleseatplandetail;
    //按座位号定位到CELL
    function locateBySeatNo(seatno:Byte;triggerSelectEvent:Boolean=True):Boolean;
    function setParent(parent:TWinControl):TWinControl;

    function getShowspacename: Boolean;
    procedure setShowspacename(const Value: Boolean);
    function getShowspacepicture: Boolean;
    procedure setShowspacepicture(const Value: Boolean);
    function getSeatsStatus: TDictionary<Word, string>;
    procedure setSeatsStatus(const Value: TDictionary<Word, String>);
    function getSeatsTickettype: TDictionary<Word, string>;
    procedure setSeatsTickettype(const Value: TDictionary<Word, String>);
    function getBrandModelid: Int64;
    procedure setBrandModelid(const Value: Int64);
    function getActualwidth: Integer;
    function getActualheight: Integer;

    //座位状态
    property seatsStatus:TDictionary<Word,String> read getSeatsStatus write setSeatsStatus;
    //座位已售票种
    property seatsTickettype:TDictionary<Word,String> read getSeatsTickettype write setSeatsTickettype;
    //是否显示空间图片
    property showspacepicture:Boolean read getShowspacepicture write setShowspacepicture;
    //是否显示空间名称
    property showspacename:Boolean read getShowspacename write setShowspacename;
    //实际宽度
    property actualwidth:Integer read getActualwidth;
    //实际高度
    property actualheight:Integer read getActualheight;
    //品牌型号ID
    property brandModelid:Int64 read getBrandModelid write setBrandModelid;
    //所有座位的提示字符串
    property seatshint:TDictionary<Word,String> read getSeatshint write setSeatshint;
    //默认列宽
    property defaultcellwidth:integer read Fdefaultcellwidth write Fdefaultcellwidth;
    //默认列高
    property defaultcellheight:integer read Fdefaultcellheight write Fdefaultcellheight;
    //默认列数
    property defaultcolcount:integer read Fdefaultcolcount write Fdefaultcolcount;
    //状态图显示位置
    property StatusPicturePosition:TStatusPicturePosition read FStatusPicturePosition write FStatusPicturePosition;
    //单元格底部文字行数
    property CellBottomlinenum:Integer read FCellBottomlinenum write FCellBottomlinenum;
  end;

  IVehicleSeatPlanEdit = interface(IVehicleSeatPlan)
  ['{F1EA98C9-76D4-4674-90D6-10002CE1CA95}']
    function addrow(num:Byte=1):Byte;
    function addcol(num:byte=1):byte;
    function delrow(rowno:Byte):Byte;
    function delcol(colno:Byte):Byte;
    //设置座位空间
    function setSpace(arow,acol:Byte):TVehicleseatplandetail;
    function clearspace(arow,acol:Byte):TVehicleseatplandetail;
    function save():Boolean;

    function getRationseatnum: Word;
    procedure setRationseatnum(const Value: Word);
    function getOnSizeChange:TNotifyEvent;
    procedure setOnSizeChange(const value:TNotifyEvent);
    property rationseatnum:Word read getRationseatnum write setRationseatnum;
    property OnSizeChange: TNotifyEvent read getOnSizeChange write setOnSizeChange;
  end;

  TSeatPlanEdit = class(TSeatPlan,IVehicleSeatPlanEdit)
  private
    Frationseatnum:Word;
    editrow:Integer;
    editcol:integer;
    miseparate:TMenuItem;
    miaddrow: TMenuItem;
    miaddcol: TMenuItem;
    midelrow: TMenuItem;
    midelcol: TMenuItem;
    misetspace: TMenuItem;
    miclearspace: TMenuItem;
    emptydetails:TjsonClientDataSet;  //用于批量提交数据   动态创建参数的执行速度太慢
    procedure miaddrowClick(Sender: TObject);
    procedure miaddcolClick(Sender: TObject);
    procedure midelrowClick(Sender: TObject);
    procedure midelcolClick(Sender: TObject);
    procedure misetspaceClick(Sender: TObject);
    procedure miclearspaceClick(Sender: TObject);
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DblClick; override;
    procedure ColWidthsChanged; override;
    procedure RowHeightsChanged; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function addrow(num:Byte=1):Byte;
    function addcol(num:byte=1):byte;
    function delrow(rowno:Byte):Byte;
    function delcol(colno:Byte):Byte;
    //设置座位空间
    function setSpace(arow,acol:Byte):TVehicleseatplandetail;
    function clearspace(arow,acol:Byte):TVehicleseatplandetail;
    function save():Boolean;

    function getRationseatnum: Word;
    procedure setRationseatnum(const Value: Word);
    function getOnSizeChange:TNotifyEvent;
    procedure setOnSizeChange(const value:TNotifyEvent);
    property rationseatnum:Word read getRationseatnum write setRationseatnum;
    property OnSizeChange: TNotifyEvent read getOnSizeChange write setOnSizeChange;
  end;

  IVehicleSeatPlanSelect = interface(IVehicleSeatPlan)
  ['{EAC497AE-906F-4C5C-BD8E-06FE4F2111A5}']
    function getSelectSeatStatus:TList<string>;
    procedure setSelectSeatStatus(const selectSeatStatus:TList<string>);
    function getSelectSeatNum:Word;
    procedure setSelectSeatNum(const selectSeatNum:Word);
    function getSelectSeattype:String;
    procedure setSelectSeattype(const selectSeattype:string);
    function getSelectedSeats:TList<Word>;
    procedure setSelectedSeats(const selectSeats:TList<Word>);
    function getOnSelectComplete:TNotifyEvent;
    procedure setOnSelectComplete(const onSelectComplete:TNotifyEvent);
    //可选座位状态
    property selectSeatStatus:TList<string> read getSelectSeatStatus write setSelectSeatStatus;
    //可选座位数
    property selectSeatNum:Word read getSelectSeatNum write setSelectSeatNum;
    //可选座位类型
    property selectSeattype:string read getSelectSeattype write setSelectSeattype;
    //已经选中的座位列表
    property selectedSeats:TList<Word> read getSelectedSeats write setSelectedSeats;
    //选位完成事件
    property OnSelectComplete: TNotifyEvent read getOnSelectComplete write setOnSelectComplete;
  end;

  TSeatPlanSelect = class(TSeatPlan,IVehicleSeatPlanSelect)
  private
    FOnSelectSeatno: TSeatOnSelectEvent;
    FselectSeatStatus:TList<string>;
    FselectSeatNum:Word;
    FselectSeattype:string;
    FselectedSeats:TList<Word>;
    FOnSelectComplete: TNotifyEvent;
    Fseatstype:TDictionary<Word, string>; //座位表时存储座位类型
    Fseatscolor:TDictionary<Word, string>; //座位表时存储座位颜色
    Fseatsreachstationname:TDictionary<Word,String>; //座位到站
    FallowSelectByHand:Boolean;//是否允许手动选择座位
    function getCanSelect(arow,acol:Integer):Boolean;
    //当前选中座位LIST改变通知事件
    procedure SelectChangeNotify(Sender: TObject; const Item: Word;Action: TCollectionNotification);
    //取出所有连续的座位
    function getCanSelectSerialseats:TList<TList<Word>>;
    //检查选中的座位是否符合条件
    function checkSelectSeat:boolean;
    function getSeatsreachstationname: TDictionary<Word,String>;
    procedure setSeatsreachstationname(const Value: TDictionary<Word,String>);
  protected
    //选择空间
    function CellSelected(ACol, ARow: Integer):boolean;dynamic;
    //按位置取出要显示的小图
    function getStatusPicture(row,col:Byte):TBitmap; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
//    procedure Click; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure AddLayerMask(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState);
    //取出底部字符串
    function getCellBottomText(ACol, ARow: Integer):string;override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    //自动选位 isserial是否选择连续座位
    function autoSelectSeats(isserial:Boolean=false):Boolean;

    function getCanSelectSeatNum:word;
    function getSelectSeatStatus:TList<string>;
    procedure setSelectSeatStatus(const selectSeatStatus:TList<string>);
    function getSelectSeatNum:Word;
    procedure setSelectSeatNum(const selectSeatNum:Word);
    function getSelectSeattype:String;
    procedure setSelectSeattype(const selectSeattype:string);
    function getSelectedSeats:TList<Word>;
    procedure setSelectedSeats(const selectSeats:TList<Word>);
    function getOnSelectComplete:TNotifyEvent;
    procedure setOnSelectComplete(const onSelectComplete:TNotifyEvent);

    //可选座位状态
    property selectSeatStatus:TList<string> read getSelectSeatStatus write setSelectSeatStatus;
    //可选座位数
    property selectSeatNum:Word read getSelectSeatNum write setSelectSeatNum;
    //可选座位类型
    property selectSeattype:string read getSelectSeattype write setSelectSeattype;
    //已经选中的座位列表
    property selectedSeats:TList<Word> read getSelectedSeats write setSelectedSeats;
    //选位完成事件
    property OnSelectComplete: TNotifyEvent read getOnSelectComplete write setOnSelectComplete;
    //所有座位号对应座位类型列表
    property seatstype:TDictionary<Word, string> read Fseatstype write Fseatstype;
    //选中座位事件
    property OnSelectSeatno:TSeatOnSelectEvent read FOnSelectSeatno write FOnSelectSeatno;
    //所有座位到站
    property seatsreachstationname:TDictionary<Word,String> read getSeatsreachstationname write setSeatsreachstationname;
    //是否允许手动选位（键盘、鼠标）
    property allowSelectByHand:Boolean read FallowSelectByHand write FallowSelectByHand;
        //所有座位号对应颜色
    property seatscolor:TDictionary<Word, string> read Fseatscolor write Fseatscolor;
  end;

  TSeatPlanChecked = class(TSeatPlanSelect)
  private
    FOnSelectSeat: TSeatSelectEvent;
    FOnDbClickSeat: TSeatSelectEvent;
//    FCheckedSeats:TDictionary<Word, boolean>; //座位检票状态
    Fseatsticketno:TDictionary<Word,String>; //座位票号
    function getSeatsticketno: TDictionary<Word,String>;
    procedure setSeatsticketno(const Value: TDictionary<Word,String>);
  protected
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect;
      AState: TGridDrawState); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure DblClick; override;
    function ischecked(row,col:Byte):boolean; //按位置取出是否已检
    function getStatusPicture(row,col:Byte):TBitmap; override; //按位置取出要显示的小图
    function CellSelected(ACol, ARow: Integer):boolean;override;  //选择空间
    //取出底部字符串
    function getCellBottomText(ACol, ARow: Integer):string;override;
  public
    //按票号定位到CELL
    function locateByTicketNo(ticketno:String;triggerSelectEvent:Boolean=True):Boolean;
    //选中座位事件
    property OnSelectSeat:TSeatSelectEvent read FOnSelectSeat write FOnSelectSeat;
    //双击座位事件
    property OnDbClickSeat:TSeatSelectEvent read FOnDbClickSeat write FOnDbClickSeat;
    //所有座位票号
    property seatsticketno:TDictionary<Word,String> read getSeatsticketno write setSeatsticketno;
  end;

  //对IVehicleSeatPlan的实现类进行外观包装，加上显示车头车身车尾功能
  TVehicleSeatPlanDecorator = class(Tpanel,IVehicleSeatPlan)
  private
    Fvehicleseatplan:IVehicleSeatPlan;
    imghead: TImage;
    imgtail: TImage;
    imgtailleft: TImage;
    imgleftside:TImage;
    imgrightside:TImage;

    imgheadright: TImage;
    imgheadleft: TImage;
    imgtailright: TImage;

    imgSteering: TImage;

    procedure layoutItems;
    procedure seatPlanSizeChange(Sender: TObject);
    //在选中行变化时，改变VertScrollBar.Position
    procedure SelectRowChange(acol,arow: Integer);
  public
    constructor Create(AOwner: TComponent;vehicleseatplan:IVehicleSeatPlan); dynamic;
    destructor Destroy; override;

    {IVehicleSeatPlan}
    function getVehicleseatplandetail(row,col:Byte):TVehicleseatplandetail;
    function setParent(parent:TWinControl):TWinControl;

    function getShowspacename: Boolean;
    function getShowspacepicture: Boolean;
    procedure setShowspacename(const Value: Boolean);
    procedure setShowspacepicture(const Value: Boolean);
    function getSeatsStatus: TDictionary<Word, string>;
    procedure setSeatsStatus(const Value: TDictionary<Word, String>);
    function getSeatsTickettype: TDictionary<Word, string>;
    procedure setSeatsTickettype(const Value: TDictionary<Word, String>);
    function getBrandModelid: Int64;
    procedure setBrandModelid(const Value: Int64);
    function getActualwidth: Integer;
    function getActualheight: Integer;

    property seatsStatus:TDictionary<Word,String> read getSeatsStatus write setSeatsStatus;
    property seatsTickettype:TDictionary<Word,String> read getSeatsTickettype write setSeatsTickettype;
    property showspacepicture:Boolean read getShowspacepicture write setShowspacepicture;
    property showspacename:Boolean read getShowspacename write setShowspacename;
    property actualwidth:Integer read getActualwidth;
    property actualheight:Integer read getActualheight;
    property brandModelid:Int64 read getBrandModelid write setBrandModelid;

  end;

  TListCountComparer<T> = class(TComparer<TList<Word>>)
    function Compare(const Left, Right: TList<Word>): Integer; override;
  end;

  TDrawProc  =  procedure(ACol, ARow: Integer; ARect: TRect; AState: TGridDrawState)   of   object;


  TSeatPicHelp = Class(TObject)
  private
    jcdsQryScheduleSeatstatus, jcdsQrySeatstatus: TjsonClientDataSet;
  protected

  public
    checktickets, unchecktickets: integer;
    selectSeatStatus: TList<string>;
    seatscolor: TDictionary<Word, String>;
    seatstype: TDictionary<Word, String>;
    seatsStatus: TDictionary<Word, String>;
    seatsTickettype: TDictionary<Word, String>;
    seatticketno: TDictionary<Word, String>;
    seatStation: TDictionary<Word, String>;
    seatCanCheck: TList<Word>;
    seatshint: TDictionary<Word, String>;
    Constructor Create;
    destructor Destroy;override;
    // 根据班次ID取班次座位状态
    procedure qryScheduleSeatstatus(scheduleplanid: int64);
    // 查询座位图的信息
    procedure qrySeatstatus(scheduleplanid: int64; isshowseathint: boolean);
  End;

implementation

const
//      defaultcellwidth=40;
//      defaultcellheight=55;
//      defaultcolcount=13;
      defaultrowcount=6;
      adjustWidth=2;

      vehiclehead_picturename = 'images\vehiclehead.bmp';
      vehicletail_picturename = 'images\vehicletail.bmp';
      vehicleleftside_picturename = 'images\vehicleleftside.bmp';
      vehiclerightside_picturename = 'images\vehiclerightside.bmp';

      vehicleheadright_picturename = 'images\vehicleheadright.bmp';
      vehicleheadleft_picturename = 'images\vehicleheadleft.bmp';
      vehicletailright_picturename = 'images\vehicletailright.bmp';
      vehicletailleft_picturename = 'images\vehicletailleft.bmp';

      vehicleSteering_picturename = 'images\vehicleSteering.bmp';

      checkMarkPicturename = 'images\checkmark.bmp';

var //车辆内部空间类型
    vehiclespaces:TList<TVehiclespace>;
    //空间售出状态车票类型图片
    spacesoldpicture:TDictionary<Int64, TDictionary<string, TJPEGImage>>;
    //默认非售出状态图片
    statuspicture:TDictionary<string, TBitmap>;
    //默认售出状态车票类型图片
    soldpicture:TDictionary<string, TJPEGImage>;

//procedure TSeatPlan.initvehiclespaces;
procedure initvehiclespaces;
var jcds:TjsonClientDataSet;
    vehiclespace:TVehiclespace;
begin
  if Assigned(vehiclespaces) then exit;

  vehiclespaces:=TList<TVehiclespace>.Create;
  jcds:=TjsonClientDataSet.Create(nil);
  with jcds do
  begin
    try
      Active:=false;
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='vehiclespacelist';
      QueryAddress:='base/findVehiclespace';
      Active:=true;
      while not Eof do
      begin
        vehiclespace:=TVehiclespace.Create;
        with vehiclespace do
        begin
          id:=FieldByName('id').AsLargeInt;
          name:=FieldByName('name').AsString;
          ispassengerseat:=StrToBool(FieldByName('ispassengerseat').AsString);
          seattype:=FieldByName('seattype').AsString;
          if (FieldByName('picture').Value<>Null) and (FieldByName('picture').AsString<>'') then
          begin
            picture:=HexStrToJpg(FieldByName('picture').AsString);
          end
          else
          begin
            picture:=nil;
          end;;
        end;
        vehiclespaces.Add(vehiclespace);
        next;
      end;
    finally
      free;
    end;
  end;
end;

//procedure TSeatPlan.initSoldpicture;
procedure initSoldpicture;
var jcds:TjsonClientDataSet;
begin
  if Assigned(soldpicture) then exit;

  jcds:=TjsonClientDataSet.Create(nil);
  with jcds do
  begin
    try
      Active:=false;
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='tickettypemap';
      QueryAddress:='base/findTickettype';
      Active:=true;
      if recordcount>0 then
      begin
        soldpicture:=TDictionary<string, TJPEGImage>.Create;
      end;
      while not Eof do
      begin
        soldpicture.AddOrSetValue(FieldByName('code').AsString,HexStrToJpg(fieldbyname('soldpicture').AsString));
        next;
      end;
    finally
      free;
    end;
  end;
end;

//procedure TSeatPlan.initSpacesoldpicture;
procedure initSpacesoldpicture;
var jcds:TjsonClientDataSet;
    _soldpicture:TDictionary<string, TJPEGImage>;
begin
  if Assigned(spacesoldpicture) then exit;

  jcds:=TjsonClientDataSet.Create(nil);
  with jcds do
  begin
    try
      Active:=false;
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='vehiclespacesoldpicturemap';
      QueryAddress:='base/qryvehiclespacesoldpicture';
      Active:=true;
      if recordcount>0 then
      begin
        spacesoldpicture:=TDictionary<Int64, TDictionary<string, TJPEGImage>>.Create;
      end;
      while not Eof do
      begin
        if spacesoldpicture.ContainsKey(FieldByName('vehiclespaceid').AsLargeInt) then
        begin
          _soldpicture := spacesoldpicture.Items[FieldByName('vehiclespaceid').AsLargeInt];
          _soldpicture.Add(FieldByName('tickettypecode').AsString,HexStrToJpg(fieldbyname('soldpicture').AsString));
        end
        else
        begin
          _soldpicture := TDictionary<string, TJPEGImage>.Create;
          _soldpicture.Add(FieldByName('tickettypecode').AsString,HexStrToJpg(fieldbyname('soldpicture').AsString));
          spacesoldpicture.Add(FieldByName('vehiclespaceid').AsLargeInt,_soldpicture);
        end;
        next;
      end;
    finally
      Free;
    end;
  end;
end;

//procedure TSeatPlan.initStatuspicturee;
procedure initStatuspicturee;
var jcds:TjsonClientDataSet;
begin
  if Assigned(statuspicture) then exit;

  jcds:=TjsonClientDataSet.Create(nil);
  with jcds do
  begin
    try
      Active:=false;
      RemoteServer:=DMPublic.jcon;
      DataSourceName:='seatstatuspicturemap';
      QueryAddress:='base/qryseatstatuspicture';
      Active:=true;
      if recordcount>0 then
      begin
        statuspicture:=TDictionary<string, TBitmap>.Create;
      end;
      while not Eof do
      begin
        statuspicture.AddOrSetValue(FieldByName('seatstatus').AsString,HexStrToGraphic(fieldbyname('picture').AsString));
        next;
      end;
    finally
      free;
    end;
  end;
end;



{ TSeatPlan }

function TSeatPlanEdit.addcol(num: byte=1): byte;
begin
  self.ColCount:=self.ColCount+num;
  Result:=self.ColCount;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

function TSeatPlanEdit.addrow(num: Byte=1): Byte;
begin
  self.RowCount:=self.RowCount+num;
  Result:=self.RowCount;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

function TSeatPlanEdit.clearspace(arow, acol: Byte): TVehicleseatplandetail;
var vehicleseatplandetail:TVehicleseatplandetail;
begin
  vehicleseatplandetail:=self.getVehicleseatplandetail(arow,acol);
  if vehicleseatplandetail<>nil then
  begin
    vehicleseatplandetails.Remove(vehicleseatplandetail);
    self.Refresh;
  end;
  Result:=vehicleseatplandetail;
end;

procedure TSeatPlanEdit.ColWidthsChanged;
var vehicleseatplandetail:TVehicleseatplandetail;
begin
  if vehicleseatplandetails<>nil then
  begin
    for vehicleseatplandetail in vehicleseatplandetails do
    begin
      vehicleseatplandetail.width:=self.ColWidths[vehicleseatplandetail.colno];
    end;
    self.Repaint;
  end;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

constructor TSeatPlanEdit.Create(AOwner: TComponent);
begin
  inherited;
  rationseatnum:=0;
  //第一行和第一列用来调整宽和高
  RowHeights[0]:=adjustWidth;
  ColWidths[0]:=adjustWidth;
  miaddrow:=TMenuItem.Create(Self);
  miaddrow.Caption:='添加行';
  miaddrow.OnClick:=miaddrowClick;
  miaddcol:=TMenuItem.Create(Self);
  miaddcol.Caption:='添加列';
  miaddcol.OnClick:=miaddcolClick;
  midelrow:=TMenuItem.Create(Self);
  midelrow.Caption:='删除行';
  midelrow.OnClick:=midelrowClick;
  midelcol:=TMenuItem.Create(Self);
  midelcol.Caption:='删除列';
  midelcol.OnClick:=midelcolClick;
  misetspace:=TMenuItem.Create(Self);
  misetspace.Caption:='设置空间类型';
  misetspace.OnClick:=misetspaceClick;
  miclearspace:=TMenuItem.Create(Self);
  miclearspace.Caption:='删除空间';
  miclearspace.OnClick:=miclearspaceClick;
  miseparate:=TMenuItem.Create(Self);
  miseparate.Caption:='-';
  emptydetails:=TjsonClientDataSet.Create(self);
  //查询一个空的座位图明细数据集出来
  with emptydetails do
  begin
    Active:=false;
    RemoteServer:=DMPublic.jcon;
    DataSourceName:='vehicleseatplandetaillist';
    QueryAddress:='base/findVehicleseatplandetail';
    SaveAddress:='base/saveVehicleseatplan';
    UpdateDataSet:='saveVehicleseatplandetails';
    Params.CreateParam(ftString,'vehicleseatplan.vehiclebrandmodelid',ptInput);
    Params.CreateParam(ftInteger,'flag',ptOutput);
    Params.CreateParam(ftString,'msg',ptOutput);
    Params.ParamValues['vehicleseatplan.vehiclebrandmodelid']:=0;
    Active:=true;
  end;
end;

procedure TSeatPlanEdit.DblClick;
var popupMenu:TPopupMenu;
    p:TPoint;
    _col,_row:integer;
begin
  inherited;
  //取当前的位置
  p:=ScreenToClient(Mouse.CursorPos);
  self.MouseToCell(p.x,p.y,_col,_row);
  setSpace(_row,_col);
end;

function TSeatPlanEdit.delcol(colno: Byte): Byte;
var vehicleseatplandetail:TVehicleseatplandetail;
begin
  if (colno=0) then exit;
  //删除此列明细数据
  for vehicleseatplandetail in vehicleseatplandetails do
  begin
    if vehicleseatplandetail.colno=colno then
    begin
      //删除
      vehicleseatplandetails.Remove(vehicleseatplandetail);
    end
    else if vehicleseatplandetail.colno>colno then
    begin
      //修改
      vehicleseatplandetail.colno:=vehicleseatplandetail.colno-1;
    end;
  end;
  vehicleseatplandetails:=vehicleseatplandetails;
  Result:=self.ColCount;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

function TSeatPlanEdit.delrow(rowno: Byte): Byte;
var vehicleseatplandetail:TVehicleseatplandetail;
begin
  if (Rowno=0) then exit;
  //删除此行明细数据
  for vehicleseatplandetail in vehicleseatplandetails do
  begin
    if vehicleseatplandetail.rowno=rowno then
    begin
      //删除
      vehicleseatplandetails.Remove(vehicleseatplandetail);
    end
    else if vehicleseatplandetail.rowno>rowno then
    begin
      //修改
      vehicleseatplandetail.rowno:=vehicleseatplandetail.rowno-1;
    end;
  end;
  vehicleseatplandetails:=vehicleseatplandetails;
  Result:=self.RowCount;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

destructor TSeatPlanEdit.Destroy;
begin
  if Assigned(FFrmsetVehicleSpace) then
  begin
    FFrmsetVehicleSpace.Free;
  end;
  inherited;
end;

function TSeatPlanEdit.getOnSizeChange: TNotifyEvent;
begin
  Result:=self.OnResize;
end;

function TSeatPlanEdit.getRationseatnum: Word;
begin
  result:=Frationseatnum;
end;

procedure TSeatPlanEdit.miaddcolClick(Sender: TObject);
begin
  self.addcol(1);
end;

procedure TSeatPlanEdit.miaddrowClick(Sender: TObject);
begin
  self.addrow(1);
end;

procedure TSeatPlanEdit.miclearspaceClick(Sender: TObject);
begin
  if (editcol<=0) or (editrow<=0) then exit;
  if not SysDialogs.Confirm('提示','确定要删除该空间吗？') then
  begin
    exit;
  end;
  self.clearspace(editrow,editcol);
end;

procedure TSeatPlanEdit.midelcolClick(Sender: TObject);
begin
  if (editcol=0) then exit;
  if not SysDialogs.Confirm('提示','确定要删除该列吗？') then
  begin
    exit;
  end;
  Self.delcol(editcol);
end;

procedure TSeatPlanEdit.midelrowClick(Sender: TObject);
begin
  if (editrow=0) then exit;
  if not SysDialogs.Confirm('提示','确定要删除该行吗？') then
  begin
    exit;
  end;
  Self.delrow(editrow);
end;

procedure TSeatPlanEdit.misetspaceClick(Sender: TObject);
begin
  setSpace(editrow,editcol);
end;

procedure TSeatPlanEdit.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var popupMenu:TPopupMenu;
    p:TPoint;
    vehicleseatplandetail:TVehicleseatplandetail;
begin
  //右键弹出菜单编辑
  if Button = mbRight then
  begin
    //取当前的位置
    p:=ScreenToClient(Mouse.CursorPos);
    self.MouseToCell(p.x,p.y,editcol,editrow);
    if self.PopupMenu<>nil then
    begin
      popupMenu:=self.PopupMenu;
    end
    else
    begin
      popupMenu:=TPopupMenu.Create(self);
    end;
    if popupMenu.Items.IndexOf(miseparate)<0 then
      popupMenu.Items.Insert(0,miseparate);
    if popupMenu.Items.IndexOf(miaddrow)<0 then
      popupMenu.Items.Insert(0,miaddrow);
    if popupMenu.Items.IndexOf(miaddcol)<0 then
      popupMenu.Items.Insert(0,miaddcol);
    if popupMenu.Items.IndexOf(midelrow)<0 then
      popupMenu.Items.Insert(0,midelrow);
    if popupMenu.Items.IndexOf(midelcol)<0 then
      popupMenu.Items.Insert(0,midelcol);
    if (editrow>=1) and (editcol>=1) then
    begin
      if popupMenu.Items.IndexOf(misetspace)<0 then
        popupMenu.Items.Insert(0,misetspace);

      vehicleseatplandetail:=self.getVehicleseatplandetail(editrow,editcol);
      if vehicleseatplandetail<>nil then
      begin
        if popupMenu.Items.IndexOf(miclearspace)<0 then
          popupMenu.Items.Insert(0,miclearspace);
      end
      else
      begin
        if popupMenu.Items.IndexOf(miclearspace)>=0 then
          popupMenu.Items.Delete(popupMenu.Items.IndexOf(miclearspace));
      end;
    end
    else
    begin
      if popupMenu.Items.IndexOf(misetspace)>=0 then
        popupMenu.Items.Delete(popupMenu.Items.IndexOf(misetspace));
      if popupMenu.Items.IndexOf(miclearspace)>=0 then
        popupMenu.Items.Delete(popupMenu.Items.IndexOf(miclearspace));
    end;
    self.popupMenu:=PopupMenu;
  end;
  inherited;
end;

procedure TSeatPlanEdit.RowHeightsChanged;
var vehicleseatplandetail:TVehicleseatplandetail;
begin
  if vehicleseatplandetails<>nil then
  begin
    for vehicleseatplandetail in vehicleseatplandetails do
    begin
      vehicleseatplandetail.height:=self.RowHeights[vehicleseatplandetail.rowno];
    end;
    self.Repaint;
  end;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

constructor TSeatPlan.Create(AOwner: TComponent);
begin
  inherited;
  FCellBottomlinenum:=1;
  FisLocateTriggerSelectEvent:=True;
  curhintcol:=-1;
  curhintrow:=-1;
  if Fdefaultcellwidth=0 then
  begin
    Fdefaultcellwidth:=StrToIntDef(PubFn.getParametervalue('0004',SysInfo.LoginUserInfo.OrgID),40);
    Fdefaultcellheight:=StrToIntDef(PubFn.getParametervalue('0005',SysInfo.LoginUserInfo.OrgID),55);
    Fdefaultcolcount:=StrToIntDef(PubFn.getParametervalue('0003',SysInfo.LoginUserInfo.OrgID),15)+1;
  end;
  FBrandModelSeatnum:=0;
  BorderStyle:=bsNone;
  Options:=Options+[goRowSizing,goColSizing]-[goRangeSelect]+[goDrawFocusSelected];
//  self.DefaultDrawing:=false;
  showspacepicture:=true;
  showspacename:=true;
  //初始化空间类型
  initvehiclespaces();
  BrandModelid:=0;
  self.DefaultColWidth:=Fdefaultcellwidth;
  self.DefaultRowHeight:=Fdefaultcellheight;
  //第一行隐藏
  RowCount:=defaultrowcount;
  ColCount:=Fdefaultcolcount;
  FixedCols:=1;
  FixedRows:=1;
  RowHeights[0]:=0;
  ColWidths[0]:=0;
  FStatusPicturePosition:=sprighttop;
end;

destructor TSeatPlan.Destroy;
begin
 { if Assigned(seatsStatus) then
  begin
    seatsStatus.free;
    seatsStatus:=nil;
  end; }
  inherited;
end;

procedure TSeatPlan.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var vehicleseatplandetail : TVehicleseatplandetail;
    ix,iy:integer;
    text:string;
    spacepicture:TGraphic;
    textheight:integer;
    StretchDrawRect,statusDrawRect:TRect;
    statusPicture:TBitmap;
    bottomrect:TRect;
begin
  Canvas.FillRect(ARect);
  if (ACol=0) or (ARow=0) then exit;
  textheight:=Canvas.TextHeight('余')*CellBottomlinenum;
  vehicleseatplandetail:=getVehicleseatplandetail(ARow,ACol);
  //画空间图
  if showspacepicture then
  begin
    spacepicture:=self.getdisplaypicture(ARow,ACol);
    if spacepicture<>nil then
    begin
      iX := aRect.Left + (aRect.Right - aRect.Left - spacepicture.Width) div 2;
      iY := aRect.Top + (aRect.Bottom - aRect.Top - textheight - spacepicture.Height) div 2;
      if (ix<aRect.Left) or (iy<aRect.Top) then
      begin
        if spacepicture.Width/spacepicture.Height>(aRect.Right - aRect.Left)/(aRect.Bottom - aRect.Top- textheight) then
        begin
          StretchDrawRect.Left:=ARect.Left;
          StretchDrawRect.Right:=ARect.Right;
          StretchDrawRect.Top:=aRect.Top
                              + (aRect.Bottom - aRect.Top - textheight
                                 -trunc(spacepicture.Height*(StretchDrawRect.Right-StretchDrawRect.Left)/spacepicture.Width)
                                ) div 2;
          StretchDrawRect.Bottom:= StretchDrawRect.Top+trunc(spacepicture.Height*(StretchDrawRect.Right-StretchDrawRect.Left)/spacepicture.Width);
        end
        else if spacepicture.Width/spacepicture.Height<(aRect.Right - aRect.Left)/(aRect.Bottom - aRect.Top- textheight) then
        begin
          StretchDrawRect.Top:=aRect.Top;
          StretchDrawRect.Bottom:= aRect.Bottom - textheight;
          StretchDrawRect.Left:=aRect.Left + (aRect.Right - aRect.Left - trunc(spacepicture.Width*(StretchDrawRect.Bottom-StretchDrawRect.Top)/spacepicture.Height)) div 2;
          StretchDrawRect.Right:=StretchDrawRect.Left+trunc(spacepicture.Width*(StretchDrawRect.Bottom-StretchDrawRect.Top)/spacepicture.Height);
        end
        else
        begin
          StretchDrawRect.Left:=ARect.Left;
          StretchDrawRect.Right:=ARect.Right;
          StretchDrawRect.Top:=aRect.Top;
          StretchDrawRect.Bottom:= aRect.Bottom - textheight;
        end;
        Canvas.StretchDraw(StretchDrawRect,spacepicture);
      end
      else
      begin
        Canvas.Draw(iX,iY,spacepicture);
      end;
    end;
  end;
  //画空间名称+座位号
  text:=getCellBottomText(ACol,ARow);
  if trim(text)<>'' then
  begin
    bottomrect:=Rect(ARect.Left,aRect.Bottom - textheight,ARect.Right,ARect.Bottom);
    DrawTextInRectIntelligence(text,bottomrect);
  end;
  //画小图表示附加状态信息
  statusPicture:=getStatusPicture(ARow,ACol);
  if statusPicture<>nil then
  begin
    if (StatusPicturePosition=splefttop)
      or (StatusPicturePosition=spleftbottom) then
    begin
      statusDrawRect.Left:=ARect.Left;
    end
    else
    begin
      statusDrawRect.Left:=max((ARect.Left+ARect.Right) div 2, ARect.Right-statusPicture.Width);
    end;
    if (StatusPicturePosition=sprighttop)
      or (StatusPicturePosition=sprightbottom) then
    begin
      statusDrawRect.Right:=ARect.Right;
    end
    else
    begin
      statusDrawRect.Right:=Min((ARect.Left+ARect.Right) div 2,statusDrawRect.Left+statusPicture.Width);
    end;
    if (StatusPicturePosition=splefttop)
      or (StatusPicturePosition=sprighttop) then
    begin
      statusDrawRect.Top:=ARect.Top;
    end
    else
    begin
      statusDrawRect.Top:=Max((ARect.Top+ARect.Bottom) div 2, ARect.Bottom-statusPicture.Height);
    end;
    if (StatusPicturePosition=spleftbottom)
      or (StatusPicturePosition=sprightbottom) then
    begin
      statusDrawRect.bottom:=ARect.Bottom;
    end
    else
    begin
      statusDrawRect.bottom:=Min((ARect.Top+ARect.Bottom) div 2, statusDrawRect.Top+statusPicture.Height);
    end;
    statusPicture.TransparentColor := statusPicture.Canvas.Pixels[0,0];//透明颜色
    statusPicture.Transparent := true;
    Canvas.Brush.Style := bsClear;
    canvas.StretchDraw(statusDrawRect,statusPicture);
  end;
end;

function TSeatPlan.getActualheight: Integer;
var i:integer;
begin
  Result:=0;
  for I := 0 to self.RowCount - 1 do
    Result:=Result+self.RowHeights[i];
  Result:=Result+(self.RowCount+1)*self.GridLineWidth+self.BevelWidth*2;
end;

function TSeatPlan.getActualwidth: Integer;
var i:integer;
begin
  Result:=0;
  for I := 0 to self.ColCount - 1 do
    Result:=Result+self.ColWidths[i];
  Result:=Result+(self.ColCount+1)*self.GridLineWidth+self.BevelWidth*2;
end;

function TSeatPlan.getBrandModelid: Int64;
begin
  result:=FBrandModelid;
end;

function TSeatPlan.getCellBottomText(ACol, ARow: Integer): string;
var vehicleseatplandetail : TVehicleseatplandetail;
begin
  //画空间名称+座位号
  if showspacename and (vehicleseatplandetails<>nil) then
  begin
    vehicleseatplandetail:=getVehicleseatplandetail(row,col);
    if (vehicleseatplandetail<>nil) then
    begin
      result:= vehicleseatplandetail.space.name+' ';
    end;
  end;
  result:=result+getSeatNoStr(ARow,ACol);
end;

function TSeatPlan.getSeatNo(row, col: Byte): Word;
var detail: TVehicleseatplandetail;
begin
  result:=0;
  if (Col=0) or (Row=0) then exit;
  if (vehicleseatplandetails=nil) or (vehicleseatplandetails.Count=0) then
  begin
    if (seatsStatus<>nil) and (seatsStatus.Count>0) then
      result:=(self.ColCount-1)*(row-1)+col;
  end
  else
  begin
    detail:=getVehicleseatplandetail(row,col);
    if (detail<>nil) and (detail.space<>nil) and (detail.space.ispassengerseat) then
      result:=detail.seatno;
  end;
  if (seatsStatus<>nil) and (Result>seatsStatus.Count) then
  begin
    result:=0;
  end;
end;

function TSeatPlan.getSeatNoStr(_seatno: Word): String;
var vehicleseatplandetail : TVehicleseatplandetail;
begin
  Result:=IntToStr(_seatno);
  if _seatno<=0 then
  begin
    Result:='';
    exit;
  end;
  if (vehicleseatplandetails<>nil) and (vehicleseatplandetails.Count>0) then
  begin
    for vehicleseatplandetail in vehicleseatplandetails do
    begin
      if (vehicleseatplandetail.space<>nil) and (vehicleseatplandetail.space.ispassengerseat) and (vehicleseatplandetail.seatno=_seatno) then
      begin
        if Trim(vehicleseatplandetail.remarks)<>'' then
        begin
          Result:=vehicleseatplandetail.remarks;
        end;
        Break;
      end;
    end;
  end;
end;

function TSeatPlan.getSeatNoStr(row, col: Byte): String;
var detail: TVehicleseatplandetail;
    _seatno:Word;
begin
  result:='';
  if (Col=0) or (Row=0) then exit;
  if (vehicleseatplandetails=nil) or (vehicleseatplandetails.Count=0) then
  begin
    if (seatsStatus<>nil) and (seatsStatus.Count>0) then
    begin
      _seatno:=(self.ColCount-1)*(row-1)+col;
      result:=inttostr(_seatno);
    end;
  end
  else
  begin
    detail:=getVehicleseatplandetail(row,col);
    if (detail<>nil) and (detail.space<>nil) and (detail.space.ispassengerseat) then
    begin
      _seatno:=detail.seatno;
      if Trim(detail.remarks)<>'' then
        result:=detail.remarks
      else
        result:=IntToStr(detail.seatno);
    end;
  end;
  if (seatsStatus<>nil) and (_seatno>seatsStatus.Count) then
  begin
    result:='';
  end;
end;

function TSeatPlan.getdisplaypicture(row, col: Byte):TGraphic;
var detail: TVehicleseatplandetail;
    findspacepicture:boolean;
    seatstatus,seattickettype:string;
    spacepicture:TDictionary<string, TJPEGImage>;
    seatno:Word;
begin
  Result:=nil;
  if (Col=0) or (Row=0) then exit;
  if ((vehicleseatplandetails=nil) or (vehicleseatplandetails.Count=0) ) then  //座位表
  begin
    //计算出座位号
    seatno:=getSeatNo(row,col);
    if seatno>0 then
    begin
      seatstatus:=seatsStatus.Items[seatno];
      if ((seatstatus='0') or (seatstatus='1') or (seatstatus='3') or (seatstatus='4') or (seatstatus='5')) then
      begin
        if (statuspicture<>nil) and (statuspicture.ContainsKey('0')) then
          Result:=statuspicture.Items['0'];
      end
      else
      begin
        seattickettype:=seatstickettype.Items[seatno];
        if (soldpicture<>nil) and (soldpicture.ContainsKey(seattickettype)) then
          Result:=soldpicture.Items[seattickettype];
      end;
    end;
//    exit;
  end
  else  //座位图
  begin
    detail:=getVehicleseatplandetail(row,col);
    if (detail<>nil) and (detail.space<>nil) and (detail.space.ispassengerseat)
        and (seatsStatus<>nil) and (seatsStatus.ContainsKey(detail.seatno)) then
    begin
      findspacepicture:=false;
      if (spacesoldpicture<>nil) and (spacesoldpicture.ContainsKey(detail.space.id)) then
      begin
        spacepicture:=spacesoldpicture.Items[detail.space.id];
        if (spacepicture<>nil) and seatstickettype.ContainsKey(detail.seatno)
          and (spacepicture.ContainsKey(seatstickettype.Items[detail.seatno])) then
        begin
          Result:=spacepicture.Items[seatstickettype.Items[detail.seatno]];
          findspacepicture:=true;
        end;
      end;
      if (not findspacepicture) then
      begin
        if (soldpicture<>nil) and seatstickettype.ContainsKey(detail.seatno)
          and (soldpicture.ContainsKey(seatstickettype.Items[detail.seatno])) then
        begin
          Result:=soldpicture.Items[seatstickettype.Items[detail.seatno]];
        end;
      end;
    end;
    if (Result=nil) and (detail<>nil) and (detail.space<>nil) then
    begin
      Result:=detail.space.picture;
    end;
  end;
end;

function TSeatPlan.getStatusPicture(row, col: Byte):TBitmap;
var seatno:word;
    seatstatus:string;
begin
  result:=nil;
  if (Col=0) or (Row=0) then exit;
  seatno:=getSeatNo(row,col);
  if (seatno>0) and (seatsStatus<>nil) and (seatsStatus.ContainsKey(seatno)) then
  begin
    seatstatus:=seatsStatus.Items[seatno];
    if ((seatstatus='1') or (seatstatus='3') or (seatstatus='4') or (seatstatus='5')
        or (seatstatus='7') or (seatstatus='8'))
       and (statuspicture<>nil) and (statuspicture.ContainsKey(seatstatus)) then
    begin
      Result:=statuspicture.Items[seatstatus];
    end
    else
    begin
      result:=nil;
    end;
  end;
end;

function TSeatPlan.getSeatshint: TDictionary<Word, String>;
begin
  if not assigned(Fseatshint) then
  begin
    Fseatshint:=TDictionary<Word,string>.create;
  end;
  result:=Fseatshint;
end;

function TSeatPlan.getSeatsStatus: TDictionary<Word, String>;
begin
  Result:= FseatsState;
end;

function TSeatPlan.getSeatsTickettype: TDictionary<Word, string>;
begin
  Result:=FseatsTickettype;
end;

function TSeatPlan.getFocusCellSeatNo: Word;
begin
  Result:=getSeatNo(self.Row,Self.Col);
end;

function TSeatPlan.getShowspacename: Boolean;
begin
  Result:=Fshowspacename;
end;

function TSeatPlan.getShowspacepicture: Boolean;
begin
  Result:=Fshowspacepicture;
end;

function TSeatPlan.getVehicleseatplandetail(row,
  col: Byte): TVehicleseatplandetail;
var vehicleseatplandetail : TVehicleseatplandetail;
begin
  Result:=nil;
  if (Col=0) or (Row=0) then exit;
  for vehicleseatplandetail in vehicleseatplandetails do
  begin
    if (vehicleseatplandetail.rowno=row) and (vehicleseatplandetail.colno=col) then
    begin
      Result:=vehicleseatplandetail;
      Break;
    end;
  end;
end;

procedure TSeatPlan.initDefaultSeatPlan;
var i:integer;
begin
  if ((vehicleseatplandetails=nil) or (vehicleseatplandetails.Count=0) )
      and ( (seatsStatus<>nil) and (seatsStatus.Count>0)) then
  begin
    self.ColCount:=Fdefaultcolcount;
    self.RowCount:=(seatsStatus.Count div (self.ColCount-1))+1;
    if (seatsStatus.Count mod (self.ColCount-1))<>0 then
    begin
      self.RowCount:=self.RowCount+1;
    end;
    for I := 1 to Self.RowCount - 1 do
      self.RowHeights[i]:=Fdefaultcellheight;
    for I := 1 to self.ColCount - 1 do
      self.ColWidths[i]:=Fdefaultcellwidth;
    self.Width:=self.actualwidth;
    self.Height:=self.actualheight;
  end;
end;

function TSeatPlan.locateBySeatNo(seatno: Byte;triggerSelectEvent:Boolean): Boolean;
var vehicleseatplandetail : TVehicleseatplandetail;
    _col,_row:Integer;
begin
  Result:=False;
  if seatno<=0 then exit;
  if (vehicleseatplandetails=nil) or (vehicleseatplandetails.Count=0) then
  begin
    if (seatsStatus<>nil) and (seatsStatus.Count>0) then
    begin
      _row:=(seatno div (self.ColCount-1)) +1;
      _col:=seatno-(self.ColCount-1)*(_row-1);
      FisLocateTriggerSelectEvent:=triggerSelectEvent;
      try
        self.Row:=_row;
        self.Col:=_col;
        Result:=Self.SelectCell(_col,_row);
      finally
        FisLocateTriggerSelectEvent:=true;
      end;
    end;
  end
  else
  begin
    for vehicleseatplandetail in vehicleseatplandetails do
    begin
      if (vehicleseatplandetail.space<>nil) and (vehicleseatplandetail.space.ispassengerseat) and (vehicleseatplandetail.seatno=seatno) then
      begin
        FisLocateTriggerSelectEvent:=triggerSelectEvent;
        try
          self.Row:=vehicleseatplandetail.rowno;
          self.Col:=vehicleseatplandetail.colno;
          Result:=Self.SelectCell(vehicleseatplandetail.colno,vehicleseatplandetail.rowno);
        finally
          FisLocateTriggerSelectEvent:=true;
        end;
        Break;
      end;
    end;
  end;
end;

procedure TSeatPlan.MouseMove(Shift: TShiftState; X, Y: Integer);
var _col,_row:integer;
begin
  inherited;
  MouseToCell(x,y,_col,_row);
  showcellhint(_col,_row);
end;

function TSeatPlan.SelectCell(ACol, ARow: Integer): Boolean;
begin
  if Assigned(OnSelectRowChangeEvent) then
    OnSelectRowChangeEvent(ACol,ARow);
  showcellhint(Acol,Arow);
  result:=inherited;
end;

procedure TSeatPlan.setBrandModelid(const Value: Int64);
var jcds:TjsonClientDataSet;
    detail:TVehicleseatplandetail;
    tmpVehiclespace:TVehiclespace;
    _vehicleseatplandetails:TList<TVehicleseatplandetail>;
begin
//  if FBrandModelid=Value then exit;
  FBrandModelid := Value;
  if not Assigned(vehicleseatplandetails) then
  begin
    _vehicleseatplandetails:=TList<TVehicleseatplandetail>.Create;
  end
  else
  begin
    _vehicleseatplandetails:=vehicleseatplandetails;
  end;;
  _vehicleseatplandetails.Clear;
  if Value>0 then
  begin
    //查询数据库取出此品牌型号的座位图
    jcds:=TjsonClientDataSet.Create(nil);
    with jcds do
    begin
      try
        Active:=false;
        RemoteServer:=DMPublic.jcon;
        DataSourceName:='vehicleseatplandetaillist';
        QueryAddress:='base/findVehicleseatplandetail';
        Params.CreateParam(ftString,'vehicleseatplan.vehiclebrandmodelid',ptInput);
        Params.ParamValues['vehicleseatplan.vehiclebrandmodelid']:=brandModelid;
        Active:=true;
        FBrandModelSeatnum:=0;
        while not Eof do
        begin
          detail:=TVehicleseatplandetail.Create;
          with detail do
          begin
            id:=FieldByName('id').AsLargeInt;
            rowno:=FieldByName('rowno').AsInteger;
            colno:=FieldByName('colno').AsInteger;
            width:=FieldByName('width').AsInteger;
            height:=FieldByName('height').AsInteger;
            seatno:=FieldByName('seatno').AsInteger;
            remarks:=FieldByName('remarks').AsString;
            createby:=FieldByName('createby').AsLargeInt;
            createtime:=FieldByName('createtime').AsString;
            updateby:=FieldByName('updateby').AsLargeInt;
            updatetime:=FieldByName('updatetime').AsString;

            if vehiclespaces<>nil then
            begin
              for tmpVehiclespace in vehiclespaces do
              begin
                if tmpVehiclespace.id=FieldByName('vehiclespaceid').AsLargeInt then
                begin
                  space:=tmpVehiclespace;
                  if space.ispassengerseat then
                  begin
                    inc(FBrandModelSeatnum);
                  end;
                  Break;
                end;
              end;
            end;
          end;
          _vehicleseatplandetails.Add(detail);
          next;
        end;
      finally
        free;
      end;
    end;
  end;
  vehicleseatplandetails:=_vehicleseatplandetails;
  initDefaultSeatPlan;
  if (seatsStatus<>nil) and (seatsStatus.Count>0)
    and (brandModelid>0) and (FBrandModelSeatnum<>seatsStatus.Count) then
  begin
    brandModelid:=0;
  end;
end;

function TSeatPlan.setParent(parent: TWinControl): TWinControl;
begin
  self.Parent:=parent;
  Result:=self;
end;

procedure TSeatPlan.setSeatshint(const Value: TDictionary<Word, String>);
begin
  if Assigned(Fseatshint) and (value<>nil) and (Fseatshint<>Value) then
  begin
    freeandnil(Fseatshint);
  end;
  Fseatshint:=value;
end;

procedure TSeatPlan.setSeatsStatus(const Value: TDictionary<Word, string>);
begin
  FseatsState:=value;
  if (seatsStatus<>nil) and (seatsStatus.Count>0) then
  begin
    //取图片
    initSpacesoldpicture();
    initStatuspicturee();
    initSoldpicture();

    initDefaultSeatPlan;
  end;
  if (seatsStatus<>nil) and (seatsStatus.Count>0)
    and (brandModelid>0) and (FBrandModelSeatnum<>seatsStatus.Count) then
  begin
    brandModelid:=0;
  end;
end;

procedure TSeatPlan.setSeatsTickettype(const Value: TDictionary<Word, String>);
begin
  FseatsTickettype:=Value;
end;

procedure TSeatPlan.setShowspacename(const Value: Boolean);
begin
  Fshowspacename := Value;
end;

procedure TSeatPlan.setShowspacepicture(const Value: Boolean);
begin
  Fshowspacepicture := Value;
end;

//保存设置
function TSeatPlanEdit.save: Boolean;
var jcdssaveVehicleseatplan:TjsonClientDataSet;
    vehicleseatplandetail:TVehicleseatplandetail;
    i:Integer;
    tmpSeat:TStringList;
    begintime:Tdatetime;
begin
  result:=false;
  //检查座位号是否有重复,座位有没有设置足够
  begintime:=now;
  i:=0;
  tmpSeat:=TStringList.Create;
  for vehicleseatplandetail in self.vehicleseatplandetails do
  begin
    if vehicleseatplandetail.space.ispassengerseat then
    begin
      if tmpSeat.IndexOf(inttostr(vehicleseatplandetail.seatno))>=0 then
      begin
        SysDialogs.ShowError('座位号'+inttostr(vehicleseatplandetail.seatno)+'重复！');
        exit;
      end
      else
      begin
        tmpSeat.Add(inttostr(vehicleseatplandetail.seatno));
      end;
      inc(i);
    end;
  end;
  tmpSeat.Free;
  if i<>self.rationseatnum then
  begin
    SysDialogs.ShowError('本车辆品牌型号的乘客座位数为'+inttostr(rationseatnum)+'座，您指定了'+IntToStr(i)+'个座位！');
    exit;
  end
  else if i<=0 then
  begin
    SysDialogs.ShowError('车辆品牌型号的乘客座位数为'+inttostr(i)+'不允许保存！');
    exit;
  end;

  with emptydetails do
  begin
    Params.ParamValues['vehicleseatplan.vehiclebrandmodelid']:=brandModelid;
    for vehicleseatplandetail in self.vehicleseatplandetails do
    begin
      Insert;
      FieldByName('id').Value:=vehicleseatplandetail.id;
      FieldByName('colno').Value:=vehicleseatplandetail.colno;
      FieldByName('height').Value:=vehicleseatplandetail.height;
      FieldByName('remarks').Value:=vehicleseatplandetail.remarks;
      FieldByName('rowno').Value:=vehicleseatplandetail.rowno;
      FieldByName('seatno').Value:=vehicleseatplandetail.seatno;
      FieldByName('vehiclespaceid').Value:=vehicleseatplandetail.space.id;
      FieldByName('width').Value:=vehicleseatplandetail.width;
//      FieldByName('createby').Value:=vehicleseatplandetail.createby;
//      FieldByName('createtime').Value:=vehicleseatplandetail.createtime;
//      FieldByName('updateby').Value:=vehicleseatplandetail.updateby;
//      FieldByName('updatetime').Value:=vehicleseatplandetail.updatetime;
//      FieldByName('vehiclebrandmodelid').Value:=brandModelid;
    end;
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('保存失败:未知错误！');
      end;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        result:=true;
      end;
    except on E: Exception do
      SysDialogs.Warning('保存失败:'+e.Message);
    end;
  end;


//  SysDialogs.ShowMessage('保存前检查'+IntToStr(trunc(TimeStampToMSecs(DateTimeToTimeStamp(now))-TimeStampToMSecs(DateTimeToTimeStamp(begintime))) div 1000));
//  jcdssaveVehicleseatplan:=TjsonClientDataSet.Create(Self);
//  with jcdssaveVehicleseatplan do
//  begin
//    try
//      Active:=false;
//      RemoteServer:=DMPublic.jcon;
//      SaveAddress:='base/saveVehicleseatplan';
//      Params.CreateParam(ftString,'vehicleseatplan.vehiclebrandmodelid',ptInput);
//      Params.ParamValues['vehicleseatplan.vehiclebrandmodelid']:=brandModelid;
//
//      i:=0;
//      for vehicleseatplandetail in self.vehicleseatplandetails do
//      begin
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].id',ptInput);
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].id']:=vehicleseatplandetail.id;
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].colno',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].createby',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].createtime',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].height',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].remarks',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].rowno',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].seatno',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].updateby',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].updatetime',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].vehiclespaceid',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].width',ptInput);
//        Params.CreateParam(ftString,'vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].vehicleseatplan.vehiclebrandmodelid',ptInput);
//
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].colno']:=vehicleseatplandetail.colno;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].createby']:=vehicleseatplandetail.createby;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].createtime']:=vehicleseatplandetail.createtime;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].height']:=vehicleseatplandetail.height;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].remarks']:=vehicleseatplandetail.remarks;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].rowno']:=vehicleseatplandetail.rowno;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].seatno']:=vehicleseatplandetail.seatno;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].updateby']:=vehicleseatplandetail.updateby;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].updatetime']:=vehicleseatplandetail.updatetime;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].vehiclespaceid']:=vehicleseatplandetail.space.id;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].width']:=vehicleseatplandetail.width;
//        Params.ParamValues['vehicleseatplan.vehicleseatplandetails['+inttostr(i)+'].vehicleseatplan.vehiclebrandmodelid']:=brandModelid;
//        inc(i);
//      end;
//      Params.CreateParam(ftInteger,'flag',ptOutput);
//      Params.CreateParam(ftString,'msg',ptOutput);
//      SysDialogs.ShowMessage('创建参数'+IntToStr(trunc(TimeStampToMSecs(DateTimeToTimeStamp(now))-TimeStampToMSecs(DateTimeToTimeStamp(begintime))) div 1000));
//      Execute;
//      SysDialogs.ShowMessage('执行'+IntToStr(trunc(TimeStampToMSecs(DateTimeToTimeStamp(now))-TimeStampToMSecs(DateTimeToTimeStamp(begintime))) div 1000));
//      if Params.ParamValues['msg']<>'' then
//      begin
//        SysDialogs.ShowMessage(Params.ParamValues['msg']);
//      end;
//      if Params.ParamValues['flag']=1 then
//      begin
//        result:=True;
//      end;
//    finally
//      free;
//    end;
//  end;
end;

procedure TSeatPlanEdit.setOnSizeChange(const value: TNotifyEvent);
begin
  self.OnResize:=value;
end;

procedure TSeatPlanEdit.setRationseatnum(const Value: Word);
begin
  Frationseatnum:=value;
end;

function TSeatPlanEdit.setSpace(arow, acol: Byte): TVehicleseatplandetail;
var vehicleseatplandetail:TVehicleseatplandetail;
    vehiclespaceid:Int64;
    tmpVehiclespace:Tvehiclespace;
begin
  Result:=nil;
  if (ACol=0) or (ARow=0) then exit;
  //弹出选择空间界面
  if not Assigned(FFrmsetVehicleSpace) then
  begin
    FFrmsetVehicleSpace:= TFrmsetVehicleSpace.Create(Self);
  end;
  vehicleseatplandetail:=self.getVehicleseatplandetail(arow,acol);
  with FFrmsetVehicleSpace do
  begin
    nvedtrowno.Text:=IntToStr(arow);
    nvedtcolno.Text:=IntToStr(acol);
    if vehicleseatplandetail<>nil then
    begin
      nvedtseatno.Text:=inttostr(vehicleseatplandetail.seatno);
      nvedtwidth.Text:=IntToStr(vehicleseatplandetail.width);
      nvedtheight.Text:=IntToStr(vehicleseatplandetail.height);
      memremarks.Text:=vehicleseatplandetail.remarks;
      Nvhcbbspace.SetItemIndexByField('id',vehicleseatplandetail.space.id);
    end
    else
    begin
      nvedtseatno.Text:='0';
      nvedtwidth.Text:=IntToStr(self.ColWidths[acol]);
      nvedtheight.Text:=IntToStr(self.RowHeights[arow]);
      memremarks.Text:='';
    end;
    NvhcbbspaceChange(nil);
  end;
  if SysMainForm.showFormModal(FFrmsetVehicleSpace,false)=mrOk then
  begin
    //更新
    if vehicleseatplandetail=nil then
    begin
      vehicleseatplandetail:=TVehicleseatplandetail.Create;
      vehicleseatplandetails.Add(vehicleseatplandetail);
    end;
    with vehicleseatplandetail do
    begin
      rowno:=arow;
      colno:=acol;
      width:=strtoint(FFrmsetVehicleSpace.nvedtwidth.Text);
      height:=strtoint(FFrmsetVehicleSpace.nvedtheight.Text);
      vehiclespaceid:=FFrmsetVehicleSpace.Nvhcbbspace.HelpFieldValue['id'];
      seatno:=strtoint(FFrmsetVehicleSpace.nvedtseatno.Text);
      remarks:=FFrmsetVehicleSpace.memremarks.Text;
      for tmpVehiclespace in vehiclespaces do
      begin
        if tmpVehiclespace.id=vehiclespaceid then
        begin
          space:=tmpVehiclespace;
          Break;
        end;
      end;
    end;
    self.Repaint;
    Result:=vehicleseatplandetail;
  end;
end;

procedure TSeatPlan.setvehicleseatplandetails(
  avalue: TList<TVehicleseatplandetail>);
var vehicleseatplandetail:TVehicleseatplandetail;
    maxrowno,maxcolno:byte;
    colwidths:TArray<Word>;
    rowheights:TArray<Word>;
    i:Integer;
    oldlength:integer;
begin
  //初始化要显示的行和列数
  Fvehicleseatplandetails:=avalue;
  SetLength(colwidths,1);
  SetLength(rowheights,1);
  if (vehicleseatplandetails<>nil) and (vehicleseatplandetails.Count>0) then
  begin
    maxrowno:=0;
    maxcolno:=0;
    for vehicleseatplandetail in avalue do
    begin
      maxrowno:=max(maxrowno,vehicleseatplandetail.rowno);
      maxcolno:=max(maxcolno,vehicleseatplandetail.colno);
      oldlength:=length(colwidths);
      if oldlength<=maxcolno then
      begin
        SetLength(colwidths,maxcolno+1);
        for I := oldlength+1 to maxcolno+1 do
          colwidths[i-1]:=0;
      end;
      oldlength:=length(rowheights);
      if oldlength<=maxrowno then
      begin
        SetLength(rowheights,maxrowno+1);
        for I := oldlength+1 to maxrowno+1 do
          rowheights[i-1]:=0;
      end;
      colwidths[vehicleseatplandetail.colno]:=max(vehicleseatplandetail.width,colwidths[vehicleseatplandetail.colno]);
      rowheights[vehicleseatplandetail.rowno]:=max(vehicleseatplandetail.height,rowheights[vehicleseatplandetail.rowno]);
    end;
    self.RowCount:=maxrowno+1;
    self.ColCount:=maxcolno+1;
    for I := 1 to Self.RowCount - 1 do
      if rowheights[i]=0 then
        self.RowHeights[i]:=Fdefaultcellheight
      else
        self.RowHeights[i]:=rowheights[i];
    for I := 1 to self.ColCount - 1 do
      if colwidths[i]=0 then
        self.ColWidths[i]:=Fdefaultcellwidth
      else
        self.ColWidths[i]:=colwidths[i];
  end
  else
  begin
    self.RowCount:=defaultrowcount;
    self.ColCount:=Fdefaultcolcount;
    for I := 1 to Self.RowCount - 1 do
      self.RowHeights[i]:=Fdefaultcellheight;
    for I := 1 to self.ColCount - 1 do
      self.ColWidths[i]:=Fdefaultcellwidth;
  end;
  self.Width:=self.actualwidth;
  self.Height:=self.actualheight;
end;

procedure TSeatPlan.showcellhint(ACol, ARow: Integer);
var seatno:word;
    newhint:String;
    curcellrect:Trect;
begin
  inherited;
  //设置单元格提示
  seatno:=getSeatNo(arow,acol);
  if (seatno>0) and seatshint.ContainsKey(seatno) then
    newhint:=seatshint.Items[seatno]
  else
    newhint:='';
  if (newhint<>cellhint)
     or (acol<>curhintcol)
     or (arow<>curhintrow) then
  begin
    cellhint:=newhint;
    if ShowHint then
    begin
      if not assigned(BalloonHint) then
      begin
        BalloonHint:=TBalloonHint.Create(self);
        BalloonHint.Delay:=0;
        BalloonHint.HideAfter:=3000;  //3秒后自动隐藏
      end;
      if BalloonHint.ShowingHint then
        BalloonHint.HideHint;
      if cellhint<>'' then
      begin
        BalloonHint.Description:=cellhint;
        curcellrect:=self.CellRect(acol,arow);
        BalloonHint.ShowHint(ClientToScreen(point((curcellrect.Left+curcellrect.Right) div 2,
                                                      (curcellrect.Top+curcellrect.Bottom) div 2)));
      end;
    end;
  end;
  if (acol<>curhintcol) or (arow<>curhintrow) then
  begin
    curhintrow:=arow;
    curhintcol:=acol;
  end;
end;

{ TVehicleSeatPlanDecorator }

constructor TVehicleSeatPlanDecorator.Create(AOwner: TComponent;
  vehicleseatplan: IVehicleSeatPlan);
begin
  inherited Create(AOwner);
  self.BevelOuter:=bvNone;
  Fvehicleseatplan:=vehicleseatplan;
  (Fvehicleseatplan as TDrawGrid).ScrollBars:=ssNone;
  TSeatPlan(Fvehicleseatplan).OnSelectRowChangeEvent:=SelectRowChange;
  (Fvehicleseatplan as TControl).Parent:=Self;
  if Supports(Fvehicleseatplan,IVehicleSeatPlanEdit) then
    (Fvehicleseatplan as IVehicleSeatPlanEdit).OnSizeChange:=seatPlanSizeChange;

  //左边
  imghead:=TImage.Create(Self);
  imghead.Stretch:=true;
  imghead.Parent:=Self;
  imghead.Left:=0;
  imghead.Width:=0;
  {
  if FileExists(vehiclehead_picturename) then
  begin
    imghead.Picture.LoadFromFile(vehiclehead_picturename);
    imghead.Width:=imghead.Picture.Graphic.Width;
  end
  else
    imghead.Width:=0;
  }
  //右边
  imgtail:=TImage.Create(Self);
  imgtail.Stretch:=true;
  imgtail.Parent:=Self;
  imgtail.Width:=0;
  {if FileExists(vehicletail_picturename) then
  begin
    imgtail.Picture.LoadFromFile(vehicletail_picturename);
    imgtail.Width:=imgtail.Picture.Graphic.Width;
  end
  else
    imgtail.Width:=0;
   }
  //下边
  imgleftside:=TImage.Create(Self);
  imgleftside.Stretch:=true;
  imgleftside.Parent:=Self;
  imgleftside.Height:=0;
  {
  if FileExists(vehicleleftside_picturename) then
  begin
    imgleftside.Picture.LoadFromFile(vehicleleftside_picturename);
    imgleftside.Height:=imgleftside.Picture.Graphic.Height;
  end
  else
    imgleftside.Height:=0;
   }
  //上边
  imgrightside:=TImage.Create(Self);
  imgrightside.Stretch:=true;
  imgrightside.Parent:=Self;
  imgrightside.Top:=0;
  imgrightside.Height:=0;
{  if FileExists(vehiclerightside_picturename) then
  begin
    imgrightside.Picture.LoadFromFile(vehiclerightside_picturename);
    imgrightside.Height:=imgrightside.Picture.Graphic.Height;
  end
  else
    imgrightside.Height:=0;
 }
  //左上角
  imgheadright:=TImage.Create(Self);
  imgheadright.Stretch:=True;
  imgheadright.Parent:=Self;
  imgheadright.Left:=0;
  imgheadright.Top:=0;
  {
  if FileExists(vehicleheadright_picturename) then
  begin
    imgheadright.Picture.LoadFromFile(vehicleheadright_picturename);
    imgheadright.Height:=imgheadright.Picture.Graphic.Height;
    imgheadright.Width:=imgheadright.Picture.Graphic.Width;
  end
  else
  begin
    imgheadright.Height:=0;
    imgheadright.Width:=0;
  end;}
  imgheadright.Height:=0;
  imgheadright.Width:=0;
  //左下角
  imgheadleft:=TImage.Create(Self);
  imgheadleft.Stretch:=True;
  imgheadleft.Parent:=Self;
  imgheadleft.Left:=0;
    imgheadleft.Width:=0;
    imgheadleft.Height:=0;
{
  if FileExists(vehicleheadleft_picturename) then
  begin
    imgheadleft.Picture.LoadFromFile(vehicleheadleft_picturename);
    imgheadleft.Width:=imgheadleft.Picture.Graphic.Width;
    imgheadleft.Height:=imgheadleft.Picture.Graphic.Height;
  end
  else
  begin
    imgheadleft.Width:=0;
    imgheadleft.Height:=0;
  end;
 }
  //右上角
  imgtailright:=TImage.Create(Self);
  imgtailright.Stretch:=True;
  imgtailright.Parent:=Self;
  imgtailright.Top:=0;
    imgtailright.Width:=0;
    imgtailright.Height:=0;
   {
  if FileExists(vehicletailright_picturename) then
  begin
    imgtailright.Picture.LoadFromFile(vehicletailright_picturename);
    imgtailright.Height:=imgtailright.Picture.Graphic.Height;
    imgtailright.Width:=imgtailright.Picture.Graphic.Width;
  end
  else
  begin
    imgtailright.Width:=0;
    imgtailright.Height:=0;
  end;
   }
  //右下角
  imgtailleft:=TImage.Create(Self);
  imgtailleft.Stretch:=True;
  imgtailleft.Parent:=Self;
    imgtailleft.Height:=0;
    imgtailleft.Width:=0;
   {
  if FileExists(vehicletailleft_picturename) then
  begin
    imgtailleft.Picture.LoadFromFile(vehicletailleft_picturename);
    imgtailleft.Height:=imgtailleft.Picture.Graphic.Height;
    imgtailleft.Width:=imgtailleft.Picture.Graphic.Width;
  end
  else
  begin
    imgtailleft.Height:=0;
    imgtailleft.Width:=0;
  end;
  }
  //方向盘
  imgSteering:=TImage.Create(Self);
  imgSteering.Stretch:=True;
  imgSteering.Transparent:=true;
  imgSteering.Parent:=Self;
    imgSteering.Height:=0;
    imgSteering.Width:=0;
{
  if FileExists(vehicleSteering_picturename) then
  begin
    imgSteering.Picture.LoadFromFile(vehicleSteering_picturename);
    imgSteering.Height:=imgSteering.Picture.Graphic.Height;
    imgSteering.Width:=imgSteering.Picture.Graphic.Width;
  end
  else
  begin
    imgSteering.Height:=0;
    imgSteering.Width:=0;
  end;
 }
  imghead.Top:=Max(Max(imgheadright.Height,imgrightside.Height),imgtailright.Height);
  imgtail.Top:=imghead.Top;
  (Fvehicleseatplan as TSeatPlan).Top:=imghead.Top;

  imgrightside.Left:=Max(Max(imghead.Width,imgheadright.Width),imgheadleft.Width);
  imgleftside.Left:=imgrightside.Left;
  imgSteering.Left:=imghead.Left+imghead.Width-imgSteering.Width;
  imgSteering.Top:=imghead.Top+imghead.Height-imgSteering.Height;
  (Fvehicleseatplan as TSeatPlan).Left:=imgrightside.Left;

  layoutItems;
end;

destructor TVehicleSeatPlanDecorator.Destroy;
begin
//  if Assigned(seatsStatus) then
//    seatsStatus.free;
  inherited;
end;

function TVehicleSeatPlanDecorator.getActualheight: Integer;
begin
  Result:=Fvehicleseatplan.getActualheight
          +max(max(imgheadright.Height,imgrightside.Height),imgtailright.Height)
          +max(max(imgheadleft.Height,imgleftside.Height),imgtailleft.Height);
end;

function TVehicleSeatPlanDecorator.getActualwidth: Integer;
begin
  Result:=Fvehicleseatplan.getActualwidth
          +max(max(imgheadright.Width,imghead.Width),imgheadleft.Width)
          +max(max(imgtailright.Width,imgtail.Width),imgtailleft.Width);

end;

function TVehicleSeatPlanDecorator.getBrandModelid: Int64;
begin
  Result:=Fvehicleseatplan.getBrandModelid;
end;

function TVehicleSeatPlanDecorator.getSeatsStatus: TDictionary<Word, string>;
begin
  Result:=Fvehicleseatplan.getSeatsStatus;
end;

function TVehicleSeatPlanDecorator.getSeatsTickettype: TDictionary<Word, string>;
begin
  Result:=Fvehicleseatplan.getSeatsTickettype;
end;

function TVehicleSeatPlanDecorator.getShowspacename: Boolean;
begin
  result:=Fvehicleseatplan.getShowspacename;
end;

function TVehicleSeatPlanDecorator.getShowspacepicture: Boolean;
begin
  result:=Fvehicleseatplan.getShowspacepicture;
end;

function TVehicleSeatPlanDecorator.getVehicleseatplandetail(row,
  col: Byte): TVehicleseatplandetail;
begin
  result:=Fvehicleseatplan.getVehicleseatplandetail(row,col);
end;

procedure TVehicleSeatPlanDecorator.layoutItems;
begin
  imghead.Height:=Fvehicleseatplan.actualheight;
  imgtail.Height:=imghead.Height;

  imgheadleft.Top:=imghead.Top+imghead.Height;
  imgtailleft.Top:=imgheadleft.Top;
  imgleftside.Top:=imgheadleft.Top;

  imgleftside.Width:=Fvehicleseatplan.actualwidth;
  imgrightside.Width:=imgleftside.Width;

  imgtailright.Left:=imgleftside.Left+imgleftside.Width;
  imgtailleft.Left:=imgtailright.Left;
  imgtail.Left:=imgtailright.Left;
  imgSteering.Top:=imghead.Top+imghead.Height-imgSteering.Height;

  self.Height:=self.actualheight;
  self.Width:=self.actualwidth;
end;

procedure TVehicleSeatPlanDecorator.seatPlanSizeChange(Sender: TObject);
begin
  layoutItems;
end;

procedure TVehicleSeatPlanDecorator.SelectRowChange(acol,arow: Integer);
var curRowPostion,curRowPostion_bottom:Integer;
    i:integer;
    scrollparnt:TScrollingWinControl;
begin
  if Assigned(self.Parent) and (Self.Parent is TScrollingWinControl) then
  begin
    scrollparnt:=(Self.Parent as TScrollingWinControl);
    with scrollparnt do
    begin
      if self.actualheight>Height then
      begin
        curRowPostion:=(Fvehicleseatplan as TSeatPlan).Top;
        for I := 0 to arow-1 do
        begin
          curRowPostion:=curRowPostion+TStringGrid(Fvehicleseatplan).RowHeights[i];
        end;
        curRowPostion_bottom:=curRowPostion+TStringGrid(Fvehicleseatplan).RowHeights[arow];
        curRowPostion:=curRowPostion+max(max(imgheadright.Height,imgrightside.Height),imgtailright.Height);
        if curRowPostion-VertScrollBar.Position<0 then
        begin
          VertScrollBar.Position:=max(max(imgheadright.Height,imgrightside.Height),imgtailright.Height);
        end
        else if curRowPostion_bottom-VertScrollBar.Position>Height then
        begin
          VertScrollBar.Position:=Max(0,Min(curRowPostion_bottom-Height,VertScrollBar.Range-Height));
        end
//        else
//        begin
//          VertScrollBar.Position:=0;
//        end
        ;
      end;
    end;
  end;
end;

procedure TVehicleSeatPlanDecorator.setBrandModelid(const Value: Int64);
begin
  Fvehicleseatplan.setBrandModelid(Value);
  layoutItems;
end;

function TVehicleSeatPlanDecorator.setParent(parent: TWinControl): TWinControl;
begin
  self.Parent:=parent;
  result:=Self;
end;

procedure TVehicleSeatPlanDecorator.setSeatsStatus(
  const Value: TDictionary<Word, String>);
begin
  Fvehicleseatplan.setSeatsStatus(value);
end;

procedure TVehicleSeatPlanDecorator.setSeatsTickettype(
  const Value: TDictionary<Word, String>);
begin
  Fvehicleseatplan.setSeatsTickettype(value);
end;

procedure TVehicleSeatPlanDecorator.setShowspacename(const Value: Boolean);
begin
  Fvehicleseatplan.setShowspacename(value);
end;

procedure TVehicleSeatPlanDecorator.setShowspacepicture(const Value: Boolean);
begin
  Fvehicleseatplan.setShowspacepicture(value);
end;

{ TSeatPlanSelect }

procedure TSeatPlanSelect.AddLayerMask(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var gpGraph:IGPGraphics;
    gpbmp:IGPBitmap;
    GrayColorMatrix:TGPColorMatrix;
    ImageAttributes: IGPImageAttributes;
    bmp:TBitmap;
begin
  //在单元格上加一层灰色蒙版
  if not getCanSelect(ARow,ACol) then
  begin
    gpGraph:=Canvas.ToGPGraphics;
    gpGraph.SetClip(TGPRect.Create(ARect));
    bmp:=TBitmap.Create;
    bmp.SetSize(ARect.Right-ARect.Left,ARect.Bottom-ARect.Top);
    bmp.Canvas.CopyRect(bmp.Canvas.ClipRect,Canvas,ARect);
    gpbmp:=TGPBitmap.Create(bmp.Handle,bmp.Palette);
    ImageAttributes := TGPImageAttributes.Create;
    GrayColorMatrix.SetToIdentity;
    GrayColorMatrix.M[0, 0] := 0.299;
    GrayColorMatrix.M[0, 1] := 0.299;
    GrayColorMatrix.M[0, 2] := 0.299;
    GrayColorMatrix.M[1, 0] := 0.518;
    GrayColorMatrix.M[1, 1] := 0.518;
    GrayColorMatrix.M[1, 2] := 0.518;
    GrayColorMatrix.M[2, 0] := 0.114;
    GrayColorMatrix.M[2, 1] := 0.114;
    GrayColorMatrix.M[2, 2] := 0.114;
    ImageAttributes.SetColorMatrix(GrayColorMatrix);
    gpGraph.DrawImage(gpbmp,TGPRect.Create(ARect),0,0,gpbmp.Width,gpbmp.Height,UnitPixel,ImageAttributes);
    bmp.Free;
//    TGPImageAttributes(ImageAttributes).Free;
//    TGPBitmap(gpbmp).Free;
//    TGPGraphics(gpGraph).Free;
  end;
end;

function TSeatPlanSelect.autoSelectSeats(isserial: Boolean): Boolean;
var CanSelectSerialseats:TList<TList<Word>>;
    i,j:integer;
    hasPre:integer; //前面有N个元素(内部元素数量相等)大于等于剩余选择总数

    seatkey:Word;
    seatkeys:Tlist<Word>;
begin
  result:=false;
  if (selectSeatStatus=nil) or (selectSeatNum<=0)
    or (seatstype=nil) or (seatsStatus=nil) then   exit;

  if not assigned(selectedSeats) then
  begin
    selectedSeats:=TList<word>.Create;
  end;
  selectedSeats.Clear;
//  while selectedSeats.Count - selectSeatNum > 0 do
//    selectedSeats.Delete(selectedSeats.Count-1);
  if isserial then
  begin
    //取连接的座位号段
    CanSelectSerialseats:=getCanSelectSerialseats;
    //按连续座位数的数量倒序
    CanSelectSerialseats.Sort(TListCountComparer<TList<Word>>.Create);
    if (CanSelectSerialseats<>nil) and (CanSelectSerialseats.Count>0) then
    begin
      hasPre:=0;
      for I := 0 to CanSelectSerialseats.Count - 1 do
      begin
        if CanSelectSerialseats.Items[i].Count<selectSeatNum-selectedSeats.Count then //小于剩余选择总数
        begin
          if (hasPre>0) then  //前面的元素大于等于剩余选择总数
          begin
            for j := 0 to selectSeatNum - selectedSeats.Count - 1 do
            begin
              selectedSeats.Add(CanSelectSerialseats.Items[i-hasPre].Items[j]);
            end;//完成
          end
          else
          begin
//            for j := 0 to selectSeatNum - selectedSeats.Count - 1 do
            for j := 0 to CanSelectSerialseats.Items[i].Count-1 do
            begin
              selectedSeats.Add(CanSelectSerialseats.Items[i].Items[j]);
            end;
          end;
          hasPre:=0;
        end
        else  //大于等于剩余选择总数
        begin
          if (i>0) and (CanSelectSerialseats.Items[i-1].Count=CanSelectSerialseats.Items[i].Count) then
          begin
            inc(hasPre);
          end
          else
          begin
            hasPre:=1;
          end;
          if (I = CanSelectSerialseats.Count - 1) then  //到了最后
          begin
            for j := 0 to selectSeatNum - selectedSeats.Count - 1 do
            begin
              selectedSeats.Add(CanSelectSerialseats.Items[i-hasPre+1].Items[j]);
            end;
          end;// 完成
        end;
        if selectedSeats.Count=selectSeatNum then
        begin
          result:=true;
          self.Repaint;
          exit;
        end;
      end;  //end for i
    end; //end if
  end
  else
  begin
//    for seatStatus in seatsStatus do
//    begin
//      if selectSeatStatus.Contains(seatStatus.Value)
//        and ((selectSeattype='')
//             or (seatstype.Items[seatStatus.Key]=selectSeattype)
//            ) then
//      begin
//        selectedSeats.Add(seatStatus.Key);
//        if selectedSeats.Count=selectSeatNum then
//        begin
//          result:=true;
//          self.Repaint;
//          exit;
//        end;
//      end;
//    end;
    //排序
    seatkeys:=Tlist<Word>.Create;
    seatkeys.AddRange(seatsStatus.Keys);
    seatkeys.Sort;
    for seatkey in seatkeys do
    begin
      OutputDebugString(PWideChar(inttostr(seatkey)));
      if selectSeatStatus.Contains(seatsStatus.Items[seatkey])
        and ((selectSeattype='')
             or (seatstype.Items[seatkey]=selectSeattype)
            ) then
      begin
        selectedSeats.Add(seatkey);
        if selectedSeats.Count=selectSeatNum then
        begin
          result:=true;
          self.Repaint;
          exit;
        end;
      end;
    end;
  end;
end;

function TSeatPlanSelect.checkSelectSeat: boolean;
var slectedseatEnum:TList<Word>.TEnumerator;
begin
  result:=true;
  if (selectSeatStatus=nil) or (selectSeatNum<=0)
    or (seatstype=nil) or (seatsStatus=nil) then   exit;
  if (not assigned(selectedSeats)) or (selectedSeats.Count=0) then exit;
  slectedseatEnum:=selectedseats.GetEnumerator;
  while slectedseatEnum.MoveNext do
  begin
    if (not selectSeatStatus.Contains(seatsstatus.Items[slectedseatEnum.Current]))
      or ((selectSeattype<>'')
           and (seatstype.Items[slectedseatEnum.Current]<>selectSeattype)
          ) then
    begin
      selectedseats.Remove(slectedseatEnum.Current);
      result:=false;
    end;
  end;
  while selectedSeats.Count - selectSeatNum > 0 do
    selectedSeats.Delete(selectedSeats.Count-1);
end;

//procedure TSeatPlanSelect.Click;
//var p:TPoint;
//    _col,_row:integer;
//    seatno:Word;
//    beforchecked,afterChecked:boolean;
//begin
//  inherited;
//  //取当前的位置
//  p:=ScreenToClient(Mouse.CursorPos);
//  self.MouseToCell(p.x,p.y,_col,_row);
//  CellSelected(_col,_row);
////  CellSelected(self.Col,self.Row);
//end;

constructor TSeatPlanSelect.Create(AOwner: TComponent);
//var i :Integer;
begin
  inherited;
  FselectSeatNum:=0;
  FselectSeattype:='';
  FallowSelectByHand:=True;
  {$IFDEF DEBUG}

  {$ENDIF}
end;

destructor TSeatPlanSelect.Destroy;
begin
//  if Assigned(seatsStatus) then
//     seatsStatus.Free;
  inherited;
end;

procedure TSeatPlanSelect.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
begin
  inherited;
  AddLayerMask(ACol, ARow,ARect,AState);
end;

function TSeatPlanSelect.getCanSelect(arow, acol: Integer): Boolean;
var seatno:Word;
begin
  Result:=False;
  seatno:=getSeatNo(arow,acol);
  if (seatno>0)
      and ((trim(getSelectSeattype)='')
            or  ((trim(getSelectSeattype)<>'') and (Fseatstype<>nil)
                  and (Fseatstype.ContainsKey(seatno)) and (getSelectSeattype=Fseatstype.Items[seatno])
                 )
          )
      and (getSelectSeatStatus<>nil)
      and (seatsStatus<>nil)
      and getSelectSeatStatus.Contains(seatsStatus.Items[seatno])
  then
  begin
    Result:=true;
  end;
end;

function TSeatPlanSelect.getOnSelectComplete: TNotifyEvent;
begin
  Result:=FOnSelectComplete;
end;

function TSeatPlanSelect.getSelectedSeats: TList<Word>;
begin
  Result:=FselectedSeats;
end;

function TSeatPlanSelect.getSelectSeatNum: Word;
begin
  Result:=FselectSeatNum;
end;

function TSeatPlanSelect.getSelectSeatStatus: TList<string>;
begin
  Result:=FselectSeatStatus;
end;

function TSeatPlanSelect.getSelectSeattype: String;
begin
  Result:=FselectSeattype;
end;

function TSeatPlanSelect.getCanSelectSeatNum: word;
var key:Word;
begin
  result:=0;
  if (selectSeatStatus=nil) or (seatstype=nil) or (seatsStatus=nil) then   exit;
  for key in seatsStatus.Keys do
  begin
    if selectSeatStatus.Contains(seatsStatus.Items[key])
      and ((selectSeattype='')
           or (seatstype.Items[Key]=selectSeattype)
          ) then
    begin
      inc(result);
    end;
  end;
end;

function TSeatPlanSelect.getCanSelectSerialseats: TList<TList<Word>>;
var //seatStatus:TPair<Word,String>;
    isserial:boolean;
    item: TList<Word>;
    keys:TList<Word>;
    key:Word;
begin
  result:=nil;
  if (selectSeatStatus=nil) or (selectSeatNum<=0)
    or (seatstype=nil) or (seatsStatus=nil) then   exit;

  isserial:=false;
  item:=nil;
  result:=TList<TList<Word>>.Create;
//  seatsStatus.Keys
  //给KEY排序
  keys:=TList<Word>.create;
  keys.AddRange(seatsStatus.Keys);
  keys.Sort;
  for key in keys do
  begin

    if selectSeatStatus.Contains(seatsStatus.Items[key])
      and ((selectSeattype='')
           or (seatstype.Items[Key]=selectSeattype)
          ) then
    begin
      if not isserial then
      begin
        item:=TList<Word>.create;
      end;
      item.Add(Key);
      isserial:=true;
    end
    else
    begin
      isserial:=false;
      if item<>nil then
      begin
        item.Sort;
        result.Add(item);
        item:=nil;
      end;
    end;
  end;
  if item<>nil then
  begin
    item.Sort;
    result.Add(item);
  end;
end;

function TSeatPlanSelect.getCellBottomText(ACol, ARow: Integer): string;
var seatno:Word;
begin
  Result:=inherited;
  seatno:=getSeatNo(arow,acol);
  if Assigned(seatsreachstationname) and (seatsreachstationname.Count>0)
     and (seatno>0)
     and seatsreachstationname.ContainsKey(seatno)
     and (Trim(seatsreachstationname.Items[seatno])<>'') then
  begin
    Result:=Result+'-'+seatsreachstationname.Items[seatno];
  end;
end;

function TSeatPlanSelect.getStatusPicture(row, col: Byte): TBitmap;
var seatno:Word;
begin
  seatno:=getSeatNo(row,col);
  if (seatno>0) and (getSelectedSeats<>nil) and getSelectedSeats.Contains(seatno)
      and (seatsStatus<>nil) and (seatsStatus.ContainsKey(seatno))
      and (statuspicture<>nil) and (statuspicture.ContainsKey('6'))
      then
  begin
    Result:= statuspicture.Items['6'];
  end
  else
  begin
    Result:= inherited getStatusPicture(row, col);
  end;
  {$IFDEF DEBUG}
    if (Result=nil) and FileExists(checkMarkPicturename)
        and (seatno>0) and (getSelectedSeats<>nil) and getSelectedSeats.Contains(seatno)
    then
    begin
      Result:=TBitmap.Create;
      Result.LoadFromFile(checkMarkPicturename);
    end;
  {$ENDIF}
end;

procedure TSeatPlanSelect.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  //空格键选择
  if (key=VK_SPACE) and (self.Row>=0) and (self.Col>=0) then
  begin
    CellSelected(self.Col,self.Row);
  end;
end;

procedure TSeatPlanSelect.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited;
  //左键进行选择
  if (Button = mbLeft) then
    CellSelected(self.Col,self.Row);
end;

function TSeatPlanSelect.CellSelected(ACol, ARow: Integer): boolean;
var seatno:Word;
begin
  Result:=False;
  if getCanSelect(arow, acol) and allowSelectByHand then
  begin
    seatno:=getSeatNo(arow,acol);
    if (seatno>0) and (getSelectedSeats<>nil) and getSelectedSeats.Contains(seatno) then
    begin
      getSelectedSeats.Remove(seatno);
      Result:=True;
    end
    else
    begin
      if getSelectedSeats=nil then
      begin
        SelectedSeats:=TList<word>.Create;
      end;
      if getSelectedSeats.Count<getSelectSeatNum then
      begin
        getSelectedSeats.Add(seatno);
        Result:=True;
      end;
    end;
    if Assigned(OnSelectSeatno) then
    begin
      OnSelectSeatno(seatno);
    end;
  end;
  if Result then
  begin
    self.Repaint;
  end;
end;

procedure TSeatPlanSelect.SelectChangeNotify(Sender: TObject; const Item: Word;
  Action: TCollectionNotification);
begin
  if self.Visible then
    self.Repaint;
  if (getSelectedSeats.Count=getSelectSeatNum) and Assigned(FOnSelectComplete) then
  begin
    OnSelectComplete(Self);
  end;
end;

procedure TSeatPlanSelect.setOnSelectComplete(
  const onSelectComplete: TNotifyEvent);
begin
  FOnSelectComplete:=onSelectComplete;
end;

procedure TSeatPlanSelect.setSelectedSeats(const selectSeats: TList<Word>);
begin
  FselectedSeats:=selectSeats;
  checkSelectSeat;
  FselectedSeats.OnNotify:=SelectChangeNotify;
end;

procedure TSeatPlanSelect.setSelectSeatNum(const selectSeatNum: Word);
begin
  FselectSeatNum:=selectSeatNum;
  checkSelectSeat;
end;

procedure TSeatPlanSelect.setSelectSeatStatus(
  const selectSeatStatus: TList<string>);
begin
  FselectSeatStatus:=selectSeatStatus;
  checkSelectSeat;
end;

procedure TSeatPlanSelect.setSelectSeattype(const selectSeattype: string);
begin
  FselectSeattype:=selectSeattype;
  checkSelectSeat;
end;

function TSeatPlanSelect.getSeatsreachstationname: TDictionary<Word, String>;
begin
  if not assigned(Fseatsreachstationname) then
  begin
    Fseatsreachstationname:=TDictionary<Word,string>.create;
  end;
  result:=Fseatsreachstationname;
  if (Fseatsreachstationname<>nil) and (Fseatsreachstationname.Count>0) and (CellBottomlinenum<2) then
  begin
    CellBottomlinenum:=2;
  end;
end;

procedure TSeatPlanSelect.setSeatsreachstationname(
  const Value: TDictionary<Word, String>);
begin
  if Assigned(Fseatsreachstationname) and (Fseatsreachstationname<>value) then //and (value<>nil)
  begin
    freeandnil(Fseatsreachstationname);
  end;
  Fseatsreachstationname:=value;
  if (Fseatsreachstationname<>nil) and (Fseatsreachstationname.Count>0) and (CellBottomlinenum<2) then
  begin
    CellBottomlinenum:=2;
  end;
end;

{ TListCountComparer<TList<Word>> }

function TListCountComparer<T>.Compare(const Left,
  Right: TList<Word>): Integer;
begin
  //座位数多的排在前面
  result:=Left.Count-right.Count;
  if result=0 then
  begin
    //相同数量 ，座位号小的排在前面
    Result:=right.Items[0]-Left.Items[0];
  end;
  result:=-1*result;
end;

{ TSeatPlanChecked }

procedure TSeatPlanChecked.DblClick;
var p:TPoint;
    _col,_row:integer;
    seatno:Word;
    beforchecked,afterChecked:boolean;
begin
  //取当前的位置
  p:=ScreenToClient(Mouse.CursorPos);
  self.MouseToCell(p.x,p.y,_col,_row);

  if getCanSelect(_row, _col) and allowSelectByHand then
  begin
    seatno:=getSeatNo(_row,_col);
    if (seatno>0) and Assigned(OnDbClickSeat) then
    begin
//      if (FCheckedSeats<>nil) and FCheckedSeats.ContainsKey(seatno) and FCheckedSeats.Items[seatno] then
      if (seatsStatus.Items[seatno]='7') or (seatsStatus.Items[seatno]='8') then
        beforchecked:=true
      else
        beforchecked:=false;
      if seatsticketno.ContainsKey(seatno) then
        OnDbClickSeat(seatno,seatsticketno.Items[seatno],beforchecked,afterChecked)
      else
        OnDbClickSeat(seatno,'',beforchecked,afterChecked);
      if beforchecked<>afterChecked then
      begin
        self.Repaint;
      end;
    end;
  end;
  inherited;
end;

procedure TSeatPlanChecked.DrawCell(ACol, ARow: Integer; ARect: TRect;
  AState: TGridDrawState);
var ix,iy:integer;
    text:string;
    textheight:integer;
    seatno:Word;
    TP:TMethod;
    vehicleseatplandetail : TVehicleseatplandetail;
    bottomrect:TRect;
begin
  inherited;
//  TP.Code   :=   @TSeatPlan.DrawCell;
//  TP.Data   :=   Self;
//  TDrawProc(TP)(ACol, ARow,ARect,AState);
//
//  if (ACol>0) and (ARow>0) then
//  begin
//    textheight:=Canvas.TextHeight('余');
//    seatno:=getSeatNo(arow,acol);
////    在中间位置显示到站
////    if Assigned(seatsreachstationname) and (seatsreachstationname.Count>0)
////       and (seatno>0)
////       and seatsreachstationname.ContainsKey(seatno) then
////    begin
////      text:=seatsreachstationname.Items[seatno];
////      if trim(text)<>'' then
////      begin
////        DrawTextInRectIntelligence(text,Rect(ARect.Left,ARect.Top,ARect.Right,ARect.Bottom-textheight));
////      end;
////    end;
//    //画空间名称+座位号
//    bottomrect:=Rect(ARect.Left,aRect.Bottom - textheight,ARect.Right,ARect.Bottom);
//    Canvas.FillRect(bottomrect);
//    vehicleseatplandetail:=getVehicleseatplandetail(ARow,ACol);
//    if showspacename and (vehicleseatplandetail<>nil) then
//    begin
//      text:= vehicleseatplandetail.space.name+' ';
//    end;
//    text:=text+getSeatNoStr(ARow,ACol);
//    if Assigned(seatsreachstationname) and (seatsreachstationname.Count>0)
//       and (seatno>0)
//       and seatsreachstationname.ContainsKey(seatno)
//       and (Trim(seatsreachstationname.Items[seatno])<>'') then
//    begin
//      text:=text+'-'+seatsreachstationname.Items[seatno];
//    end;
//    if trim(text)<>'' then
//    begin
//      DrawTextInRectIntelligence(text,bottomrect);
//    end;
//  end;
//  AddLayerMask(ACol, ARow,ARect,AState);
////  TP.Code   :=   @TSeatPlanSelect.DrawCell;
////  TP.Data   :=   Self;
////  TDrawProc(TP)(ACol, ARow,ARect,AState);
end;

procedure TSeatPlan.DrawTextInRectIntelligence(text: string;
  rect: TRect);
var oldFontSize:Integer;
//    firstlinetext:String;
    linenum:Integer;
  I: Integer;
  ix,iy:Integer;
  lengthperline: integer;
  tmpstr:string;
  function getWidthPerLine(_linenum:Integer):Integer;
  var j:Integer;
      firstlinelength:Integer;
      firstlinetext:String;
  begin
    firstlinetext:='';
    firstlinelength:=Length(text) div _linenum;
    if Length(text) mod _linenum>0 then
    begin
      Inc(firstlinelength);
    end;
    for j := 1 to firstlinelength do
    begin
      firstlinetext:=firstlinetext+'中';
    end;
    result:=Canvas.TextWidth(firstlinetext);
  end;
begin
  oldFontSize:=Canvas.Font.Size;
  //计算出输出行数及字体大小
  linenum:=1;
//  firstlinetext:=text;
  while getWidthPerLine(linenum)>rect.Right-rect.Left do       //Canvas.TextWidth(firstlinetext)
  begin
    Inc(linenum);
    if Canvas.TextHeight(text)*linenum>rect.Bottom-rect.Top then
    begin
      //缩小字体
      Canvas.Font.Size:=Canvas.Font.Size-1;
      linenum:=1;
//      firstlinetext:=text;
      Continue;
    end;
//    if Length(text) mod linenum>0 then
//    begin
//      firstlinetext:=Copy(text,1,Length(text) div linenum+1);
//    end
//    else
//    begin
//      firstlinetext:=Copy(text,1,Length(text) div linenum);
//    end;
  end;
  //按计算出来的行数和字体输出
  lengthperline:=Length(text) div linenum;
  if Length(text) mod linenum>0 then
  begin
    Inc(lengthperline);
  end;
  for I := 1 to linenum do
  begin
    tmpstr:=Copy(text,lengthperline*(i-1)+1,lengthperline);
    ix:=(rect.Right-rect.Left-Canvas.TextWidth(tmpstr)) div 2+rect.Left;
    iy:=(rect.Bottom-rect.Top-Canvas.TextHeight(tmpstr)*linenum) div 2
        +(i-1)*Canvas.TextHeight(tmpstr)+rect.Top;
    Canvas.TextOut(ix,iy,tmpstr);
  end;
  Canvas.Font.Size:=oldFontSize;
end;

function TSeatPlanChecked.getCellBottomText(ACol, ARow: Integer): string;
var seatno:Word;
begin
  Result:=inherited;
  if ischecked(ARow,acol) then
  begin
    seatno:=getSeatNo(ARow,acol);
    if  (seatscolor.Items[seatno]='3') then
    begin
      self.Canvas.Font.Color:=clGreen;
    end
    //本站非混检
    else if  (seatscolor.Items[seatno]='1') then
    begin
      self.Canvas.Font.Color:=clBlue;
    end
    else
    //本站混检
    if  (seatscolor.Items[seatno]='2') then
    begin
      self.Canvas.Font.Color:=clRed;
    end
    else
    begin
      self.Canvas.Font.Color:=clGreen;
    end;
  end
  else
  begin
    seatno:=getSeatNo(ARow,acol);
    if (seatno>0) and (statuspicture<>nil) and (seatsStatus.Items[seatno]='2')
    and statuspicture.ContainsKey(seatsStatus.Items[seatno]) then
    begin
      //本站未检
      if (seatscolor.ContainsKey(seatno)) and (seatscolor.Items[seatno]='1') then
      begin
        self.Canvas.Font.Color:=clBlue;
      end
      else
      if (seatscolor.ContainsKey(seatno)) and  (seatscolor.Items[seatno]='3') then
      begin
        self.Canvas.Font.Color:=clGreen;
      end
      else
      begin
        self.Canvas.Font.Color:=clBlack;
      end;
    end
    else
    begin
      self.Canvas.Font.Color:=clBlack;
    end;
  end;
end;

function TSeatPlanChecked.getSeatsticketno: TDictionary<Word, String>;
begin
  if not assigned(Fseatsticketno) then
  begin
    Fseatsticketno:=TDictionary<Word,string>.create;
  end;
  result:=Fseatsticketno;
end;

function TSeatPlanChecked.getStatusPicture(row, col: Byte): TBitmap;
var seatno:Word;
begin
  seatno:=getSeatNo(row,col);
  if (seatno>0) and (statuspicture<>nil)
    and ((seatsStatus.Items[seatno]='7') or (seatsStatus.Items[seatno]='8'))
    and statuspicture.ContainsKey(seatsStatus.Items[seatno]) then
  begin
    Result:= statuspicture.Items[seatsStatus.Items[seatno]];
  end
  else
  begin
    Result:= inherited getStatusPicture(row, col);
  end;
end;

function TSeatPlanChecked.ischecked(row, col: Byte): boolean;
var seatno:Word;
begin
  Result:= false;
  seatno:=getSeatNo(row,col);
  if (seatno>0) and (statuspicture<>nil)
    and ((seatsStatus.Items[seatno]='7') or (seatsStatus.Items[seatno]='8'))
    and statuspicture.ContainsKey(seatsStatus.Items[seatno]) then
  begin
    Result:= true;
  end;
end;

function TSeatPlanChecked.locateByTicketNo(ticketno: String;triggerSelectEvent:Boolean): Boolean;
var _seatno:Word;
    // TDictionary<Word,String>.TKeyCollection;
begin
  Result:=False;
  //if seatno<=0 then exit;
  for _seatno in seatsticketno.Keys do
  begin
    if seatsticketno.Items[_seatno]=ticketno then
    begin
      result:=locateBySeatNo(_seatno,triggerSelectEvent);
      Break;
    end;
  end;
end;

procedure TSeatPlanChecked.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  //覆盖父类方法，不触发单击事件
  inherited;
//  //左键进行选择
//  if (Button = mbLeft) then
//    CellSelected(self.Col,self.Row);
end;

function TSeatPlanChecked.CellSelected(ACol, ARow: Integer): boolean;
var seatno:Word;
    beforchecked,afterChecked:boolean;
begin
  Result:=true;
  if  (FisLocateTriggerSelectEvent) and getCanSelect(arow, acol) and allowSelectByHand then
  begin
    seatno:=getSeatNo(arow,acol);
    if (seatno>0) and Assigned(OnSelectSeat) then
    begin
//      if (FCheckedSeats<>nil) and FCheckedSeats.ContainsKey(seatno) and FCheckedSeats.Items[seatno] then
      if (seatsStatus.Items[seatno]='7') or (seatsStatus.Items[seatno]='8') then
        beforchecked:=true
      else
        beforchecked:=false;
      if seatsticketno.ContainsKey(seatno) then
        OnSelectSeat(seatno,seatsticketno.Items[seatno],beforchecked,afterChecked)
      else
        OnSelectSeat(seatno,'',beforchecked,afterChecked);
      if beforchecked<>afterChecked then
      begin
        self.Repaint;
      end;
    end;
  end;
end;

procedure TSeatPlanChecked.setSeatsticketno(
  const Value: TDictionary<Word, String>);
begin
  if Assigned(Fseatsticketno) and (value<>nil) and (Fseatsticketno<>value) then
  begin
    freeandnil(Fseatsticketno);
  end;
  Fseatsticketno:=value;
end;

{ TSeatPicHelp }

constructor TSeatPicHelp.Create;
begin
 selectSeatStatus := TList<string>.Create;
  seatsStatus := TDictionary<Word, String>.Create;
  seatsTickettype := TDictionary<Word, String>.Create;
  seatticketno := TDictionary<Word, String>.Create;
  seatStation := TDictionary<Word, String>.Create;
  seatCanCheck := TList<Word>.Create;
  seatshint := TDictionary<Word, String>.Create;
  seatstype:= TDictionary<Word, String>.Create;
  seatscolor:= TDictionary<Word, String>.Create;
  checktickets := 0;
  unchecktickets := 0;
  selectSeatStatus.Add('2');
  selectSeatStatus.Add('7');
  selectSeatStatus.Add('8');
  jcdsQryScheduleSeatstatus := TjsonClientDataSet.Create(nil);
  with jcdsQryScheduleSeatstatus do
  begin
    RemoteServer := DMPublic.jcon;
    DataSourceName := 'scheduleseatlist';
    QueryAddress := 'ticketprice/qryScheduleseatinfo';
    Params.CreateParam(ftString, 'scheduleplan.id', ptInput);
  end;

  jcdsQrySeatstatus := TjsonClientDataSet.Create(nil);
  with jcdsQrySeatstatus do
  begin
    RemoteServer := DMPublic.jcon;
    DataSourceName := 'seatstatuslist';
    QueryAddress := 'checkticket/qrySeatstatus';
    Params.CreateParam(ftString, 'scheduleplanid', ptInput);
  end;
end;

destructor TSeatPicHelp.Destroy;
begin
  if Assigned(selectSeatStatus) then
    selectSeatStatus.Free;
  if Assigned(seatsStatus) then
    seatsStatus.Free;
  if Assigned(seatsTickettype) then
    seatsTickettype.Free;
  if Assigned(seatticketno) then
    seatticketno.Free;
  if Assigned(seatStation) then
    seatStation.Free;
  if Assigned(seatCanCheck) then
    seatCanCheck.Free;
  if Assigned(seatshint) then
    seatshint.Free;
  if Assigned(jcdsQryScheduleSeatstatus) then
    jcdsQryScheduleSeatstatus.Free;
  if Assigned(jcdsQrySeatstatus) then
    jcdsQrySeatstatus.Free;
  if Assigned(seatstype) then
    seatstype.Free;
  if Assigned(seatscolor) then
    seatscolor.Free;
  inherited;
end;

procedure TSeatPicHelp.qryScheduleSeatstatus(scheduleplanid: int64);
var
  status: String;
  seatno: integer;
  colortype:String;
begin
  {
  seatsStatus.Clear;
  seatsTickettype.Clear;
  seatstype.Clear;
  with jcdsQryScheduleSeatstatus do
  begin
    Active := false;
    Params.ParamValues['scheduleplan.id'] := scheduleplanid;
    Active := true;
    if RecordCount > 0 then
    begin
      first;
      while (not eof) do
      begin
        status := Fieldbyname('status').AsString;
        //colortype:= Fieldbyname('colortype').AsString;
        seatno := Fieldbyname('seatno').AsInteger;
        seatsStatus.Add(seatno, status);
        if (status = '2') or (status = '7') or (status = '8') then
        begin
          seatsTickettype.Add(seatno, Fieldbyname('tickettype').AsString);
        end;
        seatstype.Add(seatno,FieldByName('seattype').AsString);
        Next;
      end;
    end;
  end;
   }
end;

procedure TSeatPicHelp.qrySeatstatus(scheduleplanid: int64;
  isshowseathint: boolean);
var
  seatno: Word;
  status: String;
begin
  checktickets := 0;
  unchecktickets := 0;
  seatCanCheck.Clear;
  seatticketno.Clear;
  seatshint.Clear;
  seatStation.Clear;
  seatscolor.Clear;
  seatsStatus.Clear;
  seatsTickettype.Clear;
  seatstype.Clear;
  with jcdsQrySeatstatus do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Active := true;
    if RecordCount > 0 then
    begin
      first;
      while (not eof) do
      begin
        seatno := Fieldbyname('seatno').AsInteger;
        status := Fieldbyname('status').AsString;

        if(not seatsStatus.ContainsKey(seatno)) then
        begin
          seatsStatus.Add(seatno, status);
        end;
       if (status = '2') or (status = '7') or (status = '8') then
        begin
          if(not seatsTickettype.ContainsKey(seatno)) then
          begin
            seatsTickettype.Add(seatno, Fieldbyname('tickettype').AsString);
          end;
        end;
        if(not seatstype.ContainsKey(seatno)) then
        begin
          seatstype.Add(seatno,FieldByName('seattype').AsString);
        end;

        if Fieldbyname('ticketno').AsString <> '0' then
        begin

          if Fieldbyname('ischecked').AsBoolean then
          begin
            inc(checktickets);
          end
          else
          begin
            if Fieldbyname('departstationid')
              .AsLargeInt = Sysinfo.LoginUserInfo.StationID then
            begin
             if(not seatCanCheck.Contains(seatno)) then
             begin
                seatCanCheck.Add(seatno);
                inc(unchecktickets);
             end;
            end;
          end;
          if(not seatticketno.ContainsKey(seatno)) then
          begin
            seatticketno.Add(seatno, Fieldbyname('ticketno').AsString);
            seatStation.Add(seatno, Fieldbyname('seatinfo').AsString);
          end
          else
          begin
             seatticketno.Items[seatno]:=seatticketno.Items[seatno]+','+Fieldbyname('ticketno').AsString;
             seatStation.Items[seatno]:=seatStation.Items[seatno]+','+Fieldbyname('seatinfo').AsString;
          end;

          if(not seatscolor.ContainsKey(seatno)) then
            seatscolor.Add(seatno,FieldByName('colortype').AsString);
        end;

        if isshowseathint then
        begin
          if(not seatshint.ContainsKey(seatno)) then
          begin
            seatshint.AddOrSetValue(seatno, Fieldbyname('hint').AsString);
          end;
        end;
        Next;
      end;
    end;
  end;

end;

end.
