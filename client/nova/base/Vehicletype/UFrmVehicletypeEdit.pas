unit UFrmVehicletypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, NovaComboBox, Buttons, ExtCtrls,
  DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmVehicletypeEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    jsonCDSVehSave: TjsonClientDataSet;
    cbbtype: TNovaComboBox;
    cbbgrade: TNovaComboBox;
    edtname: TNovaEdit;
    edtcode: TNovaEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    Label5: TLabel;
    edtration: TNovaEdit;
    edtcustom: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbtypeSelect(Sender: TObject);
    procedure cbbgradeSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag: boolean;
    id, createby, orgid, islocal : string;
    createtime: string;
    typeid, grade,synccode: string;
  end;

var
  FrmVehicletypeEdit: TFrmVehicletypeEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmVehicletypeEdit.bbtnSaveClick(Sender: TObject);
var
  nResult,parentid: integer;
  sResult: string;
begin
  if (Trim(cbbtype.Text) = '') then
  begin
    SysDialogs.Warning('请填写类型');
    cbbtype.SetFocus;
    exit;
  end;
  if (trim(edtname.Text)='') then
  begin
    SysDialogs.Warning('请填写车型名称');
    edtname.SetFocus;
    exit;
  end;
  if (Trim(cbbgrade.Text) = '') then
  begin
    SysDialogs.Warning('请填写级别');
    cbbgrade.SetFocus;
    exit;
  end;
  if (trim(edtCode.Text)='') then
  begin
    SysDialogs.Warning('请填写车型代码');
    edtCode.SetFocus;
    exit;
  end;
  if (trim(edtration.Text)='') then
  begin
    SysDialogs.Warning('请填写核定座位数');
    edtration.SetFocus;
    exit;
  end;

  with jsonCDSVehSave do
  begin
    Close;
    if cbbtype.ItemIndex >= 0 then
    begin
      typeid := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
    if cbbgrade.ItemIndex >= 0 then
    begin
      grade := TCommInfo(cbbgrade.Items.Objects[cbbgrade.ItemIndex]).Value;
    end;

    Params.ParamByName('vehicletype.id').Value := id;
    Params.ParamByName('vehicletype.name').Value := edtname.Text;
    Params.ParamByName('vehicletype.code').Value := edtCode.Text;
    Params.ParamByName('vehicletype.type').Value := typeid;
    Params.ParamByName('vehicletype.grade').Value := grade;
    Params.ParamByName('vehicletype.customname').Value := edtcustom.Text;

    Params.ParamByName('vehicletype.rationseatnum').Value := edtration.Text;
    Params.ParamByName('vehicletype.orgid').Value := orgid;
    Params.ParamByName('vehicletype.createby').Value := createby;
    Params.ParamByName('vehicletype.createtime').Value := createtime;
    Params.ParamByName('vehicletype.isactive').Value := true;
    Params.ParamByName('vehicletype.islocaldelete').Value := islocal;
    Params.ParamByName('vehicletype.synccode').Value := synccode;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
         edtname.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车型信息添加失败：' + E.Message);
      end;
    end;
  end;
end;


procedure TFrmVehicletypeEdit.cbbgradeSelect(Sender: TObject);
begin
  inherited;
  edtname.Text := cbbtype.Text + cbbgrade.Text;
  edtcustom.Text := cbbtype.Text + cbbgrade.Text;
end;

procedure TFrmVehicletypeEdit.cbbtypeSelect(Sender: TObject);
begin
  inherited;
  edtname.Text := cbbtype.Text + cbbgrade.Text;
  edtcustom.Text := cbbtype.Text + cbbgrade.Text;
end;

procedure TFrmVehicletypeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbgrade.Active:=false;
  cbbgrade.Active:=true;

  cbbtype.Active:= false;
  cbbtype.Active:= true;
end;

end.
