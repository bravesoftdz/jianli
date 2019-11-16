{ ------------------------------------
  功能说明：平台主窗体
  创建日期：2010/11/22
  作者：ice
  版权：nova
  ------------------------------------- }
unit UFrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MainFormIntf, Menus, ExtCtrls, ComCtrls, ToolWin, Buttons,
  ImgList, StdCtrls, SysSvc, SystemInstance, Services, WinSkinData,
  LoginIntf, math, CardManage, IniFiles, PubFn, Generics.Collections,
  UDMPublic, FunctionItemIntf, uBaseForm, jpeg, GIFImg, ScktComp, cefvcl,
  ceflib, pngimage, AppEvnts, DB, DBClient, ShellAPI;

Const
  Msg_ClosePage = WM_USER + 177;
  WEBMENUWIDTH = 125;

type
  TCrackWinControl = class(TWinControl);
    TCrackCustomForm = class(TCustomForm);
    // 扩展TMenuItem来存储菜单调用相关信息
    TMenuItem = class(Menus.TMenuItem)private id: integer;
    packagename: String;
    FuctionItemKey: TGUID;
    parameters: TFunctionItemParameters;
    hotkeyValue: word;
  end;

  // 扩展TTabSheet来存储菜单调用相关信息
  TTabSheet = class(ComCtrls.TTabSheet)
  private
    menuItem: TMenuItem;
  end;

  TToolButton = class(ComCtrls.TToolButton)
  private
    menuItem: TMenuItem;
  end;

  {
    // 菜单调用信息结构体
    TFunctionItemCall = record
    FuctionItemKey: TGUID;
    parameters: TFunctionItemParameters;
    menuItem: TMenuItem;
    end;

    // 封装 TRzGroupItem.data指针
    PFunctionItemCall = ^TFunctionItemCall;

    TRzGroupItemHelper = class helper for TRzGroupItem
    private
    public
    function getFuctionItemKey(): TGUID;
    function getParameters(): TFunctionItemParameters;
    function getMenuItem(): TMenuItem;
    end;

    }

  TNovaSplitter = class(TSplitter)
  private
    oldwidth: integer;
    oldControl: Tcontrol;
    dblclicking: boolean;
    function FindControl: Tcontrol;
  protected
    procedure DblClick; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: integer);
      override;
  public
    constructor Create(AOwner: TComponent); override;

  end;

  TfrmMain = class(TForm, IMainForm)
    MainMenu: TMainMenu;
    StatusBar: TStatusBar;
    pgcForms: TPageControl;
    ts_Default: TTabSheet;
    SkinData1: TSkinData;
    il_smallMenu: TImageList;
    il_largeMenu: TImageList;
    dlgOpenStyle: TOpenDialog;
    ilToolBar: TImageList;
    tlbAddress: TToolBar;
    btnRoot: TToolButton;
    pmRoot: TPopupMenu;
    scrlbxleft: TScrollBox;
    tlbleft: TToolBar;
    tmrTime: TTimer;
    tmrwebmenu: TTimer;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    exitbtn: TBitBtn;
    aboutbtn: TBitBtn;
    modifypwdbtn: TBitBtn;
    lockscreenbtn: TBitBtn;
    Chromium1: TChromium;
    Timer1: TTimer;
    pnlmenu: TPanel;
    pnlwebmenu: TPanel;
    scrlbxmenuleft: TScrollBox;
    imgbgcolor: TImage;
    imgbase: TImage;
    imgarchive: TImage;
    imgvehiclecheck: TImage;
    imgdispatch: TImage;
    imgsale: TImage;
    imgcheckticket: TImage;
    imgpack: TImage;
    imgbalance: TImage;
    imgquery: TImage;
    imgreport: TImage;
    imgsystem: TImage;
    lblloginname: TLabel;
    imglogin: TImage;
    imgsplit: TImage;
    imgframebg: TImage;
    chrm1: TChromium;
    imghide: TImage;
    tmr1: TTimer;
    ApplicationEvents1: TApplicationEvents;
    HeartBeatTimer: TTimer;
    BitBtn_ReLoad: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure pgcFormsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure menuItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pgcFormsChange(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    // 焦点改变事件
    procedure screenActiveControlChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure btnToolButtonClick(Sender: TObject);
    procedure btnRootClick(Sender: TObject);
    procedure scrlbxleftResize(Sender: TObject);
    procedure pgcFormsChanging(Sender: TObject; var AllowChange: boolean);
    procedure FormActivate(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure tmrTimeTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    function SplitString(const source, ch: string): TStringList;
    procedure tmrwebmenuTimer(Sender: TObject);
    procedure exitbtnClick(Sender: TObject);
    procedure aboutbtnClick(Sender: TObject);
    procedure lockscreenbtnClick(Sender: TObject);
    procedure modifypwdbtnClick(Sender: TObject);
    procedure lockscreenbtnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure lockscreenbtnMouseLeave(Sender: TObject);
    procedure aboutbtnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure aboutbtnMouseLeave(Sender: TObject);
    procedure modifypwdbtnMouseLeave(Sender: TObject);
    procedure modifypwdbtnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure exitbtnMouseLeave(Sender: TObject);
    procedure exitbtnMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure Timer1Timer(Sender: TObject);
    procedure pnlLeftMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: integer);
    procedure pnlmenuMouseLeave(Sender: TObject);
    procedure imgbaseMouseLeave(Sender: TObject);
    procedure imgarchiveMouseLeave(Sender: TObject);
    procedure imgvehiclecheckMouseLeave(Sender: TObject);
    procedure imgdispatchMouseLeave(Sender: TObject);
    procedure imgsaleMouseLeave(Sender: TObject);
    procedure imgcheckticketMouseLeave(Sender: TObject);
    procedure imgpackMouseLeave(Sender: TObject);
    procedure imgbalanceMouseLeave(Sender: TObject);
    procedure imgqueryMouseLeave(Sender: TObject);
    procedure imgreportMouseLeave(Sender: TObject);
    procedure imgsystemMouseLeave(Sender: TObject);
    procedure imghideClick(Sender: TObject);
    procedure imgbaseClick(Sender: TObject);
    procedure imgarchiveClick(Sender: TObject);
    procedure imgvehiclecheckClick(Sender: TObject);
    procedure imgdispatchClick(Sender: TObject);
    procedure imgsaleClick(Sender: TObject);
    procedure imgcheckticketClick(Sender: TObject);
    procedure imgpackClick(Sender: TObject);
    procedure imgbalanceClick(Sender: TObject);
    procedure imgqueryClick(Sender: TObject);
    procedure imgreportClick(Sender: TObject);
    procedure imgsystemClick(Sender: TObject);
    procedure tmr1Timer(Sender: TObject);
    procedure lockscreenbtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure aboutbtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure modifypwdbtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure exitbtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ApplicationEvents1Exception(Sender: TObject; E: Exception);
    procedure HeartBeatTimerTimer(Sender: TObject);
    procedure BitBtn_ReLoadClick(Sender: TObject);
    procedure BitBtn_ReLoadMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn_ReLoadMouseLeave(Sender: TObject);
    procedure BitBtn_ReLoadMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);

  private
    ismousedown:boolean;
    balancemenucount:Integer;
    querymenucount: integer;
    reportmenucount: integer;
    dispatchmenucount: integer;
    orderno: integer;
    ImgList: TDictionary<integer, TImage>;
    isCapture: boolean;
    sp: TNovaSplitter;
    selfActiveWhenKeydown: boolean;
    selfKeydowned: boolean;
    curMenuItem: TMenuItem;
    CurFolerMenuItem: TMenuItem;
    basemark, archivemark, vehiclemark, dispatchmark, salemark,
      checkticketmark, packmark, balancemark, querymark, reportmark,
      systemmark: integer;
    procedure HandleException(Sender: TObject; E: Exception);
    // function FindTab(const tabName: string): TTabSheet;
    function FindTab(Aform: TCustomForm): TTabSheet;
    procedure CloseActivePage;
    procedure ClosePage(var Message: TMessage); message Msg_ClosePage;
    procedure CNTabClose(var Message: TMessage); message CN_TabSheetClose;
    // 释放侧边栏菜单指针
    procedure freePoint();
    // 跟据当前模块显示路径
    procedure refreshPath(mi: TMenuItem);
    // 根据id查找菜单项
    function findParentMenuItem(parentId: integer): TMenuItem;
    procedure handMenuShortCut(hotkeyValue: word);
    // 初始化菜单样式
    procedure initMenuStyle;

  protected
    { IMainForm }
    // 创建菜单,一般用于DEBUG时,注册菜单
    function CreateMenu(const Path: string; guid: TGUID;
      parameters: TFunctionItemParameters): TObject; overload;
    // 创建菜单,一般用于RELEASE时,注册菜单
    function CreateMenu(id: integer; name: string; guidstr: string;
      parameters: TFunctionItemParameters; parentId: integer;
      isvisible: boolean; hotkeystr: String): TObject; overload;
    // procedure CreateRzGroupItem(aItem: TMenuItem);
    // 取消注册菜单
    procedure DeleteMenu(Const Path: string);
    // 创建工具栏
    function CreateToolButton(const aCaption: String; onClick: TNotifyEvent;
      Hint: String = ''): TObject;
    // 显示状态
    procedure ShowStatus(PnlIndex: integer; const Msg: string);
    // 退出程序
    procedure ExitApplication;
    // 给ImageList添加图标
    function AddImage(Img: TGraphic): integer;
    // function FindForm(const FormClassName: string): TForm;
    procedure ShowForm(Aform: TForm); overload;
    procedure ShowForm(FormClass: TFormClass; var Reference;
      functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil;
      checkpermission: boolean = true); overload;
    function showFormModal(FormClass: TFormClass;
      functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil;
      checkpermission: boolean = true): integer; overload;
    function showFormModal(Aform: TForm; autofree: boolean = true): integer;
      overload;
    procedure CloseForm(Aform: TForm);
    // 根据功能及参数定位TAB页
    function locationTab(guid: TGUID; parameters: TFunctionItemParameters)
      : boolean;
    procedure loadchrom;
    procedure setLblloginname(const loginname: string);
  public
    function findmenuitem(guid: TGUID; parameters: TStringList;
      parentmenu: Menus.TMenuItem): Menus.TMenuItem;
  end;

  TExtension = class(TCefv8HandlerOwn)
  private
    FTestParam: ustring;
  protected
    function Execute(const name: ustring; const obj: ICefv8Value;
      const arguments: TCefv8ValueArray; var retval: ICefv8Value;
      var Exception: ustring): boolean; override;
  end;

  ERegShortCutException = Class(Exception);

  var
    frmMain: TfrmMain;

implementation

uses ceffilescheme, UFrmException, Constant;
{$R *.dfm}

const
  code = 'var cef;' + 'if (!cef)' + '  cef = {};' + 'if (!cef.test)' +
    '  cef.test = {};' + '(function() {' +
    '  cef.test.__defineGetter__(''test_param'', function() {' +
    '    native function GetTestParam();' + '    return GetTestParam();' +
    '  });' + '  cef.test.__defineSetter__(''test_param'', function(b) {' +
    '    native function SetTestParam();' + '    if(b) SetTestParam(b);' +
    '  });' + '  cef.test.test_object = function() {' +
    '    native function GetTestObject();' + '    return GetTestObject();' +
    '  };' + '})();' +
    'function myfunc1(pp){native function myfunc();return myfunc(pp);};' +
    'function getkeyvalue(key,par,pid){native function getkeyvalue();return getkeyvalue(key,par,pid);};'
    +
    'function levelmenu(){native function levelmenu();return levelmenu();};'
    + 'function entermenu(publickey){native function entermenu();return entermenu(publickey);};' + 'function leavemenu(publickey){native function leavemenu();return leavemenu(publickey);};';

var
  df: TCefv8Handler;

function TExtension.Execute(const name: ustring; const obj: ICefv8Value;
  const arguments: TCefv8ValueArray; var retval: ICefv8Value;
  var Exception: ustring): boolean;
var
  menuItem: Menus.TMenuItem;
  parameters: TStringList;
begin
  if (name = 'SetTestParam') then
  begin
    // Handle the SetTestParam native function by saving the string argument
    // into the local member.
    if (Length(arguments) <> 1) or (not arguments[0].IsString) then
    begin
      Result := false;
      Exit;
    end;
    FTestParam := arguments[0].GetStringValue;

    // OutputDebugString(PWideChar(FTestParam));
    Result := true;
  end
  else if (name = 'GetTestParam') then
  begin
    // Handle the GetTestParam native function by returning the local member
    // value.
    retval := TCefv8ValueRef.CreateString(FTestParam);
    Result := true;
  end
  else if (name = 'GetTestObject') then
  begin
    // Handle the GetTestObject native function by creating and returning a
    // new V8 object.
    retval := TCefv8ValueRef.CreateObject(nil);
    // Add a string parameter to the new V8 object.
    retval.SetValueByKey('param', TCefv8ValueRef.CreateString(
        'Retrieving a parameter on a native object succeeded.'),
      V8_PROPERTY_ATTRIBUTE_NONE);
    // Add a function to the new V8 object.
    retval.SetValueByKey('GetMessage',
      TCefv8ValueRef.CreateFunction('GetMessage', Self),
      V8_PROPERTY_ATTRIBUTE_NONE);
    Result := true;
  end
  else if (name = 'GetMessage') then
  begin
    // Handle the GetMessage object function by returning a string.
    retval := TCefv8ValueRef.CreateString(
      'Calling a function on a native object succeeded.');
    Result := true;
  end
  else if (name = 'myfunc') then
  begin
    OutputDebugString('myfunc execed');
    ShowMessage('myfunc execed');
    if (Length(arguments) > 0) and (arguments[0].IsString) then
    begin
      OutputDebugString(PWideChar('param0 is :' + arguments[0].GetStringValue));
      ShowMessage('param0 is :' + arguments[0].GetStringValue);
    end;
    Result := true;
  end
  else if (name = 'getkeyvalue') then
  begin

    if (Length(arguments) > 0) and (arguments[0].IsString) then
    begin
      // OutputDebugString(PWideChar('param0 is :' + arguments[0].GetStringValue));
      // 根据功能GUID和参数查出菜单 2014-8-27 PM 04:55:57 }
      if (arguments[1].GetStringValue = '') then
      begin
        parameters := nil;
      end
      else
      begin
        parameters := frmMain.SplitString(arguments[1].GetStringValue, ',');
      end;
      menuItem := frmMain.findmenuitem
        (StringToGUID(arguments[0].GetStringValue), parameters, nil);
      if menuItem = nil then
      begin
        SysDialogs.ShowError('没有找到对应菜单');
        Exit;
      end;
      menuItem.Click;
      // frmMain.pnlwebmenu.Align:=alLeft;
      // frmMain.pnlwebmenu.Width:=WEBMENUWIDTH;
      frmMain.Timer1.Enabled := true;
      if arguments[2].GetStringValue = '1' then
      begin
        frmMain.imgbase.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\base.png');
        frmMain.basemark := 0;
      end
      else if arguments[2].GetStringValue = '2' then
      begin
        frmMain.imgarchive.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\archive.png');
        frmMain.archivemark := 0;
      end
      else if arguments[2].GetStringValue = '17' then
      begin
        frmMain.imgvehiclecheck.Picture.LoadFromFile
          (ExtractFilePath(Paramstr(0)) + '\images\menu\vehiclecheck.png');
        frmMain.vehiclemark := 0;
      end
      else if (arguments[2].GetStringValue = '5') or
        (arguments[2].GetStringValue = '6') or
        (arguments[2].GetStringValue = '1060019') then
      begin
        frmMain.imgdispatch.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\dispatch.png');
        frmMain.dispatchmark := 0;
      end
      else if arguments[2].GetStringValue = '3' then
      begin
        frmMain.imgsale.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\sale.png');
        frmMain.salemark := 0;
      end
      else if arguments[2].GetStringValue = '8' then
      begin
        frmMain.imgcheckticket.Picture.LoadFromFile
          (ExtractFilePath(Paramstr(0)) + '\images\menu\checkticket.png');
        frmMain.checkticketmark := 0;
      end
      else if arguments[2].GetStringValue = '20' then
      begin
        frmMain.imgpack.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\pack.png');
        frmMain.packmark := 0;
      end
      else if (arguments[2].GetStringValue = '4') or
        (arguments[2].GetStringValue = '7') or
        (arguments[2].GetStringValue = '18500') or (arguments[2].GetStringValue = '100103') then
      begin
        frmMain.imgbalance.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\balance.png');
        frmMain.balancemark := 0;
      end
      else if (arguments[2].GetStringValue = '32') or
        (arguments[2].GetStringValue = '33') or
        (arguments[2].GetStringValue = '34') or
        (arguments[2].GetStringValue = '30') or
        (arguments[2].GetStringValue = '27') or
        (arguments[2].GetStringValue = '8242') or
        (arguments[2].GetStringValue = '6851') then
      begin
        frmMain.imgquery.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\query.png');
        frmMain.querymark := 0;
      end
      else if (arguments[2].GetStringValue = '31') or
        (arguments[2].GetStringValue = '300') or
        (arguments[2].GetStringValue = '301') then
      begin
        frmMain.imgreport.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\report.png');
        frmMain.reportmark := 0;
      end
      else if arguments[2].GetStringValue = '9' then
      begin
        frmMain.imgsystem.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\system.png');
        frmMain.systemmark := 0;
      end;

    end;
    Result := true;
  end
  else if (name = 'levelmenu') then
  begin
    frmMain.pnlwebmenu.Align := alLeft;
    frmMain.pnlwebmenu.Width := WEBMENUWIDTH;
    Result := true;
  end
  else if (name = 'entermenu') then
  begin
    if (Length(arguments) > 0) and (arguments[0].IsString) then
    begin
      if arguments[0].GetStringValue = '1' then
      begin
        if frmMain.basemark = 0 then
        begin
          frmMain.imgbase.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\base.png');
          frmMain.basemark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '2' then
      begin
        if frmMain.archivemark = 0 then
        begin
          frmMain.imgarchive.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\archive.png');
          frmMain.archivemark := 1;
        end;
      end
      else if arguments[0].GetStringValue = '17' then
      begin
        if frmMain.vehiclemark = 0 then
        begin
          frmMain.imgvehiclecheck.Picture.LoadFromFile
            (ExtractFilePath(Paramstr(0)) + '\images\menu_1\vehiclecheck.png');
          frmMain.vehiclemark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '1060018' then
      begin
        if frmMain.dispatchmark = 0 then
        begin
          frmMain.imgdispatch.Picture.LoadFromFile
            (ExtractFilePath(Paramstr(0)) + '\images\menu_1\dispatch.png');
          frmMain.dispatchmark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '3' then
      begin
        if frmMain.salemark = 0 then
        begin
          frmMain.imgsale.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\sale.png');
          frmMain.salemark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '8' then
      begin
        if frmMain.checkticketmark = 0 then
        begin
          frmMain.imgcheckticket.Picture.LoadFromFile
            (ExtractFilePath(Paramstr(0)) + '\images\menu_1\checkticket.png');
          frmMain.checkticketmark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '20' then
      begin
        if frmMain.packmark = 0 then
        begin
          frmMain.imgpack.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\pack.png');
          frmMain.packmark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '1060021' then
      begin
        if frmMain.balancemark = 0 then
        begin
          frmMain.imgbalance.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\balance.png');
          frmMain.balancemark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '18' then
      begin
        if frmMain.querymark = 0 then
        begin
          frmMain.imgquery.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\query.png');
          frmMain.querymark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '19' then
      begin
        if frmMain.reportmark = 0 then
        begin
          frmMain.imgreport.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\report.png');
          frmMain.reportmark := 1;
        end;

      end
      else if arguments[0].GetStringValue = '9' then
      begin
        if frmMain.systemmark = 0 then
        begin
          frmMain.imgsystem.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
              + '\images\menu_1\system.png');
          frmMain.systemmark := 1;
        end;

      end;

    end;
    frmMain.Timer1.Enabled := false;
    Result := true;
  end
  else if (name = 'leavemenu') then
  begin
    if (Length(arguments) > 0) and (arguments[0].IsString) then
    begin
      if arguments[0].GetStringValue = '1' then
      begin
        frmMain.imgbase.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\base.png');
        frmMain.basemark := 0;
      end
      else if arguments[0].GetStringValue = '2' then
      begin
        frmMain.imgarchive.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\archive.png');
        frmMain.archivemark := 0;
      end
      else if arguments[0].GetStringValue = '17' then
      begin
        frmMain.imgvehiclecheck.Picture.LoadFromFile
          (ExtractFilePath(Paramstr(0)) + '\images\menu\vehiclecheck.png');
        frmMain.vehiclemark := 0;
      end
      else if arguments[0].GetStringValue = '1060018' then
      begin
        frmMain.imgdispatch.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\dispatch.png');
        frmMain.dispatchmark := 0;
      end
      else if arguments[0].GetStringValue = '3' then
      begin
        frmMain.imgsale.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\sale.png');
        frmMain.salemark := 0;
      end
      else if arguments[0].GetStringValue = '8' then
      begin
        frmMain.imgcheckticket.Picture.LoadFromFile
          (ExtractFilePath(Paramstr(0)) + '\images\menu\checkticket.png');
        frmMain.checkticketmark := 0;
      end
      else if arguments[0].GetStringValue = '20' then
      begin
        frmMain.imgpack.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\pack.png');
        frmMain.packmark := 0;
      end
      else if arguments[0].GetStringValue = '1060021' then
      begin
        frmMain.imgbalance.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\balance.png');
        frmMain.balancemark := 0;
      end
      else if arguments[0].GetStringValue = '18' then
      begin
        frmMain.imgquery.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\query.png');
        frmMain.querymark := 0;
      end
      else if arguments[0].GetStringValue = '19' then
      begin
        frmMain.imgreport.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\report.png');
        frmMain.reportmark := 0;
      end
      else if arguments[0].GetStringValue = '9' then
      begin
        frmMain.imgsystem.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
            + '\images\menu\system.png');
        frmMain.systemmark := 0;
      end;

    end;
    frmMain.Timer1.Enabled := true;
    Result := true;
  end
  else
    Result := false;
end;

procedure CefOnRegisterCustomSchemes(const registrar: ICefSchemeRegistrar);
begin
  registrar.AddCustomScheme('dcef', true, false, false);
end;
{ TfrmMain }

{
  procedure TfrmMain.CreateRzGroupItem(aItem: TMenuItem);
  var
  rzg: TRzGroup;
  rzgi,rzgiparent: TRzGroupItem;

  functionItemKey: PFunctionItemCall;

  parentMenu: TMenuItem;
  i,deep,topparentid,parentid:integer;
  topparentcaption:String;
  begin
  parentMenu := TMenuItem(aItem);
  deep:=-1;
  while assigned(parentMenu) do
  begin
  inc(deep);
  if assigned(parentMenu.Parent) and (not assigned(parentMenu.Parent.Parent)) then
  begin
  //找到顶级菜单
  topparentcaption:=parentMenu.Caption;
  topparentid:=parentMenu.id;
  break;
  end;
  parentMenu := TMenuItem(parentMenu.Parent);
  end;
  if deep=0 then
  begin
  rzg := TRzGroup.Create](rzgb_menu);
  rzg.Caption := aItem.Caption;
  rzg.Parent := rzgb_menu;
  rzg.Tag:=aItem.id;
  rzgb_menu.AddGroup(rzg);
  end
  else
  begin
  for i := 0 to rzgb_menu.GroupCount - 1 do
  //      if rzgb_menu.Groups[j].Caption = itemCaption then
  if rzgb_menu.Groups[i].Tag = topparentid then
  begin
  rzg := rzgb_menu.Groups[i];
  Break;
  end;
  rzgi := TRzGroupItem(rzg.Items.Add);
  rzgi.Caption := aItem.Caption;
  rzgi.IndentLevel := deep;
  rzgi.Tag:=aItem.id;
  if (rzgi.IndentLevel>1) then
  begin
  rzgiparent:=nil;
  for I := 0 to rzg.Items.Count - 1 do
  begin
  if rzg.Items.Items[i].Tag=TMenuItem(aitem.Parent).id then
  begin
  rzgiparent:=rzg.Items.Items[i];
  continue;
  end;
  if (rzgiparent<>nil) and (rzg.Items.Items[i].IndentLevel=rzgiparent.IndentLevel) then
  begin
  rzgi.Index:=rzg.Items.Items[i].Index;
  break;
  end;
  end;
  end;

  new(functionItemKey);
  functionItemKey^.FuctionItemKey := aItem.FuctionItemKey;
  functionItemKey^.parameters := aItem.parameters;
  functionItemKey^.menuItem := aItem;
  rzgi.Data := functionItemKey;
  if assigned(aitem.OnClick) then
  begin
  rzgi.onClick := menuItemClick;
  end;
  end;
  end;
}

function TfrmMain.CreateMenu(id: integer; name: string; guidstr: string;
  parameters: TFunctionItemParameters; parentId: integer; isvisible: boolean;
  hotkeystr: String): TObject;
var
  parentmenu, aItem: TMenuItem;
begin
  parentmenu := findParentMenuItem(parentId);
  if parentmenu = nil then
    Exit;
  aItem := TMenuItem.Create(Self);
  aItem.Caption := name;
  aItem.id := id;
  aItem.parameters := parameters;
  aItem.Visible := isvisible;
  if guidstr <> '' then
  begin
    aItem.FuctionItemKey := StringToGUID(guidstr);
    aItem.onClick := menuItemClick;
    if trim(hotkeystr) <> '' then
    begin
      aItem.hotkeyValue := TextToShortCut(hotkeystr);
      // aItem.ShortCut:=TextToShortCut(hotkeystr);
    end;
  end;
  parentmenu.Add(aItem);
  if isvisible and ((parentId = 18) or (parentId = 30) or (parentId = 32) or
      (parentId = 33) or (parentId = 34) or (parentId = 27) or
      (parentId = 8242) or (parentId = 6851)) then
  begin
    querymenucount := querymenucount + 1;
  end
  else if isvisible and ((parentId = 19) or (parentId = 31) or (parentId = 300)
      or (parentId = 301)) then
  begin
    reportmenucount := reportmenucount + 1;
  end
  else if isvisible and ((parentId = 1060018) or (parentId = 5) or
      (parentId = 6) or (parentId = 1060019)) then
  begin
    dispatchmenucount := dispatchmenucount + 1;
  end
  else if isvisible and ((parentId = 1060021) or (parentId = 4) or
      (parentId = 7) or (parentId = 100103) or (parentId = 18500) ) then
  begin
    balancemenucount := balancemenucount + 1;
  end;

  if (id = 1) and isvisible then
  begin
    imgbase.Visible := true;
    ImgList.Add(orderno, imgbase);
    orderno := orderno + 1;

  end
  else if (id = 2) and isvisible then
  begin
    imgarchive.Visible := true;
    ImgList.Add(orderno, imgarchive);
    orderno := orderno + 1;
  end
  else if (id = 17) and isvisible then
  begin
    imgvehiclecheck.Visible := true;
    ImgList.Add(orderno, imgvehiclecheck);
    orderno := orderno + 1;
  end
  else if (id = 1060018) and isvisible then
  begin
    imgdispatch.Visible := true;
    ImgList.Add(orderno, imgdispatch);
    orderno := orderno + 1;
  end
  else if (id = 3) and isvisible then
  begin
    imgsale.Visible := true;
    ImgList.Add(orderno, imgsale);
    orderno := orderno + 1;
  end
  else if (id = 8) and isvisible then
  begin
    imgcheckticket.Visible := true;
    ImgList.Add(orderno, imgcheckticket);
    orderno := orderno + 1;
  end
  else if (id = 20) and isvisible then
  begin
    imgpack.Visible := true;
    ImgList.Add(orderno, imgpack);
    orderno := orderno + 1;
  end
  else if (id = 1060021) and isvisible then
  begin
    imgbalance.Visible := true;
    ImgList.Add(orderno, imgbalance);
    orderno := orderno + 1;
  end
  else if (id = 18) and isvisible then
  begin
    imgquery.Visible := true;
    ImgList.Add(orderno, imgquery);
    orderno := orderno + 1;
  end
  else if (id = 19) and isvisible then
  begin
    imgreport.Visible := true;
    ImgList.Add(orderno, imgreport);
    orderno := orderno + 1;
  end
  else if (id = 9) and isvisible then
  begin
    imgsystem.Visible := true;
    ImgList.Add(orderno, imgsystem);
    orderno := orderno + 1;
  end;
  // CreateRzGroupItem(aItem);
end;

procedure TfrmMain.ExitApplication;
var
  LoginIntf: ILogin;
  i, count: integer;
  tab: TTabSheet;
begin
  if SysInfo.LoginUserInfo = nil then
  begin
    application.Terminate;
    Exit;
  end;
  for i := 1 to Self.pgcForms.PageCount - 1 do
  begin
    if (TCustomForm(Self.pgcForms.Pages[i].Tag).ClassName = 'TFrmCheckTicket')
      or (TCustomForm(Self.pgcForms.Pages[i].Tag).ClassName = 'TFrmTakeTicket')
      or (TCustomForm(Self.pgcForms.Pages[i].Tag).ClassName = 'TFrmSellTicket')
      or (TCustomForm(Self.pgcForms.Pages[i].Tag)
        .ClassName = 'TFrmChangeTicket') or
      (TCustomForm(Self.pgcForms.Pages[i].Tag)
        .ClassName = 'TFrmSellBookTicket') then
    begin
      tab := TTabSheet(Self.pgcForms.Pages[i]);
      Self.CloseForm(TForm(tab.Tag));
      // Break;
    end;
  end;
  if SysService.QueryInterface(ILogin, LoginIntf) = S_OK then
  begin
    LoginIntf.Logout();
  end
  else
  begin
    // SysDialogs.ShowError('找不到退出模块！');
    // SysMainForm.ExitApplication;
  end;
  application.Terminate;
end;

// function TfrmMain.FindForm(const FormClassName: string): TForm;
// var
// tab: TTabSheet;
// begin
// Result := nil;
// tab := self.FindTab(FormClassName);
// if assigned(tab) then
// Result := TForm(tab.Tag);
// end;

function TfrmMain.findmenuitem(guid: TGUID; parameters: TStringList;
  parentmenu: Menus.TMenuItem): Menus.TMenuItem;
var
  i, j, k: integer;
  menusitemlist, menuthirdlist: Menus.TMenuItem;
  isfind: boolean;
begin
  Result := nil;
  if parentmenu = nil then
  begin
    parentmenu := MainMenu.Items;
  end;
  isfind := false;
  for i := 0 to MainMenu.Items.count - 1 do
  begin
    menusitemlist := MainMenu.Items[i];
    for j := 0 to menusitemlist.count - 1 do
    begin
      if GUIDToString((menusitemlist.Items[j] as TMenuItem).FuctionItemKey)
        = GUIDToString(guid) then
      begin
        if (parameters = nil) and ((menusitemlist.Items[j] as TMenuItem)
            .parameters = nil) then
        begin
          Result := menusitemlist.Items[j];
          isfind := true;
          Break;
        end
        else if (parameters.text = (menusitemlist.Items[j] as TMenuItem)
            .parameters.text) then
        begin
          Result := menusitemlist.Items[j];
          isfind := true;
          Break;
        end;
      end;
      menuthirdlist := menusitemlist.Items[j];
      for k := 0 to menuthirdlist.count - 1 do
      begin
        if GUIDToString((menuthirdlist.Items[k] as TMenuItem).FuctionItemKey)
          = GUIDToString(guid) then
        begin
          if (parameters = nil) and ((menuthirdlist.Items[k] as TMenuItem)
              .parameters = nil) then
          begin
            Result := menuthirdlist.Items[k];
            isfind := true;
            Break;
          end
          else if (parameters.text = (menuthirdlist.Items[k] as TMenuItem)
              .parameters.text) then
          begin
            Result := menuthirdlist.Items[k];
            isfind := true;
            Break;
          end;
        end;
        if isfind then
          Break;
      end;
      if isfind then
        Break;
    end;
    if isfind then
      Break;
  end;
  // ----------以前递归
  // for I := 0 to parentmenu.Count -1 do
  // begin
  // if parentmenu.Items[i].Count>0 then
  // begin
  // Result:=findmenuitem(guid,parameters,parentmenu.Items[i]);
  // if Result<>nil then
  // begin
  // Break;
  // end;
  // end
  // else if GUIDToString((parentmenu.Items[i] as TMenuItem).FuctionItemKey)=GUIDToString(guid) then
  // begin
  // if(parameters=nil) or ((parentmenu.Items[i] as TMenuItem).parameters=nil )then
  // begin
  // Result:=parentmenu.Items[i];
  // break;
  // end
  // else
  // if( parameters.text=(parentmenu.Items[i] as TMenuItem).parameters.text)then
  // begin
  // Result:=parentmenu.Items[i];
  // Break;
  // end
  // else
  // begin
  // Break;
  // end;
  //
  // end;
  // end;

end;

function TfrmMain.findParentMenuItem(parentId: integer): TMenuItem;
  function findmenuitem(menuItem: TMenuItem): TMenuItem;
  var
    i: integer;
  begin
    Result := nil;
    for i := 0 to menuItem.count - 1 do
    begin
      if TMenuItem(menuItem.Items[i]).id = parentId then
      begin
        Result := TMenuItem(menuItem.Items[i]);
        Break;
      end;
      if menuItem.Items[i].count > 0 then
      begin
        Result := findmenuitem(TMenuItem(menuItem.Items[i]));
        if Result <> nil then
        begin
          Break;
        end;
      end;
    end;
  end;

begin
  if parentId = 0 then
  begin
    Result := TMenuItem(MainMenu.Items);
    Exit;
  end;
  Result := findmenuitem(TMenuItem(MainMenu.Items));
end;

function TfrmMain.FindTab(Aform: TCustomForm): TTabSheet;
var
  i: integer;
begin
  Result := nil;
  for i := 1 to Self.pgcForms.PageCount - 1 do
  begin
    if TCustomForm(Self.pgcForms.Pages[i].Tag) = Aform then
    begin
      Result := TTabSheet(Self.pgcForms.Pages[i]);
      Exit;
    end;
  end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
  if assigned(pgcForms.ActivePage) then
  begin
    if (pgcForms.ActivePage <> pgcForms.Pages[0]) then
    begin
      TCrackCustomForm(pgcForms.ActivePage.Tag).Activate;
    end;
    refreshPath(TTabSheet(pgcForms.ActivePage).menuItem);
  end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ImgList.Free;
  ExitApplication;
  // ServerSocket1.Close;
  // 退出系统
  // SysFunctionMgr.exec(StringToGUID('{77C3AE74-3F62-4741-ACA4-E365FF6AB562}'),
  // nil);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  tmrTime.Enabled := false;
  tmr1.Enabled:=false;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  Ini: TIniFile;
  tabstyle: integer;
  imgframebgsrc: string;
  strurl, mainurl, beginmenuurl, endmenuurl: string;
  firstLocate: integer;
begin
  initMenuStyle;
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  LongDateFormat := 'yyyy-mm-dd';
  TimeSeparator := ':';
  ShortTimeFormat := 'hh:nn:ss';
  LongTimeFormat := 'hh:nn:ss';
  application.UpdateFormatSettings := false;

  MainMenu.AutoHotkeys := maAutomatic; // maManual;
  selfActiveWhenKeydown := false;
  selfKeydowned := false;
//  application.OnException := HandleException;
  UDMPublic.SkinData := Self.SkinData1;

  // Image1.Left:=((pgcForms.Width-Image1.Width) div 2)+50;
  // Image1.Top:=((pgcForms.Height-Image1.Height)div 2)+30;
  Self.Update;
  try
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    tabstyle := Ini.ReadInteger('backgroundtab', 'tabstyle', 0);
    if tabstyle = 1 then
    begin

      // Chromium1.Browser.MainFrame.LoadUrl(Ini.ReadString('system', 'url', '')+'/indexhead/index');

      strurl := Ini.ReadString('server', 'download', '');
      firstLocate := pos('//', strurl);
      mainurl := copy(strurl, firstLocate + 2, Length(strurl));
      beginmenuurl := copy(strurl, 1, firstLocate + 1);
      endmenuurl := copy(mainurl, 1, pos('/', mainurl) - 1);
      Chromium1.Browser.MainFrame.LoadUrl
        (beginmenuurl + endmenuurl + '/indexhead/index');

      Chromium1.Visible := true;
    end
    else
    begin
      imgframebgsrc := Ini.ReadString('backgroundtab', 'imgframebgsrc',
        'welcome.bmp');
      imgframebg.Picture.LoadFromFile
        (ExtractFilePath(Paramstr(0)) + '\images\' + imgframebgsrc);
      imgframebg.Visible := true;
    end;

  finally
    Ini.Free;
  end;

  ImgList := TDictionary<integer, TImage>.Create;
  querymenucount := 0;
  reportmenucount := 0;
  dispatchmenucount := 0;
  balancemenucount:=0;
  Application.OnException := ApplicationEvents1.OnException;
end;

procedure TfrmMain.FormDeactivate(Sender: TObject);
begin
  selfActiveWhenKeydown := false;
  selfKeydowned := false;
  if assigned(pgcForms.ActivePage) then
  begin
    if (pgcForms.ActivePage <> pgcForms.Pages[0]) then
    begin
      TCrackCustomForm(pgcForms.ActivePage.Tag).Deactivate;
    end;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  freePoint();
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  childForm: TCustomForm;
begin
  selfActiveWhenKeydown := Self.Active;
  selfKeydowned := true;
  if ActiveControl = nil then
    Exit;
  childForm := GetParentForm(ActiveControl, false);
  if (childForm <> nil) and (childForm <> Self) and (childForm.KeyPreview) then
  // 子窗体要自己处理按键
  begin
    TCrackWinControl(childForm).KeyDown(Key, Shift);
  end;
end;

procedure TfrmMain.FormKeyPress(Sender: TObject; var Key: Char);
var
  childForm: TCustomForm;
begin
  if ActiveControl = nil then
    Exit;
  childForm := GetParentForm(ActiveControl, false);
  if (childForm <> nil) and (childForm <> Self) and (childForm.KeyPreview) then
  // 子窗体要自己处理按键
  begin
    TCrackWinControl(childForm).KeyPress(Key);
  end;
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: word;
  Shift: TShiftState);
var
  childForm: TCustomForm;
  shortcutstr: String;
begin
  if not selfActiveWhenKeydown then
  begin
    selfKeydowned := false;
    Exit;
  end;
  if not selfKeydowned then
    Exit;
  selfActiveWhenKeydown := false;
  selfKeydowned := false;
  if ActiveControl = nil then
    Exit;
  childForm := GetParentForm(ActiveControl, false);
  if (childForm <> nil) and (childForm <> Self) and (childForm.KeyPreview) then
  // 子窗体要自己处理按键
  begin
    TCrackWinControl(childForm).KeyUp(Key, Shift);
  end;
  if Key > 0 then
  begin
    if Key = vk_return then
    begin
      if (ActiveControl is Tcombobox) then
        if (ActiveControl as Tcombobox).Style in [csDropDownList,
          csOwnerDrawFixed, csOwnerDrawVariable] then
          Key := 0;
      selectnext(ActiveControl, true, true);
    end
    else if Key = vk_escape then
    begin
      if (ActiveControl is Tcombobox) then
        if (ActiveControl as Tcombobox).Style in [csDropDownList,
          csOwnerDrawFixed, csOwnerDrawVariable] then
          Key := 0;
      selectnext(ActiveControl, false, true);
    end
    else
    begin
      handMenuShortCut(ShortCut(Key, Shift));
    end;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  localhostport, i, imgheight, heartbeatrate: integer;
  Ini: TIniFile;
begin
  Screen.OnActiveControlChange := screenActiveControlChange;
  refreshPath(TMenuItem(MainMenu.Items));
  tmrTime.Enabled := true;
  { try
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    localhostport := strtoint(Ini.ReadString('localhostport', 'port', '8888'));
    Ini.WriteString('localhostport', 'port', inttostr(localhostport));
    ServerSocket1.Close;
    // self.Caption:=sysinfo.LocalHostPort;
    ServerSocket1.Port := localhostport;
    ServerSocket1.Open;


    finally
    Ini.Free;
    end; }
  if(getParametervalue('0066', sysInfo.LoginUserInfo.OrgID)='1') then
  begin
    tmr1.interval := StrToInt(getParametervalue('0067', sysInfo.LoginUserInfo.OrgID)) * 1000 ; //窗体打开默认10秒自动刷新
    tmr1.Enabled:=true;
  end;
//  try
//    heartbeatrate := StrToInt( getParametervalue('0040', sysInfo.LoginUserInfo.OrgID));
//  except
//    on E: Exception do
//    begin
//      heartbeatrate := 15;
//    end;
//  end;
//  if heartbeatrate>0 then
//  begin
//    HeartBeatTimer.Interval := heartbeatrate * 1000;
    HeartBeatTimer.Enabled := True;
//  end;
  basemark := 0;
  archivemark := 0;
  vehiclemark := 0;
  dispatchmark := 0;
  salemark := 0;
  checkticketmark := 0;
  packmark := 0;
  balancemark := 0;
  querymark := 0;
  reportmark := 0;
  systemmark := 0;
  orderno := 0;
  // 菜单排版
  if ImgList.count > 0 then
  begin
    ImgList.Items[0].top := 85;
    imgheight := ImgList.Items[0].Height;
  end;
  for i := 1 to ImgList.count - 1 do
  begin
    ImgList.Items[i].top := ImgList.Items[i - 1].top + imgheight + 5;
  end;
end;

procedure TfrmMain.freePoint;
var
  i, j: integer;
begin
  {
    for I := 0 to rzgb_menu.GroupCount - 1 do
    begin
    for j := 0 to rzgb_menu.Groups[I].Items.Count - 1 do
    begin
    if rzgb_menu.Groups[I].Items.Items[j].Data <> nil then
    begin
    Dispose(rzgb_menu.Groups[I].Items.Items[j].Data);
    rzgb_menu.Groups[I].Items.Items[j].Data := nil;
    end;
    end;
    end;
    }
end;

procedure TfrmMain.HandleException(Sender: TObject; E: Exception);
begin
  frmException := TfrmException.Create(nil);
  try
    frmException.ExceptionClass := E.ClassName;
    if Sender.InheritsFrom(TComponent) then
      frmException.SourceClass := TComponent(Sender).Name;
    frmException.ExceptionMsg := E.Message;
//     frmException.ShowModal;
  finally
    frmException.Free;
  end;
end;

procedure TfrmMain.handMenuShortCut(hotkeyValue: word);
var
  _menuitem: TMenuItem;
  AllowChange: boolean;
  function findmenuitem(menuItem: TMenuItem): TMenuItem;
  var
    i: integer;
  begin
    Result := nil;
    for i := 0 to menuItem.count - 1 do
    begin
      if TMenuItem(menuItem.Items[i]).hotkeyValue = hotkeyValue then
      begin
        Result := TMenuItem(menuItem.Items[i]);
        Break;
      end;
      if menuItem.Items[i].count > 0 then
      begin
        Result := findmenuitem(TMenuItem(menuItem.Items[i]));
        if Result <> nil then
        begin
          Break;
        end;
      end;
    end;
  end;

begin
  _menuitem := findmenuitem(TMenuItem(MainMenu.Items));
  if (_menuitem <> nil) and (_menuitem.Visible) then
  begin
    pgcFormsChanging(nil, AllowChange);
    _menuitem.Click;
    pgcFormsChange(nil);
  end;
end;

procedure TfrmMain.HeartBeatTimerTimer(Sender: TObject);
var haeartbeatmsg : string;
begin
//  //心跳包发送
// { try
//    if SysInfo.LoginUserInfo = nil then
//       exit ;
//    //SysFunctionMgr.exec(StringToGUID('{624DD1FA-8898-4563-B80C-F0646AACBECE}'), nil);
// { except
//    on E: Exception do
//    begin
//      SysLog.WriteErr('心跳包调用失败:' + e.Message);
//    end;
//  end;
//  HeartBeatTimer.Enabled := False; }
end;

procedure TfrmMain.imgbalanceClick(Sender: TObject);
begin
  imgbalance.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\balance.png');
  balancemark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgbalance.top > frmMain.Height - pnlmenu.Height - 110 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 110;
  end
  else
  begin
    pnlmenu.top := imgbalance.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 55;
  end;
  if balancemenucount > 36 then
    begin
      pnlmenu.Width := 650;
    end
    else
    begin
      pnlmenu.Width := 440;
    end;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''1060021'')',
    'about:blank', 0);
end;

procedure TfrmMain.imgbalanceMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgbalance.Left + imgbalance.Width, imgbalance.top,
      pnlmenu.Left, imgbalance.Height + imgbalance.top), p1) then
  begin
    imgbalance.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\balance.png');
    balancemark := 0;
    Timer1.Enabled := true;
  end;
end;

procedure TfrmMain.imgbaseClick(Sender: TObject);
begin
  imgbase.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\base.png');
  basemark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgbase.top > frmMain.Height - pnlmenu.Height - 270 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 210;
  end
  else
  begin
    pnlmenu.top := imgbase.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 20;
  end;

  pnlmenu.Width := 440;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''1'')', 'about:blank',
    0);
end;

procedure TfrmMain.imgbaseMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgbase.Left + imgbase.Width, imgbase.top, pnlmenu.Left,
      imgbase.Height + imgbase.top), p1) then
  begin
    imgbase.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\base.png');
    basemark := 0;
    Timer1.Enabled := true;
  end;

end;

procedure TfrmMain.initMenuStyle;
var
  Ini: TIniFile;
  menustyle: integer;
begin
  menustyle := 0;
  if FileExists(ExtractFilePath(Paramstr(0)) + applicationCfgName) then
  begin
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    try
      menustyle := Ini.ReadInteger('system', 'menustyle', 0);
    finally
      Ini.Free;
    end;
  end;
  if menustyle = 1 then
  begin
    tlbAddress.Visible := false;
    scrlbxleft.Visible := false;
  end
  else if menustyle = 3 then
  begin
    Self.Menu := nil;
    tlbAddress.Visible := false;
    scrlbxleft.Visible := false;
    // pnlwebmenu.Visible:=true;
    // tmrwebmenu.Enabled:=True;
  end
  else
  begin
    sp := TNovaSplitter.Create(Self);
    with sp do
    begin
      Align := alLeft;
      Left := scrlbxleft.Left + scrlbxleft.Width;
      parent := Self;
      MinSize := 100;
    end;
    if menustyle = 2 then
    begin
      Self.Menu := nil;
    end;
  end;
end;

function TfrmMain.locationTab(guid: TGUID; parameters: TFunctionItemParameters)
  : boolean;
var
  i: integer;
  menuItem: TMenuItem;
  AllowChange: boolean;
begin
  Result := false;
  for i := 1 to Self.pgcForms.PageCount - 1 do
  begin
    menuItem := TTabSheet(Self.pgcForms.Pages[i]).menuItem;
    if (GUIDToString(menuItem.FuctionItemKey) = GUIDToString(guid)) and
      (((menuItem.parameters = nil) and (parameters = nil)) or
        ((menuItem.parameters <> nil) and (parameters <> nil)
          and menuItem.parameters.Equals(parameters))) then
    begin
      Result := true;
      if Self.pgcForms.ActivePage <> Self.pgcForms.Pages[i] then
      begin
        AllowChange := true;
        pgcFormsChanging(pgcForms, AllowChange);
        Self.pgcForms.ActivePage := Self.pgcForms.Pages[i];
        pgcFormsChange(pgcForms);
      end;
      Break;
    end;
  end;
end;

procedure TfrmMain.loadchrom;
var
  Ini: TIniFile;
  strurl, mainurl, beginmenuurl, endmenuurl: string;
  firstLocate: integer;
begin
  try
    Ini := TIniFile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);

    // frmMain.chrm1.Browser.MainFrame.LoadUrl(Ini.ReadString('system', 'url', '')+'/menu');

    strurl := Ini.ReadString('server', 'download', '');
    firstLocate := pos('//', strurl);
    mainurl := copy(strurl, firstLocate + 2, Length(strurl));
    beginmenuurl := copy(strurl, 1, firstLocate + 1);
    endmenuurl := copy(mainurl, 1, pos('/', mainurl) - 1);
    frmMain.chrm1.Browser.MainFrame.LoadUrl
      (beginmenuurl + endmenuurl + '/menu' + '/' + inttostr
        (SysInfo.LoginUserInfo.UserID));

  finally
    Ini.Free;
  end;
end;

procedure TfrmMain.setLblloginname(const loginname: string);
begin
  lblloginname.Caption := loginname;
end;

procedure TfrmMain.lockscreenbtnClick(Sender: TObject);
begin
  if ismousedown then
  begin
    ismousedown:=False;
    SysFunctionMgr.exec(StringToGUID('{334691FC-3E05-4CA2-BC24-555DF89226F0}'),
    nil);

  end;
end;

procedure TfrmMain.lockscreenbtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ismousedown:=true;
end;

procedure TfrmMain.lockscreenbtnMouseLeave(Sender: TObject);
begin
  lockscreenbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\01.bmp');
end;

procedure TfrmMain.lockscreenbtnMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  lockscreenbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\01h.bmp');
end;

function TfrmMain.CreateMenu(const Path: string; guid: TGUID;
  parameters: TFunctionItemParameters): TObject;
var
  aList: TStrings;
  newItem: TMenuItem;
  // newGroupItem: TRzGroupItem;
  function CreateMenuItem(aList: TStrings): TMenuItem;
  var
    i: integer;
    pItem, aItem: TMenuItem;
    itemCaption: string;
  begin
    aItem := nil;
    pItem := TMenuItem(MainMenu.Items);
    for i := 0 to aList.count - 1 do
    begin
      itemCaption := aList[i];
      aItem := TMenuItem(pItem.Find(itemCaption));

      if aItem = Nil then
      begin
        aItem := TMenuItem.Create(Self);
        aItem.Caption := itemCaption;
        pItem.Add(aItem);
      end;
      pItem := aItem;
    end;
    Result := aItem;
  end;

{
  function CreateRzGroupItem(aList: TStrings; guid: TGUID;
  parameters: TFunctionItemParameters): TRzGroupItem;
  var
  rzg: TRzGroup;
  rzgi: TRzGroupItem;
  I, j, k: integer;
  itemCaption: string;
  functionItemKey: PFunctionItemCall;
  begin
  rzg := nil;
  for I := 0 to aList.Count - 1 do
  begin
  itemCaption := aList[I];
  if I = 0 then
  begin
  for j := 0 to rzgb_menu.GroupCount - 1 do
  if rzgb_menu.Groups[j].Caption = itemCaption then
  begin
  rzg := rzgb_menu.Groups[j];
  Break;
  end;
  if rzg = nil then
  begin
  rzg := TRzGroup.Create(rzgb_menu);
  rzg.Caption := itemCaption;
  rzg.Parent := rzgb_menu;
  rzgb_menu.AddGroup(rzg);
  end;
  end
  else
  begin
  rzgi := nil;
  for k := 0 to rzg.Items.Count - 1 do
  if (GUIDToString(rzg.Items.Items[k].getFuctionItemKey()) = GUIDToString(guid))
  and (((rzg.Items.Items[k].getParameters=nil) and (parameters=nil))
  or ((rzg.Items.Items[k].getParameters<>nil) and (parameters<>nil) and rzg.Items.Items[k].getParameters.Equals(parameters))
  ) then
  begin
  rzgi := TRzGroupItem(rzg.Items.Items[k]);
  Break;
  end;
  if rzgi = nil then
  begin
  rzgi := TRzGroupItem(rzg.Items.Add);
  rzgi.Caption := itemCaption;
  rzgi.IndentLevel := I - 1;
  if I = aList.Count - 1 then
  begin
  new(functionItemKey);
  functionItemKey^.FuctionItemKey := guid;
  functionItemKey^.parameters := parameters;
  rzgi.Data := functionItemKey;
  rzgi.onClick := menuItemClick;
  end;
  end;
  end;
  end;
  Result := rzgi;
  end;
  }
begin
  /// //////////////////////////////////////////////////
  /// 不使用DEBUG直接注册了
  Exit;
  /// //////////////////////////////////////////////////
  Result := nil;
  if trim(Path) = '' then
    Exit;
  aList := TStringList.Create;
  try
    ExtractStrings(['\'], [], Pchar(Path), aList);
    newItem := CreateMenuItem(aList);
    newItem.FuctionItemKey := guid;
    newItem.onClick := menuItemClick;
    newItem.parameters := parameters;
    {
      newGroupItem := CreateRzGroupItem(aList, guid, parameters);
      if assigned(newGroupItem) and (newGroupItem.Data <> nil) then
      PFunctionItemCall(newGroupItem.Data).menuItem := newItem;
      }
    Result := newItem;
  finally
    aList.Free;
  end;
end;

function TfrmMain.showFormModal(Aform: TForm;
  autofree: boolean = true): integer;
var
  AllowChange: boolean;
begin
  if SkinData1.Active and (Aform.Tag <> SkinData1.DisableTag) then
  begin
    // SkinData1.UpdateSkinControl(aForm);
    SkinData1.AddNestForm(Self, Aform);
  end;
  AllowChange := true;
  pgcFormsChanging(nil, AllowChange);
  Result := Aform.ShowModal;
  if autofree then
  begin
    FreeAndNil(Aform);
  end;
  pgcFormsChange(nil);
end;

procedure TfrmMain.ShowStatus(PnlIndex: integer; const Msg: string);
begin
  if (PnlIndex >= 0) and (PnlIndex < StatusBar.Panels.count - 1) then
    StatusBar.Panels[PnlIndex].text := Msg;
end;

procedure TfrmMain.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  if (Panel = StatusBar.Panels[3]) then
  begin
    StatusBar.canvas.font.color := clblue;
    StatusBar.canvas.font.Size := 14;
    StatusBar.canvas.font.Style := [fsbold];
    StatusBar.canvas.textOut(Rect.Left + 1, Rect.top + 1, Panel.text);
  end;
end;

procedure TfrmMain.imgsystemClick(Sender: TObject);
begin
  imgsystem.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\system.png');
  systemmark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgsystem.top > frmMain.Height - pnlmenu.Height - 50 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 50;
  end
  else
  begin
    pnlmenu.top := imgsystem.top;
  end;
  pnlmenu.Width := 440;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''9'')', 'about:blank',
    0);
end;

procedure TfrmMain.imgsystemMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgsystem.Left + imgsystem.Width, imgsystem.top,
      pnlmenu.Left, imgsystem.Height + imgsystem.top), p1) then
  begin
    imgsystem.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\system.png');
    systemmark := 0;
    Timer1.Enabled := true;
  end;

end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
var
  ps, pc: TPoint; //screen, client
begin
  GetCursorPos(ps);
  pc := frmMain.ScreenToClient(ps);
  if not PtInrect(Rect(frmMain.pnlmenu.Left,
        frmMain.pnlmenu.top,
        frmMain.pnlmenu.Left+frmMain.pnlmenu.Width,
        frmMain.pnlmenu.top + frmMain.pnlmenu.Height+5),
        pc) then
  begin
    //光标定位在区域内，底部+5增加操作稳定性
    chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
    pnlwebmenu.Visible := false;
    pnlmenu.Visible := false;
  end
  else
  begin
    //光标移出区域
  end;
end;

procedure TfrmMain.tmr1Timer(Sender: TObject);
begin
  SysFunctionMgr.exec(StringToGUID('{8A2730E9-F70F-40F6-BEF4-0B0FED44E3BE}'), nil);
end;

procedure TfrmMain.tmrTimeTimer(Sender: TObject);
begin
  StatusBar.Panels[3].text := FormatDateTime('YYYY.MM.DD', Date)
    + ' 星期' + getWeekNum(DayOfWeek(Now())) + ' ' + FormatDateTime('HH:MM:SS',
    Time)
end;

procedure TfrmMain.tmrwebmenuTimer(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := pnlwebmenu.ScreenToClient(p);
  if (pnlwebmenu.Align = alNone) and (p1.Y < 60) and (p1.X < WEBMENUWIDTH) then
  begin
    pnlwebmenu.Align := alLeft;
    pnlwebmenu.Width := WEBMENUWIDTH;
  end
  else if (p1.Y > 60) and (p1.X < WEBMENUWIDTH) and (p1.X > 0) then
  begin
    pnlwebmenu.Align := alNone;
    pnlwebmenu.top := 40;
    pnlwebmenu.Left := 0;
    pnlwebmenu.Width := Self.ClientWidth;
    pnlwebmenu.Height := Self.ClientHeight - StatusBar.Height - 34;
  end
  else
  begin
  end;
end;

procedure TfrmMain.imgvehiclecheckClick(Sender: TObject);
begin
  imgvehiclecheck.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\vehiclecheck.png');
  vehiclemark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgvehiclecheck.top > frmMain.Height - pnlmenu.Height - 210 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 210;
  end
  else
  begin
    pnlmenu.top := imgvehiclecheck.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 30;
  end;
  pnlmenu.Width := 440;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''17'')', 'about:blank',
    0);
end;

procedure TfrmMain.imgvehiclecheckMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgvehiclecheck.Left + imgvehiclecheck.Width,
      imgvehiclecheck.top, pnlmenu.Left,
      imgvehiclecheck.Height + imgvehiclecheck.top), p1) then
  begin
    imgvehiclecheck.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\vehiclecheck.png');
    vehiclemark := 0;
    Timer1.Enabled := true;
  end;

end;

procedure TfrmMain.pnlmenuMouseLeave(Sender: TObject);
begin
  // OutputDebugString('leave');
end;

procedure TfrmMain.DeleteMenu(const Path: string);
begin
  //
end;

procedure TfrmMain.imgdispatchClick(Sender: TObject);
begin
  imgdispatch.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\dispatch.png');
  dispatchmark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgdispatch.top > frmMain.Height - pnlmenu.Height - 190 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 190;
  end
  else
  begin
    pnlmenu.top := imgdispatch.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 35;
  end;
  if dispatchmenucount > 36 then
  begin
    pnlmenu.Width := 650;
  end
  else
  begin
    pnlmenu.Width := 440;
  end;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''1060018'')',
    'about:blank', 0);
end;

procedure TfrmMain.imgdispatchMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgdispatch.Left + imgdispatch.Width, imgdispatch.top,
      pnlmenu.Left, imgdispatch.Height + imgdispatch.top), p1) then
  begin
    imgdispatch.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\dispatch.png');
    dispatchmark := 0;
    Timer1.Enabled := true;
  end;

end;

procedure TfrmMain.imghideClick(Sender: TObject);
begin
  if frmMain.scrlbxmenuleft.Visible then
  begin
    frmMain.scrlbxmenuleft.Visible := false;
    imghide.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\hideright.png');
    imghide.Hint := '点击显示左侧菜单';
  end
  else
  begin
    frmMain.scrlbxmenuleft.Visible := true;
    imghide.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\hide.png');
    imghide.Hint := '点击隐藏左侧菜单';
  end;
  // frmMain.pnlhide.Visible:=true;
end;

procedure TfrmMain.aboutbtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ismousedown:=true;
end;

procedure TfrmMain.aboutbtnMouseLeave(Sender: TObject);
begin
  aboutbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0)) + '\images\02.bmp');
end;

procedure TfrmMain.aboutbtnMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  aboutbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0)) + '\images\02h.bmp');
end;

function TfrmMain.AddImage(Img: TGraphic): integer;
begin
  Result := -1;
  if Img = nil then
    Exit;
  if Img is TBitmap then
    Result := Self.il_largeMenu.Add(TBitmap(Img), TBitmap(Img))
  else if Img is TIcon then
    Result := Self.il_largeMenu.AddIcon(TIcon(Img));
end;

procedure TfrmMain.ApplicationEvents1Exception(Sender: TObject; E: Exception);
var
  tab: TTabSheet;
begin
  if Pos('{flag:-300}',e.Message)>0 then
  begin
    try
      SysDialogs.Warning('系统登录超时,请重新登录!若打开的模块不可使用请关闭重新打开!');
      SysFunctionMgr.exec(StringToGUID('{334691FC-3E05-4CA2-BC24-555DF89226F0}'),
        nil);

    finally
      tab := TTabSheet(Self.pgcForms.ActivePage);
      Self.CloseForm(TForm(tab.Tag));
    end;

  end
  else
  if Pos('灾难性故障',e.Message)>0 then
  begin
    frmException := TfrmException.Create(nil);
    try
      frmException.ExceptionClass := E.ClassName;
      if Sender.InheritsFrom(TComponent) then
        frmException.SourceClass := TComponent(Sender).Name;
      SysLog.WriteErr(e.Message);
      //SysLog.WriteLog(E.Message+'');
      frmException.ExceptionMsg := '请尝试重新登录!';
       frmException.ShowModal;
    finally
      frmException.Free;
    end;
  end
  else
  begin
    SysLog.WriteErr(e.Message);
  end;
end;

procedure TfrmMain.BitBtn_ReLoadClick(Sender: TObject);
  var
  LoginIntf: ILogin;
  i, count: integer;
  tab: TTabSheet;
begin
  if ismousedown then
  begin
    ismousedown:=False;
    if not SysDialogs.Confirm('信息提示', '确认要重新登录吗?') then
      Exit;

    if SysInfo.LoginUserInfo = nil then
    begin
      application.Terminate;
      Exit;
    end;
    for i := 1 to Self.pgcForms.PageCount - 1 do
    begin
      if (TCustomForm(Self.pgcForms.Pages[i].Tag).ClassName = 'TFrmCheckTicket')
        or (TCustomForm(Self.pgcForms.Pages[i].Tag).ClassName = 'TFrmTakeTicket')
        or (TCustomForm(Self.pgcForms.Pages[i].Tag).ClassName = 'TFrmSellTicket')
        or (TCustomForm(Self.pgcForms.Pages[i].Tag)
          .ClassName = 'TFrmChangeTicket') or
        (TCustomForm(Self.pgcForms.Pages[i].Tag)
          .ClassName = 'TFrmSellBookTicket') then
      begin
        tab := TTabSheet(Self.pgcForms.Pages[i]);
        Self.CloseForm(TForm(tab.Tag));
        // Break;
      end;
    end;
    if SysService.QueryInterface(ILogin, LoginIntf) = S_OK then
    begin
      LoginIntf.Logout();
    end;
    application.Terminate;
    ShellExecute(Application.Handle, 'OPEN', PChar(paramstr(0)),
    '', '', SW_SHOWNORMAL);
  end;

end;

procedure TfrmMain.BitBtn_ReLoadMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ismousedown:=true;
end;

procedure TfrmMain.BitBtn_ReLoadMouseLeave(Sender: TObject);
begin
  BitBtn_ReLoad.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\05.bmp');
end;

procedure TfrmMain.BitBtn_ReLoadMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  BitBtn_ReLoad.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\05h.bmp');
end;

procedure TfrmMain.imgarchiveClick(Sender: TObject);
begin
  imgarchive.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\archive.png');
  archivemark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgarchive.top > frmMain.Height - pnlmenu.Height - 250 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 210;
  end
  else
  begin
    pnlmenu.top := imgarchive.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 25;
  end;
  pnlmenu.Width := 440;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''2'')', 'about:blank',
    0);
end;

procedure TfrmMain.imgarchiveMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgarchive.Left + imgarchive.Width, imgarchive.top,
      pnlmenu.Left, imgarchive.Height + imgarchive.top), p1) then
  begin
    imgarchive.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\archive.png');
    archivemark := 0;
    Timer1.Enabled := true;
  end;

end;

function TfrmMain.CreateToolButton(const aCaption: String;
  onClick: TNotifyEvent; Hint: String): TObject;
var
  ToolButton: TToolButton;
begin
  // ToolButton:=TToolButton.Create(self);
  // ToolButton.Parent:=self.ToolBar1;
  // ToolButton.Left:=ToolBar1.Buttons[ToolBar1.ButtonCount-1].Left+ToolBar1.Buttons[ToolBar1.ButtonCount-1].Width;
  // if aCaption='-' then//是分隔
  // begin
  // ToolButton.Style:=tbsDivider;
  // ToolButton.Width:=8;
  // end else begin
  // ToolButton.Caption:=aCaption;
  // ToolButton.OnClick:=onClick;
  // if Hint<>'' then
  // begin
  // ToolButton.ShowHint:=True;
  // ToolButton.Hint:=Hint;
  // end;
  // end;
  // Result:=ToolButton;
end;

procedure TfrmMain.menuItemClick(Sender: TObject);
begin
  if (Sender is TMenuItem) then
  begin
    curMenuItem := (Sender as TMenuItem);
    refreshPath(curMenuItem);
    OutputDebugString(PWideChar('FuctionItemKey: '+guidtostring(curMenuItem.FuctionItemKey)));
    if guidtostring(curMenuItem.FuctionItemKey)='{77C3AE74-3F62-4741-ACA4-E365FF6AB562}'  then
    begin
       exitbtnClick(nil);
    end;
    SysFunctionMgr.exec(curMenuItem.FuctionItemKey, curMenuItem.parameters);
  end
  { else
    begin
    curMenuItem := (Sender as TRzGroupItem).getMenuItem;
    refreshPath(curMenuItem);
    SysFunctionMgr.exec((Sender as TRzGroupItem).getFuctionItemKey(),
    (Sender as TRzGroupItem).getParameters);
    end
    }
  ;
end;

procedure TfrmMain.modifypwdbtnClick(Sender: TObject);
begin
  if ismousedown then
  begin
    ismousedown:=False;
  SysFunctionMgr.exec(StringToGUID('{0B2D3890-4904-43D8-9D98-D43A486902AE}'),
    nil);
  end;
end;

procedure TfrmMain.modifypwdbtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ismousedown:=true;
end;

procedure TfrmMain.modifypwdbtnMouseLeave(Sender: TObject);
begin
  modifypwdbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\03.bmp');
end;

procedure TfrmMain.modifypwdbtnMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  modifypwdbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\03h.bmp');
end;

// function TfrmMain.FindTab(const tabName: string): TTabSheet;
// var
// I: integer;
// s: String;
// begin
// Result := nil;
// for I := 0 to self.pgcForms.PageCount - 1 do
// begin
// s := self.pgcForms.Pages[I].Name;
// if CompareText(tabName, s) = 0 then
// begin
// Result := TTabSheet(self.pgcForms.Pages[I]);
// exit;
// end;
// end;
// end;

procedure TfrmMain.CloseForm(Aform: TForm);
var
  tab: TTabSheet;
  idx: integer;
  AllowChange: boolean;
begin
  // tab := self.FindTab(aform.ClassName);
  tab := FindTab(Aform);
  if assigned(tab) then
  begin
    idx := tab.TabIndex;
    AllowChange := true;
    pgcFormsChanging(nil, AllowChange);
    PostMessage(Self.Handle, Msg_ClosePage, idx, 0);
  end;
end;

procedure TfrmMain.exitbtnClick(Sender: TObject);
begin
  if ismousedown then
  begin
    ismousedown:=False;
    if not SysDialogs.Confirm('信息提示', '确认要退出吗?') then
      Exit;
    ExitApplication;
  end;
//  SysFunctionMgr.exec(StringToGUID('{77C3AE74-3F62-4741-ACA4-E365FF6AB562}'),
//    nil);

end;

procedure TfrmMain.exitbtnMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 ismousedown:=true;
end;

procedure TfrmMain.exitbtnMouseLeave(Sender: TObject);
begin
  exitbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0)) + '\images\04.bmp');
end;

procedure TfrmMain.exitbtnMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: integer);
begin
  exitbtn.Glyph.LoadFromFile(ExtractFilePath(Paramstr(0)) + '\images\04h.bmp');
end;

procedure TfrmMain.aboutbtnClick(Sender: TObject);
begin
  // showFormModal(,true);
  if ismousedown then
  begin
    ismousedown:=False;
    SysFunctionMgr.exec(StringToGUID('{BEF59B44-781A-4403-AEB8-DCDCC377B2E0}'),
    nil);
  end;

end;

procedure TfrmMain.btnRootClick(Sender: TObject);
begin
  refreshPath(TMenuItem(MainMenu.Items));
end;

procedure TfrmMain.btnToolButtonClick(Sender: TObject);
begin
  with TToolButton(Sender) do
  begin
    if assigned(menuItem.onClick) then
    begin
      menuItem.Click;
    end
    else
    begin
      refreshPath(menuItem);
    end;
  end;
end;

procedure TfrmMain.imgcheckticketClick(Sender: TObject);
begin
  imgcheckticket.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\checkticket.png');
  checkticketmark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgcheckticket.top > frmMain.Height - pnlmenu.Height - 150 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 150;
  end
  else
  begin
    pnlmenu.top := imgcheckticket.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 45;
  end;
  pnlmenu.Width := 440;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''8'')', 'about:blank',
    0);
end;

procedure TfrmMain.imgcheckticketMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgcheckticket.Left + imgcheckticket.Width,
      imgcheckticket.top, pnlmenu.Left,
      imgcheckticket.Height + imgcheckticket.top), p1) then
  begin
    imgcheckticket.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\checkticket.png');
    checkticketmark := 0;
    Timer1.Enabled := true;
  end;

end;

procedure TfrmMain.CloseActivePage;
var
  tab: TTabSheet;
begin
  tab := TTabSheet(Self.pgcForms.ActivePage);
  if tab.TabIndex <> 0 then
    Self.CloseForm(TForm(tab.Tag));
end;

procedure TfrmMain.imgpackClick(Sender: TObject);
begin
  imgpack.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
      + '\images\menu_1\pack.png');
  packmark := 1;
  chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
  Timer1.Enabled := false;
  pnlwebmenu.Visible := false;
  pnlmenu.Visible := true;
  pnlmenu.Left := 136;
  if imgpack.top > frmMain.Height - pnlmenu.Height - 130 then
  begin
    pnlmenu.top := frmMain.Height - pnlmenu.Height - 130;
  end
  else
  begin
    pnlmenu.top := imgpack.top;
  end;
  if (frmMain.Height < 750) and
    (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
  begin
    pnlmenu.top := 50;
  end;
  pnlmenu.Width := 440;
  pnlmenu.Height := 550;
  chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''20'')', 'about:blank',
    0);
end;

procedure TfrmMain.imgpackMouseLeave(Sender: TObject);
var
  p, p1: Tpoint;
begin
  GetCursorPos(p);
  p1 := scrlbxmenuleft.ScreenToClient(p);
  if not PtInrect(Rect(imgpack.Left + imgpack.Width, imgpack.top, pnlmenu.Left,
      imgpack.Height + imgpack.top), p1) then
  begin
    imgpack.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu\pack.png');
    packmark := 0;
    Timer1.Enabled := true;
  end;

end;

procedure TfrmMain.pgcFormsChange(Sender: TObject);
begin
  if assigned(pgcForms.ActivePage) then
  begin
    if (pgcForms.ActivePage <> pgcForms.Pages[0]) then
    // and Assigned(TForm(pgcForms.ActivePage.Tag).ActiveControl)
    begin
      // if not pnlwebmenu.Visible then
      // chrm1.Visible:=false;
      TCrackCustomForm(pgcForms.ActivePage.Tag).Activate;
      // TForm(pgcForms.ActivePage.Tag).ActiveControl.SetFocus;
    end
    else
    begin
      // chrm1.Visible:=true;
    end;
    refreshPath(TTabSheet(pgcForms.ActivePage).menuItem);
  end;
end;

procedure TfrmMain.pgcFormsChanging(Sender: TObject; var AllowChange: boolean);
begin
  if assigned(pgcForms.ActivePage) then
  begin
    if (pgcForms.ActivePage <> pgcForms.Pages[0]) then
    begin
      TCrackCustomForm(pgcForms.ActivePage.Tag).Deactivate;
    end;
  end;
end;

procedure TfrmMain.pgcFormsMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  if (Button = mbLeft) and (ssDouble in Shift) then
    // Self.CloseActivePage;
  end;

  procedure TfrmMain.pnlLeftMouseMove(Sender: TObject; Shift: TShiftState;
    X, Y: integer);
  begin
    // OutputDebugString('ssssssssss');
    // SetCapture(chrm1.Handle);
    // if isCapture=false then
    // begin
    // isCapture:=true;
    //
    // end;
  end;

  procedure TfrmMain.imgqueryClick(Sender: TObject);
  begin
    imgquery.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu_1\query.png');
    querymark := 1;
    chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
    Timer1.Enabled := false;
    pnlwebmenu.Visible := false;
    pnlmenu.Visible := true;
    pnlmenu.Left := 136;
    if imgquery.top > frmMain.Height - pnlmenu.Height - 90 then
    begin
      pnlmenu.top := frmMain.Height - pnlmenu.Height - 90;
    end
    else
    begin
      pnlmenu.top := imgquery.top;
    end;
    if querymenucount > 36 then
    begin
      pnlmenu.Width := 650;
    end
    else
    begin
      pnlmenu.Width := 440;
    end;
    pnlmenu.Height := 550;
    chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''18'')',
      'about:blank', 0);
  end;

  procedure TfrmMain.imgqueryMouseLeave(Sender: TObject);
  var
    p, p1: Tpoint;
  begin
    GetCursorPos(p);
    p1 := scrlbxmenuleft.ScreenToClient(p);
    if not PtInrect(Rect(imgquery.Left + imgquery.Width, imgquery.top,
        pnlmenu.Left, imgquery.Height + imgquery.top), p1) then
    begin
      imgquery.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
          + '\images\menu\query.png');
      querymark := 0;
      Timer1.Enabled := true;
    end;
  end;

  procedure TfrmMain.refreshPath(mi: TMenuItem);
  var
    tmpmi: TMenuItem;
    toolBarEnumerator: TToolBarEnumerator;

    tmpToolButton: TToolButton;
    tmppopmenu: TPopupMenu;
    tmpmenuitem: TMenuItem;
    i, tmptop: integer;
  begin
    if not tlbAddress.Visible then
      Exit;
    tmpmi := mi;
    {
      rzpthbr1.Items.Clear;
      rzpthbr1.Items.Add.Caption := '南凌客运信息系统';
      }
    while tlbAddress.ButtonCount > 1 do
    begin
      if tlbAddress.Buttons[1] = btnRoot then
        tlbAddress.Buttons[0].Free
      else
        tlbAddress.Buttons[1].Free;
    end;

    if tmpmi = nil then
    begin
      Exit;
    end;
    repeat
    begin
      if not assigned(tmpmi.parent) then
        Break;

      {
        with TRzPathItem(rzpthbr1.Items.Insert(1)) do
        begin
        Caption := tmpmi.Caption;
        end;
        }
      tmpToolButton := TToolButton.Create(Self);
      with tmpToolButton do
      begin
        Caption := tmpmi.Caption;
        parent := tlbAddress;
        menuItem := TMenuItem(tmpmi);
        // AutoSize:=true;
        Style := tbsButton;
        if assigned(tmpmi.onClick) then
        begin
          imageindex := 2;
          // style:=tbsTextButton;
        end
        else
        begin
          imageindex := 1;
          // style:=tbsTextButton;
          // style:=tbsDropDown;
          onClick := btnToolButtonClick;
          { for I := 0 to tmpmi.Count - 1 do
            begin
            if i=0 then
            begin
            tmppopmenu:=TPopupMenu.Create(tmpToolButton);
            DropdownMenu:=tmppopmenu;
            end;
            tmpmenuitem:=TMenuitem.Create(tmpToolButton);
            with TMenuitem(tmpmi.Items[i]) do
            begin
            tmpmenuitem.id:=id;
            tmpmenuitem.Caption:=caption;
            tmpmenuitem.Visible:=visible;
            tmpmenuitem.packagename:=packagename;
            tmpmenuitem.FuctionItemKey:=FuctionItemKey;
            tmpmenuitem.parameters:=parameters;
            tmpmenuitem.hotkeyValue:=hotkeyValue;
            tmpmenuitem.OnClick:=OnClick;
            end;
            tmppopmenu.Items.Add(tmpmenuitem);
            end;
            }
        end;
        // left:=0;
        Left := btnRoot.Width + 10;
      end;
      tmpmi := TMenuItem(tmpmi.parent);
    end
    until (not assigned(tmpmi.parent));
    btnRoot.Left := 0;
    if assigned(mi.onClick) then
    begin
      CurFolerMenuItem := TMenuItem(mi.parent);
      for i := 0 to tlbleft.ButtonCount - 1 do
      begin
        if TToolButton(tlbleft.Buttons[i]).menuItem = mi then
        begin
          Exit;
        end;
      end;
    end
    else
    begin
      if CurFolerMenuItem = mi then
      begin
        CurFolerMenuItem := mi;
        Exit;
      end;
      CurFolerMenuItem := mi;
    end;
    // 刷新侧边栏
    while tlbleft.ButtonCount > 0 do
    begin
      tlbleft.Buttons[0].Free;
    end;
    tmptop := 0;
    if assigned(mi.onClick) then
    begin
      tmpmi := TMenuItem(mi.parent);
    end
    else
    begin
      tmpmi := mi;
    end;
    for i := tmpmi.count - 1 downto 0 do
    begin
      tmpToolButton := TToolButton.Create(Self);
      with tmpToolButton do
      begin
        Caption := tmpmi.Items[i].Caption;
        parent := tlbleft;
        menuItem := TMenuItem(tmpmi.Items[i]);
        // top:=tmptop+10;
        tmptop := tmptop + Height;
        onClick := btnToolButtonClick;
        if assigned(tmpmi.Items[i].onClick) then
        begin
          imageindex := 2;
          // style:=tbsTextButton;
        end
        else
        begin
          imageindex := 1;
          // style:=tbsDropDown;
        end;
      end;
    end;
    scrlbxleftResize(nil);
  end;

  procedure TfrmMain.imgreportClick(Sender: TObject);
  begin
    imgreport.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu_1\report.png');
    reportmark := 1;
    chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
    Timer1.Enabled := false;
    pnlwebmenu.Visible := false;
    pnlmenu.Visible := true;
    pnlmenu.Left := 136;
    if imgreport.top > frmMain.Height - pnlmenu.Height - 70 then
    begin
      pnlmenu.top := frmMain.Height - pnlmenu.Height - 70;
    end
    else
    begin
      pnlmenu.top := imgreport.top;
    end;
    if reportmenucount > 36 then
    begin
      pnlmenu.Width := 650;
    end
    else
    begin
      pnlmenu.Width := 440;
    end;
    pnlmenu.Height := 550;
    chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''19'')',
      'about:blank', 0);
  end;

  procedure TfrmMain.imgreportMouseLeave(Sender: TObject);
  var
    p, p1: Tpoint;
  begin
    GetCursorPos(p);
    p1 := scrlbxmenuleft.ScreenToClient(p);
    if not PtInrect(Rect(imgreport.Left + imgreport.Width, imgreport.top,
        pnlmenu.Left, imgreport.Height + imgreport.top), p1) then
    begin
      imgreport.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
          + '\images\menu\report.png');
      reportmark := 0;
      Timer1.Enabled := true;
    end;

  end;

  procedure TfrmMain.RzGroup1Items0Click(Sender: TObject);
  begin
    if dlgOpenStyle.Execute then
    begin
      SkinData1.LoadFromFile(dlgOpenStyle.FileName);
      if not SkinData1.Active then
      begin
        UDMPublic.SkinData := Self.SkinData1;
        SkinData1.Active := true;
      end;
    end;
  end;

  procedure TfrmMain.imgsaleClick(Sender: TObject);
  begin
    imgsale.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
        + '\images\menu_1\sale.png');
    salemark := 1;
    chrm1.Browser.MainFrame.ExecuteJavaScript('moveindex()', 'about:blank', 0);
    Timer1.Enabled := false;
    pnlwebmenu.Visible := false;
    pnlmenu.Visible := true;
    pnlmenu.Left := 136;
    if imgsale.top > frmMain.Height - pnlmenu.Height - 170 then
    begin
      pnlmenu.top := frmMain.Height - pnlmenu.Height - 170;
    end
    else
    begin
      pnlmenu.top := imgsale.top;
    end;
    if (frmMain.Height < 750) and
      (pnlmenu.top < frmMain.Height - pnlmenu.Height - 50) then
    begin
      pnlmenu.top := 40;
    end;
    pnlmenu.Width := 440;
    pnlmenu.Height := 550;
    chrm1.Browser.MainFrame.ExecuteJavaScript('getindex(''3'')', 'about:blank',
      0);
  end;

  procedure TfrmMain.imgsaleMouseLeave(Sender: TObject);
  var
    p, p1: Tpoint;
  begin
    GetCursorPos(p);
    p1 := scrlbxmenuleft.ScreenToClient(p);
    if not PtInrect(Rect(imgsale.Left + imgsale.Width, imgsale.top,
        pnlmenu.Left, imgsale.Height + imgsale.top), p1) then
    begin
      imgsale.Picture.LoadFromFile(ExtractFilePath(Paramstr(0))
          + '\images\menu\sale.png');
      salemark := 0;
      Timer1.Enabled := true;
    end;
  end;

  procedure TfrmMain.screenActiveControlChange(Sender: TObject);
  var
    childForm: TCustomForm;
  begin
    try
      childForm := GetParentForm(ActiveControl, false);
      if (childForm <> nil) and (childForm <> Self) then // 通知子窗体焦点改变
      begin
        TCrackCustomForm(childForm).ActiveChanged;
      end;
    except
      on E: Exception do
        // SysDialogs.ShowError(E.Message);
      end;
    end;

    procedure TfrmMain.scrlbxleftResize(Sender: TObject);
    var
      i, totalheight: integer;
    begin
      tlbleft.Left := 0;
      tlbleft.top := 20;
      // tlbleft.Width:=scrlbxleft.Width;
      // tlbleft.ButtonWidth:=scrlbxleft.Width;
      // for I := tlbleft.ButtonCount - 1 downto 0 do
      // begin
      // tlbleft.Buttons[i].Width:=tlbleft.Width;
      // end;
      tlbleft.Height := max(scrlbxleft.Height,
        (tlbleft.ButtonHeight + 3) * tlbleft.ButtonCount);
    end;

    procedure TfrmMain.ShowForm(Aform: TForm);
    var
      tab: TTabSheet;
      AllowChange: boolean;
    begin
      // tab := self.FindTab(aform.ClassName);
      tab := Self.FindTab(Aform);
      if not assigned(tab) then
      begin
        tab := TTabSheet.Create(nil);
        tab.menuItem := curMenuItem;
        tab.PageControl := Self.pgcForms;
        Aform.FormStyle := fsNormal;
        Aform.parent := tab;
        Aform.BorderStyle := bsNone;
        Aform.Align := alClient;
        if SkinData1.Active and (Aform.Tag <> SkinData1.DisableTag) then
          SkinData1.AddNestForm(Self, Aform);
        tab.Name := Aform.ClassName;
        tab.Caption := tab.menuItem.Caption; // aform.Caption;
        tab.Tag := integer(Aform);
        AllowChange := true;
        pgcFormsChanging(nil, AllowChange);
        Aform.Show;
      end;
      Self.pgcForms.ActivePage := tab;
      pgcFormsChange(nil);
    end;

    procedure TfrmMain.ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    var
      msgr, theFileName: string;
      bufRecv: Pointer;
      iLength: integer;
    begin
      inherited;
      // 接收到的数据的长度
      iLength := Socket.ReceiveLength;
      // 开辟一块新的内存，用来保存接收到的数据
      GetMem(bufRecv, iLength);
      try
        // 接收数据
        Socket.ReceiveBuf(bufRecv^, iLength);
        // 将接收到的数据以字符串的形式存到msgr中
        // msgr:=StrPas(PChar(bufRecv));
        msgr := StrPas(PAnsiChar(bufRecv));
        // self.Caption:= msgr;
        if msgr = 'DOWNLINE' then
        begin
          SysDialogs.ShowMessage('你已经被管理员强制下线！');
          Close;
        end;
      finally
        // 释放内存
        FreeMem(bufRecv, iLength);
      end;

    end;

    procedure TfrmMain.ShowForm(FormClass: TFormClass; var Reference;
      functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil;
      checkpermission: boolean = true);
    var
      Aform: TForm;
      tab: TTabSheet;
      AllowChange: boolean;
    begin
      // tab := self.FindTab(FormClass.ClassName);
      // tab := self.FindTab(FormClass.ClassName);
      // if not assigned(tab) then
      // begin
      tab := TTabSheet.Create(nil);
      tab.menuItem := curMenuItem;
      tab.PageControl := Self.pgcForms;
      // if FormClass.InheritsFrom(TbaseFormClass) then
      // aForm:=FormClass.Create(nil,functionItem)
      // else
      // aForm:=FormClass.Create(nil);
      try
        Aform := TbaseFormClass(FormClass).Create(Self, functionItem,
          parameter, checkpermission);
      except
        on E: Exception do
          Aform := FormClass.Create(Self);
      end;
      TComponent(Reference) := Aform;
      Aform.FormStyle := fsNormal;
      Aform.parent := tab;
      Aform.BorderStyle := bsNone;
      Aform.Align := alClient;
      if SkinData1.Active and (Aform.Tag <> SkinData1.DisableTag) then
        SkinData1.AddNestForm(Self, Aform);
      AllowChange := true;
      pgcFormsChanging(nil, AllowChange);
      Aform.Show;
      tab.Name := Aform.ClassName;
      tab.Caption := tab.menuItem.Caption; //
      Aform.Caption := tab.Caption;
      tab.Tag := integer(Aform);
      // end;
      Self.pgcForms.ActivePage := tab;
      pgcFormsChange(nil);
    end;

    function TfrmMain.showFormModal(FormClass: TFormClass;
      functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil;
      checkpermission: boolean = true): integer;
    var
      from: TForm;
    begin
      try
        from := TbaseFormClass(FormClass).Create(nil, functionItem, parameter,
          checkpermission);
      except
        on E: Exception do
          from := FormClass.Create(nil);
      end;
      showFormModal(from);
    end;

    procedure TfrmMain.ClosePage(var Message: TMessage);
    var
      idx: integer;
    begin
      idx := Message.WParam;
      try
        Self.pgcForms.Pages[idx].Free;
      except
        // TODO 补票 在private中定义Currency或double类型时，在释放时会报错。用single则不会。奇怪。 暂时屏蔽异常
      end;
      if idx > 0 then
        Self.pgcForms.ActivePageIndex := idx - 1;
    end;

    procedure TfrmMain.CNTabClose(var Message: TMessage);
    var
      tab: TPageControl;
    begin
      tab := TPageControl(FindControl(message.WParam));
      if tab = nil then
        Exit;
      if message.lparam = 0 then
      begin
        message.Result := 1;
        Exit;
      end;
      if SysDialogs.Ask('确认',
        '您确定要关闭窗口： ' + tab.Pages[message.lparam].Caption + ' ?') then
      begin

        // if MessageDlg('您确定要关闭窗口： '+tab.Pages[message.lparam].Caption+' ?',
        // mtInformation,[mbYes,mbNo], 0)=mrYes then
        message.Result := 0; // result=0,close
        chrm1.Visible := true;
      end
      else
        message.Result := 1;
    end;

    { TRzGroupItemHelper }
    {
      function TRzGroupItemHelper.getFuctionItemKey: TGUID;
      begin
      if self.Data <> nil then
      Result := PFunctionItemCall(self.Data).FuctionItemKey;
      end;

      function TRzGroupItemHelper.getMenuItem: TMenuItem;
      begin
      if self.Data <> nil then
      Result := PFunctionItemCall(self.Data).menuItem;
      end;

      function TRzGroupItemHelper.getParameters: TFunctionItemParameters;
      begin
      if self.Data <> nil then
      Result := PFunctionItemCall(self.Data).parameters;
      end;
      }
    { TNovaSplitter }

    function TfrmMain.SplitString(const source, ch: string): TStringList;
    var
      temp, t2: string;
      i: integer;
    begin
      Result := TStringList.Create;
      temp := source;
      i := pos(ch, source);
      while i <> 0 do
      begin
        t2 := copy(temp, 0, i - 1);
        if (t2 <> '') then
          Result.Add(t2);
        delete(temp, 1, i - 1 + Length(ch));
        i := pos(ch, temp);
      end;
      Result.Add(temp);
    end;

    constructor TNovaSplitter.Create(AOwner: TComponent);
    begin
      inherited;
      dblclicking := false;
    end;

    procedure TNovaSplitter.DblClick;
    var
      _control: Tcontrol;
    begin
      dblclicking := true;
      inherited;
      _control := FindControl;
      if not assigned(_control) then
      begin
        _control := oldControl;
      end;
      if assigned(_control) then
      begin
        if _control.Width = 0 then
        begin
          _control.Width := oldwidth;
          Self.Left := _control.Left + _control.Width + 1;
        end
        else
        begin
          oldwidth := _control.Width;
          oldControl := _control;
          _control.Width := 0;
        end;
      end;
    end;

    function TNovaSplitter.FindControl: Tcontrol;
    var
      p: Tpoint;
      i: integer;
      R: TRect;
    begin
      Result := nil;
      p := Point(Left, top);
      case Align of
        alLeft:
          if not AlignWithMargins then
            Dec(p.X)
          else
            Dec(p.X, Margins.Left + 1);
        alRight:
          if not AlignWithMargins then
            Inc(p.X, Width)
          else
            Inc(p.X, Width + Margins.Right + 1);
        alTop:
          if not AlignWithMargins then
            Dec(p.Y)
          else
            Dec(p.Y, Margins.top + 1);
        alBottom:
          if not AlignWithMargins then
            Inc(p.Y, Height)
          else
            Inc(p.Y, Height + Margins.Bottom + 1);
      else
        Exit;
      end;
      for i := 0 to parent.ControlCount - 1 do
      begin
        Result := parent.Controls[i];
        if Result.Visible and Result.Enabled then
        begin
          R := Result.BoundsRect;
          if Result.AlignWithMargins then
          begin
            Inc(R.Right, Result.Margins.Right);
            Dec(R.Left, Result.Margins.Left);
            Inc(R.Bottom, Result.Margins.Bottom);
            Dec(R.top, Result.Margins.top);
          end;
          if (R.Right - R.Left) = 0 then
            if Align in [alTop, alLeft] then
              Dec(R.Left)
            else
              Inc(R.Right);
          if (R.Bottom - R.top) = 0 then
            if Align in [alTop, alLeft] then
              Dec(R.top)
            else
              Inc(R.Bottom);
          if PtInrect(R, p) then
            Exit;
        end;
      end;
      Result := nil;
    end;

    procedure TNovaSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer);
    begin
      if not dblclicking then
        inherited;
    end;

    procedure TNovaSplitter.MouseMove(Shift: TShiftState; X, Y: integer);
    begin
      if not dblclicking then
        inherited;
    end;

    procedure TNovaSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: integer);
    begin
      if not dblclicking then
        inherited;
      dblclicking := false;
    end;

initialization

FSysService := TSysService.Create;

CefCache := 'cache';
CefRegisterCustomSchemes := CefOnRegisterCustomSchemes;
CefRegisterSchemeHandlerFactory('dcef', '', true, TFileScheme);
CefRegisterExtension('v8/test', code, TExtension.Create as ICefV8Handler);

finalization

FSysService := nil;

end.
