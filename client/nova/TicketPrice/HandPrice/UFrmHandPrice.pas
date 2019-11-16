unit UFrmHandPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox;

type
  TFrmHandPrice = class(TSimpleCRUDForm)
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
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    NvDbgridEh1: TNvDbgridEh;
    jcsdWorkType: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;

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
    jcdsResultISSALEAFTERREPORT: TBooleanField;
    jcdsResultISCANMIXCHECK: TBooleanField;
    jcdsResultPLANSEATNUM: TIntegerField;
    jcdsResultVIASTATION: TWideStringField;
    jcdsResultPRINTINFO: TWideStringField;
    jcdsResultREMARKS: TWideStringField;
    jcdsResultISAUDITED: TBooleanField;
    jcdsResultISAUDITPASS: TBooleanField;
    jcdsResultISACTIVE: TBooleanField;
    jcdsResultusername: TWideStringField;
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
    jcsdQryHandPrice: TjsonClientDataSet;
    DsHandPrice: TDataSource;
    jcsdQryHandPricescheduleid: TLargeintField;
    jcsdQryHandPricedepartstation: TWideStringField;
    jcsdQryHandPricereachstation: TWideStringField;
    jcsdQryHandPricevehicletype: TWideStringField;
    jcsdQryHandPriceseattype: TWideStringField;
    jcsdQryHandPricefullprice: TFloatField;
    jcsdQryHandPricehalfprice: TFloatField;
    jcsdQryHandPricestudentprice: TFloatField;
    jcsdQryHandPricetoplimitprice: TFloatField;
    jcsdQryHandPricelowerlimitprice: TFloatField;
    jcdsQrySeatType: TjsonClientDataSet;
    jcsdQryHandPriceseattypename: TWideStringField;
    jcdsDelhandprice: TjsonClientDataSet;
    jcsdQryHandPricevehicletypeid: TLargeintField;
    jcdsResultCREATETIME: TDateTimeField;
    jcdsResultUPDATETIME: TDateTimeField;
    wdstrngfldQryHandPriceseats: TWideStringField;
    jcsdQryCheckSchedule: TjsonClientDataSet;
    wdstrngfldQryHandPricebrandname: TWideStringField;
    wdstrngfldQryHandPricemodelcode: TWideStringField;
    jcsdQryHandPricerationseatnum: TIntegerField;
    jcsdQryHandPriceid: TLargeintField;
    jcsdQryHandPricemoreprice: TFloatField;
    jscdCopyStartprice: TjsonClientDataSet;
    jcsdQryHandPricedepartstationid: TLargeintField;
    jcsdQryHandPricereachstationid: TLargeintField;
    jcsdQryHandPricedistance: TIntegerField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure NvDbgridEh1CellClick(Column: TColumnEh);
    procedure NHelpRouteKeyPress(Sender: TObject; var Key: Char);
    procedure tbtnCancelClick(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
  private
    { Private declarations }
   // log : String;
    procedure qryHandprice(scheduleid:integer);
  public
    { Public declarations }
    isusemoreprice:boolean;
  end;

var
  FrmHandPrice: TFrmHandPrice;

implementation
uses UFrmHandPriceEdt,PubFn, UFrmCopyHandprice,UFrmHandpriceItem,
UFrmDelHandPrice,Services,UDMPublic, UFrmAdjustHandPrice;
{$R *.dfm}

procedure TFrmHandPrice.FormShow(Sender: TObject);
var
  moreprice:string;
begin
  inherited;
  moreprice:=  getParametervalue('5001', Sysinfo.LoginUserInfo.OrgID);
  if moreprice='1' then
     isusemoreprice:=true;
  if isusemoreprice then
      NvDbgridEh1.Columns[8].Visible:=true
  else
      NvDbgridEh1.Columns[8].Visible:=false;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
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


end;

procedure TFrmHandPrice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryHandprice(jcdsResult.FieldByName('id').AsInteger);
end;

procedure TFrmHandPrice.NHelpRouteKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmHandPrice.NvDbgridEh1CellClick(Column: TColumnEh);
var
  curticketype, curcaption: String;
  isPriceItem: boolean;
begin
  inherited;
  if not jcsdQryHandPrice.Active then
    exit;
  if jcsdQryHandPrice.RecordCount <= 0 then
    exit;
  isPriceItem := false;
  if (Column.FieldName = 'fullprice') then
  begin
    curticketype := 'Q';
    isPriceItem := true;
    curcaption := '全票票价组成项目明细';
  end;
{  else if (Column.FieldName = 'halfprice') then
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
  end; }
  if isPriceItem then
  begin
    FrmHandpriceItem := TFrmHandpriceItem.Create(self);
    with FrmHandpriceItem do
    begin
      caption := curcaption;
      handpriceid := jcsdQryHandPrice.FieldByName('id').AsLargeInt;
      tickettype := curticketype;
      ShowModal;
    end;
  end;
end;

procedure TFrmHandPrice.qryHandprice(scheduleid: integer);
begin
  with jcsdQryHandPrice do
  begin
    active:=false;
    Params.ParamValues['scheduleid'] := scheduleid;
    active:=true;
  end;
end;

procedure TFrmHandPrice.tbtnCancelClick(Sender: TObject);
var
  sResult: string;
  nResult:integer;
begin
  inherited;
  with jscdCopyStartprice do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := jcsdQryHandPrice.FieldByName('scheduleid')
      .AsInteger;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
      qryHandprice(jcdsResult.FieldByName('id').AsInteger);
  end;
end;

procedure TFrmHandPrice.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult:integer;
  i:integer;
begin
    if not jcdsResult.Active then
    exit;
    if not jcsdQryHandPrice.Active then
    exit;
    FrmDelHandPrice := TFrmDelHandPrice.Create(Self);
    with FrmDelHandPrice do
    begin
      Caption := '删除硬调票价';
      scheduleid := jcsdQryHandPrice.FieldByName('scheduleid').AsInteger;
      NovaHelpSchedule.Id := scheduleid;
      vehicletypeid := jcsdQryHandPrice.FieldByName('vehicletypeid').AsInteger;
      NovaHelpSchedule.Text := jcdsResult.FieldByName('code').AsString;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
      routeid := jcdsResult.FieldByName('routeid').AsInteger;
      NovaHelpRoute.Id := routeid;
      orgid := jcdsResult.FieldByName('orgid').AsInteger;
      if NovaHelpSchedule.Text<>'' then
      begin
        with NovaListSchedule do
        begin
          for i := 0 to GetCount - 1 do
            begin

              if NovaHelpSchedule.Text = (NovaListSchedule.Items.Item[i].SubItems.Strings[0]) then
              begin
                NovaListSchedule.Items.Item[i].Checked:=True;
              end;
            end;
        end;
      end;
      if SysMainForm.showFormModal(FrmDelHandPrice) = mrok then
      begin
        //tbtnFilterClick(Sender);
        qryHandprice(jcdsResult.FieldByName('id').AsInteger)
      end;
    end;

//  if jcsdQryHandPrice.RecordCount <= 0 then
//    exit;
//  if SysDialogs.Confirm('删除操作','确认要删除该车型票价信息吗？') then
//  with jcdsDelhandprice do
//  begin
//    Active := false;
//    execute;
//    sResult := Params.ParamByName('msg').Value;
//    nResult := Params.ParamByName('flag').Value;
//    SysDialogs.ShowMessage(sResult);
//    if (nResult = 1) then
//      log := '删除节日票价信息：所属机构='+jcdsResult.FieldByName('orgname').AsString+
//      ',所属线路='+jcdsResult.FieldByName('routename').AsString+',班次='+
//      jcdsResult.FieldByName('code').AsString+',发车时间'+jcdsResult.FieldByName('STARTTIME').AsString+
//      ',上车站='+
//      jcsdQryHandPrice.FieldByName('departstation').AsString+',到达站='+
//      jcsdQryHandPrice.FieldByName('reachstation').AsString;
//      SysLog.WriteLog('票价管理->硬调票价','删除',log);
//      qryHandprice(jcdsResult.FieldByName('id').AsInteger);
//  end;
end;

procedure TFrmHandPrice.tbtnEditClick(Sender: TObject);
var
 curscheduleid:integer;
begin
  inherited;

  if not jcdsResult.Active then
  begin
    SysDialogs.Warning('请先进行查询！');
    exit;
  end;
  if jcdsResult.RecordCount<=0 then
    begin
      SysDialogs.Warning('该班次还没有排班信息！');
      Exit;
    end;

  with jcsdQryCheckSchedule do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('id').AsInteger;
    Active := true;
    if RecordCount=0 then
    begin
      SysDialogs.Warning('该班次还没有排班信息！');
      Exit;
    end;
  end;
  FrmHandPriceEdt := TFrmHandPriceEdt.Create(self);
  try
  with FrmHandPriceEdt do
    begin
      Caption := '设置票价信息';
      createby := SysInfo.LoginUserInfo.UserID;
      if isusemoreprice then
        FrmHandPriceEdt.NvDbgridEh1.Columns[8].Visible:=true
      else
        FrmHandPriceEdt.NvDbgridEh1.Columns[8].Visible:=false;
      NovaEdtRoute.Text:=jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id:=jcdsResult.FieldByName('routeid').AsInteger;
      NovaEditSchedule.Text:=jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id:=jcdsResult.FieldByName('id').AsInteger;
      curscheduleid:=jcdsResult.FieldByName('id').AsInteger;
      if ((jcsdQryHandPrice.Active) and (jcsdQryHandPrice.RecordCount>0)) then
      begin
          vehicletypeid:=jcsdQryHandPrice.fieldbyname('vehicletypeid').AsLargeInt;
      end;
      if SysMainForm.showFormModal(FrmHandPriceEdt,false) = mrok then
      begin
          qryHandprice(curscheduleid);
      end;
    end;
  finally
    FreeAndNil(FrmHandPriceEdt);
  end;
end;

procedure TFrmHandPrice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll:=nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    if NHelpRoute.Id>0 then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.id
    else
       Params.ParamValues['filter_EQL_r!id'] :=null;
    Params.ParamValues['filter_LIKES_s!code'] := trim
      (NEdtScheduleHelpCode.Text);
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
      qryHandprice(jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
  jcdsResult.AfterScroll:=jcdsResultAfterScroll;
end;

procedure TFrmHandPrice.tbtnSaveClick(Sender: TObject);
var
  curscheduleid:Int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount<=0 then
     exit;
  if (not jcsdQryHandPrice.Active)
       or (jcdsResult.RecordCount<=0)then
    exit;
  with jcsdQryCheckSchedule do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('id').AsInteger;
    Active := true;
    if RecordCount=0 then
    begin
      SysDialogs.Warning('该班次还没有排班信息！');
      Exit;
    end;
  end;
  FrmCopyHandprice := TFrmCopyHandprice.Create(self);
  try
  with FrmCopyHandprice do
    begin
      Caption := '同线路班次票价复制';
      createby := SysInfo.LoginUserInfo.UserID;
      NovaEdtRoute.Text:=jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id:=jcdsResult.FieldByName('routeid').AsInteger;
      NovaEditSchedule.Text:=jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id:=jcdsResult.FieldByName('id').AsInteger;
      NovaEdtTime.Text:=jcdsResult.FieldByName('STARTTIME').AsString;
      curscheduleid:=jcdsResult.FieldByName('id').AsInteger;
      routeid:=jcdsResult.FieldByName('routeid').AsLargeInt;
      if SysMainForm.showFormModal(FrmCopyHandprice,false) = mrok then
      begin
          qryHandprice(curscheduleid);
      end;
    end;
  finally
    FreeAndNil(FrmCopyHandprice);
  end;
end;

procedure TFrmHandPrice.ToolButton52Click(Sender: TObject);
var
  curschid:int64;
begin
  inherited;
  FrmAdjustHandPrice := TFrmAdjustHandPrice.Create(self);
  try
  with FrmAdjustHandPrice do
    begin
      Caption := '设置站点票价';
      if jcdsResult.Active and (jcdsResult.RecordCount>0) then
      begin
        curschid:=jcdsResult.FieldByName('id').AsInteger;
      end;
      if jcsdQryHandPrice.Active and (jcsdQryHandPrice.RecordCount>0) then
      begin
        NovaChOrgStation.CheckById(true,jcsdQryHandPrice.FieldByName('departstationid').AsLargeInt);
        NovaHStation.Id:= jcsdQryHandPrice.FieldByName('reachstationid').AsLargeInt;
        NovaHStation.text:= jcsdQryHandPrice.FieldByName('reachstation').AsString;
        NovaEdtFullprice.Text:=jcsdQryHandPrice.fieldbyname('fullprice').AsString;
        NovaEdtHalfprice.Text:=jcsdQryHandPrice.fieldbyname('halfprice').AsString;
        NovaEdtStudentprice.Text:=jcsdQryHandPrice.fieldbyname('studentprice').AsString;
        NovaEdtTopprice.Text:=jcsdQryHandPrice.fieldbyname('toplimitprice').AsString;
        NovaEdtMoreprice.Text:=jcsdQryHandPrice.fieldbyname('moreprice').AsString;
        station := NovaChOrgStation.Text;
        recher := NovaHStation.text;
        full :=  NovaEdtFullprice.Text;
        half := NovaEdtHalfprice.Text;
        student := NovaEdtStudentprice.Text;
        more := NovaEdtMoreprice.Text;
        topprice :=   NovaEdtTopprice.Text;
      end;
      if SysMainForm.showFormModal(FrmAdjustHandPrice,false) = mrok then
      begin
        qryHandprice(curschid);
      end;
    end;
  finally
    FreeAndNil(FrmAdjustHandPrice);
  end;
end;

end.
