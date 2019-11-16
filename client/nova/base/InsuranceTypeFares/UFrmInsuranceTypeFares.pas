unit UFrmInsuranceTypeFares;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaHComboBox, NovaCheckedComboBox,
  UDMPublic,
  Services;

type
  TFrmInsuranceTypeFares = class(TSimpleCRUDForm)
    lblorg: TLabel;
    Label1: TLabel;
    NHInsuranceType: TNovaHelp;
    jscdDelinsuretypefares: TjsonClientDataSet;
    cbborgid: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsuranceTypeFares: TFrmInsuranceTypeFares;

implementation

uses UFrmInsuranceTypeFaresEdit;
{$R *.dfm}

procedure TFrmInsuranceTypeFares.FormCreate(Sender: TObject);
begin
  inherited;
  cbborgid.Active := True;
end;

procedure TFrmInsuranceTypeFares.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_LIKES_s!name'] := Trim(NHInsuranceType.Text);

    if cbborgid.Text <> '' then
    begin
      Params.ParamValues['filter_INS_o!id'] := cbborgid.HelpFieldValue['id'];

    end
    else
    begin
      Params.ParamValues['filter_INS_o!id'] := '';
    end;
    Active := True;

  end;

end;

procedure TFrmInsuranceTypeFares.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmInsuranceTypeFaresEdit do
  begin
    FrmInsuranceTypeFaresEdit := TFrmInsuranceTypeFaresEdit.Create(self);
    Caption := '添加保险类型票价信息';
    edittype := Tedittype.Add;
    // createby:=Sysinfo.LoginUserInfo.UserID;
    ShowModal;

    tbtnFilterClick(Sender);
    jcdsResult.Locate('id', FrmInsuranceTypeFaresEdit.id, []);
  end;

end;

procedure TFrmInsuranceTypeFares.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;
  with jscdDelinsuretypefares do
  begin
    close;

    Params.ParamByName('insurancetypefares.id').Value := jcdsResult.FieldByName
      ('id').AsLargeInt;
    Execute;

    if (Params.ParamByName('flag').Value = 1) then
    begin
      SysDialogs.ShowMessage(Params.ParamByName('msg').Value);
      tbtnFilterClick(Sender);
    end;
    // SysDialogs.ShowMessage('   111  '+Params.ParamByName('insuretypedistance.id').Value);
    // SysDialogs.ShowMessage('   222   '+Params.ParamByName('flag').Value);
  end;
end;

procedure TFrmInsuranceTypeFares.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  with FrmInsuranceTypeFaresEdit do
  begin
    FrmInsuranceTypeFaresEdit := TFrmInsuranceTypeFaresEdit.Create(self);
    Caption := '修改保险类型票价信息';
    edittype := Tedittype.update;
    id := jcdsResult.FieldByName('id').AsLargeInt;
    // SysDialogs.ShowMessage(inttostr(id));
    // createby := jcdsResult.FieldByName('createby').AsLargeInt;
    // createtime := jcdsResult.FieldByName('createtime').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    NovaHInsuranceType.Text := jcdsResult.FieldByName('insuretypename')
      .AsString;
    NovaHInsuranceType.id := jcdsResult.FieldByName('insuretypeid').AsLargeInt;
    NovaEdtFromFares.Text := jcdsResult.FieldByName('fromprice').AsString;
    NovaEdtEndFares.Text := jcdsResult.FieldByName('endprice').AsString;
    nvHcbborgid.Text := jcdsResult.FieldByName('orgname').AsString;
    nvHcbborgid.SetItemIndexByField('id',
      jcdsResult.FieldByName('orgid').AsInteger);
    ShowModal;
    tbtnFilterClick(Sender);
    jcdsResult.Locate('id', FrmInsuranceTypeFaresEdit.id, []);
  end;

end;

end.
