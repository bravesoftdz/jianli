unit UFrmTicketoutletssellschedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls,UFrmTicketoutletssellscheduleEdit, NovaEdit, NovaHelp,
  NovaComboBox;

type
  TFrmTicketoutlet = class(TSimpleCRUDForm)
    lblticketoutlet: TLabel;
    lblroutename: TLabel;
    lblschedule: TLabel;
    nvhlpticketoutlet: TNovaHelp;
    nvhlproutename: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    jsonCDSDelTicketoutlet: TjsonClientDataSet;
    cbbtype: TNovaComboBox;
    lbltype: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure cbbtypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhlproutenameIdChange(Sender: TObject);
    procedure nvhlpscheduleIdChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketoutlet: TFrmTicketoutlet;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmTicketoutlet.cbbtypeChange(Sender: TObject);
begin
  inherited;
  if (cbbtype.ItemIndex = 0) or (cbbtype.ItemIndex =1) then
  begin
    nvhlproutename.Text := '';
    nvhlpschedule.Text := '';
    nvhlproutename.Visible := False;
    nvhlpschedule.Visible := False;
    lblschedule.Visible := False;
    lblroutename.Visible := False;
  end else if cbbtype.ItemIndex = 2 then
  begin
    nvhlproutename.Text := '';
    nvhlpschedule.Text := '';
    nvhlproutename.Visible := True;
    nvhlpschedule.Visible := False;
    lblschedule.Visible := False;
    lblroutename.Visible := True;
    nvhlproutename.SetFocus;
  end else if cbbtype.ItemIndex = 3 then
  begin
    nvhlproutename.Text := '';
    nvhlpschedule.Text := '';
    nvhlproutename.Visible := False;
    nvhlpschedule.Visible := True;
    lblschedule.Visible := True;
    lblroutename.Visible := False;
    nvhlpschedule.SetFocus;
  end;
end;

procedure TFrmTicketoutlet.FormCreate(Sender: TObject);
begin
  inherited;
  with cbbtype do
  begin
    Active := False;
    Active := True;
  end;
  nvhlproutename.Visible := False;
  nvhlpschedule.Visible := False;
  lblschedule.Visible := False;
  lblroutename.Visible := False;
end;

procedure TFrmTicketoutlet.nvhlproutenameIdChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(Sender);
end;

procedure TFrmTicketoutlet.nvhlpscheduleIdChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(Sender);
end;

procedure TFrmTicketoutlet.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
//  if jcdsResult.FieldByName('type').AsString = '0' then
//  begin
    if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��?') then
    exit;
//  end;
//  if jcdsResult.FieldByName('type').AsString = '1' then
//  begin
//    if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ������·�����еİ�μ�¼��!') then
//    exit;
//  end;
//  if jcdsResult.FieldByName('type').AsString = '2' then
//  begin
//    if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ð�μ�¼��!') then
//    exit;
//  end;

  with jsonCDSDelTicketoutlet do
  try
    close;
    log := 'ɾ����Ʊ����۰�Σ�'+jcdsResult.FieldByName('ticketname').AsString;
    Params.ParamByName('ticketoutletssellschedule.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    log := '[��Ʊ��]��'+jcdsResult.FieldByName('ticketname').AsString
          +',[����]:'+ jcdsResult.FieldByName('value').AsString
          +',[����]:'+ jcdsResult.FieldByName('typename').AsString
          +',[��Ч��]:'+ jcdsResult.FieldByName('startdate').AsString
          +' �� '+ jcdsResult.FieldByName('enddate').AsString;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('ҵ�����->��Ʊ����۰�ο���','ɾ�����۰��',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('��Ʊ����Ʊ����ɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmTicketoutlet.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
      if Trim(nvhlpticketoutlet.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_ti!id'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_ti!id'] := nvhlpticketoutlet.Id;
      end;
      if cbbtype.ItemIndex = 0 then
      begin
         Params.ParamValues['filter_EQS_t!type'] := '';
         Params.ParamValues['filter_EQL_t!typeid'] :='';
      end
      else if cbbtype.ItemIndex = 1 then
      begin
        Params.ParamValues['filter_EQS_t!type'] := '0';
      end
      else if cbbtype.ItemIndex = 2 then
      begin
        Params.ParamValues['filter_EQS_t!type'] := '1';
        if Trim(nvhlproutename.Text) = '' then
        begin
          Params.ParamValues['filter_EQL_t!typeid'] := '';
        end else
        begin
          Params.ParamValues['filter_EQL_t!typeid'] := nvhlproutename.Id;
        end;
      end
      else if cbbtype.ItemIndex = 3 then
      begin
        Params.ParamValues['filter_EQS_t!type'] := '2';
        if Trim(nvhlpschedule.Text) = '' then
        begin
          Params.ParamValues['filter_EQL_t!typeid'] := '';
        end else
        begin
          Params.ParamValues['filter_EQL_t!typeid'] := nvhlpschedule.Id;
        end;
      end;
    Active:= true;
  end;
end;

procedure TFrmTicketoutlet.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmTicketoutletssellscheduleEdit do
  begin
    FrmTicketoutletssellscheduleEdit := TFrmTicketoutletssellscheduleEdit.Create(self);
    Caption := '�����Ʊ����Ʊ������Ϣ';
    sign:=true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

end.
