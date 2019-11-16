unit UFrmDispatchManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaComboBox, NovaCheckedComboBox,
  NovaHComboBox, FunctionItemIntf, Generics.Collections, DateUtils, UICcardRW,
  NovaPrint, StrUtils,Dispatch, OleCtrls,mmsystem, ZKFPEngXControl_TLB,ShellAPI;

type

  TNodeInfo = record
    arealevel: integer;
    name: string;
    pcode: string;
    code: string;
  end;

  PNodeInfo = ^TNodeInfo;

  TFrmDispatchManage = class(TSimpleCRUDForm, IBaseCardfound)
    lbl1: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    DpDepartdate: TDateTimePicker;
    dtfromdatetime: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    NovaCobbScheduleStatus: TNovaComboBox;
    Label8: TLabel;
    NovaCbbIsChecked: TNovaComboBox;
    Label9: TLabel;
    NovaCbbIsReported: TNovaComboBox;
    Label6: TLabel;
    NovaCbbissellable: TNovaComboBox;
    NHelpRoute: TNovaHelp;
    NovaHelpUnit: TNovaHelp;
    NovaHelpSchedule: TNovaHelp;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsQryRouteTree: TjsonClientDataSet;
    NovaHelpVehiclenoHelp: TNovaHelp;
    ImageList1: TImageList;
    Panel2: TPanel;
    Splitter1: TSplitter;
    GroupBox4: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    GroupBox5: TGroupBox;
    NvDbgridEh2: TNvDbgridEh;
    jcdstype: TjsonClientDataSet;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcsdWorkType: TjsonClientDataSet;
    jcdsScheduleStatus: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultorgid: TLargeintField;
    jcdsResultscheduleid: TLargeintField;
    jcdsResultcode: TWideStringField;
    jcdsResultseatnum: TIntegerField;
    jcdsResultautocancelreserveseatnum: TIntegerField;
    jcdsResultunautocancelreserveseatnum: TIntegerField;
    jcdsResultfixedreserveseatnum: TIntegerField;
    jcdsResultsoldeatnum: TIntegerField;
    jcdsResultissellable: TBooleanField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultruntime: TFloatField;
    jcdsResultdistance: TIntegerField;
    jcdsResulthighdistance: TIntegerField;
    jcdsResultworktype: TWideStringField;
    jcdsResultworkways: TWideStringField;
    jcdsResultdistricttype: TWideStringField;
    jcdsResultscheduletype: TWideStringField;
    jcdsResultisproprietary: TBooleanField;
    jcdsResultisovertime: TBooleanField;
    jcdsResultissellreturnticket: TBooleanField;
    jcdsResultislinework: TBooleanField;
    jcdsResultendtime: TWideStringField;
    jcdsResultspacinginterval: TIntegerField;
    jcdsResultisoriginator: TBooleanField;
    jcdsResultissaleafterreport: TBooleanField;
    jcdsResultiscanmixcheck: TBooleanField;
    jcdsResultdepartstationid: TLargeintField;
    jcdsResultdepartstation: TWideStringField;
    jcdsResultendstation: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultbuspark: TWideStringField;
    jcdsResultisreported: TBooleanField;
    jcdsResultisbegincheck: TBooleanField;
    jcdsResultisdeparted: TBooleanField;
    jcdsResultstatus: TWideStringField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultplanvehicleid: TLargeintField;
    jcdsResultplanvehicle: TWideStringField;
    jcdsResultplanvehicletypeid: TLargeintField;
    jcdsResultplanvehicletype: TWideStringField;
    jcdsResultplanvehiclebrandmodelid: TLargeintField;
    jcdsResultplanunitid: TLargeintField;
    jcdsResultschedulestatus: TWideStringField;
    jcdsResultworktypename: TWideStringField;
    jcdsResultworkwaysname: TWideStringField;
    jcdsResultdistricttypename: TWideStringField;
    jcdsResultscheduletypename: TWideStringField;
    jcdsResultdeparttime: TWideStringField;
    departdate: TDateField;
    jcdsResultleaveseat: TIntegerField;
    jcdsResultroutename: TWideStringField;
    jcdsResultreportid: TLargeintField;
    jcdsResultisemptyvehicle: TBooleanField;
    jcdsStopScheduleplan: TjsonClientDataSet;
    jcdsallowScheduleplan: TjsonClientDataSet;
    jcdsResultreportunit: TWideStringField;
    jcsdSaveRoadbill: TjsonClientDataSet;
    jcdsDepartScheduleNoPrint: TjsonClientDataSet;
    jcsdundodepartScheduleNoPrint: TjsonClientDataSet;
    Splitter2: TSplitter;
    chkDepatetimePre: TCheckBox;
    NovaEditMinute: TNovaEdit;
    Label10: TLabel;
    pnl1: TPanel;
    grp1: TGroupBox;
    mmoReportInfo: TMemo;
    grp3: TGroupBox;
    jcdsResultreportname: TWideStringField;
    grp2: TGroupBox;
    NovaEdtCardNo: TNovaEdit;
    NovaHelpVehicleNo: TNovaHelp;
    jcdsResultreporttime: TDateTimeField;
    jcdsResultplanunit: TWideStringField;
    jcdsResultplandriver1id: TLargeintField;
    jcdsResultplandriver1: TWideStringField;
    jcdsResultplandriver2id: TLargeintField;
    jcdsResultplandriver2: TWideStringField;
    jcdsResultplandriver3id: TLargeintField;
    jcdsResultplandriver3: TWideStringField;
    jcdsResultplansteward1id: TLargeintField;
    jcdsResultplansteward2id: TLargeintField;
    jcdsResultplansteward1: TWideStringField;
    jcdsResultplansteward2: TWideStringField;
    jcdsResultreportorgid: TLargeintField;
    ChkNotIsworkline: TCheckBox;
    ChkIsworkline: TCheckBox;
    jcdsResultremarks: TWideStringField;
    jscdVehicleLater: TjsonClientDataSet;
    jcdsResultschedulestatusid: TLargeintField;
    jcdsResultreporddriver1: TWideStringField;
    jcdsResultreporddriver2: TWideStringField;
    jcdsResultisreplace: TBooleanField;
    jcdsDepartinvoice: TjsonClientDataSet;
    jcdsQryDetail: TjsonClientDataSet;
    jcdsOthersells: TjsonClientDataSet;
    GroupBox2: TGroupBox;
    lblBillnum: TLabel;
    lblBillno: TLabel;
    Label11: TLabel;
    jcdsResultSave: TjsonClientDataSet;
    jscdQryDeductfees: TjsonClientDataSet;
    jcdsResultdriverfingernum: TIntegerField;
    jsonSpcQry: TjsonClientDataSet;
    jsonQryStwed: TjsonClientDataSet;
    qryvehisecuresult: TjsonClientDataSet;
    jcdsResultreportddriver3: TWideStringField;
    jcdsResultreporddriver4: TWideStringField;
    jcdsVehicleDriver: TjsonClientDataSet;
    jcdsResultrationseatnum: TWideStringField;
    pnlAutoReport: TPanel;
    chkAutoReport: TCheckBox;
    jcdsResultplandriver4id: TLargeintField;
    jcdsResultplandriver4: TWideStringField;
    jcdsResultbalanceunitid: TLargeintField;
    jcdsResultbalanceunitname: TWideStringField;
    jcdsResultliabilityinsureenddate: TDateField;
    jcdsResultroadno: TWideStringField;
    jcdsResultlicenseenddate: TDateField;
    jcdsResultworkenddate: TDateField;
    jcdsResultcompulsoryinsureenddate: TDateField;
    edtDriver1: TNovaHelp;
    jcsdqryvehiclebydriverid: TjsonClientDataSet;
    jcdsResultstewardname: TWideStringField;

    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure TreeVRouteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure tbtnPrinterClick(Sender: TObject);
    procedure ToolButton53Click(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
    procedure edCardNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure NovaEdtCardNoChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrdhResultDblClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tbtnInfoClick(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure NovaEdtCardNoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtn6Click(Sender: TObject);
    procedure NovaHelpVehicleNoIdChange(Sender: TObject);
    procedure edtDriver1IdChange(Sender: TObject);
    procedure NovaHelpVehicleNoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ZKFPEngX1Capture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure ZKFPEngX1Enroll(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure chkAutoReportClick(Sender: TObject);
  private
    { Private declarations }
    ZKFPEngX1:TZKFPEngX;
    Driverid:integer;
    isexist:boolean;
    Drivername:string;
    initsuccess:boolean;
    sRegTemplate:WideString;
    sRegTemplate1: WideString;
    fpcHandle,vehicledriverid: Integer;
    serialnumber: String;
    //p0143,p6002:String;
    roadPrint: TNovaPrint;
    isjumpno: boolean;
    isfinger:boolean;
    isIDorIc:boolean;//2032
    billPrint: TNovaPrint;
    // functionParm: TFunctionItemParameters;
    printValue: TDictionary<String, String>; // 输出单变量
    isNovaEdtCardNoKeyPress: boolean; // 若是IC卡报到回车后不跳转
    vheicleisMustCheck: boolean; // 是否必须安检
    isMustCheckwithout: boolean; // 无 键计划，是否必须安检
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    multipleValueValue: TDictionary<String, String>;
    procedure CreateTreeListRouteStationOwner(TV: TTreeView);
    procedure qryScheduleplan(curid: Int64);
    procedure stopScheduleplan(curid: Int64);
    procedure allowScheduleplan(curid: Int64);
    procedure departSchedulenoprint(curid: Int64); // 放空
    procedure undodepartSchedulenoprint(curid: Int64); // 取消放空
    procedure iccardfound(icCard: TBaseCard);
    // 获取车辆安检信息
   // function checkVehicle(vehicleid: Int64; departdate: string): boolean;
    // 获取车辆验证有效性
    //function VehicleActive(vehicleid: Int64; departdate: string): boolean;
    procedure departSchImpl(invoincesno: String; iscomputeno: boolean;
      isreprint: boolean);
    procedure refreshBill; // 刷新票号
    //procedure IcCardReport; //报班
  public
    { Public declarations }
    distancemessage: string;
    // 是否可手动输入车号和IC卡号
    isvehicleable, isICcodeable: boolean;
    //接收自动报班界面传的参数
    iccardFromAuto: TBaseCard;
    //自动报班结果提示
    titleResult:string;
    qrycurstationid: Int64;
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;

  end;

var
  FrmDispatchManage: TFrmDispatchManage;

implementation

uses PubFn, Services, UFrmChanageVehicleplan, UDMPublic, UFrmVehicleReport,
  UFrmCancelReport, UFrmChangeVehicle, UFrmVehicleRunPlan,
  UFrmVehicleLost, UFrmInitRoadBill, UFrmPrintRoadInfo, UFrmScheduleReport,
  UFrmAutoReportResult;

{$R *.dfm}

procedure TFrmDispatchManage.dbgrdhResultDblClick(Sender: TObject);
begin
  inherited;
  tbtnInsertClick(Sender);
end;

procedure TFrmDispatchManage.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  // 报停
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    Background := clRed; // clYellow;
    // dbgrdhResult.Canvas.Font.Color := clRed; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 被并
  if (jcdsResult.FieldByName('status').AsString = '3') and not
    (gdSelected in State) then
  begin
    Background := clOlive;
    // dbgrdhResult.Canvas.Font.Color := clLtGray; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 脱班
  if (jcdsResult.FieldByName('status').AsString = '4') and not
    (gdSelected in State) then
  begin
    Background := clYellow;
    // dbgrdhResult.Canvas.Font.Color := clOlive;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // 停售
  if (jcdsResult.FieldByName('status').AsString = '5') and not
    (gdSelected in State) then
  begin
    Background := clFuchsia;
    // dbgrdhResult.Canvas.Font.Color := clFuchsia;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('isreported').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clSkyBlue;
    // dbgrdhResult.Canvas.Font.Color := clBlue;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('isdeparted').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clMoneyGreen;
    // dbgrdhResult.Canvas.Font.Color := clMoneyGreen;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

end;

procedure TFrmDispatchManage.departSchedulenoprint(curid: Int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jcdsDepartScheduleNoPrint do
    begin
      Active := false;
      Params.ParamValues['vehiclereport.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Params.ParamValues['vehiclereport.scheduleplanid'] := curid;
      Params.ParamValues['vehiclereport.reportorgid'] :=
        sysInfo.LoginUserInfo.OrgID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('放空操作失败：' + E.Message);
    end;
  end;
end;

procedure TFrmDispatchManage.departSchImpl(invoincesno: String;
  iscomputeno, isreprint: boolean);
var
  vehiclereportid, departinvoicesid, vehicleid, scheduleplanid: Int64;
  nResult: integer;
  msgmgs,sResult, vehicleno: String;
  multipleValueValue: TDictionary<String, String>;
  schedulecode, departdate: string;
  departtime, departstation, endstation: string;
  routename, templtename: string;
  fulls, halfs, students, discounts, totalpsdistance: integer;
  totalpeople, psdistance: integer;
  totalfee, noagentbalanceprice: double;
  i: integer;
begin
  fulls := 0;
  halfs := 0;
  students := 0;
  discounts := 0;
  totalpsdistance := 0;
  totalfee := 0;
    with qryvehisecuresult do
  begin
     Active:=False;
           if (jcdsResult.FieldByName('islinework').AsBoolean) then
            begin
              if not jcdsResult.Active then
                exit;
              if jcdsResult.RecordCount = 0 then
                exit;
             Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName('id').AsLargeInt;

            end
           else
            begin

              Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName('reportid').AsLargeInt;

            end;
//     Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName('id').AsLargeInt;
     Execute;
//      flags := Params.ParamByName('flag').Value;
      msgmgs := Params.ParamByName('msg').Value;
  end;
  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
    vehiclereportid := jcdsResult.FieldByName('id').AsLargeInt;
    vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
  end
  else
  begin

    vehiclereportid := jcdsResult.FieldByName('reportid').AsLargeInt;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
  end;

  schedulecode := jcdsResult.FieldByName('code').AsString;
  departdate := jcdsResult.FieldByName('departdate').AsString;
  departtime := jcdsResult.FieldByName('departtime').AsString;
  departstation := jcdsResult.FieldByName('departstation').AsString;
  endstation := jcdsResult.FieldByName('endstation').AsString;
  routename := jcdsResult.FieldByName('routename').AsString;

  templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');

  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);

  scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;

  try
    with jcdsDepartinvoice do
    begin
      Active := false;
      Params.ParamValues['departstationid'] := sysInfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['departinvoicesno'] := invoincesno;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['ip'] := sysInfo.LocalHostAddress;
      Params.ParamValues['isreprint'] := isreprint;

      Params.ParamValues['iscomputeno'] := iscomputeno;

      Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
        DpDepartdate.Date);
      Active := true;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if iscomputeno then
        begin
          if RecordCount > 0 then
          begin
            while not Eof do
            begin
              if not Assigned(printValue) then
                printValue := TDictionary<String, String>.Create
              else
                printValue.Clear;
              printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
              printValue.Add('seats', FieldByName('seatnum').AsString);
              printValue.Add('brandmodel', FieldByName('brandname').AsString);
              printValue.Add('vehicletype',
                FieldByName('vehicletype').AsString);
              printValue.Add('route', routename);
              printValue.Add('routedistance', FieldByName('distance').AsString);
              printValue.Add('schedulecode', schedulecode);
              printValue.Add('departdate', departdate);
              printValue.Add('departtime', departtime);
              printValue.Add('departstation', departstation);
              printValue.Add('checkedname',
                FieldByName('checkedname').AsString);
              printValue.Add('endstation', endstation);
              printValue.Add('packbalanceprice', FieldByName('packbalanceprice').AsString);
              printValue.Add('freetickets',
                FieldByName('freetickets').AsString);
              printValue.Add('armtickets', FieldByName('armtickets').AsString);

              departinvoicesid := FieldByName('id').AsLargeInt;
              printValue.Add('invoicesno', FieldByName('invoicesno').AsString);
              printValue.Add('unit', FieldByName('unit').AsString);
              printValue.Add('ticketnum', FieldByName('ticketnum').AsString);
              printValue.Add('driver1', FieldByName('driver1').AsString);
              printValue.Add('driver2', FieldByName('driver2').AsString);
              printValue.Add('driver3', FieldByName('driver3').AsString);
              printValue.Add('driver4', FieldByName('driver4').AsString);
              printValue.Add('steward', FieldByName('steward').AsString);
              printValue.Add('balanceunit',
                FieldByName('balanceunit').AsString);
              // 扣费明细改为由数据集返回
              with jscdQryDeductfees do
              begin
                Active := false;
                Params.ParamValues['departinvoicesid'] := departinvoicesid;
                Active := true;
                if RecordCount > 0 then
                begin
                  first;
                  while (not Eof) do
                  begin
                    printValue.Add(FieldByName('code').AsString,
                      FieldByName('deductmoney').AsString);
                    next;
                  end;
                end;
              end;
              // 扣费明细改为由数据集返回
              printValue.Add('stationfee', FieldByName('stationfee').AsString);

              totalfee := FieldByName('totalamount').AsFloat - FieldByName
                ('agentfee').AsFloat - FieldByName('balanceamount').AsFloat;
              noagentbalanceprice := FieldByName('agentfee')
                .AsFloat + FieldByName('balanceamount').AsFloat;
              printValue.Add('peoplepackprice',FloatToStr(noagentbalanceprice+ FieldByName('packbalanceprice').AsFloat));
              printValue.Add('noagentbalanceprice',
                floattostr(noagentbalanceprice));
              printValue.Add('totalfee', floattostr(totalfee));
              printValue.Add('reprint', '');
              printValue.Add('agentfee', FieldByName('agentfee').AsString);
              printValue.Add('fueladditionfee',
                FieldByName('fueladditionfee').AsString);

              printValue.Add('otherfee', FieldByName('otherfee').AsString);
              printValue.Add('totalamount',
                FieldByName('totalamount').AsString);
              printValue.Add('balanceamount',
                FieldByName('balanceamount').AsString);
              if FieldByName('isovertime').AsBoolean then
                printValue.Add('isovertime', '加班')
              else
                printValue.Add('isovertime', '');
              printValue.Add('printby', sysInfo.LoginUserInfo.UserName);
              printValue.Add('printstation', sysInfo.LoginUserInfo.OrgName);
              printValue.Add('printertime',
                formatdatetime('yyyy-mm-dd hh:mm', now));

              if not Assigned(multiplelist) then
                multiplelist := TList < TDictionary < String, String >> .Create
              else
                multiplelist.Clear;
              with jcdsQryDetail do
              begin
                Active := false;
                Params.ParamValues['departinvoicesid'] := departinvoicesid;
                Active := true;
                if RecordCount > 0 then
                begin
                  first;

                  while (not Eof) do
                  begin
                    multipleValueValue := TDictionary<String, String>.Create;
                    multipleValueValue.Add('fromstation',
                      FieldByName('fromstation').AsString);
                    multipleValueValue.Add('reachstation',
                      FieldByName('reachstation').AsString);
                    multipleValueValue.Add('fullpeople',
                      FieldByName('fullpeople').AsString);
                    multipleValueValue.Add('price',
                      FieldByName('price').AsString);
                    multipleValueValue.Add('halfpeople',
                      FieldByName('halfpeople').AsString);
                    multipleValueValue.Add('studentpeople', '0');
                    multipleValueValue.Add('discountpeople',
                      FieldByName('discountpeople').AsString);
                    multipleValueValue.Add('distance',
                      FieldByName('distance').AsString);
                    totalpeople := FieldByName('fullpeople')
                      .AsInteger + FieldByName('halfpeople').AsInteger;
                    psdistance := FieldByName('distance')
                      .AsInteger * totalpeople;
                    multipleValueValue.Add('psdistance', inttostr(psdistance));
                    multipleValueValue.Add('totalamount',
                      FieldByName('totalamount').AsString);
                    multipleValueValue.Add('balanceprice',
                      FieldByName('balanceprice').AsString);
                    multiplelist.Add(multipleValueValue);
                    multipleValueValue.Add('balanceamount',
                      FieldByName('balanceamount').AsString);
                    multipleValueValue.Add('noagentbalanceamount',
                      FieldByName('noagentbalanceamount').AsString);
                    fulls := fulls + FieldByName('fullpeople').AsInteger;
                    halfs := halfs + FieldByName('halfpeople').AsInteger;
                    students := 0;
                    discounts := 0;
                    totalpsdistance := totalpsdistance + psdistance;
                    next;
                  end;
                end;
              end;
              // 根据运量ID 发车日期获取他站售票情况
              with jcdsOthersells do
              begin
                Active := false;
                Params.ParamValues['departinvoicesid'] := departinvoicesid;
                Params.ParamValues['departdate'] := departdate;
                Execute;
                printValue.Add('othersell',
                  Params.ParamByName('othersells').Value);
              end;
              printValue.Add('fulls', inttostr(fulls));
              printValue.Add('halfs', inttostr(halfs));
              printValue.Add('students', inttostr(students));
              printValue.Add('discounts', inttostr(discounts));
              printValue.Add('totalpsdistance', inttostr(totalpsdistance));

              billPrint.SingleValue := printValue;
              billPrint.MultipleValue := multiplelist;


            if ((msgmgs = '0') or (msgmgs='2')) then
            begin  //安检合格打印
               billPrint.Print;
            end
            else
            begin
              if (getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '1') then
              begin   //安检不合格 参数是1是时 能打印
                billPrint.Print;
              end  ;
            end;
              with sysInfo.LoginUserInfo do
              begin
                curBillNo.AddOrSetValue('BalanceBill',
                  zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                        + 1), length(curBillNo.Items['BalanceBill'])));
                curBillNum.AddOrSetValue('BalanceBill',
                  curBillNum.Items['BalanceBill'] - 1);
              end;
              refreshBill;
              next;
            end;
          end;

          SysDialogs.ShowMessage(sResult);
          // lbl2.Caption := sresult;
          // dtpfromdatetime.Time := now - 0.08;
          qryScheduleplan(scheduleplanid);
          NovaEdtCardNo.SetFocus;
        end;
      end
      else
      begin
        SysDialogs.Warning(sResult);
      end;

    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('发班操作失败：' + E.Message);
    end;
  end;

end;

procedure TFrmDispatchManage.edtDriver1IdChange(Sender: TObject);
begin
  inherited;
  if edtDriver1.Id>0 then
  begin
    with jcsdqryvehiclebydriverid do
      begin
        Active:=False;
        Params.ParamValues['driverid']:=  edtDriver1.Id;
        active:=True;
        if RecordCount > 0 then
        begin
          if FieldByName('vehicleid').AsInteger>0 then
          begin
            NovaHelpVehicleNo.Text :=FieldByName('vehicleno').AsString;
            NovaHelpVehicleNo.Id:=FieldByName('vehicleid').AsInteger;
//            NovaHelpVehicleNo.DoExit;
            keybd_event(VK_RETURN,0,0,0); //模拟按键，按下enter键
            keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //按上来
          end;
      end;
    end;
    edtDriver1.Id := 0;
  end;

end;


procedure TFrmDispatchManage.edCardNoKeyPress(Sender: TObject; var Key: Char);
begin
  // inherited;

end;

procedure TFrmDispatchManage.FormActivate(Sender: TObject);
begin
  inherited;
  // if Assigned(sysInfo.CardManage) then
  // begin
  // sysInfo.CardManage.StopRead;
  // sysInfo.CardManage.ReadCardNo(Self.NovaEdtCardNo);
  // sysInfo.CardManage.StartRead;
  // end;
end;

procedure TFrmDispatchManage.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  if Assigned(printValue) then
    printValue.Free;
  if Assigned(roadPrint) then
    roadPrint.Free;
  if Assigned(multiplelist) then
    multiplelist.Free;
  if Assigned(multipleValueValue) then
    multipleValueValue.Free;
  inherited;
end;

procedure TFrmDispatchManage.FormCreate(Sender: TObject);
var
  id: Int64;
begin
  inherited;
  id := sysInfo.LoginUserInfo.OrgID;

  try
    TBaseCardRW.GetInstance.addObserver(self);
  except
    TBaseCardRW.GetInstance.addObserver(self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,
    sysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, sysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    sysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, sysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, sysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    sysInfo.curBillLength.Items['Unit']);
  // if not Assigned(sysInfo.CardManage) then
  // begin
  // sysInfo.CardManage := TCardManage.Create(nil);
  // sysInfo.CardManage.CardLength := sysInfo.curBillLength.Items['Vehicle'];
  // sysInfo.CardManage.CardType := TCardType.All;
  // sysInfo.CardManage.SetConfig(2, 1, '111fffffffff');
  // sysInfo.CardManage.ReadCardNo(NovaEdtCardNo);
  // sysInfo.CardManage.StartRead;
  // end
  // else
  // begin
  // sysInfo.CardManage.CardLength := sysInfo.curBillLength.Items['Vehicle'];
  // sysInfo.CardManage.CardType := TCardType.All;
  // sysInfo.CardManage.ReadCardNo(NovaEdtCardNo);
  // sysInfo.CardManage.StartRead;
  // end;
  DpDepartdate.DateTime := now;
  dtfromdatetime.Time := now - 0.021;
  NovaCobbScheduleStatus.Active := false;
  NovaCobbScheduleStatus.Active := true;
  with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    NovaHCbbOrg.SetItemIndexByField('id', sysInfo.LoginUserInfo.StationID);
  end;
  jcsdWorkType.Active := false;
  jcsdWorkType.Active := true;
  jcdsworkways.Active := false;
  jcdsworkways.Active := true;
  jcdsDISTRICTTYPE.Active := false;
  jcdsDISTRICTTYPE.Active := true;
  jcdstype.Active := false;
  jcdstype.Active := true;
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := true;
  // CreateTreeListRouteStationOwner(TreeVRoute);
  if not Assigned(vehReport) then
      vehReport:=TVehcileReport.create(self);
  vehReport.qryParameter;
  // 安检获取参数   ：是否需要安检合格才允许报到
  if vehReport.p2013 = '1' then
    vheicleisMustCheck := true
  else
    vheicleisMustCheck := false;

  if vehReport.p6008 = '1' then
    isMustCheckwithout := true
  else
    isMustCheckwithout := false;
  if vehReport.p2033 = '1' then
     isfinger:=true
  else
     isfinger:=false;
  if vehReport.p1819 = '1' then
  begin
      checkBillno('BalanceBill');
      GroupBox2.Visible := true;
      refreshBill;
  end;
  if isfinger then
  begin
      jsonSpcQry.Active:=false;
      jsonSpcQry.Active:=true;
      //jsonQryStwed.Active:=false;
     // jsonQryStwed.Active:=true;
  end;
  if (vehReport.p2033='1') and (vehReport.p0030='0')  then
  begin
      ZKFPEngX1:=TZKFPEngX.Create(Self);
      fpcHandle := ZKFPEngX1.CreateFPCacheDB;
  end;
end;

procedure TFrmDispatchManage.FormDeactivate(Sender: TObject);
begin
  inherited;
  if Assigned(sysInfo.CardManage) then
  begin
    sysInfo.CardManage.StopRead;
  end;
end;

procedure TFrmDispatchManage.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(self);
  except
  end;
  try
   if self.initsuccess then
   begin
     if fpcHandle<=0 then exit;
      ZKFPEngX1.FreeFPCacheDB(fpcHandle);
      ZKFPEngX1.Free;
   end;
  except
  end;
end;

procedure TFrmDispatchManage.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if isNovaEdtCardNoKeyPress then
  begin
    Key := 0;
    isNovaEdtCardNoKeyPress := false;
  end;
end;

procedure TFrmDispatchManage.FormShow(Sender: TObject);
var
  id:integer;
  sTemp:WideString;
begin
  inherited;
  //dbgrdhResult.jsonConnection := DMPublic.jcon;
  //dbgrdhResult.GridUser := sysInfo.LoginUserInfo.UserID;
  tbtnFilterClick(Sender);
  NovaHelpVehicleNo.SetFocus;
  if vehReport.p3025= '1' then
    isjumpno := true
  else
    isjumpno := false;
  if vehReport.p2032 = '1' then
    isIDorIc := true
  else
    isIDorIc := false;
   if(vehReport.p2033='1') and (vehReport.p0030='0') then
   begin
      if ZKFPEngX1.InitEngine = 0 then
      begin
        mmoReportInfo.Lines.Insert(0, '指纹设备初始化成功！');
        initsuccess:=true;
        with jsonSpcQry do
        begin
           if active then
           begin
             first;
             while(not eof) do
             begin
               sTemp:= FieldByName('fingerstr').AsString;
               SysLog.WriteErr('sTemp='+sTemp);
               id:=FieldByName('id').AsInteger;
               try
                  ZKFPEngX1.AddRegTemplateStrToFPCacheDB(fpcHandle,id,sTemp);
               except
                  SysLog.WriteErr('id='+inttostr(id)+'指纹注册失败！');
               end;
               next;
             end;
           end;
        end ;
        ZKFPEngX1.BeginCapture;
        ZKFPENgX1.EnrollCount:=1;
        //ZKFPEngX1.BeginEnroll;
        if ZKFPEngX1.IsRegister then ZKFPEngX1.CancelEnroll;
        ZKFPEngX1.SetAutoIdentifyPara(true, fpcHandle, 8);
      end
      else
      begin
         mmoReportInfo.Lines.Insert(0, '指纹设备初始化失败！');
         initsuccess:=false;
      end;
   end;
end;

procedure TFrmDispatchManage.HandleAuthority(const Key: TGUID;
  aEnable: boolean);
begin
  inherited;
  if GUIDToString(Key) = '{5672D30A-82E1-41C1-A4F0-391D3FD15BC0}' then
  begin
    ToolButton50.Visible := aEnable;
  end;
  //报到
  if GUIDToString(Key) = '{27EFFFDD-929A-4B1A-9CF3-79D347AD878D}' then
  begin
    tbtnInsert.Visible := aEnable;
  end;
  //取消报到
  if GUIDToString(Key) = '{303388F8-8C91-4045-AF8F-C77BB831906E}' then
  begin
    tbtnEdit.Visible := aEnable;
  end;
  //晚点处理
  if GUIDToString(Key) = '{70C32B77-2605-4948-A55E-03F802DFED7B}' then
  begin
    tbtnDelete.Visible := aEnable;
  end;
  //换车报到
  if GUIDToString(Key) = '{C0D62F22-A4BD-4563-8E95-6DD82623837D}' then
  begin
    tbtnSave.Visible := aEnable;
  end;
  // 非流水班
  if GUIDToString(Key) = '{B5B156E5-2662-4183-84A2-B50617556B4B}' then
  begin
    ChkNotIsworkline.Checked := aEnable;
    ChkNotIsworkline.Enabled := aEnable;
  end;
  // 流水班
  if GUIDToString(Key) = '{DDD1600A-629B-4B67-BE9E-7F7A3A0B9513}' then
  begin
    ChkIsworkline.Checked := aEnable;
    ChkIsworkline.Enabled := aEnable;
  end;
  if ((ChkIsworkline.Checked) and (ChkNotIsworkline.Checked) or
      ((not ChkIsworkline.Checked) and (not ChkNotIsworkline.Checked))) then
  begin
    ChkIsworkline.Enabled := true;
    ChkNotIsworkline.Enabled := true;
  end;
  if GUIDToString(Key) = '{CCC78578-5637-4D48-AC5A-D13D2D343045}' then
  begin
//    ToolButton53.Visible := aEnable;
    tbtnPrinter.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{57F0B3FE-288C-41B3-B037-097A38CADED4}' then
  begin
    tbtnInfo.Visible := aEnable;
  end;
  if GUIDToString(Key) = '{C8E4AF11-7C6A-4A43-9DEF-1F9B03D2632B}' then
  begin
    ToolButton51.Visible := aEnable;
    if aEnable then
    begin
      refreshBill;
    end
    else
    begin
      GroupBox2.Visible := false;
    end;
  end;
  // 可输入车号进行报班
  if GUIDToString(Key) = '{EA7999D5-5785-4C68-9BFC-4FBBD89D317C}' then
  begin
    NovaHelpVehicleNo.ReadOnly := not(aEnable);
    isvehicleable := aEnable
  end;
  // 可输入IC卡号进行报班
  if GUIDToString(Key) = '{4B8F59BF-3ED7-4AC1-B22E-4DB48128BDA7}' then
  begin
    NovaEdtCardNo.ReadOnly := not(aEnable);
    isICcodeable := aEnable;
  end;
end;

procedure TFrmDispatchManage.iccardfound(icCard: TBaseCard);
begin
  serialnumber := '';
  if integer(icCard.cardtype) <> 0 then
  begin
    //自动报班不出现提示框
    //ShowMessage('该卡不是报到卡，不能用于报到！');
    mmoReportInfo.Lines.Insert(0, '该卡不是报到卡，不能用于报到！');
  end
  else
  begin
    serialnumber := inttostr(icCard.internalSerialNo);
    NovaEdtCardNo.Text := icCard.cardNo;
  end;
end;



procedure TFrmDispatchManage.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  // 正常、报停、晚点、被并、脱班、停售

  // 已经报到了不能在脱班 \顶班
  if jcdsResult.FieldByName('isreported').AsBoolean then
  begin
    tbtnDelete.Enabled := false;
    tbtnEdit.Enabled := true;
    ToolButton52.Enabled := true; // 放空
    tbtnCancel.Enabled := false;
    tbtnPrinter.Enabled := true;
    tbtn6.Enabled := true;
  end
  else
  begin
    tbtnDelete.Enabled := true;
    tbtnCancel.Enabled := true;
    tbtnEdit.Enabled := false;
    ToolButton52.Enabled := false; // 放空
    tbtnPrinter.Enabled := false;
    tbtn6.Enabled := false;
  end;
  // 已经发班，不能取消报班
  if jcdsResult.FieldByName('isdeparted').AsBoolean then
  begin
    tbtnEdit.Enabled := false;
  end;
  // 流水班不可以做晚点处理。
  if jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    tbtnDelete.Enabled := false;
  end;

end;

procedure TFrmDispatchManage.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    qryScheduleplan(0);
  end;
end;

procedure TFrmDispatchManage.NovaEdtCardNoChange(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if Trim(NovaEdtCardNo.Text)='' then
  Exit;
  if (Length(NovaEdtCardNo.Text)=SysInfo.curBillLength['Vehicle']) or (not isIDorIc) then
  begin
    vehReport.cardno:=NovaEdtCardNo.Text;
    vehReport.QryVehicleinfo(NovaEdtCardNo.Text);
    if vehReport.res.flag<0 then
      begin
        //自动报班不出现提示框
        //SysDialogs.Warning(sResult);
        mmoReportInfo.Lines.Insert(0, vehReport.res.msg);
        NovaEdtCardNo.Clear;
        NovaEdtCardNo.SetFocus;
        exit;
      end
    else
    begin
        NovaEdtCardNo.Clear;
        NovaHelpVehicleNo.Text:= vehReport.jcsdQryVehicleinfo.FieldByName('vehicleno').AsString;
        NovaHelpVehicleNo.id:=vehReport.jcsdQryVehicleinfo.FieldByName('id').AsLargeInt;
       // NovaHelpVehicleNoIdChange(nil);
    end;
  end;
end;

procedure TFrmDispatchManage.NovaEdtCardNoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  key:=0;
  if not isIDorIc then
    NovaEdtCardNoChange(sender);
end;

procedure TFrmDispatchManage.NovaHelpVehicleNoIdChange(Sender: TObject);
var
  autoVehicleno:string;
  sResult: string;
   curseats, busseats,limitdistance,departdistance,vehiclenoid, nResult: integer;
  curid, curvehicleid: Int64;
begin
  inherited;
  if (trim(NovaHelpVehicleNo.Text) <> '') and (NovaHelpVehicleNo.id > 0) then
  begin
     vehReport.vehicleid:= NovaHelpVehicleNo.id;
     vehReport.vehicleno:= NovaHelpVehicleNo.Text;
     if NovaHelpVehicleNo.HelpFieldValue['code']<>'' then
     begin
        vehReport.cardno := NovaHelpVehicleNo.HelpFieldValue['code']; //IC卡号
     end;
     curvehicleid:=NovaHelpVehicleNo.id;
     vehReport.departstationid:= NovaHCbbOrg.HelpFieldValue['id'];
     vehReport.QryScheduleplan(formatdatetime('yyyy-mm-dd', DpDepartdate.DateTime),
             sysInfo.LoginUserInfo.StationID,0,vehReport.vehicleid,0);
//     if vehReport.jcsdQryScheduleplan.RecordCount=0 then
//     begin
//        mmoReportInfo.Lines.Insert(0, '车号:' + trim(NovaHelpVehicleNo.Text)
//            + '该车辆未设置关联班线，请手动报班！');
//        NovaHelpVehicleNo.Clear;
//     end
//     else
//     begin
        //自动报班
        if (chkAutoReport.Checked) then
        begin
            NovaHelpVehicleNo.Clear;
            repAskCondition.departstationid:=NovaHCbbOrg.HelpFieldValue['id'];
            repAskCondition.departdate:= vehReport.jcsdQryScheduleplan.FieldByName('departdate').AsDateTime;
            repAskCondition.createby:=sysInfo.LoginUserInfo.UserID;
            repAskCondition.scheduleplanid:=vehReport.jcsdQryScheduleplan.FieldByName('id').AsLargeInt;
            repAskCondition.reportorgid:=sysInfo.LoginUserInfo.OrgID;
            repAskCondition.scheduleid:=vehReport.jcsdQryScheduleplan.FieldByName('scheduleid').AsLargeInt;
            repAskCondition.vehicleid:=curvehicleid;
            repAskCondition.isTempVehicle:=false;
            if vehReport.jcsdQryScheduleplan.FieldByName('driver1').AsLargeInt>0 then //驾驶员1
               repAskCondition.driver1id:= vehReport.jcsdQryScheduleplan.FieldByName('driver1').AsLargeInt;
            if vehReport.jcsdQryScheduleplan.FieldByName('driver2').AsLargeInt>0 then   //驾驶员2
               repAskCondition.driver2id := vehReport.jcsdQryScheduleplan.FieldByName('driver2').AsLargeInt;
            if vehReport.jcsdQryScheduleplan.FieldByName('steward1').AsLargeInt>0 then   //乘务员
               repAskCondition.steward1id:= vehReport.jcsdQryScheduleplan.FieldByName('steward1').AsLargeInt;
            FrmAutoReportResult := TFrmAutoReportResult.Create(self);
            try
              with FrmAutoReportResult do
              begin
                Caption := '自动报班';

                NovaEdtCardNo.Text:='';
                nvhlpVehicleNo.Text:=vehReport.vehicleno;
                nvhlpSchedule.Text:=vehReport.jcsdQryScheduleplan.FieldByName('code').AsString;
                nvhlpSchedule.id:=vehReport.jcsdQryScheduleplan.FieldByName('scheduleid').AsLargeInt;
                curid:=vehReport.jcsdQryScheduleplan.FieldByName('id').AsLargeInt;
                nvhlpRoute.Text:=vehReport.jcsdQryScheduleplan.FieldByName('endstationname').AsString;
                nvhlpRoute.id:=vehReport.jcsdQryScheduleplan.FieldByName('endstationid').AsLargeInt;
                NovaEdtSeatnum.Text:=vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsString;
                NovaEdtDeparttime.Text:=vehReport.jcsdQryScheduleplan.FieldByName('departtime').AsString;
                nvhlpUnit.Text:=vehReport.jcsdQryScheduleplan.FieldByName('unitname').AsString;
                NovaEdtReportDateTime.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
                mmoResult.Lines.Clear;
                if SysMainForm.showFormModal(FrmAutoReportResult, false)=mrOk then
                begin
                    mmoResult.Lines.Append(vehReport.res.msg);
                    NovaHelpVehicleNo.Clear;
                    PlaySound('thankyou.wav', 0, snd_async);
                    qryScheduleplan(curid);
                    NovaHelpVehicleNo.SetFocus;
                end
                else
                begin
                   qryScheduleplan(curid);
                end;
              end;
            finally
               FreeAndNil(FrmAutoReportResult);
            end;
        end
        //没有开启自动报班时
        else
        begin
          NovaHelpVehicleNo.Clear;
          NovaHelpVehicleNo.SetFocus;
          FrmScheduleReport := TFrmScheduleReport.Create(self);
          try
            with FrmScheduleReport do
            begin
              Caption := '车辆报班';
              LblVehicleNo.Caption := vehReport.vehicleno;
              ds1.DataSet:=vehReport.jcsdQryScheduleplan;
              departstationid:=NovaHCbbOrg.HelpFieldValue['id'];
              departdate:=FormatDateTime('yyyy-mm-dd',
              vehReport.jcsdQryScheduleplan.FieldByName('departdate').AsDateTime);
              vehicleid:=vehReport.vehicleid;
              vehReport.isShowmsg:=true;
              vehicledriver1 := vehicledriverid;
              if SysMainForm.showFormModal(FrmScheduleReport, false) = mrok then
              begin
                curid := repAskCondition.scheduleplanid;
                PlaySound('thankyou.wav', 0, snd_async);
                mmoReportInfo.Lines.Append(vehReport.res.msg);
                NovaHelpVehicleNo.Clear;
                qryScheduleplan(curid);
                NovaHelpVehicleNo.SetFocus;
              end
              else
              begin
                NovaHelpVehicleNo.SetFocus;
              end;
            end;
          finally
            FreeAndNil(FrmScheduleReport);
          end;
        end;
//     end;
  end;

end;

procedure TFrmDispatchManage.NovaHelpVehicleNoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key=13 then
  begin
    key:=0;
    NovaHelpVehicleNo.SetFocus;
  end;
end;



procedure TFrmDispatchManage.qryScheduleplan(curid: Int64);
var
  permin: integer;
  departtime: string;
begin
  inherited;
  if (curid = 0) and (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
    curid := jcdsResult.FieldByName('id').AsLargeInt;

  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_EQD_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', DpDepartdate.DateTime);

    Params.ParamValues['departstationid'] := NovaHCbbOrg.HelpFieldValue['id'];

    if qrycurstationid>0 then
    begin
       Params.ParamValues['qrycurstationid'] := qrycurstationid;
    end
    else
    begin
       Params.ParamValues['qrycurstationid'] := '';
    end;


    if dtfromdatetime.Checked then
      Params.ParamValues['filter_GES_ss!departtime'] := formatdatetime('hh:mm',
        dtfromdatetime.Time)
    else
      Params.ParamValues['filter_GES_ss!departtime'] := null;

    if (NovaEditMinute.Text) = '' then
    begin
      NovaEditMinute.Text := '0';
    end;
    permin := StrToInt(NovaEditMinute.Text);
    if chkDepatetimePre.Checked and (permin > 0) then
    begin
      departtime := formatdatetime('hh:mm', (now + permin / 60 / 24));
      Params.ParamValues['filter_LES_ss!departtime'] := departtime; // <=
      // >=
      Params.ParamValues['filter_GES_ss!departtime'] := formatdatetime('hh:mm',
        now);
    end
    else
      Params.ParamValues['filter_LES_ss!departtime'] := null;

    if NovaCobbScheduleStatus.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_ss!status'] :=
        NovaCobbScheduleStatus.GetSelectCode
    else
      Params.ParamValues['filter_EQS_ss!status'] :=
        NovaCobbScheduleStatus.GetSelectCode;

    if NovaCbbIsChecked.ItemIndex = 1 then
      Params.ParamValues['filter_EQB_ss!isbegincheck'] := true
    else if NovaCbbIsChecked.ItemIndex = 2 then
      Params.ParamValues['filter_EQB_ss!isbegincheck'] := false
    else
      Params.ParamValues['filter_EQB_ss!isbegincheck'] := null;

    if NovaCbbIsReported.ItemIndex = 1 then
      Params.ParamValues['filter_EQB_ss!isreported'] := true
    else if NovaCbbIsReported.ItemIndex = 2 then
      Params.ParamValues['filter_EQB_ss!isreported'] := false
    else
      Params.ParamValues['filter_EQB_ss!isreported'] := null;

    if NovaCbbissellable.ItemIndex = 1 then
    begin
      Params.ParamValues['filter_EQB_sp!issellable'] := true;
      // Params.ParamValues['filter_NOEQS_ss!status'] :='5'
    end
    else if NovaCbbissellable.ItemIndex = 2 then
    begin
      Params.ParamValues['filter_EQB_sp!issellable'] := false;
      Params.ParamValues['filter_EQS_ss!status'] := '5';
    end
    else
    begin
      Params.ParamValues['filter_EQB_sp!issellable'] := null;

    end;

    if trim(NHelpRoute.Text) <> '' then
      Params.ParamValues['filter_EQS_r!name'] := trim(NHelpRoute.Text)
    else
      Params.ParamValues['filter_EQS_r!name'] := null;
    if trim(NovaHelpUnit.Text) <> '' then
      Params.ParamValues['filter_EQS_u1!name'] := trim(NovaHelpUnit.Text)
    else
      Params.ParamValues['filter_EQS_u1!name'] := null;

    if (NovaHelpVehiclenoHelp.id > 0) and
      (trim(NovaHelpVehiclenoHelp.Text) <> '') then
      Params.ParamValues['filter_EQL_sv!planvehicleid'] :=
        NovaHelpVehiclenoHelp.id
    else
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := null;
    if trim(NovaHelpSchedule.Text) <> '' then
      Params.ParamValues['filter_EQS_s!code'] := trim(NovaHelpSchedule.Text)
    else
      Params.ParamValues['filter_EQS_s!code'] := null;
    if (ChkNotIsworkline.Checked) and (not ChkIsworkline.Checked) then
    begin
      Params.ParamValues['filter_EQB_sp!islinework'] := false;
    end
    else if (not ChkNotIsworkline.Checked) and (ChkIsworkline.Checked) then
    begin
      Params.ParamValues['filter_EQB_sp!islinework'] := true;
    end
    else
    begin
      Params.ParamValues['filter_EQB_sp!islinework'] := null;
    end;
    Params.ParamValues['departdate'] := formatdatetime('yyyy-mm-dd',
      DpDepartdate.DateTime);
    Active := true;
    if RecordCount > 0 then
    begin
      jcdsResult.Locate('id', curid, []);
      dbgrdhResult.SetFocus;
      dbgrdhResult.SelectedRows.CurrentRowSelected := true;
    end;
  end;

end;

procedure TFrmDispatchManage.refreshBill;
begin
  if sysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and sysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (sysInfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin
    lblBillno.Caption := sysInfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    lblBillnum.Caption := inttostr(sysInfo.LoginUserInfo.curBillNum.Items
        ['BalanceBill']);
    lblBillnum.Refresh;
    lblBillno.Refresh;
    GroupBox2.Refresh;
    // ToolButton53.Enabled := true;
    // tbtnPrinter.Enabled := true;
  end
  else
  begin
    lblBillno.Caption := '';
    lblBillnum.Caption := '0';
    // ToolButton53.Enabled := false;
    // tbtnPrinter.Enabled := false;
    // SysDialogs.Warning('请重置结算单号！');
    // self.Close;
  end;
end;

procedure TFrmDispatchManage.tbtnCancelClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;

  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm(tbtnCancel.Caption + '操作',
    '确认要' + tbtnCancel.Caption + '该班次吗？') then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    //
    if jcdsResult.FieldByName('status').AsString = '1' then
    begin
      allowScheduleplan(curid) // 恢复
    end
    else
    begin
      if (jcdsResult.FieldByName('soldeatnum').AsInteger > 0) then
      begin
        if SysDialogs.Ask('停班操作',
          '该班次已经售票' + jcdsResult.FieldByName('soldeatnum')
            .AsString + '张，是否要继续停班？') then
          stopScheduleplan(curid); // 报停
      end
      else
        stopScheduleplan(curid); // 报停
    end;
  end;

end;


procedure TFrmDispatchManage.tbtnDeleteClick(Sender: TObject);
var
  curid: Int64;
  nResult: integer;
  sResult: String;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  // 服务端已增加了操作日志
  if SysDialogs.Confirm('晚点操作', '确认要进行晚点操作吗？') then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    try
      with jscdVehicleLater do
      begin
        Active := false;
        Params.ParamValues['schedulestatusid'] := jcdsResult.FieldByName
          ('schedulestatusid').AsLargeInt;
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        if (nResult <= 0) then
        begin
          SysDialogs.Warning(sResult);
        end
        else
        begin
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
          jcdsResult.Locate('id', curid, []);
          NovaHelpVehicleNo.SetFocus;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('晚点操作失败：' + E.Message);
      end;
    end;
  end;
  { if SysDialogs.Confirm('脱班操作', '确认要进行脱班操作吗？') then
    begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    FrmVehicleLost := TFrmVehicleLost.Create(Self);
    try
    with FrmVehicleLost do
    begin
    scheduleplanid := curid;
    NovaEdtDepartDate.Text := jcdsResult.FieldByName('departdate').AsString;
    NvEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
    nvedtcode.Text := jcdsResult.FieldByName('code').AsString;
    nvedtcode.id := jcdsResult.FieldByName('scheduleid').AsLargeInt;
    NvedtDeparttimeL.Text := jcdsResult.FieldByName('departtime').AsString;
    nvedtSeatnum.Text := jcdsResult.FieldByName('Seatnum').AsString;
    NovaEdtUnit.Text := jcdsResult.FieldByName('planunit').AsString;
    NovaEdtUnit.id := jcdsResult.FieldByName('planunitid').AsLargeInt;
    NovaHelpVehiclenoL.id := jcdsResult.FieldByName('planvehicleid')
    .AsLargeInt;
    NovaHelpVehiclenoL.Text := jcdsResult.FieldByName('planvehicle')
    .AsString;
    nvedttickettype.Text := jcdsResult.FieldByName('planvehicletype')
    .AsString;
    if SysMainForm.showFormModal(FrmVehicleLost, false) = mrok then
    begin
    tbtnFilterClick(Sender);
    jcdsResult.Locate('id', curid, []);
    end;
    end;
    finally
    FreeAndNil(FrmVehicleLost);
    end;
    end; }

end;

procedure TFrmDispatchManage.tbtnEditClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('isreported').AsBoolean then
  begin
    // if SysDialogs.Confirm('取消报到', '确认要取消报到吗？') then
    // begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    FrmCancelReport := TFrmCancelReport.Create(self);
    try
      with FrmCancelReport do
      begin
        schedulecode := jcdsResult.FieldByName('code').AsString;
        // NvedtDeparttimeL.Text := jcdsResult.FieldByName('departtime')
        /// .AsString;
        vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
        // NovaEdtReportTime.Text := jcdsResult.FieldByName('reporttime')
        // .AsString;
        islineWork := jcdsResult.FieldByName('islinework').AsBoolean;
        updateby := sysInfo.LoginUserInfo.UserID;
        scheduleplanid := curid;
        curStationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
        reportorgid := jcdsResult.FieldByName('reportorgid').AsLargeInt;
        vehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
        reportid := jcdsResult.FieldByName('reportid').AsLargeInt;
        scheduleid := jcdsResult.FieldByName('scheduleid').AsLargeInt;
        DpDepartdate.Date := jcdsResult.FieldByName('departdate').AsDateTime;
        departdate := jcdsResult.FieldByName('departdate').AsString;

        // NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
        if SysMainForm.showFormModal(FrmCancelReport, false) = mrok then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id', curid, []);
        end;
      end;
    finally
      FreeAndNil(FrmCancelReport);
    end;
  end;

end;

procedure TFrmDispatchManage.tbtnFilterClick(Sender: TObject);
begin
  qryScheduleplan(0);
end;

procedure TFrmDispatchManage.tbtnInfoClick(Sender: TObject);
begin
  // inherited;
  with FrmVehicleRunPlan do
  begin
    FrmVehicleRunPlan := TFrmVehicleRunPlan.Create(self);
    departdate := FrmDispatchManage.DpDepartdate.Date;
    if trim(FrmDispatchManage.jcdsResult.FieldByName('vehicleno').AsString)
      <> '' then
    begin
      vehicleid := FrmDispatchManage.jcdsResult.FieldByName('vehicleid')
        .AsInteger;
      NovaHelpVehiclenoHelp.Text := FrmDispatchManage.jcdsResult.FieldByName
        ('vehicleno').AsString;
    end
    else if trim(FrmDispatchManage.jcdsResult.FieldByName('planvehicle')
        .AsString) <> '' then
    begin
      vehicleid := FrmDispatchManage.jcdsResult.FieldByName('planvehicleid')
        .AsInteger;
      NovaHelpVehiclenoHelp.Text := FrmDispatchManage.jcdsResult.FieldByName
        ('planvehicle').AsString;
    end
    else
      vehicleid := 0;
    ShowModal;
    // NovaHelpVehiclenoHelp.Id := vehicleid;
  end;
end;

procedure TFrmDispatchManage.tbtnInsertClick(Sender: TObject);
var
  curid: Int64;
  templtename: string;
begin
  inherited;
  curid := 0;
  FrmVehicleReport := TFrmVehicleReport.Create(self);
  try
    with FrmVehicleReport do
    begin
      Caption := '营运车辆报到';
      createby := sysInfo.LoginUserInfo.UserID;
      isMustCheck := vheicleisMustCheck;
      //curQryFingerInfo:=self.jsonSpcQry;
      //curisfinger:=isfinger;
      reportorgid := sysInfo.LoginUserInfo.OrgID;
      NovaHelpVehicleNo.ReadOnly := not(isvehicleable);
      nvedtbdcard.ReadOnly := not(isICcodeable);
      if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
      begin
        curStationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
        qrycurstationid := curStationid;
        if jcdsResult.FieldByName('islinework').AsBoolean then
          pgc1.ActivePageIndex := 1
        else
          pgc1.ActivePageIndex := 0;
        DpDepartdate.Date := jcdsResult.FieldByName('departdate').AsDateTime;
        scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
        curid := jcdsResult.FieldByName('id').AsLargeInt;
        NovaHelpVehicleNo.id := jcdsResult.FieldByName('planvehicleid')
          .AsInteger;
        try
        NovaHelpVehicleNo.Text := jcdsResult.FieldByName('planvehicle')
          .AsString;
        except on e:Exception do
         ShowMessage(e.Message);
      end;
        NovaHelpVehicleNo.OnIdChange := nil;
        if NovaHelpVehicleNo.id > 0 then
          FrmVehicleReport.checkVehicles(FrmVehicleReport.NovaHelpVehicleNo.id,
            formatdatetime('yyyy-mm-dd', FrmVehicleReport.DpDepartdate.DateTime)
            );
        NovaHelpVehicleNo.HelpFieldValue['seatnum'] := jcdsResult.FieldByName
          ('seatnum').AsString;
        NovaHelpVehicleNo.OnIdChange := FrmVehicleReport.NovaHelpVehicleNoIdChange;
        NovaHUnit.id := jcdsResult.FieldByName('planunitid').AsInteger;
        NovaHUnit.Text := jcdsResult.FieldByName('planunit').AsString;
        NovaHelpBalanceUnit.id := jcdsResult.FieldByName('balanceunitid').AsInteger;
        NovaHelpBalanceUnit.Text := jcdsResult.FieldByName('balanceunitname').AsString;
        NovaHReprotSchedule.OnIdChange := nil;
        NovaHReprotSchedule.id := jcdsResult.FieldByName('scheduleid')
          .AsInteger;
        NovaHReprotSchedule.Text := jcdsResult.FieldByName('code').AsString;
        NovaHReprotSchedule.OnIdChange := NovaHReprotScheduleIdChange;
        try
        if jcdsResult.FieldByName('liabilityinsureenddate').AsString<>'' then
          Edtliabilityinsureenddate.Text:=FormatDateTime('yyyy-mm-dd',jcdsResult.FieldByName('liabilityinsureenddate').AsDateTime) ;
        if jcdsResult.FieldByName('licenseenddate').AsString<>'' then
          Edtlicenseenddate.Text:=FormatDateTime('yyyy-mm-dd', jcdsResult.FieldByName('licenseenddate').AsDateTime);
        if jcdsResult.FieldByName('workenddate').AsString<>'' then
          Edtworkenddate.Text:=FormatDateTime('yyyy-mm-dd',jcdsResult.FieldByName('workenddate').AsDateTime);
        if jcdsResult.FieldByName('compulsoryinsureenddate').AsString<>'' then
        edtcompulsoryinsureenddate.text:= FormatDateTime('yyyy-mm-dd',jcdsResult.FieldByName('compulsoryinsureenddate').AsDateTime);
        Edtworkno.text:= jcdsResult.FieldByName('roadno').AsString;
        except on e:Exception do
           ShowMessage(e.Message);
        end;
        //取计划 还是指纹录入
        if vehReport.p0030='0' then
        begin
           // nvhlpdriver.OnIdChange := nil;
          nvhlpdriver.id := jcdsResult.FieldByName('plandriver1id').AsInteger;
          nvhlpdriver.Text := jcdsResult.FieldByName('plandriver1').AsString;
          //nvhlpdriver.OnIdChange:=nvhlpdriverIdChange;
          //NovaHelpcopilot1.OnIdChange:=nil;
          NovaHelpcopilot1.id := jcdsResult.FieldByName('plandriver2id')
            .AsInteger;
          NovaHelpcopilot1.Text := jcdsResult.FieldByName('plandriver2').AsString;
          //NovaHelpcopilot1.OnIdChange:=NovaHelpcopilot1IdChange;

          NovaHelpcopilot2.id := jcdsResult.FieldByName('plandriver3id')
            .AsInteger;
          NovaHelpcopilot2.Text := jcdsResult.FieldByName('plandriver3').AsString;

           NovaHelpcopilot3.id := jcdsResult.FieldByName('plandriver4id')
           .AsInteger;
           NovaHelpcopilot3.Text := jcdsResult.FieldByName('plandriver4').AsString;
          NovaHelpsteward.id := jcdsResult.FieldByName('plansteward1id')
            .AsInteger;
          NovaHelpsteward.Text := jcdsResult.FieldByName('plansteward1').AsString;
        end;

        // 班次信息
        NvEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
        nvedttickettype.Text := jcdsResult.FieldByName('planvehicletype')
          .AsString;
        nvedtcode.Text := jcdsResult.FieldByName('code').AsString;
        nvedDeparttime.Text := jcdsResult.FieldByName('departtime').AsString;
        nvedtSeatnum.Text := jcdsResult.FieldByName('seatnum').AsString;
        //增加隐藏控件 李电志 2015年6月4日 15:52:45
        nvedtSeatnumhid.Text := jcdsResult.FieldByName('seatnum').AsString;
        //增加班次id  Scheduleplanidhid  李电志 2015年6月5日 11:02:44
        Scheduleplanidhid.Text := jcdsResult.FieldByName('id').AsString;

        nvedtSoldeatnum.Text := jcdsResult.FieldByName('soldeatnum').AsString;
        nvedtylNum.Text := inttostr(jcdsResult.FieldByName
            ('autocancelreserveseatnum').AsInteger + jcdsResult.FieldByName
            ('unautocancelreserveseatnum').AsInteger + jcdsResult.FieldByName
            ('fixedreserveseatnum').AsInteger);
        nvedtyzNum.Text := jcdsResult.FieldByName('leaveseat').AsString;
        routedistance := jcdsResult.FieldByName('distance').AsInteger;
        NovaHelpVehicletype.id := jcdsResult.FieldByName('planvehicletypeid')
          .AsInteger;

        FrmVehicleReport.planvehicleid := jcdsResult.FieldByName('planvehicletypeid').AsInteger;//计划车辆id

        NovaHelpVehicletype.Text := jcdsResult.FieldByName('planvehicletype')
          .AsString;
        scheduleEmployees:=jcdsResult.FieldByName('driverfingernum')
          .AsInteger;
      end
      else
      begin
        DpDepartdate.Date := now;
        curStationid := sysInfo.LoginUserInfo.StationID;
      end;
      edittype := Add;
      if SysMainForm.showFormModal(FrmVehicleReport, false) = mrok then
      begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id', curid, []);
      end;
    end;

  finally
    FreeAndNil(FrmVehicleReport);
  end;



  NovaHelpVehicleNo.SetFocus;
end;


procedure TFrmDispatchManage.tbtn6Click(Sender: TObject);
var
 nResult, peoples, totalpsdistance: integer;
  sResult: string;
begin
  inherited;
begin
  if not(jcdsResult.Active) then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('isreported').AsBoolean then
  begin

     if not SysDialogs.Confirm('提示信息', '确认进行重打操作？') then
        begin
          exit;
        end;
      try
        with jcsdSaveRoadbill do
        begin
          Active := false;
          Params.ParamValues['roadbillprint.createby'] :=
            sysInfo.LoginUserInfo.UserID;
          Params.ParamValues['roadbillprint.validateday'] := '1';
          Params.ParamValues['roadbillprint.remark'] := '重打';
          Params.ParamValues['roadbillprint.orgid'] :=
            sysInfo.LoginUserInfo.OrgID;
          Params.ParamValues['roadbillprint.roadbillno'] :=  formatdatetime('yyyymmddhhmmss',now);
//            sysInfo.LoginUserInfo.curBillNo.Items[_roadbill];
          Params.ParamValues['roadbillprint.vehiclereportid'] :=
            jcdsResult.FieldByName('reportid').AsString;
          Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
            .AsString;
          Active := true;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          if nResult = 1 then
          begin
            if not Assigned(roadPrint) then
              roadPrint := TNovaPrint.Create(self,
                TNovaPrint.GetTicketModelName('行车路单',
                  '默认行车路单'));
            if not Assigned(printValue) then
              printValue := TDictionary<String, String>.Create;
            printValue.Clear;
            printValue.Add('vehicleno',
              jcdsResult.FieldByName('vehicleno').AsString);
            printValue.Add('departtime',
              jcdsResult.FieldByName('departtime').AsString);
            printValue.Add('schedulecode',
              jcdsResult.FieldByName('code').AsString);
            printValue.Add('reportunit',
              jcdsResult.FieldByName('reportunit').AsString);
            printValue.Add('stewardname',
              jcdsResult.FieldByName('stewardname').AsString);
            printValue.Add('routename',
              jcdsResult.FieldByName('routename').AsString);
            printValue.Add('seatnum',
              jcdsResult.FieldByName('seatnum').AsString);
            //新增数据源获取核定座位数
            printValue.Add('rationseatnum1',
              jcdsResult.FieldByName('rationseatnum').AsString);
            printValue.Add('plandriver1',
              jcdsResult.FieldByName('reporddriver1').AsString);
            printValue.Add('plandriver2',
              jcdsResult.FieldByName('reporddriver2').AsString);
//            printValue.Add('plandriver3','hahahaha');
            try
            printValue.Add('plandriver3',
             jcdsResult.FieldByName('reporddriver3').AsString);
            printValue.Add('plandriver4',
             jcdsResult.FieldByName('reporddriver4').AsString);
            except on e:Exception do
              SysLog.WriteErr(e.Message);
            end;
//            printValue.Add('plansteward1',
//             jcdsResult.FieldByName('reportsteward').AsString);
            //始发站
            printValue.Add('beginstation',
              jcdsResult.FieldByName('departstation').AsString);
            //终点车站
            printValue.Add('zdstation',
              jcdsResult.FieldByName('endstation').AsString);
            //公里数
            printValue.Add('testdistance',
              jcdsResult.FieldByName('distance').AsString);
            //人次seatnum
            printValue.Add('testseatnum',
              jcdsResult.FieldByName('seatnum').AsString);
            //人公里
            printValue.Add('testpeopledistance',
              IntToStr(jcdsResult.FieldByName('seatnum').AsInteger * jcdsResult.FieldByName('distance').AsInteger));

            printValue.Add('departstation',
              jcdsResult.FieldByName('departstation').AsString);
            printValue.Add('endstation',
              jcdsResult.FieldByName('endstation').AsString);
            printValue.Add('distance',
              jcdsResult.FieldByName('distance').AsString);
//
            printValue.Add('days', '1');
            printValue.Add('remark', '重打');
            printValue.Add('orgname', sysInfo.LoginUserInfo.OrgName);
            printValue.Add('printer', sysInfo.LoginUserInfo.UserName);
            printValue.Add('printertime',
              formatdatetime('yyyy-mm-dd hh:mm', now));

            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            totalpsdistance := 0;
            peoples := 0;
            if RecordCount > 0 then
            begin
              first;
              while (not Eof) do
              begin
                multipleValueValue := TDictionary<String, String>.Create;
                multipleValueValue.Add('fromstation',
                  FieldByName('fromstation').AsString);
                multipleValueValue.Add('tostation',
                  FieldByName('tostation').AsString);
                multipleValueValue.Add('todistance',
                  FieldByName('todistance').AsString);
                multipleValueValue.Add('seatnum',
                  FieldByName('peoples').AsString);
                multipleValueValue.Add('peopledistance',
                  FieldByName('peopledistance').AsString);

                multiplelist.Add(multipleValueValue);
                peoples := peoples + FieldByName('peoples').AsInteger;
                totalpsdistance := totalpsdistance + FieldByName
                  ('peopledistance').AsInteger;
                next;
              end;
            end;

            //总人数
            peoples := peoples + jcdsResult.FieldByName('seatnum').AsInteger;
            //总人公里
            totalpsdistance := totalpsdistance + jcdsResult.FieldByName('seatnum').AsInteger * jcdsResult.FieldByName('distance').AsInteger;

            printValue.Add('allsoldeatnum', inttostr(peoples));
            printValue.Add('allpeopledistance', inttostr(totalpsdistance));

            roadPrint.MultipleValue := multiplelist;
            roadPrint.SingleValue := printValue;
            roadPrint.Print;
          end
          ELSE
            SysDialogs.Warning(sResult);
        end;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('打印路单操作失败：' + E.Message);
        end;
      end;
  end;
end;



end;
  procedure TFrmDispatchManage.tbtnPrinterClick(Sender: TObject);
var

  days, remark: string;
  nResult, peoples, totalpsdistance: integer;
  sResult: string;
begin
  if not(jcdsResult.Active) then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('isreported').AsBoolean then
  begin
//    if (sysInfo.LoginUserInfo.curBillNo.ContainsKey(_roadbill)) and
//      ((sysInfo.LoginUserInfo.curBillNo.Items[_roadbill] = '') or
//        (sysInfo.LoginUserInfo.curBillNum.Items[_roadbill] = 0)) then
//    begin
//      ToolButton53Click(Sender);
//    end;
//    if (sysInfo.LoginUserInfo.curBillNo.ContainsKey(_roadbill)) then
//    begin
//      if (sysInfo.LoginUserInfo.curBillNum.Items[_roadbill] = 0) then
//      begin
//        SysDialogs.Warning('请重置路单号！');
//        exit;
//      end;
      FrmPrintRoadInfo := TFrmPrintRoadInfo.Create(self);
      try
        with FrmPrintRoadInfo do
        begin
          if SysMainForm.showFormModal(FrmPrintRoadInfo, false) = mrok then
          begin
            days := trim(NovaEdtDays.Text);
            remark := trim(MeRemark.Text);
          end
          else
          begin
            exit;
          end;
        end;
      finally
        FreeAndNil(FrmPrintRoadInfo);
      end;
      try
        with jcsdSaveRoadbill do
        begin
          Active := false;
          Params.ParamValues['roadbillprint.createby'] :=
            sysInfo.LoginUserInfo.UserID;
          Params.ParamValues['roadbillprint.validateday'] := days;
          Params.ParamValues['roadbillprint.remark'] := remark;
          Params.ParamValues['roadbillprint.orgid'] :=
            sysInfo.LoginUserInfo.OrgID;
          Params.ParamValues['roadbillprint.roadbillno'] :=  formatdatetime('yyyymmddhhmmss',now);
//            sysInfo.LoginUserInfo.curBillNo.Items[_roadbill];
          Params.ParamValues['roadbillprint.vehiclereportid'] :=
            jcdsResult.FieldByName('reportid').AsString;
          Params.ParamValues['scheduleplanid'] := jcdsResult.FieldByName('id')
            .AsString;
          Active := true;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          if nResult = 1 then
          begin
            if not Assigned(roadPrint) then
              roadPrint := TNovaPrint.Create(self,
                TNovaPrint.GetTicketModelName('行车路单',
                  '默认行车路单'));
            if not Assigned(printValue) then
              printValue := TDictionary<String, String>.Create;
            printValue.Clear;
            printValue.Add('vehicleno',
              jcdsResult.FieldByName('vehicleno').AsString);
            printValue.Add('departtime',
              jcdsResult.FieldByName('departtime').AsString);
            printValue.Add('schedulecode',
              jcdsResult.FieldByName('code').AsString);
            printValue.Add('reportunit',
              jcdsResult.FieldByName('reportunit').AsString);
            printValue.Add('seatnum',
              jcdsResult.FieldByName('seatnum').AsString);
            printValue.Add('routename',
              jcdsResult.FieldByName('routename').AsString);
            printValue.Add('stewardname',
              jcdsResult.FieldByName('stewardname').AsString);
            //新增数据源获取核定座位数
            printValue.Add('rationseatnum1',
              jcdsResult.FieldByName('rationseatnum').AsString);
            printValue.Add('plandriver1',
              jcdsResult.FieldByName('reporddriver1').AsString);
            printValue.Add('plandriver2',
              jcdsResult.FieldByName('reporddriver2').AsString);
//            printValue.Add('plandriver3','hahahaha');
            try
            printValue.Add('plandriver3',
             jcdsResult.FieldByName('reporddriver3').AsString);
            printValue.Add('plandriver4',
             jcdsResult.FieldByName('reporddriver4').AsString);
            except on e:Exception do
              SysLog.WriteErr(e.Message);
            end;
//            printValue.Add('plansteward1',
//             jcdsResult.FieldByName('reportsteward').AsString);
            //始发站
            printValue.Add('beginstation',
              jcdsResult.FieldByName('departstation').AsString);
            //终点车站
            printValue.Add('zdstation',
              jcdsResult.FieldByName('endstation').AsString);
            //公里数
            printValue.Add('testdistance',
              jcdsResult.FieldByName('distance').AsString);
            //人次seatnum
            printValue.Add('testseatnum',
              jcdsResult.FieldByName('seatnum').AsString);
            //人公里
            printValue.Add('testpeopledistance',
              IntToStr(jcdsResult.FieldByName('seatnum').AsInteger * jcdsResult.FieldByName('distance').AsInteger));

            printValue.Add('departstation',
              jcdsResult.FieldByName('departstation').AsString);
            printValue.Add('endstation',
              jcdsResult.FieldByName('endstation').AsString);
            printValue.Add('distance',
              jcdsResult.FieldByName('distance').AsString);

            printValue.Add('days', days);
            printValue.Add('remark', remark);
            printValue.Add('orgname', sysInfo.LoginUserInfo.OrgName);
            printValue.Add('printer', sysInfo.LoginUserInfo.UserName);
            printValue.Add('printertime',
              formatdatetime('yyyy-mm-dd hh:mm', now));

            if not Assigned(multiplelist) then
              multiplelist := TList < TDictionary < String, String >> .Create
            else
              multiplelist.Clear;
            totalpsdistance := 0;
            peoples := 0;
            if RecordCount > 0 then
            begin
              first;
              while (not Eof) do
              begin
                multipleValueValue := TDictionary<String, String>.Create;
                multipleValueValue.Add('fromstation',
                  FieldByName('fromstation').AsString);
                multipleValueValue.Add('tostation',
                  FieldByName('tostation').AsString);
                multipleValueValue.Add('todistance',
                  FieldByName('todistance').AsString);
                multipleValueValue.Add('seatnum',
                  FieldByName('peoples').AsString);
                multipleValueValue.Add('peopledistance',
                  FieldByName('peopledistance').AsString);

                multiplelist.Add(multipleValueValue);
                peoples := peoples + FieldByName('peoples').AsInteger;
                totalpsdistance := totalpsdistance + FieldByName
                  ('peopledistance').AsInteger;
                next;
              end;
            end;

            //总人数
            peoples := peoples + jcdsResult.FieldByName('seatnum').AsInteger;
            //总人公里
            totalpsdistance := totalpsdistance + jcdsResult.FieldByName('seatnum').AsInteger * jcdsResult.FieldByName('distance').AsInteger;

            printValue.Add('allsoldeatnum', inttostr(peoples));
            printValue.Add('allpeopledistance', inttostr(totalpsdistance));

            roadPrint.MultipleValue := multiplelist;
            roadPrint.SingleValue := printValue;
            roadPrint.Print;
  //          sysInfo.LoginUserInfo.increaseBillNo(_roadbill, 1);
          end
          ELSE
            SysDialogs.Warning(sResult);
        end;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('打印路单操作失败：' + E.Message);
        end;
      end;
//    end
//    else
//    begin
//      SysDialogs.Warning('请重置路单号！');
//      exit;
//    end;

  end;
  { functionParm := TFunctionItemParameters.Create;
    functionParm.CommaText := 'Ticket'; }
  // SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),functionParm);

end;

procedure TFrmDispatchManage.tbtnSaveClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;

  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if not jcdsResult.FieldByName('isreported').AsBoolean then
  begin
    SysDialogs.ShowMessage('该班次还未报到，不需要换车报到！');
    exit;
  end;

  if jcdsResult.FieldByName('isdeparted').AsBoolean then
  begin
    SysDialogs.ShowMessage('该班次已经发班，不允许换车报到！');
    exit;
  end;

  curid := jcdsResult.FieldByName('id').AsLargeInt;
  FrmChangeVehicle := TFrmChangeVehicle.Create(self);
  try
    with FrmChangeVehicle do
    begin
      scheduleplanid := curid;
      isMustCheck := vheicleisMustCheck;
      Caption := '换车报到';
      scheduledepartdate := jcdsResult.FieldByName('departdate').AsString;
      NvEdtRoute.Text := jcdsResult.FieldByName('endstation').AsString;
      vehiclereportid := jcdsResult.FieldByName('reportid').AsLargeInt;
      nvedtcode.Text := jcdsResult.FieldByName('code').AsString;
      NvedtDeparttimeL.Text := jcdsResult.FieldByName('departtime').AsString;
      nvedtSeatnum.Text := jcdsResult.FieldByName('Seatnum').AsString;
      NovaHelpReportVehicle.Text := jcdsResult.FieldByName('vehicleno')
        .AsString;
      if SysMainForm.showFormModal(FrmChangeVehicle, false) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmChangeVehicle);
  end;

end;

procedure TFrmDispatchManage.ToolButton50Click(Sender: TObject);
var
  vehiclereportid, departinvoicesid, reportvehicleid, scheduleplanid: Int64;
  flags,nResult: integer;
 msgs, sResult, vehicleno: String;
  multipleValueValue: TDictionary<String, String>;
  schedulecode, departdate: string;
  departtime, departstation, endstation: string;
  routename, templtename: string;
  fulls, halfs, students, discounts, totalpsdistance: integer;
  totalpeople, psdistance: integer;
  totalfee, noagentbalanceprice: double;
  i: integer;
begin
  inherited;

  with qryvehisecuresult do
  begin
     Active:=False;
           if (jcdsResult.FieldByName('islinework').AsBoolean) then
            begin
              if not jcdsResult.Active then
                exit;
              if jcdsResult.RecordCount = 0 then
                exit;
             Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName('id').AsLargeInt;

            end
           else
            begin

              Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName('reportid').AsLargeInt;

            end;
//     Params.ParamValues['vehiclereportid'] := jcdsResult.FieldByName('id').AsLargeInt;
     Execute;
      flags := Params.ParamByName('flag').Value;
      msgs := Params.ParamByName('msg').Value;
  end;

  if not checkBillno('BalanceBill') then
    exit;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('该班次还未报到！');
    exit;
  end;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    SysDialogs.Warning('该班次已经发班！');
    exit;
  end;
  if not jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    if not SysDialogs.Confirm('提示信息', '确认进行打印操作？') then
    begin
      exit;
    end;
  end
  else if not SysDialogs.Confirm('提示信息', '确认进行打印操作？') then
  begin
    exit;
  end;

  fulls := 0;
  halfs := 0;
  students := 0;
  discounts := 0;
  totalpsdistance := 0;
  totalfee := 0;

  if (jcdsResult.FieldByName('islinework').AsBoolean) then
  begin
    if not jcdsResult.Active then
      exit;
    if jcdsResult.RecordCount = 0 then
      exit;
    vehiclereportid := jcdsResult.FieldByName('reportid').AsLargeInt;
    vehicleno := jcdsResult.FieldByName('vehicleno').AsString;
    reportvehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
  end
  else
  begin

    vehiclereportid := jcdsResult.FieldByName('reportid').AsLargeInt;
    reportvehicleid := jcdsResult.FieldByName('vehicleid').AsLargeInt;
  end;

  schedulecode := jcdsResult.FieldByName('code').AsString;
  departdate := jcdsResult.FieldByName('departdate').AsString;
  departtime := jcdsResult.FieldByName('departtime').AsString;
  departstation := jcdsResult.FieldByName('departstation').AsString;
  endstation := jcdsResult.FieldByName('endstation').AsString;
  routename := jcdsResult.FieldByName('routename').AsString;

  scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;

  with jcdsResultSave do
  begin
    Active := false;
    Params.ParamValues['departstationid'] := sysInfo.LoginUserInfo.StationID;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    Params.ParamValues['ip'] := sysInfo.LocalHostAddress;
    Params.ParamValues['departinvoicesno'] :=
      sysInfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    Params.ParamValues['vehiclereportid'] := vehiclereportid;

    Active := true;

    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;

    if nResult = 1 then
    begin
      templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
      if not Assigned(billPrint) then
        billPrint := TNovaPrint.Create(self, templtename);
      if RecordCount > 0 then
      begin
        while not Eof do
        begin
          if not Assigned(printValue) then
            printValue := TDictionary<String, String>.Create
          else
            printValue.Clear;
          printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
          printValue.Add('seats', FieldByName('seatnum').AsString);
          printValue.Add('brandmodel', FieldByName('brandname').AsString);
          printValue.Add('vehicletype', FieldByName('vehicletype').AsString);
          printValue.Add('route', routename);
          printValue.Add('routedistance', FieldByName('distance').AsString);
          printValue.Add('schedulecode', schedulecode);
          printValue.Add('departdate', departdate);
          printValue.Add('departtime', departtime);
          printValue.Add('departstation', departstation);
          printValue.Add('checkedname', FieldByName('checkedname').AsString);
          printValue.Add('endstation', endstation);
          printValue.Add('freetickets', FieldByName('freetickets').AsString);
          printValue.Add('armtickets', FieldByName('armtickets').AsString);
          //新增打印行包的数据源
          printValue.Add('packes', FieldByName('packes').AsString);
          printValue.Add('packbalanceprice', FieldByName('packbalanceprice').AsString);


          departinvoicesid := FieldByName('id').AsLargeInt;
          printValue.Add('invoicesno', FieldByName('invoicesno').AsString);
          printValue.Add('unit', FieldByName('unit').AsString);
          printValue.Add('ticketnum', FieldByName('ticketnum').AsString);
          printValue.Add('driver1', FieldByName('driver1').AsString);
          printValue.Add('driver2', FieldByName('driver2').AsString);
          printValue.Add('driver3', FieldByName('driver3').AsString);
          printValue.Add('driver4', FieldByName('driver4').AsString);
          printValue.Add('steward', FieldByName('steward').AsString);
          printValue.Add('balanceunit', FieldByName('balanceunit').AsString);
          // 扣费明细改为由数据集返回
          with jscdQryDeductfees do
          begin
            Active := false;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Active := true;
            if RecordCount > 0 then
            begin
              first;
              while (not Eof) do
              begin
                printValue.Add(FieldByName('code').AsString,
                  FieldByName('deductmoney').AsString);
                next;
              end;
            end;
          end;
          // 扣费明细改为由数据集返回
          printValue.Add('stationfee', FieldByName('stationfee').AsString);

          totalfee := FieldByName('totalamount').AsFloat - FieldByName
            ('agentfee').AsFloat - FieldByName('balanceamount').AsFloat;
          noagentbalanceprice := FieldByName('agentfee').AsFloat + FieldByName
            ('balanceamount').AsFloat;
          printValue.Add('peoplepackprice',FloatToStr(noagentbalanceprice+ FieldByName('packbalanceprice').AsFloat));
          printValue.Add('noagentbalanceprice',
            floattostr(noagentbalanceprice));
          printValue.Add('totalfee', floattostr(totalfee));
          printValue.Add('reprint', '');
          printValue.Add('agentfee', FieldByName('agentfee').AsString);
          printValue.Add('fueladditionfee',
            FieldByName('fueladditionfee').AsString);

          printValue.Add('otherfee', FieldByName('otherfee').AsString);
          printValue.Add('totalamount', FieldByName('totalamount').AsString);
          printValue.Add('balanceamount',
            FieldByName('balanceamount').AsString);
          if FieldByName('isovertime').AsBoolean then
            printValue.Add('isovertime', '加班')
          else
            printValue.Add('isovertime', '');
          printValue.Add('printby', sysInfo.LoginUserInfo.UserName);
          printValue.Add('printstation', sysInfo.LoginUserInfo.OrgName);
          printValue.Add('printertime',
            formatdatetime('yyyy-mm-dd hh:mm', now));

          if not Assigned(multiplelist) then
            multiplelist := TList < TDictionary < String, String >> .Create
          else
            multiplelist.Clear;
          with jcdsQryDetail do
          begin
            Active := false;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Active := true;
            if RecordCount > 0 then
            begin
              first;

              while (not Eof) do
              begin
                multipleValueValue := TDictionary<String, String>.Create;
                multipleValueValue.Add('fromstation',
                  FieldByName('fromstation').AsString);
                multipleValueValue.Add('reachstation',
                  FieldByName('reachstation').AsString);
                multipleValueValue.Add('fullpeople',
                  FieldByName('fullpeople').AsString);
                multipleValueValue.Add('price', FieldByName('price').AsString);
                multipleValueValue.Add('halfpeople',
                  FieldByName('halfpeople').AsString);
                multipleValueValue.Add('studentpeople', '0');
                multipleValueValue.Add('discountpeople',
                  FieldByName('discountpeople').AsString);
                multipleValueValue.Add('distance',
                  FieldByName('distance').AsString);
                totalpeople := FieldByName('fullpeople').AsInteger + FieldByName
                  ('halfpeople').AsInteger;
                psdistance := FieldByName('distance').AsInteger * totalpeople;
                multipleValueValue.Add('psdistance', inttostr(psdistance));
                multipleValueValue.Add('totalamount',
                  FieldByName('totalamount').AsString);
                multipleValueValue.Add('balanceprice',
                  FieldByName('balanceprice').AsString);
                multiplelist.Add(multipleValueValue);
                multipleValueValue.Add('balanceamount',
                  FieldByName('balanceamount').AsString);
                multipleValueValue.Add('noagentbalanceamount',
                  FieldByName('noagentbalanceamount').AsString);
                fulls := fulls + FieldByName('fullpeople').AsInteger;
                halfs := halfs + FieldByName('halfpeople').AsInteger;
                students := 0;
                discounts := 0;
                totalpsdistance := totalpsdistance + psdistance;
                next;
              end;
            end;
          end;
          // 根据运量ID 发车日期获取他站售票情况
          with jcdsOthersells do
          begin
            Active := false;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Params.ParamValues['departdate'] := departdate;
            Execute;
            printValue.Add('othersell', Params.ParamByName('othersells').Value);
          end;
          printValue.Add('fulls', inttostr(fulls));
          printValue.Add('halfs', inttostr(halfs));
          printValue.Add('students', inttostr(students));
          printValue.Add('discounts', inttostr(discounts));
          printValue.Add('totalpsdistance', inttostr(totalpsdistance));

          billPrint.SingleValue := printValue;
          billPrint.MultipleValue := multiplelist;


            if ((msgs = '0') or (msgs='2')) then
            begin  //安检合格打印
               billPrint.Print;
            end
            else
            begin
              if (getParametervalue('6070', Sysinfo.LoginUserInfo.OrgID) = '1') then
              begin   //安检不合格 参数是1是时 能打印
                billPrint.Print;
              end  ;
            end;

          with sysInfo.LoginUserInfo do
          begin
            curBillNo.AddOrSetValue('BalanceBill',
              zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                    + 1), length(curBillNo.Items['BalanceBill'])));
            curBillNum.AddOrSetValue('BalanceBill',
              curBillNum.Items['BalanceBill'] - 1);
          end;
          refreshBill;
          next;
        end;
        SysDialogs.ShowMessage('打单成功！');
        qryScheduleplan(scheduleplanid);
      end;
    end
    else
    begin
      SysDialogs.ShowMessage(sResult);
    end;
  end;

  // 顶班操作
  { if not jcdsResult.Active then
    exit;
    if jcdsResult.RecordCount = 0 then
    exit;
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    FrmChanageVehicleplan := TFrmChanageVehicleplan.Create(Self);
    try
    with FrmChanageVehicleplan do
    begin
    scheduleplanid := curid;
    NovaEdtDepartDate.Text := jcdsResult.FieldByName('departdate').AsString;
    NvEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
    nvedtcode.Text := jcdsResult.FieldByName('code').AsString;
    nvedtcode.id := jcdsResult.FieldByName('scheduleid').AsLargeInt;
    NvedtDeparttimeL.Text := jcdsResult.FieldByName('departtime').AsString;
    nvedtSeatnum.Text := jcdsResult.FieldByName('Seatnum').AsString;
    NovaHUnit.Text := jcdsResult.FieldByName('planunit').AsString;
    NovaHUnit.id := jcdsResult.FieldByName('planunitid').AsLargeInt;
    NovaHelpVehicleNo.id := jcdsResult.FieldByName('planvehicleid')
    .AsLargeInt;
    NovaHelpVehicleNo.Text := jcdsResult.FieldByName('planvehicle').AsString;
    nvedttickettype.Text := jcdsResult.FieldByName('planvehicletype')
    .AsString;
    nvhlpdriver.id := jcdsResult.FieldByName('plandriver1id').AsInteger;
    nvhlpdriver.Text := jcdsResult.FieldByName('plandriver1').AsString;
    nvhlpcopilot1.id := jcdsResult.FieldByName('plandriver2id').AsInteger;
    nvhlpcopilot1.Text := jcdsResult.FieldByName('plandriver2').AsString;
    nvhlpcopilot2.id := jcdsResult.FieldByName('plandriver3id').AsInteger;
    nvhlpcopilot2.Text := jcdsResult.FieldByName('plandriver3').AsString;
    nvhlpcopilot3.id := jcdsResult.FieldByName('plandriver4id').AsInteger;
    nvhlpcopilot3.Text := jcdsResult.FieldByName('plandriver4').AsString;
    nvhlpsteward.id := jcdsResult.FieldByName('plansteward1id').AsInteger;
    nvhlpsteward.Text := jcdsResult.FieldByName('plansteward1').AsString;
    if SysMainForm.showFormModal(FrmChanageVehicleplan, false) = mrok then
    begin
    tbtnFilterClick(Sender);
    jcdsResult.Locate('id', curid, []);
    end;
    end;
    finally
    FreeAndNil(FrmChanageVehicleplan);
    end;
    }
end;

procedure TFrmDispatchManage.ToolButton51Click(Sender: TObject);
begin
  inherited;
  if not checkBillno('BalanceBill') then
    exit;
  refreshBill;
  // departSch(Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'], true);
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (not jcdsResult.FieldByName('isreported').AsBoolean) then
  begin
    SysDialogs.Warning('该班次还未报到！');
    exit;
  end;
  if (not jcdsResult.FieldByName('islinework').AsBoolean) and
    (jcdsResult.FieldByName('isdeparted').AsBoolean) then
  begin
    SysDialogs.Warning('该班次已经发班！');
    exit;
  end;
  if not jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    { if (LabUnCheckeds.Caption <> '') and (StrToInt(LabUnCheckeds.Caption) > 0)
      then
      begin
      if not SysDialogs.Confirm('提示信息',
      '该班次还有' + LabUnCheckeds.Caption + '张未检车票，确认进行发班打印操作？') then
      begin
      exit;
      end;
      end
      else }
    if not SysDialogs.Confirm('提示信息', '确认进行发班打印操作？') then
    begin
      exit;
    end;
  end
  else if not SysDialogs.Confirm('提示信息', '确认进行发班打印操作？') then
  begin
    exit;
  end;
  departSchImpl(sysInfo.LoginUserInfo.curBillNo.Items['BalanceBill'], true,
    false);
end;

procedure TFrmDispatchManage.ToolButton52Click(Sender: TObject);
var
  curid: Int64;
begin
  inherited;

  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm(ToolButton52.Caption + '操作',
    '确认要' + ToolButton52.Caption + '该班次吗？') then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    //
    if jcdsResult.FieldByName('isemptyvehicle').AsBoolean then
    begin
      undodepartSchedulenoprint(curid) // 取消放空
    end
    else
      departSchedulenoprint(curid); // 放空
  end;
end;

procedure TFrmDispatchManage.ToolButton53Click(Sender: TObject);
begin
  inherited;
  FrmInitRoadBill := TFrmInitRoadBill.Create(self);
  try
    with FrmInitRoadBill do
    begin
      if (sysInfo.LoginUserInfo.curBillNo.ContainsKey(_roadbill)) and
        (sysInfo.LoginUserInfo.curBillNum.Items[_roadbill] > 0) then
      begin
        nvedtbillNo.Text := sysInfo.LoginUserInfo.curBillNo.Items[_roadbill];
        NovaEdtCount.Text := inttostr
          (sysInfo.LoginUserInfo.curBillNum.Items[_roadbill]);
        nvedtBillNoRepeat.Text := sysInfo.LoginUserInfo.curBillNo.Items
          [_roadbill];
        NovaEdtEndNo.Text := inttostr(StrToInt(nvedtbillNo.Text)
            + sysInfo.LoginUserInfo.curBillNum.Items[_roadbill] - 1);
      end
      else
      begin
        NovaEdtCount.Text := '0';
      end;
      if SysMainForm.showFormModal(FrmInitRoadBill, false) = mrok then
      begin
        if (sysInfo.LoginUserInfo.curBillNo.ContainsKey(_roadbill)) then
        begin
          sysInfo.LoginUserInfo.curBillNo.Items[_roadbill] := trim
            (nvedtbillNo.Text);
          sysInfo.LoginUserInfo.curBillNum.Items[_roadbill] := StrToInt
            (NovaEdtCount.Text);
        end
        ELSE
        begin
          sysInfo.LoginUserInfo.curBillNo.Add(_roadbill,
            trim(nvedtbillNo.Text));
          sysInfo.LoginUserInfo.curBillNum.Add(_roadbill,
            StrToInt(NovaEdtCount.Text));
        end;
      end;
    end;
  finally
    FreeAndNil(FrmInitRoadBill);
  end;
end;

procedure TFrmDispatchManage.TreeVRouteClick(Sender: TObject);
// var
// code: string;
begin
  inherited;
  { if PNodeInfo(TreeVRoute.Selected.Data).arealevel = 1 then // 选择省
    begin
    code := copy(PNodeInfo(TreeVRoute.Selected.Data).code, 1, 2);
    end
    else if PNodeInfo(TreeVRoute.Selected.Data).arealevel = 2 then
    begin
    code := copy(PNodeInfo(TreeVRoute.Selected.Data).code, 1, 4);
    end
    else
    code := PNodeInfo(TreeVRoute.Selected.Data).code;
    qryScheduleplan(code); }
end;

procedure TFrmDispatchManage.undodepartSchedulenoprint(curid: Int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jcsdundodepartScheduleNoPrint do
    begin
      Active := false;
      Params.ParamValues['vehiclereport.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Params.ParamValues['vehiclereport.scheduleplanid'] := curid;
      Params.ParamValues['vehiclereport.reportorgid'] :=
        sysInfo.LoginUserInfo.OrgID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('取消放空操作失败：' + E.Message);
    end;
  end;

end;

procedure TFrmDispatchManage.ZKFPEngX1Capture(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
var
  ID: Integer;
  isexist:boolean;
begin
    if (vehReport.p0030='0') then
     Exit;
    ID:= ATemplate[0];
    if ID = -1 then
    begin
         if sRegTemplate1='' then
         begin
           sRegTemplate:='';
           //employeeid1:=0;
           //image1.Picture.Graphic:=nil;
           //LabInfo.Caption:='系统中不存在该指纹信息！';
           mmoReportInfo.Lines.Insert(0, '系统中不存在该指纹信息！');
           //LabInfo.Font.Color:=clRed;
           //LabInfo.Refresh;
           //sleep(500);
           //LabInfo.Font.Color:=clblack;
           //LabInfo.Refresh;
           //sleep(500);
           //LabInfo.Caption:='请按指纹识别器……';
           mmoReportInfo.Lines.Insert(0, '请按指纹识别器……');
           //LabInfo.Font.Color:=clblue;
           //LabInfo.Refresh;
         end ;
         PlaySound('Pressagain.wav',0,snd_async);
    end
    else
    begin
       with self.jsonSpcQry do
       begin
         if Active and (recordcount>0) then
         begin
            isexist:=false;
            first;
            while not eof do
            begin
              if FieldByName('id').AsLargeInt = ID then
              begin
                with jcsdqryvehiclebydriverid do
                begin
                    Active:=False;
                    Params.ParamValues['driverid']:= ID;
                    vehicledriverid := ID;
                    active:=True;
                    if RecordCount > 0 then
                    begin
                      if jcsdqryvehiclebydriverid.FieldByName('vehicleid').AsInteger>0 then
                      begin
                        NovaHelpVehicleNo.Text :=jcsdqryvehiclebydriverid.FieldByName('vehicleno').AsString;
                        NovaHelpVehicleNo.Id:=jcsdqryvehiclebydriverid.FieldByName('vehicleid').AsInteger;
                        //keybd_event(VK_RETURN,0,0,0); //模拟按键，按下enter键
                        //keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //按上来
                      end;
                    end
                    else
                    begin
                      mmoReportInfo.Lines.Insert(0, '没找到该驾驶员对应的车辆信息！');
                    end;
                end;
                isexist:=true;
                exit;
              end;
              next;
            end;
            if not isexist then
            begin
              mmoReportInfo.Lines.Insert(0, '没有该指纹信息……');
            end;
         end;
       end;
    end;
end;

procedure TFrmDispatchManage.ZKFPEngX1Enroll(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
begin
  inherited;
  ShowMessage('aaaaaa');
end;

procedure TFrmDispatchManage.stopScheduleplan(curid: Int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jcdsStopScheduleplan do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamValues['departstationid'] := sysInfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('停班操作失败：' + E.Message);
    end;
  end;

end;

procedure TFrmDispatchManage.allowScheduleplan(curid: Int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jcdsallowScheduleplan do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamValues['departstationid'] := sysInfo.LoginUserInfo.StationID;
      Params.ParamByName('ip').Value := sysInfo.LocalHostAddress;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('恢复报停班次操作失败：' + E.Message);
    end;
  end;
end;



procedure TFrmDispatchManage.chkAutoReportClick(Sender: TObject);
var
  filepath, salehintname: String;
  hWndClose: HWND;
begin
  inherited;
  if chkAutoReport.Checked then
  begin
    filepath := ExtractFilePath(ParamStr(0)) + 'DispachScreen.exe';
    // 小显示屏幕软件是否打开
    salehintname := 'DispachScreen'; // min_Screen 是小显示屏幕软件打开的名字
    // 开始根据名字
    hWndClose := FindWindow(nil, PChar(salehintname)); // 根据窗口名查找要窗口句柄
    if hWndClose = 0 then // 查找不成功,表示没有打开
    begin
      try
        ShellExecute(handle, 'open', PChar(filepath), nil, nil, SW_SHOWNORMAL);
        SetForegroundWindow(GetTopParentHandle);
      except
      end;
    end;
  end;
end;

procedure TFrmDispatchManage.CreateTreeListRouteStationOwner(TV: TTreeView);
var
  i, j, k: integer;
  ChildNode, ParentNode: TTreeNode; // 孩子结点
  ChildNodeInfo: PNodeInfo; // 孩子结点信息
begin
  with jcdsQryRouteTree do
  begin
    Active := true;
    TV.Items.Clear;
    for j := 1 to RecordCount do
    begin
      New(ChildNodeInfo);
      ChildNodeInfo.pcode := FieldByName('pcode').AsString;
      ChildNodeInfo.arealevel := FieldByName('arealevel').AsInteger;
      ChildNodeInfo.name := FieldByName('name').AsString;
      ChildNodeInfo.code := FieldByName('code').AsString;

      if ChildNodeInfo.arealevel = 1 then // 省
      begin
        ParentNode := TV.Items.AddObject(nil, ChildNodeInfo.name,
          ChildNodeInfo); // 增加根节点（省）
        ParentNode.ImageIndex := 1;
        ParentNode.SelectedIndex := 1;
        ParentNode.OverlayIndex := 0;
      end
      else if ChildNodeInfo.arealevel = 2 then // 地市
      begin
        for i := 0 to TV.Items.Count - 1 do
        begin
          if (PNodeInfo(TV.Items.Item[i].Data).code = ChildNodeInfo.pcode) then
          begin
            ChildNode := TV.Items.AddChildObject(TV.Items.Item[i],
              ChildNodeInfo.name, ChildNodeInfo); // 地市
            ChildNode.ImageIndex := 1;
            ChildNode.SelectedIndex := 1;
            ChildNode.OverlayIndex := 0;
          end;
        end;
      end
      else if ChildNodeInfo.arealevel = 3 then // 线路
      begin
        for i := 0 to TV.Items.Count - 1 do
          for k := 0 to TV.Items.Item[i].Count - 1 do
          begin
            if (PNodeInfo(TV.Items.Item[i].Item[k].Data)
                .code = ChildNodeInfo.pcode) then
            begin
              ChildNode := TV.Items.AddChildObject(TV.Items.Item[i].Item[k],
                ChildNodeInfo.name, ChildNodeInfo); // 地市
              ChildNode.ImageIndex := 1;
              ChildNode.SelectedIndex := 1;
              ChildNode.OverlayIndex := 0;
            end;
          end;
      end;
      next;
    end;
    Active := false;
  end;
  TV.FullExpand;
end;

end.
