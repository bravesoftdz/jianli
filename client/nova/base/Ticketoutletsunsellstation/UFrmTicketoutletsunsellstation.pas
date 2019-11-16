unit UFrmTicketoutletsunsellstation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmTicketstationEdit, NovaEdit, NovaHelp, NovaComboBox;

type
  TFrmTicketstation = class(TSimpleCRUDForm)
    jsonCDSDelTicketoutlet: TjsonClientDataSet;
    lblticketoutlet: TLabel;
    lblroutename: TLabel;
    lblschedule: TLabel;
    lblendstationname: TLabel;
    nvhlpticketoutlet: TNovaHelp;
    nvhlproutename: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlpendstation: TNovaHelp;
    lbltype: TLabel;
    nvcbbcbbtype: TNovaComboBox;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure nvcbbcbbtypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhlpscheduleIdChange(Sender: TObject);
    procedure nvhlproutenameIdChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketstation: TFrmTicketstation;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmTicketstation.FormCreate(Sender: TObject);
begin
  inherited;
  with nvcbbcbbtype do
  begin
    Active := False;
    Active := True;
  end;
  nvhlproutename.Visible := False;
  lblroutename.Visible := False;
  nvhlpschedule.Visible := False;
  lblschedule.Visible := False;
end;

procedure TFrmTicketstation.nvcbbcbbtypeChange(Sender: TObject);
begin
  inherited;
  if (nvcbbcbbtype.ItemIndex = 0) or (nvcbbcbbtype.ItemIndex =1) then
  begin
    nvhlproutename.Text := '';
    nvhlpschedule.Text := '';
    nvhlproutename.Visible := False;
    nvhlpschedule.Visible := False;
    lblschedule.Visible := False;
    lblroutename.Visible := False;
  end else if nvcbbcbbtype.ItemIndex = 2 then
  begin
    nvhlproutename.Text := '';
    nvhlpschedule.Text := '';
    nvhlproutename.Visible := True;
    nvhlpschedule.Visible := False;
    lblschedule.Visible := False;
    lblroutename.Visible := True;
    nvhlproutename.SetFocus;
  end else if nvcbbcbbtype.ItemIndex = 3 then
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

procedure TFrmTicketstation.nvhlproutenameIdChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(Sender);
end;

procedure TFrmTicketstation.nvhlpscheduleIdChange(Sender: TObject);
begin
  inherited;
   tbtnFilterClick(Sender);
end;

procedure TFrmTicketstation.tbtnDeleteClick(Sender: TObject);
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
    if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;
//  end;
//  if jcdsResult.FieldByName('type').AsString = '1' then
//  begin
//    if not SysDialogs.Confirm('信息提示', '确认要删除该线路下所有的站点记录吗!') then
//    exit;
//  end;
//  if jcdsResult.FieldByName('type').AsString = '2' then
//  begin
//    if not SysDialogs.Confirm('信息提示', '确认要删除该站点记录吗!') then
//    exit;
//  end;

  with jsonCDSDelTicketoutlet do
  try
    close;
    log := '删除售票点不可售站点：' + jcdsResult.FieldByName('ticketname').AsString
        +',类型：' + jcdsResult.FieldByName('value').AsString
        +',名称：' + jcdsResult.FieldByName('typename').AsString
        +',停靠点：' + jcdsResult.FieldByName('stationname').AsString;
    Params.ParamByName('ticketoutletsunsellstation.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('业务管理->售票点不可售站点控制','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('售票点不可售站点删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmTicketstation.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
    if nvhlpticketoutlet.Id>0 then
        jcdsResult.Params.ParamValues['filter_EQL_ti!id'] := nvhlpticketoutlet.Id
    else
        jcdsResult.Params.ParamValues['filter_EQL_ti!id'] := null;
//    if nvhlpschedule.Id>0 then
//    begin
//      jcdsResult.Params.ParamValues['filter_EQS_t!type'] := '2';
//      jcdsResult.Params.ParamValues['filter_EQL_t!typeid'] := nvhlpschedule.Id;
//    end
//    else
//    begin
//      if nvhlproutename.Id>0 then
//      begin
//        jcdsResult.Params.ParamValues['filter_EQS_t!type'] := '1';
//        jcdsResult.Params.ParamValues['filter_EQL_t!typeid'] := nvhlproutename.Id;
//      end
//      else
//      begin
//        jcdsResult.Params.ParamValues['filter_EQS_t!type'] := null;
//        jcdsResult.Params.ParamValues['filter_EQL_t!typeid'] := null;
//      end;
//    end;
    if nvcbbcbbtype.ItemIndex = 0 then
    begin
      Params.ParamValues['filter_EQS_t!type'] := '';
      Params.ParamValues['filter_EQL_t!typeid'] :='';
    end
    else if nvcbbcbbtype.ItemIndex = 1 then
    begin
      Params.ParamValues['filter_EQS_t!type'] := '0';
    end
    else if nvcbbcbbtype.ItemIndex = 2 then
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
    else if nvcbbcbbtype.ItemIndex = 3 then
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

    if nvhlpendstation.Id>0 then
      jcdsResult.Params.ParamValues['filter_EQL_st!id'] := nvhlpendstation.Id
    else
      jcdsResult.Params.ParamValues['filter_EQL_st!id'] := null;
    Active:= true;
  end;
end;

procedure TFrmTicketstation.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmTicketstationEdit do
  begin
    FrmTicketstationEdit := TFrmTicketstationEdit.Create(self);
    FrmTicketstationEdit.Caption := '添加售票点不可售站点控制信息';
    FrmTicketstationEdit.sign:=true;
    FrmTicketstationEdit.ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

end.
