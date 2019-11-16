unit UFrmHandHolidayPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  NovaHComboBox,ComObj,Excel2000;

type
  TFrmHandHolidayPrice = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    Splitter1: TSplitter;
    jcsdWorkType: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;
    Label1: TLabel;
    Label8: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Chkisoriginator: TCheckBox;
    Chkislinework: TCheckBox;
    Chkissellreturnticket: TCheckBox;
    CobDISTRICTTYPE: TNovaComboBox;
    CobWORKWAYS: TNovaComboBox;
    NcbbScheduleType: TNovaComboBox;
    NHelpRoute: TNovaHelp;
    NovaCkbOrg: TNovaCheckedComboBox;
    NEdtScheduleHelpCode: TNovaEdit;
    NCbbWorkType: TNovaComboBox;
    ChkISPROPRIETARY: TCheckBox;
    Label3: TLabel;
    jcdsResultroutename: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultWORKTYPE: TWideStringField;
    jcdsResultWORKWAYS: TWideStringField;
    jcdsResultDISTRICTTYPE: TWideStringField;
    jcdsResultTYPE: TWideStringField;
    jcdsResultSTARTTIME: TWideStringField;
    jcdsResultRUNTIME: TFloatField;
    jcdsResultISPROPRIETARY: TBooleanField;
    jcdsResultISOVERTIME: TBooleanField;
    jcdsResultISSELLRETURNTICKET: TBooleanField;
    jcdsResultISLINEWORK: TBooleanField;
    jcdsResultISORIGINATOR: TBooleanField;
    jcdsResultISCANMIXCHECK: TBooleanField;
    jcdsResultPLANSEATNUM: TIntegerField;
    jcdsResultVIASTATION: TWideStringField;
    jcdsResultPRINTINFO: TWideStringField;
    jcdsResultREMARKS: TWideStringField;
    jcdsResultISAUDITED: TBooleanField;
    jcdsResultISAUDITPASS: TBooleanField;
    jcdsResultISACTIVE: TBooleanField;
    jcdsResultWORKTYPENAME: TWideStringField;
    jcdsResultWORKWAYSNAME: TWideStringField;
    jcdsResultDISTRICTTYPENAME: TWideStringField;
    jcdsResultTYPENAME: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultvehcilepark: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultORGID: TLargeintField;
    jcdsResultROUTEID: TLargeintField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultCREATEBY: TLargeintField;
    jcdsResultUPDATEBY: TLargeintField;
    jcdsResultusername: TWideStringField;
    jcdsqryhandholidayprice: TjsonClientDataSet;
    dshandholidayprice: TDataSource;
    jcdsQrySeatType: TjsonClientDataSet;
    jcdsqryhandholidaypriceid: TLargeintField;
    jcdsqryhandholidaypricecreateby: TLargeintField;
    jcdsqryhandholidaypricedepartstationid: TLargeintField;
    jcdsqryhandholidaypricefullprice: TFloatField;
    jcdsqryhandholidaypricehalfprice: TFloatField;
    jcdsqryhandholidaypriceholidayid: TLargeintField;
    jcdsqryhandholidaypricereachstationid: TLargeintField;
    jcdsqryhandholidaypricescheduleid: TLargeintField;
    jcdsqryhandholidaypriceseats: TWideStringField;
    jcdsqryhandholidaypriceseattype: TWideStringField;
    jcdsqryhandholidaypricestudentprice: TFloatField;
    jcdsqryhandholidaypriceupdateby: TLargeintField;
    jcdsqryhandholidaypricevehicletypeid: TLargeintField;
    jcdsqryhandholidaypricevehiclebrandmodelid: TLargeintField;
    jcdsqryhandholidaypricelowerlimitprice: TFloatField;
    jcdsqryhandholidaypricedepartstation: TWideStringField;
    jcdsqryhandholidaypricereachstation: TWideStringField;
    jcdsqryhandholidaypricevehicletype: TWideStringField;
    jcdsqryhandholidaypricetoplimitprice: TFloatField;
    jcdsqryhandholidaypricefullname: TWideStringField;
    jcdsqryhandholidaypriceseattypename: TWideStringField;
    jcsdDelHandholidayprice: TjsonClientDataSet;
    dpstartdate: TDateTimePicker;
    Label5: TLabel;
    Label10: TLabel;
    NovaHCbbHoliday: TNovaHComboBox;
    jcdsResultCREATETIME: TDateTimeField;
    jcdsResultUPDATETIME: TDateTimeField;
    jcdsqryhandholidaypricecreatetime: TDateTimeField;
    jcdsqryhandholidaypriceenddate: TDateField;
    jcdsqryhandholidaypricestartdate: TDateField;
    jcdsqryhandholidaypriceupdatetime: TDateTimeField;
    jcdsqryhandholidaypricemoreprice: TFloatField;
    jcdsResultISSALEAFTERREPORT: TBooleanField;
    ToolButton1: TToolButton;
    jcdsqryhandholidaypriceroutename: TWideStringField;
    jcdsqryhandholidaypriceschedulecode: TWideStringField;
    jcdsqryhandholidaypriceviastation: TWideStringField;
    jcdsqryhandholidaypriceplanseatnum: TWideStringField;
    jcdsimportprice: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure NvDbgridEh1CellClick(Column: TColumnEh);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    log : String;
        procedure qryHandholidayprice(scheduleid:integer);
  public
    { Public declarations }
        isusemoreprice:boolean;
  end;

var
  FrmHandHolidayPrice: TFrmHandHolidayPrice;

implementation
uses UFrmHandHolidayPriceEdt,UFrmHandHolidaypriceItem,PubFn, Services,UDMPublic;
{$R *.dfm}

procedure TFrmHandHolidayPrice.FormShow(Sender: TObject);
begin
  inherited;
  if getParametervalue('5001', Sysinfo.LoginUserInfo.OrgID)='1' then
     isusemoreprice:=true;
  if isusemoreprice then
      NvDbgridEh1.Columns[10].Visible:=true
  else
      NvDbgridEh1.Columns[10].Visible:=false;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  jcsdWorkType.Active := false;
  jcsdWorkType.Active := true;

  jcdsworkways.Active := false;
  jcdsworkways.Active := true;
  jcdsDISTRICTTYPE.Active := false;
  jcdsDISTRICTTYPE.Active := true;

  jcdstype.Active := false;
  jcdstype.Active := true;
  CobWORKWAYS.Active := false;
  CobWORKWAYS.Active := true;
  CobDISTRICTTYPE.Active := false;
  CobDISTRICTTYPE.Active := true;

  NcbbScheduleType.Active := false;
  NcbbScheduleType.Active := true;
  NCbbWorkType.Active := false;
  NCbbWorkType.Active := true;

  jcdsQrySeatType.Active := false;
  jcdsQrySeatType.Active := true;
  NovaHCbbHoliday.Active := false;
  NovaHCbbHoliday.Active := true;

end;

procedure TFrmHandHolidayPrice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;

  qryHandholidayprice(jcdsResult.FieldByName('id').AsLargeInt);
end;

procedure TFrmHandHolidayPrice.NHelpRouteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmHandHolidayPrice.NvDbgridEh1CellClick(Column: TColumnEh);
var
  curticketype, curcaption: String;
  isPriceItem: boolean;
begin
  inherited;
  if not jcdsqryhandholidayprice.Active then
    exit;
  if jcdsqryhandholidayprice.RecordCount <= 0 then
    exit;
  isPriceItem := false;
  if (Column.FieldName = 'fullprice') then
  begin
    curticketype := 'Q';
    isPriceItem := true;
    curcaption := '全票票价组成项目明细';
  end
  else if (Column.FieldName = 'halfprice') then
  begin
    curticketype := 'B';
    isPriceItem := true;
    curcaption := '半票票价组成项目明细';
  end
  else if (Column.FieldName = 'studentprice') then
  begin
    curticketype := 'X';
    isPriceItem := true;
    curcaption := '学生票票价组成项目明细';
  end
  else if (Column.FieldName = 'toplimitprice') then
  begin
    curticketype := 'S';
    isPriceItem := true;
    curcaption := '上限票价组成项目明细';
  end;
  if isPriceItem then
  begin
    FrmHandHolidaypriceItem := TFrmHandHolidaypriceItem.Create(self);
    with FrmHandHolidaypriceItem do
    begin
      caption := curcaption;
      handholidaypriceid := jcdsqryhandholidayprice.FieldByName('id').AsLargeInt;
      tickettype := curticketype;
      ShowModal;
    end;
  end;

end;

procedure TFrmHandHolidayPrice.qryHandholidayprice(scheduleid: integer);
begin
  with jcdsqryhandholidayprice do
  begin
    active:=false;
    Params.ParamValues['handholidayprice.scheduleid'] := scheduleid;
    if dpstartdate.Checked then
    begin
      Params.ParamValues['handholidayprice.startdate'] := formatdatetime('yyyy-mm-dd',dpstartdate.DateTime);
    end
    else
    begin
      Params.ParamValues['handholidayprice.startdate'] := null;
    end;
    if NovaHCbbHoliday.ItemIndex>=0 then
      Params.ParamValues['handholidayprice.holidayid'] := NovaHCbbHoliday.HelpFieldValue['id']
    else
      Params.ParamValues['handholidayprice.holidayid'] := null;

    active:=true;
  end;
end;

procedure TFrmHandHolidayPrice.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.CheckAll(true);
  NCbbWorkType.ItemIndex:=-1;
  NHelpRoute.Clear;
  NEdtScheduleHelpCode.Clear;
  ChkISPROPRIETARY.Checked:=false;
  Chkisoriginator.Checked:=false;
  Chkissellreturnticket.Checked:=false;
  Chkislinework.Checked:=false;
  CobWORKWAYS.ItemIndex:=-1;
  CobDISTRICTTYPE.ItemIndex:=-1;
  NcbbScheduleType.ItemIndex:=-1;
  CobWORKWAYS.ItemIndex:=-1;
  NovaHCbbHoliday.ItemIndex:=-1;
  dpstartdate.Checked:=false;
  tbtnFilterClick(sender);
end;

procedure TFrmHandHolidayPrice.tbtnDeleteClick(Sender: TObject);
var
  sResult,startdate,enddate: string;
  nResult,scheduleid:integer;
begin
  inherited;
  if not jcdsqryhandholidayprice.Active then
    exit;
  if jcdsqryhandholidayprice.RecordCount <= 0 then
    exit;
  scheduleid:=jcdsResult.FieldByName('id').AsInteger;
  startdate:=jcdsqryhandholidayprice.FieldByName('startdate').AsString;
  enddate:=jcdsqryhandholidayprice.FieldByName('enddate').AsString;
  if SysDialogs.Confirm('删除操作','确认要删除'+startdate+'至'+enddate+'节日票价吗？') then
  with jcsdDelHandholidayprice do
  begin
    Active := false;
    Params.ParamValues['handholidayprice.scheduleid'] := jcdsqryhandholidayprice.FieldByName('scheduleid').AsString;
    Params.ParamValues['handholidayprice.vehicletypeid'] := jcdsqryhandholidayprice.FieldByName('vehicletypeid').AsString;
    Params.ParamValues['handholidayprice.holidayid'] := jcdsqryhandholidayprice.FieldByName('holidayid').AsString;
    Params.ParamValues['handholidayprice.startdate'] := jcdsqryhandholidayprice.FieldByName('startdate').AsString;
    Params.ParamValues['handholidayprice.enddate'] := jcdsqryhandholidayprice.FieldByName('enddate').AsString;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
      log := '删除节日票价信息：所属机构='+jcdsResult.FieldByName('orgname').AsString+
      ',所属线路='+jcdsResult.FieldByName('routename').AsString+',班次='+
      jcdsResult.FieldByName('code').AsString+',发车时间'+jcdsResult.FieldByName('STARTTIME').AsString+
      '，节日名称='+jcdsqryhandholidayprice.FieldByName('fullname').AsString+',开始日期='+
      jcdsqryhandholidayprice.FieldByName('startdate').AsString+',结束日期='+
      jcdsqryhandholidayprice.FieldByName('enddate').AsString+',上车站='+
      jcdsqryhandholidayprice.FieldByName('departstation').AsString+',到达站='+
      jcdsqryhandholidayprice.FieldByName('reachstation').AsString;
      SysLog.WriteLog('票价管理->节日票价','删除',log);
      SysDialogs.ShowMessage(sResult);
      qryHandholidayprice(scheduleid);
    end
    else
    begin
      SysDialogs.Warning(sResult);
    end;
 end;

end;

procedure TFrmHandHolidayPrice.tbtnEditClick(Sender: TObject);
var
 curscheduleid,curid:int64;
begin
  inherited;
  if not jcdsqryhandholidayprice.Active then
    exit;
  if jcdsqryhandholidayprice.RecordCount <= 0 then
  begin
    SysDialogs.ShowMessage('该班次没有节日票价信息！');
    exit;
  end;
  FrmHandHolidayPriceEdt := TFrmHandHolidayPriceEdt.Create(self);
  with FrmHandHolidayPriceEdt do
  begin
    Caption := '修改节日票价信息';
    createby := SysInfo.LoginUserInfo.UserID;

    if isusemoreprice then
      FrmHandHolidayPriceEdt.NvDbgridEh1.Columns[7].Visible:=true
    else
      FrmHandHolidayPriceEdt.NvDbgridEh1.Columns[7].Visible:=false;
    NovaEdtRoute.Text:=jcdsResult.FieldByName('routename').AsString;
    NovaEdtRoute.Id:=jcdsResult.FieldByName('routeid').AsInteger;
    NovaEdtRoute.Enabled:=false;
    NovaEditSchedule.Text:=jcdsResult.FieldByName('code').AsString;
    NovaEditSchedule.Id:=jcdsResult.FieldByName('id').AsInteger;
    NovaEditSchedule.Enabled:=false;
    curscheduleid:=jcdsResult.FieldByName('id').AsLargeInt;
    curid:=jcdsqryhandholidayprice.FieldByName('id').AsLargeInt;
    //NovaHcbbHoliday.Items.Count
    NovaHcbbHoliday.SetItemIndexByField('id',jcdsqryhandholidayprice.FieldByName('holidayid').AsLargeInt);
    NovaHcbbHoliday.Enabled:=false;
    DateTpFromDate.Enabled:=false;
    //DateTpEndDate.Enabled:=false;
    edittype:=Tedittype.update;
    DateTpFromDate.Date:=jcdsqryhandholidayprice.FieldByName('startdate').AsDateTime;
    DateTpEndDate.Date:=jcdsqryhandholidayprice.FieldByName('enddate').AsDateTime;
    curVehileTypeid:=jcdsqryhandholidayprice.FieldByName('vehicletypeid').AsLargeInt;
    if SysMainForm.showFormModal(FrmHandHolidayPriceEdt) = mrok then
    begin
        qryHandholidayprice(curscheduleid);
        jcdsqryhandholidayprice.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmHandHolidayPrice.tbtnFilterClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;

  if (jcdsResult.Active) and (jcdsResult.RecordCount>0) then
  begin
    curid:=jcdsResult.FieldByName('id').AsLargeInt;
  end;
  jcdsResult.AfterScroll:=nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    if (NHelpRoute.Text<>'') and (NHelpRoute.Id>0) then
       Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.id
     else
    Params.ParamValues['filter_EQL_r!id'] := null;

    Params.ParamValues['filter_LIKES_s!code'] := UpperCase(trim(NEdtScheduleHelpCode.Text));
    if CobWORKWAYS.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!workways'] := inttostr
        (CobWORKWAYS.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!workways'] := '';
    if CobDISTRICTTYPE.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!districttype'] := inttostr
        (CobDISTRICTTYPE.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!districttype'] := '';
    if NCbbWorkType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!worktype'] := inttostr
        (NCbbWorkType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!worktype'] := '';
    if NcbbScheduleType.ItemIndex > 0 then
      Params.ParamValues['filter_EQS_s!type'] := inttostr
        (NcbbScheduleType.ItemIndex - 1)
    else
      Params.ParamValues['filter_EQS_s!type'] := '';
    if Chkislinework.Checked then
      Params.ParamValues['filter_EQB_s!islinework'] := true
    else
      Params.ParamValues['filter_EQB_s!islinework'] := null;
    if Chkisoriginator.Checked then
      Params.ParamValues['filter_EQB_s!isoriginator'] := true
    else
      Params.ParamValues['filter_EQB_s!isoriginator'] := null;
    if Chkissellreturnticket.Checked then
      Params.ParamValues['filter_EQB_s!issellreturnticket'] := true
    else
      Params.ParamValues['filter_EQB_s!issellreturnticket'] := null;
    if ChkISPROPRIETARY.Checked then
      Params.ParamValues['filter_EQB_s!isproprietary'] := true
    else
      Params.ParamValues['filter_EQB_s!isproprietary'] := null;
    Active := true;
    if recordcount<=0 then
    begin
       //jcdsScheduleStop.Close;
       //jcdsScheduleLong.Close;
    end
    else
    begin
      if curid>0 then
      begin
        jcdsResult.Locate('id',curid,[]);
      end;
      qryHandholidayprice(jcdsResult.FieldByName('id').AsLargeInt);
    end;
  end;
    jcdsResult.AfterScroll:=jcdsResultAfterScroll;
end;

procedure TFrmHandHolidayPrice.tbtnInsertClick(Sender: TObject);
var
 curscheduleid,curid:int64;
begin
  inherited;
  FrmHandHolidayPriceEdt := TFrmHandHolidayPriceEdt.Create(self);
  try
    with FrmHandHolidayPriceEdt do
    begin
      Caption := '添加节日票价信息';
      createby := SysInfo.LoginUserInfo.UserID;
      if isusemoreprice then
        FrmHandHolidayPriceEdt.NvDbgridEh1.Columns[7].Visible:=true
      else
        FrmHandHolidayPriceEdt.NvDbgridEh1.Columns[7].Visible:=false;
      NovaEdtRoute.Text:=jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id:=jcdsResult.FieldByName('routeid').AsLargeInt;
      NovaEdtRoute.Enabled:=false;
      NovaEditSchedule.Text:=jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id:=jcdsResult.FieldByName('id').AsLargeInt;
      NovaEditSchedule.Enabled:=false;
      curscheduleid:=jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmHandHolidayPriceEdt,false) = mrok then
      begin
       // curid:=id;
        qryHandholidayprice(curscheduleid);
       // jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmHandHolidayPriceEdt);
  end;

end;

procedure TFrmHandHolidayPrice.ToolButton1Click(Sender: TObject);
var
  nResult:Integer;
  sResult,titlename: string;
  SaveDialog1: TSaveDialog;
  var h,k:integer;
  Excelid: Variant;
  s: string;
  Sheet: Variant;
  Msg: String;
  FileName: String;
begin
  inherited;
  with jcdsimportprice do
  begin
    jcdsimportprice.Active:=False;
    jcdsimportprice.Active:=True;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    if (nResult <= 0) then
    begin
       SysDialogs.ShowMessage(sResult);
    end
  end;
  k := jcdsimportprice.RecordCount;
  titlename :='节日票价'+FormatDateTime('YYMMDDHHmmSS', now);
  if not jcdsimportprice.Active then Exit;
    SaveDialog1 := TSaveDialog.Create(Nil);

    SaveDialog1.FileName := titlename; // + '_' + FormatDateTime('YYMMDDHHmmSS', now);

    SaveDialog1.Filter := 'Excel文件|*.xls';
    if SaveDialog1.Execute then
        FileName := SaveDialog1.FileName;
    SaveDialog1.Free;
    if FileName = '' then Exit;
    if FileExists(FileName+'.xlsx') or FileExists(FileName+'.xls')
                                    or FileExists(FileName) then
    begin
      Msg := '已存在文件（' + FileName + '），是否覆盖？';
      if Application.MessageBox(PChar(Msg), '提示',
        MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
      begin
        // 删除文件
        DeleteFile(pchar(FileName))
      end
      else
        Exit;
    end;


    Application.ProcessMessages;
    Screen.Cursor := crHourGlass;


    if not VarIsEmpty(Excelid) then
    begin
      Excelid.quit;
      VarClear(Excelid);
    end;
    // 通过ole创建Excel对象
    try
      Excelid := CreateOleObject('Excel.Application');
      Excelid.DisplayAlerts := false;
    except
      MessageDlg('创建Excel对象失败，请检查你的系统是否正确安装了Excel软件！', mtError, [mbOk], 0);
      Screen.Cursor := crDefault;
      Exit;
    end;

//    exportColumns:=DBGridEh.VisibleColumns;//DBGridEh.Columns;
    // 生成工作页
    try
      Excelid.workBooks.Add;
      Excelid.worksheets[1].range['A1:L1'].Merge(True);
      Excelid.WorkSheets[1].Cells[1,1].Value :='节日票价表' ;
      Excelid.worksheets[1].Range['a1:a1'].HorizontalAlignment := $FFFFEFF4;
      Excelid.worksheets[1].Range['a1:a1'].VerticalAlignment := $FFFFEFF4;
      Excelid.WorkSheets[1].Cells[2,1].Value := '节日名称';
      Excelid.WorkSheets[1].Cells[2,2].Value := '开始日期';
      Excelid.WorkSheets[1].Cells[2,3].Value := '结束日期';
      Excelid.WorkSheets[1].Cells[2,4].Value := '所属线路';
      Excelid.WorkSheets[1].Cells[2,5].Value := '班次号';
      Excelid.WorkSheets[1].Cells[2,6].Value := '发车时间';
      Excelid.WorkSheets[1].Cells[2,7].Value := '车型';
      Excelid.WorkSheets[1].Cells[2,8].Value := '计划座位数';
      Excelid.WorkSheets[1].Cells[2,9].Value := '到达站';
      Excelid.WorkSheets[1].Cells[2,10].Value := '全价';
      Excelid.WorkSheets[1].Cells[2,11].Value := '半价';
      Excelid.WorkSheets[1].Cells[2,12].Value := '途径站点';
      Excelid.worksheets[1].Range['A1:L1'].Font.Name := '宋体';
      Excelid.worksheets[1].Range['A1:L1'].Font.Size := 12;
      Excelid.worksheets[1].range['A1:L2'].font.bold:=true;
      Excelid.worksheets[1].Range['A2:L2'].Font.Size := 9;
      Excelid.worksheets[1].Range['A2:L2'].HorizontalAlignment := $FFFFEFF4;
      Excelid.worksheets[1].Range['A2:L2'].VerticalAlignment := $FFFFEFF4;
      h:=3;

      jcdsimportprice.First;
      while not jcdsimportprice.Eof do
      begin
        Excelid.WorkSheets[1].Cells[h,1].Value := jcdsimportprice.FieldByName('fullname').AsString;
        Excelid.WorkSheets[1].Cells[h,2].Value := jcdsimportprice.FieldByName('startdate').AsString;
        Excelid.WorkSheets[1].Cells[h,3].Value := jcdsimportprice.FieldByName('enddate').AsString;
        Excelid.WorkSheets[1].Cells[h,4].Value := jcdsimportprice.FieldByName('routename').AsString;
        Excelid.WorkSheets[1].Cells[h,5].Value := jcdsimportprice.FieldByName('code').AsString;
        Excelid.WorkSheets[1].Cells[h,6].Value := jcdsimportprice.FieldByName('starttime').AsString;
        Excelid.WorkSheets[1].Cells[h,7].Value := jcdsimportprice.FieldByName('typename').AsString;
        Excelid.WorkSheets[1].Cells[h,8].Value := jcdsimportprice.FieldByName('planseatnum').AsString;
        Excelid.WorkSheets[1].Cells[h,9].Value := jcdsimportprice.FieldByName('endstationname').AsString;
        Excelid.WorkSheets[1].Cells[h,10].Value := jcdsimportprice.FieldByName('fullprice').AsString;
        Excelid.WorkSheets[1].Cells[h,11].Value := jcdsimportprice.FieldByName('halfprice').AsString;
        Excelid.WorkSheets[1].Cells[h,12].Value := jcdsimportprice.FieldByName('viastation').AsString;
      Inc(h);
      jcdsimportprice.Next;
      end;

      s := 'A2:l'+ IntToStr(k+2);
      Excelid.worksheets[1].Range[s].Font.Name := '宋体';
      Excelid.worksheets[1].Range[s].Font.size := 9;
      Excelid.worksheets[1].Range[s].Borders.LineStyle := 1;

      Excelid.workBooks[1].saveas(FileName);
      Excelid.visible := True;
      Excelid := Unassigned;
//    Excelid.Quit;
    except
      Application.MessageBox('导入数据出错！请检查文件的格式是否正确！', '提示信息', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1+MB_APPLMODAL);
    end;
    Screen.Cursor := crDefault;
 
end;

end.
