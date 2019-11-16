unit UFrmOutstationcheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, UICcardRW, NovaHelp;

type
  TFrmOutstationcheck = class(TSimpleCRUDForm, IBaseCardfound)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    lbltype: TLabel;
    nvhelpcheckname: TNovaHelp;
    startdate: TDateTimePicker;
    nvhelpcardno: TNovaHelp;
    nvhelpunitname: TNovaHelp;
    curnvhelpvehicleno: TNovaHelp;
    cbborg: TNovaCheckedComboBox;
    cbbChecktype: TNovaCheckedComboBox;
    chkIsCheck: TCheckBox;
    jscdDelOutstaion: TjsonClientDataSet;
    jsonVehicleResult: TjsonClientDataSet;
    jsonVehicleResultid: TLargeintField;
    jsonVehicleResultunitname: TWideStringField;
    jsonVehicleResultvehicletypename: TWideStringField;
    wdstrngfldVehicleResultcardno: TWideStringField;
    wdstrngfldVehicleResultvehicleno: TWideStringField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhelpcardnoChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

  private
    { Private declarations }
    procedure iccardfound(icCard: TBaseCard);
  public
    { Public declarations }
  end;

var
  FrmOutstationcheck: TFrmOutstationcheck;

implementation

uses UFrmOutstationcheckEdt, Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmOutstationcheck.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,
    SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    SysInfo.curBillLength.Items['Unit']);
end;



procedure TFrmOutstationcheck.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmOutstationcheck.FormShow(Sender: TObject);
begin
  inherited;
  startdate.DateTime := now;
  cbborg.Active := false;
  cbborg.Active := true;
  cbbChecktype.Active := false;
  cbbChecktype.Active := true;
end;

procedure TFrmOutstationcheck.iccardfound(icCard: TBaseCard);
begin
  nvhelpcardno.SetFocus;
  if Integer(icCard.cardtype) <> 0 then
  begin
    ShowMessage('�ÿ����Ǳ��������������ڰ��죡');
  end
  else
    nvhelpcardno.Text := icCard.cardNo;
end;

procedure TFrmOutstationcheck.nvhelpcardnoChange(Sender: TObject);
var
  curid:int64;
begin
  inherited;
  // ���࿨��������ϣ���ʹ�ÿ��Ž��а��죬����ֻ����ѯ����
  if chkIsCheck.Checked then
  begin
    if length(nvhelpcardno.Text) = SysInfo.curBillLength.Items['Vehicle'] then
    begin
      with jsonVehicleResult do
      begin
        Active := false;
        Params.ParamByName('filter_EQS_v!cardno').Value := nvhelpcardno.Text;
        Active := true;
      end;
      if (jsonVehicleResult.Active) and (jsonVehicleResult.RecordCount = 0)
        then
      begin
        SysDialogs.Warning('�����ڸÿ��Ŷ�Ӧ�ĳ�����Ϣ��');
        Exit;
      end
      else
      begin
        with FrmOutstationcheckEdt do
        begin
          FrmOutstationcheckEdt := TFrmOutstationcheckEdt.Create(Self);
          Caption := '��ӻ�����Ϣ';
          DpDepartdate.date := now;
          nvhelpvehicleno.Id := jsonVehicleResult.FieldByName('id').AsInteger;
          nvhelpvehicleno.Text := jsonVehicleResult.FieldByName('vehicleno')
            .AsString;
          EdtSeats.Text:=jsonVehicleResult.FieldByName('seatnum').AsString;
          ShowModal;
          if ModalResult = mrok then
          begin
            curid := Id;
            tbtnFilterClick(Sender);
            jcdsResult.Locate('id', curid, []);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmOutstationcheck.tbtnDeleteClick(Sender: TObject);
var
  log, sResult: string;
  nResult: Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���û�����Ϣ��?') then
    Exit;
  with jscdDelOutstaion do
    try
      Close;
      Params.ParamByName('id').Value := jcdsResult.FieldByName('id').AsLargeInt;
      log := 'ɾ������������Ϣ������ʱ��' + jcdsResult.FieldByName('outtime')
        .AsString + ',������' + jcdsResult.FieldByName('code')
        .AsString + ',���ƺ�=' + jcdsResult.FieldByName('vehicleno')
        .AsString + ',������λ=' + jcdsResult.FieldByName('unitname')
        .AsString + ',��·=' + jcdsResult.FieldByName('routename')
        .AsString + ',����Ա=' + jcdsResult.FieldByName('checker')
        .AsString + ',���������=' + jcdsResult.FieldByName('carrypeople')
        .AsString + ',���鲹¼����=' + jcdsResult.FieldByName('fillpeople')
        .AsString;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        SysLog.WriteLog('ɾ������������Ϣ', 'ɾ��', log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('ɾ������������Ϣʧ�ܣ�' + E.Message);
      end;
    end;

end;

procedure TFrmOutstationcheck.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if curnvhelpvehicleno.Id > 0 then
    begin
      Params.ParamValues['filter_EQL_v!id'] := curnvhelpvehicleno.Id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!id'] := null;
    end;
    if nvhelpunitname.Id > 0 then
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhelpunitname.Id
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := null;
    end;
    if nvhelpcheckname.Id > 0 then
    begin
      Params.ParamValues['filter_EQL_uf!id'] := nvhelpcheckname.Id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_uf!id'] := null;
    end;
    if cbborg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_st!orgid'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_st!orgid'] := cbborg.GetSelectID;

    if Trim(cbbChecktype.Text) = '' then
      Params.ParamByName('filter_INS_v!type').Value := null
    else
      Params.ParamByName('filter_INS_v!type').Value := cbbChecktype.GetSelectID;
    if Trim(cbbChecktype.Text) <> '' then
      Params.ParamValues['filter_LIKES_v!cardno'] := Trim(nvhelpcardno.Text)
    else
      Params.ParamValues['filter_LIKES_v!cardno'] := null;

    Params.ParamValues['filter_GED_st!outtime'] := formatdatetime('yyyy-mm-dd',
      startdate.DateTime) + ' 00:00:00';
    Params.ParamValues['filter_LED_st!outtime'] := formatdatetime('yyyy-mm-dd',
      startdate.DateTime) + ' 23:59:59';
    Active := true;
  end;
end;

procedure TFrmOutstationcheck.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  try
  with FrmOutstationcheckEdt do
  begin
    FrmOutstationcheckEdt := TFrmOutstationcheckEdt.Create(Self);
    Caption := '��ӻ�����Ϣ';
    DpDepartdate.date := now;
    edt1.Text:= SysInfo.LoginUserInfo.UserName;
    edt1.SetEnabled(False);
//    edt1.DisEnableColor:=red;
    ShowModal;
    if ModalResult = mrok then
    begin
      curid := Id;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;
  finally
    FreeAndNil(FrmOutstationcheckEdt);
  end;
end;

end.
