unit UFrmStandardprice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox;

type
  TFrmStandardprice = class(TSimpleCRUDForm)
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
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    NvDbgridEhStandardPrice: TNvDbgridEh;
    jcdsworkways: TjsonClientDataSet;
    jcsdWorkType: TjsonClientDataSet;
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
    jcdsQryStandardprice: TjsonClientDataSet;
    jcdsResultCREATETIME: TDateTimeField;
    jcdsResultUPDATETIME: TDateTimeField;
    jcsdGenPrice: TjsonClientDataSet;

    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure NvDbgridEhStandardPriceCellClick(Column: TColumnEh);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
    procedure qryStandardprice(scheduleid: integer);
  public
    { Public declarations }
  end;

var
  FrmStandardprice: TFrmStandardprice;

implementation

uses PubFn, Services, UFrmStandardpriceItem, UDMPublic;
{$R *.dfm}

procedure TFrmStandardprice.FormShow(Sender: TObject);
begin
  inherited;
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
end;

procedure TFrmStandardprice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qryStandardprice(jcdsResult.FieldByName('id').AsInteger);
end;

procedure TFrmStandardprice.NvDbgridEhStandardPriceCellClick(Column: TColumnEh);
var
  curticketype, curcaption: String;
  isPriceItem: boolean;
begin
  inherited;
  if not jcdsQryStandardprice.Active then
    exit;
  if jcdsQryStandardprice.RecordCount <= 0 then
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
  end
  else if (Column.FieldName = 'lowerlimitprice') then
  begin
    curticketype := 'U';
    isPriceItem := true;
    curcaption := '下限票价组成项目明细';
  end ;

  if isPriceItem then
  begin
    FrmStandardpriceItem := TFrmStandardpriceItem.Create(self);
    with FrmStandardpriceItem do
    begin
      caption := curcaption;
      scheduleid := jcdsQryStandardprice.FieldByName('scheduleid').AsInteger;
      vehicletypeid := jcdsQryStandardprice.FieldByName('vehicletypeid')
        .AsInteger;
      departstationid := jcdsQryStandardprice.FieldByName('departstationid')
        .AsInteger;
      reachstationid := jcdsQryStandardprice.FieldByName('reachstationid')
        .AsInteger;
      tickettype := curticketype;
      ShowModal;
    end;
  end;
end;

procedure TFrmStandardprice.qryStandardprice(scheduleid: integer);
begin
  with jcdsQryStandardprice do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_s!id'] := scheduleid;
    Active := true;
  end;
end;

procedure TFrmStandardprice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
    jcdsResult.AfterScroll:=nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_LIKES_r!name'] := NHelpRoute.text;
    Params.ParamValues['filter_LIKES_s!code'] := trim
      (NEdtScheduleHelpCode.text);
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
    if RecordCount <= 0 then
    begin
      // jcdsScheduleStop.Close;
      // jcdsScheduleLong.Close;
    end;
  end;
    qryStandardprice(jcdsResult.FieldByName('id').AsInteger);
    jcdsResult.AfterScroll:=jcdsResultAfterScroll;
end;

procedure TFrmStandardprice.tbtnInsertClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  curid:int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount=0 then
    exit;
  curid:=jcdsResult.FieldByName('id').AsLargeInt;
  try
    with jcsdGenPrice do
    begin
      Active := false;
      Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['createby'] := SysInfo.LoginUserInfo.UserID;
      execute;
      nResult := Params.ParamValues['flag'];
      sResult := Params.ParamValues['msg'];
      if (nResult =1 ) then
      begin
        log := '生成票价：所属车站='+jcdsResult.FieldByName('orgname').AsString+
        ',所属线路='+jcdsResult.FieldByName('routename').AsString+',班次号='+
        jcdsResult.FieldByName('code').AsString+',发车时间='+
        jcdsResult.FieldByName('STARTTIME').AsString;
        SysLog.WriteLog('票价管理——>公式票价','生成票价',log);
        SysDialogs.ShowMessage(sResult);
        qryStandardprice(curid);
      end
      else
      begin
        SysDialogs.Warning(sResult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('生成公式票价失败：' + E.Message);
    end;
  end;

end;

end.
