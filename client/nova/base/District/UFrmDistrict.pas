unit UFrmDistrict;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  UFrmDistrictEdit, NvPrnDbgeh, NvDbgridEh, NovaEdit;

type
  TFrmDistrict = class(TSimpleCRUDForm)
    lblname: TLabel;
    lblcode: TLabel;
    edtname: TNovaEdit;
    edtcode: TNovaEdit;
    jsonCDSDisDel: TjsonClientDataSet;
    Label1: TLabel;
    edtjianpin: TNovaEdit;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDistrict: TFrmDistrict;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmDistrict.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key = vk_F1)  then
  begin
    tbtnInsertClick(Sender);
  end
  else if (Key = vk_F2) then
  begin
    tbtnEditClick(Sender);
  end else  if (Key = vk_F3) then
  begin
    tbtnDeleteClick(Sender);
  end ;

end;

procedure TFrmDistrict.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDisDel do
  try
    close;
    Params.ParamByName('district.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Params.ParamByName('district.orgid').Value := jcdsResult.FieldByName('orgid').AsInteger;
    Params.ParamByName('district.jianpin').Value := jcdsResult.FieldByName('jianpin').AsString;
    Params.ParamByName('district.name').Value := jcdsResult.FieldByName('name').AsString;
    Params.ParamByName('district.code').Value := jcdsResult.FieldByName('code').AsString;
    Params.ParamByName('district.createby').Value := jcdsResult.FieldByName('createby').AsInteger;
    Params.ParamByName('district.isactive').Value := jcdsResult.FieldByName('isactive').AsBoolean;
    Params.ParamByName('district.islocaldelete').Value := jcdsResult.FieldByName('islocaldelete').AsBoolean;
    Params.ParamByName('district.createtime').Value := jcdsResult.FieldByName('createtime').AsDateTime;
    Params.ParamByName('district.country').Value := jcdsResult.FieldByName('country').AsString;
    Params.ParamByName('district.fullname').Value := jcdsResult.FieldByName('fullname').AsString;

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
      SysLog.WriteErr('行政区域信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmDistrict.tbtnEditClick(Sender: TObject);
var
  id:integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with jcdsResult do
  begin
    try
    if SysInfo.LoginUserInfo.OrgID <> FieldByName('orgid').AsInteger then
    begin
      SysDialogs.ShowMessage('对不起，该记录的添加者和你不是同一机构，不能修改！');
      Locate('id',FieldByName('id').AsString,[] );
      if not (State in [dsEdit,dsInsert]) then
      begin
        Edit;
      end;
      Exit;
    end;
    finally

    end;
  end;


  with FrmDistrictEdit do
  begin
    FrmDistrictEdit := TFrmDistrictEdit.Create(self);
    Caption := '修改行政区域信息';
    flag :=false;
    id :=  jcdsResult.FieldByName('id').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsString;
    edtjianpin.Text := jcdsResult.FieldByName('jianpin').AsString;
    edtname.Text := jcdsResult.FieldByName('name').AsString;
    edtCode.Text := jcdsResult.FieldByName('code').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    isactive := jcdsResult.FieldByName('isactive').AsBoolean;
    islocal := jcdsResult.FieldByName('islocaldelete').AsBoolean;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    edtcountry.Text := jcdsResult.FieldByName('country').AsString;
    edtfullname.Text := jcdsResult.FieldByName('fullname').AsString;
    synccode := jcdsResult.FieldByName('synccode').AsString;
    edtfullname.Enabled := False;
    edtname.Enabled := False;
    edtcode.Enabled := False;
    edtcountry.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmDistrict.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if Trim(edtname.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_t!name').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_t!name').Value := edtname.Text;
    end;
    if Trim(edtcode.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_t!code').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_t!code').Value := edtcode.Text;
    end;
    if Trim(edtjianpin.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_t!jianpin').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_t!jianpin').Value := edtjianpin.Text;
    end;
    Active := true;
  end;
end;

procedure TFrmDistrict.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmDistrictEdit do
  begin
    FrmDistrictEdit := TFrmDistrictEdit.Create(self);
    Caption := '添加行政区域信息';
    flag:=true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
