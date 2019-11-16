unit UFrmInsuretypedetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet, ImgList;

type
  TFrmInsuretypedetail = class(TSimpleEditForm)
    nvhlpinsuretype: TNovaHelp;
    lblcode: TLabel;
    lblname: TLabel;
    lbl2: TLabel;
    lbl5: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    lblmaxinsureamount: TLabel;
    edtmaxinsureamount: TNovaEdit;
    lbl1: TLabel;
    lbldescription: TLabel;
    mmodescription: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    jcdsResultInsuretypeSave: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    insuretypeid, id : LongWord;
    createby, createtime : string;
    sign : Boolean;
  end;

var
  FrmInsuretypedetail: TFrmInsuretypedetail;

implementation

uses Services;
{$R *.dfm}

procedure TFrmInsuretypedetail.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  if Trim(edtname.Text)='' then
  begin
    SysDialogs.Warning('请填写保险类型！');
    edtname.SetFocus;
    exit;
  end;
  if (trim(edtcode.Text)='') then
  begin
    SysDialogs.Warning('请填写险种编码！');
    edtcode.SetFocus;
    exit;
  end;
  if (Trim(nvhlpinsuretype.Text) = '') then
  begin
    SysDialogs.Warning('请填写险种！');
    nvhlpinsuretype.SetFocus;
    exit;
  end;
  if (Trim(edtmaxinsureamount.Text) = '') then
  begin
    SysDialogs.Warning('请填写最大保额！');
    edtmaxinsureamount.SetFocus;
    exit;
  end;
  if StrToFloat(edtmaxinsureamount.Text) < 0 then
  begin
    SysDialogs.Warning('最大保额不能小于0！');
    edtmaxinsureamount.SetFocus;
    exit;
  end;
  with jcdsResultInsuretypeSave do
  begin
    Close;
    Params.ParamByName('insuretypedetail.id').Value := id ;
    Params.ParamByName('insuretypedetail.insuretype.id').Value := insuretypeid;
    Params.ParamByName('insuretypedetail.name').Value := edtname.Text;
    Params.ParamByName('insuretypedetail.createby').Value := createby;
    Params.ParamByName('insuretypedetail.createtime').Value := createtime;
    Params.ParamByName('insuretypedetail.code').Value := edtcode.Text;
    Params.ParamByName('insuretypedetail.insureamount').Value := edtmaxinsureamount.Text;
    Params.ParamByName('insuretypedetail.description').Value := mmodescription.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        if Pos('该险种的产品编码已经存在',sResult) >0 then
        begin
             edtcode.SetFocus;
        end
        else
        edtname.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保险明细信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

end.
