unit UFrmInsuretypeticketprice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaHComboBox,UFrmInsuretypepriceEdt,
  Services;

type
  TfrmInsuretypeticketprice = class(TSimpleCRUDForm)
    lblorg: TLabel;
    Label1: TLabel;
    cbborgid: TNovaHComboBox;
    NHInsuranceType: TNovaHelp;
    jscdDelinsuretypeprice: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmInsuretypeticketprice: TfrmInsuretypeticketprice;

implementation

{$R *.dfm}

procedure TfrmInsuretypeticketprice.FormCreate(Sender: TObject);
begin
  inherited;
  cbborgid.Active := false;
  cbborgid.Active := True;
end;

procedure TfrmInsuretypeticketprice.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jscdDelinsuretypeprice do
  try
    close;
    Params.ParamByName('insuretypeticketprice.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保险类型票价相关删除失败：' + E.Message);
    end;
  end;

end;

procedure TfrmInsuretypeticketprice.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then exit;
  if jcdsResult.RecordCount=0 then exit;

  with FrmInsuretypepriceEdt do
  begin
    FrmInsuretypepriceEdt := TFrmInsuretypepriceEdt.Create(self);
    Caption := '修改保险类型票价相关信息';
    createby:=Sysinfo.LoginUserInfo.UserID;
    id:=jcdsResult.FieldByName('id').AsLargeInt;
    createby:=jcdsResult.FieldByName('createby').AsLargeInt;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
    NovaHInsuranceType.Text := jcdsResult.FieldByName('insuretypename').AsString;
    NovaHInsuranceType.id := jcdsResult.FieldByName('insuretypeid').AsLargeInt;
    NovaEdtFromDistance.Text := jcdsResult.FieldByName('fromprice').AsString;
    NovaEdtEndDistance.Text := jcdsResult.FieldByName('endprice').AsString;
    nvHcbborgid.Text := jcdsResult.FieldByName('orgname').AsString;
    nvHcbborgid.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsInteger);
    nvHcbborgid.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TfrmInsuretypeticketprice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
    jcdsResult.Params.ParamValues['filter_LIKES_s!name'] := Trim(NHInsuranceType.Text);
    jcdsResult.Params.ParamValues['filter_EQL_t!orgid'] := cbborgid.HelpFieldValue['id'];
    Active:= true;
  end;
end;

procedure TfrmInsuretypeticketprice.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmInsuretypepriceEdt do
  begin
    FrmInsuretypepriceEdt := TFrmInsuretypepriceEdt.Create(self);
    Caption := '添加保险类型票价相关信息';
    createby:=Sysinfo.LoginUserInfo.UserID;
//    orgid:= Sysinfo.LoginUserInfo.OrgID;
    ShowModal;
    id:=0;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
