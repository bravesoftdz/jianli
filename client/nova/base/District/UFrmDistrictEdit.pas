unit UFrmDistrictEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls, NovaEdit,
  Buttons, ExtCtrls, ImgList;

type
  TFrmDistrictEdit = class(TSimpleEditForm)
    lblcode: TLabel;
    lblname: TLabel;
    lblfullname: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    edtfullname: TNovaEdit;
    jsonCDSDisSave: TjsonClientDataSet;
    Label5: TLabel;
    edtjianpin: TNovaEdit;
    edtcountry: TNovaEdit;
    lbl1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtnameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby, orgid, synccode: string;
    createtime: TDateTime;
    flag, isactive, islocal: Boolean;
  end;

var
  FrmDistrictEdit: TFrmDistrictEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmDistrictEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if(length(edtcode.Text) <> 11) then
  begin
      SysDialogs.Warning('请填写十一位的区域编码。如：北京市 11000011000');
      edtcode.SetFocus;
      exit;
  end;
  if (trim(edtname.Text)='') then
  begin
    SysDialogs.Warning('请填写行政区域名称');
    edtname.SetFocus;
    exit;
  end;
  if (trim(edtCode.Text)='') then
  begin
    SysDialogs.Warning('请填写行政区域代码');
    edtCode.SetFocus;
    exit;
  end;
  if (trim(edtcountry.Text)='') then
  begin
    SysDialogs.Warning('请填写所属国家');
    edtCode.SetFocus;
    exit;
  end;
  if (trim(edtfullname.Text)='') then
  begin
    SysDialogs.Warning('请填全称');
    edtfullname.SetFocus;
    exit;
  end;
  with jsonCDSDisSave do
  begin
    Close;
    Params.ParamByName('district.id').Value := id ;
    Params.ParamByName('district.orgid').Value := orgid;
    Params.ParamByName('district.name').Value := edtname.Text;
    Params.ParamByName('district.code').Value := edtcode.Text;
    Params.ParamByName('district.createby').Value := createby;
    Params.ParamByName('district.isactive').Value := isactive;
    Params.ParamByName('district.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('district.islocaldelete').Value := islocal;
    Params.ParamByName('district.country').Value := edtcountry.Text;
    Params.ParamByName('district.fullname').Value := edtfullname.Text;
    Params.ParamByName('district.jianpin').Value := edtjianpin.Text;
    Params.ParamByName('district.synccode').Value := synccode;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtcode.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('行政区域信息添加失败：' + E.Message);
      end;
    end;
  end;
end;


procedure TFrmDistrictEdit.edtnameExit(Sender: TObject);
begin
  inherited;
  if (trim(edtname.Text)<>'') and
    (edtjianpin.Text='') then
   edtjianpin.Text:=GetPyChar(trim(edtname.Text)) ;
end;

end.
