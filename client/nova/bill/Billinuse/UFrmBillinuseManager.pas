unit UFrmBillinuseManager;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh,Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHComboBox, NvPrnDbgeh, NvDbgridEh, NovaHelp,
  NovaCheckedComboBox;


type
  TFrmBillinuseManager = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    novahcbbstorage: TNovaHComboBox;
    novahcbbtype: TNovaHComboBox;
    lbl5: TLabel;
    nvhlprecipients: TNovaHelp;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    lbl3: TLabel;
    cbbstatus: TNovaComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBillinuseManager: TFrmBillinuseManager;

implementation
 uses    UFrmBillbackinuse   ;
{$R *.dfm}

procedure TFrmBillinuseManager.FormCreate(Sender: TObject);
begin
  inherited;
  novahcbbtype.Active:=false;
  novahcbbtype.Active:=true;
  novahcbbstorage.Active:=false;
  novahcbbstorage.Active:=true;
  cbborg.Active := False;
  cbborg.Active := True;
  cbbstatus.Active := False;
  cbbstatus.Active := True;
end;

procedure TFrmBillinuseManager.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (dsResult.DataSet.FieldByName('status').AsString='2')
    or (dsResult.DataSet.FieldByName('availablecount').AsLargeInt<=0) then
    begin
      SysDialogs.ShowMessage('票据已经用完');
      exit;
    end;


  with FrmBillbackinuse do
  begin
    FrmBillbackinuse := TFrmBillbackinuse.Create(self);
    Caption:= '票据退领';
    billinuseid :=  jcdsResult.FieldByName('id').AsLargeInt;
    edtbilltypename.Text:=jcdsResult.FieldByName('billtypename').AsString;
    billtypeid:=jcdsResult.FieldByName('billtypeid').AsLargeInt;
    availablestartno:= jcdsResult.FieldByName('nextno').AsLargeInt;
    availableenno:=jcdsResult.FieldByName('endno').AsLargeInt;
    edtstartnum.Text :=jcdsResult.FieldByName('nextno').AsString;
    edtendnum.Text :=jcdsResult.FieldByName('endno').AsString;
    edtstartno.Text := jcdsResult.FieldByName('nextno').AsString;
    edtstoragename.Text := jcdsResult.FieldByName('storagename').AsString;
    edtavailablecount.Text := jcdsResult.FieldByName('availablecount').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', billinuseid, []);
    end;
  end;
end;

procedure TFrmBillinuseManager.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if novahcbbstorage.ItemIndex>=0 then
      begin
        Params.ParamByName('filter_EQL_bs!id').Value :=novahcbbstorage.HelpFieldValue['id'];
      end
    else
    begin
      Params.ParamByName('filter_EQL_bs!id').Value :='';
    end;
    if novahcbbtype.ItemIndex>=0 then
    begin
       Params.ParamByName('filter_EQL_b!billtypeid').Value :=novahcbbtype.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamByName('filter_EQL_b!billtypeid').Value :='';
    end;
    if Trim(nvhlprecipients.Text) = '' then
    begin
      Params.ParamByName('filter_EQL_b!recipients').Value := '';
    end else
    begin
      Params.ParamByName('filter_EQL_b!recipients').Value := nvhlprecipients.Id;
    end;
    if cbborg.CheckedCount = 0 then
      Params.ParamByName('filter_INS_b!orgid').Value := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamByName('filter_INS_b!orgid').Value := cbborg.GetSelectID;
    if Trim(cbbstatus.Text) = '' then
      Params.ParamValues['filter_EQS_b!status'] := ''
    else
      Params.ParamValues['filter_EQS_b!status'] := cbbstatus.GetSelectCode;
    Active := true;
  end
end;

end.
