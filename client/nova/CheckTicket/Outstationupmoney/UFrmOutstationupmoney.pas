unit UFrmOutstationupmoney;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls, Generics.Collections,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,NovaPrint,
  NovaCheckedComboBox, NvDbgridEh, NovaHComboBox, NvPrnDbgeh;

type
  TFrmOutstationupmoney = class(TSimpleCRUDForm)

    jcdsResultid: TLargeintField;
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    jcdsResultORGID: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultupdateby: TLargeintField;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    Label1: TLabel;
    jcdsdelete: TjsonClientDataSet;
    nvhlpseller: TNovaHelp;
    jcdsResultdepartmonth: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultagentfee: TFloatField;
    jcdsResultwaterfee: TFloatField;
    jcdsResultstopfee: TFloatField;
    jcdsResultviolationfee: TFloatField;
    jcdsResultotherfee1: TFloatField;
    jcdsResultotherfee2: TFloatField;
    jcdsResultbalancemoney: TFloatField;
    jcdsResultoperatorid: TLargeintField;
    jcdsResultoperatorname: TWideStringField;
    jcdsResultorgname: TWideStringField;
    lbl5: TLabel;
    nvhlpRoute: TNovaHelp;
    jcdsResultprice: TFloatField;
    jcdsResultdepartmonthdate: TDateTimeField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);

  private
    { Private declarations }
    id: Integer;
    log: string;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
  public
    { Public declarations }

  end;

var
  FrmOutstationupmoney: TFrmOutstationupmoney;

implementation

uses UFrmOutstationupmoneyAdd;
{$R *.dfm}

procedure TFrmOutstationupmoney.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmOutstationupmoney.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();

end;

procedure TFrmOutstationupmoney.FormShow(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := true;
end;

procedure TFrmOutstationupmoney.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    if not SysDialogs.Confirm('��ʾ', 'ȷ��Ҫɾ������Ϣ��') then
    begin
      exit;
    end;

    with jcdsdelete do
    begin

      Active := false;
      Params.ParamValues['outstationupmoney.id'] := jcdsResult.FieldByName('id')
        .AsString;
      Execute;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        with jcdsResult do
        begin

          log := 'ɾ����վ�ɿ������=' + FieldByName('orgname')
            .AsString + ',������=' + SysInfo.LoginUserInfo.UserName + ',�����·�=' +
            jcdsResult.FieldByName('departmonth')
            .AsString + ',��·=' + jcdsResult.FieldByName('routename')
            .AsString + ',��վ��Ʊ���=' + jcdsResult.FieldByName('price')
            .AsString + ',���˴����=' + jcdsResult.FieldByName('agentfee')
            .AsString + ',ˮ��=' + jcdsResult.FieldByName('waterfee')
            .AsString + ',ͣ����=' + jcdsResult.FieldByName('stopfee')
            .AsString + ',ΥԼ�Ѱ��=' + jcdsResult.FieldByName('violationfee')
            .AsString + ',��������1=' + jcdsResult.FieldByName('otherfee1')
            .AsString + ',��������2=' + jcdsResult.FieldByName('otherfee2')
            .AsString + ',���ɽ��=' + jcdsResult.FieldByName('balancemoney')
            .AsString;
          SysLog.WriteLog('�������->��վ�ɿ', 'ɾ��', log);
          tbtnFilter.Click;
        end;

      end;
    end;
    // jcdsResult.Delete;
    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫɾ���ļ�¼��');
  end;
end;

procedure TFrmOutstationupmoney.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin

    FrmOutstationupmoneyAdd := TFrmOutstationupmoneyAdd.Create(self,
      self.functionItem);
    try
      with FrmOutstationupmoneyAdd do
      begin
        Caption := '�޸���վ�ɿ';
        edittype := Tedittype.update;

        nvhlpRoute.Text := jcdsResult.FieldByName('routename').AsString;
        oldroutename := jcdsResult.FieldByName('routename').AsString;
        dtpstartdate.DateTime := jcdsResult.FieldByName('departmonthdate')
          .AsDateTime;

        nvedtprice.Text := jcdsResult.FieldByName('price').AsString;

        nvedtagentfee.Text := jcdsResult.FieldByName('agentfee').AsString;

        nvedtwaterfee.Text := jcdsResult.FieldByName('waterfee').AsString;

        nvedtstopfee.Text := jcdsResult.FieldByName('stopfee').AsString;

        nvedtotherfee1.Text := jcdsResult.FieldByName('otherfee1').AsString;

        nvedtotherfee2.Text := jcdsResult.FieldByName('otherfee2').AsString;

        nvedtviolationfee.Text := jcdsResult.FieldByName('violationfee')
          .AsString;

        nvedtbalancemoney.Text := jcdsResult.FieldByName('balancemoney')
          .AsString;

        outstationupmoneyid := jcdsResult.FieldByName('id').AsInteger;
        operatorid := jcdsResult.FieldByName('operatorid').AsInteger;
        operatername := jcdsResult.FieldByName('operatorname').AsString;
        createtime := self.jcdsResult.FieldByName('createtime').AsDateTime;
        createby := self.jcdsResult.FieldByName('createby').AsInteger;
        OrgID := self.jcdsResult.FieldByName('orgid').AsInteger;

      end;
      if SysMainForm.showFormModal(FrmOutstationupmoneyAdd, false) = mrok then
      begin
        id := FrmOutstationupmoneyAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id', inttostr(id), []);
      end;
    finally
      FreeAndNil(FrmOutstationupmoneyAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫ�޸ĵļ�¼��');
  end;
end;

procedure TFrmOutstationupmoney.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_org!id'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GES_t!departmonth'] := FormatDateTime('yyyymm',
      dtpstartdate.DateTime);
    Params.ParamValues['filter_LES_t!departmonth'] := FormatDateTime('yyyymm',
      dtpenddate.DateTime);

    if trim(nvhlpRoute.Text) <> '' then
      Params.ParamValues['filter_EQS_t!routename'] := nvhlpRoute.Text
    else
      Params.ParamValues['filter_EQS_t!routename'] := '';

    if nvhlpseller.id > 0 then
      Params.ParamValues['filter_EQL_t!operatorid'] := nvhlpseller.id
    else
      Params.ParamValues['filter_EQL_t!operatorid'] := '';

    Active := true;

  end;
end;

procedure TFrmOutstationupmoney.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;

  FrmOutstationupmoneyAdd := TFrmOutstationupmoneyAdd.Create(self,
    self.functionItem);

  try
    FrmOutstationupmoneyAdd.Caption := '�����վ�ɿ';
    FrmOutstationupmoneyAdd.edittype := Tedittype.add;
    if SysMainForm.showFormModal(FrmOutstationupmoneyAdd, false) = mrok then
    begin
      id := FrmOutstationupmoneyAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id', id, []);
    end;
  finally
    FreeAndNil(FrmOutstationupmoneyAdd);
  end;
end;

procedure TFrmOutstationupmoney.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.recordcount = 0 then
    exit;

  try

    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
      printValue.Clear;
    if not Assigned(billPrint) then
      billPrint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('վ��ɿ', 'վ��ɿ'));
    with jcdsResult do
    begin
      printValue.add('departmonth', FieldByName('departmonth').AsString);
      printValue.add('routename', FieldByName('routename').AsString);
      printValue.add('ticketprice', FieldByName('price').AsString);
      printValue.add('agentfee', FieldByName('agentfee').AsString);
      printValue.add('waterfee', FieldByName('waterfee').AsString);
      printValue.add('stopfee', FieldByName('stopfee').AsString);
      printValue.add('otherfee1', FieldByName('otherfee1').AsString);
      printValue.add('otherfee2', FieldByName('otherfee2').AsString);
      printValue.add('violationfee', FieldByName('violationfee').AsString);
      printValue.add('balancemoney', FieldByName('balancemoney').AsString);

      billPrint.SingleValue := printValue;
      billPrint.Print;
    end;
  except
    on E: exception do
    begin
      SysLog.WriteErr('��ӡ���ʵ�ʧ�ܣ�' + E.Message);
    end;
  end;

end;

end.
