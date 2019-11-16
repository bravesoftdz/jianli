unit UFrmDepEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaHComboBox, NovaHelp, ImgList;

type
  TFrmDepEdit = class(TSimpleEditForm)
    lbledtCode: TLabel;
    lbledtName: TLabel;
    lbledtContactPerson: TLabel;
    lbledtphone: TLabel;
    lblmmodescribe: TLabel;
    Label2: TLabel;
    jsonCDSDepSave: TjsonClientDataSet;
    lbl1: TLabel;
    Label1: TLabel;
    nvhlpsupervisorid: TNovaHelp;
    edtCode: TNovaEdit;
    edtName: TNovaEdit;
    edtContactPerson: TNovaEdit;
    edtphone: TNovaEdit;
    mmodescribe: TMemo;
    lbl2: TLabel;
    lbl3: TLabel;
    NovaEdtOrg: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    createby, createtime: string;
    supervisorid : Integer;
    flag: boolean;
    id, parentid:Int64;
  end;

var
  FrmDepEdit: TFrmDepEdit;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmDepEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if (trim(edtcode.Text)='') then
  begin
    SysDialogs.Warning('请填写部门编码');
    edtcode.SetFocus;
    exit;
  end;
  if (trim(edtname.Text)='') then
  begin
    SysDialogs.Warning('请填写部门名称');
    edtname.SetFocus;
    exit;
  end;
  with jsonCDSDepSave do
  begin
    Close;
    Params.ParamByName('department.parentid').Value := parentid;
    if nvhlpsupervisorid.Id > 0 then
    begin
      Params.ParamByName('department.supervisor.id').Value := nvhlpsupervisorid.Id;
    end;
    Params.ParamByName('department.id').Value :=id ;
    Params.ParamByName('department.code').Value := edtCode.Text;
    Params.ParamByName('department.name').Value := edtName.Text;
    Params.ParamByName('department.createby').Value := createby;
    Params.ParamByName('department.createtime').Value := createtime;
    Params.ParamByName('department.describe').Value := mmodescribe.Text;
    Params.ParamByName('department.contactphone').Value := edtPhone.Text;
    Params.ParamByName('department.contactperson').Value := edtContactPerson.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        if Pos('编码',sResult)>0 then
          edtCode.SetFocus
        else  if Pos('名称',sResult)>0 then
          edtname.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('部门信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

end.
