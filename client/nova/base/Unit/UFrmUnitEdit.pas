unit UFrmUnitEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, NovaComboBox,
  StdCtrls, NovaEdit, Buttons, ExtCtrls, NovaHComboBox, NovaHelp, ImgList;

type
  TFrmUnitEdit = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label10: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    edtfullname: TNovaEdit;
    jsonCDSVehSave: TjsonClientDataSet;
    lbl5: TLabel;
    edtjianpin: TNovaEdit;
    cbbdistrictid: TNovaHelp;
    cbbtype: TNovaComboBox;
    edtperson: TNovaEdit;
    edtphone: TNovaEdit;
    edtaccountno: TNovaEdit;
    nvhlpcard: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtnameExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag, isactive, islocaldelete: Boolean;
    id, orgid, createby: string;
    districtid : Integer;
    createtime: TDateTime;
  end;

var
  FrmUnitEdit: TFrmUnitEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmUnitEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if (trim(edtcode.Text)='') then
  begin
    SysDialogs.Warning('请填写车属单位编码');
    edtCode.SetFocus;
    exit;
  end;
  if (trim(edtname.Text)='') then
  begin
    SysDialogs.Warning('请填写车属单位名称');
    edtname.SetFocus;
    exit;
  end;
  if (trim(edtfullname.Text)='') then
  begin
    SysDialogs.Warning('请填写车属单位全称');
    edtCode.SetFocus;
    exit;
  end;
  if Trim(cbbdistrictid.Text) = '' then
  begin
    SysDialogs.Warning('请填写车属单位所属区域');
    cbbdistrictid.SetFocus;
    exit;
  end;
  if (cbbtype.ItemIndex < 0) then
  begin
    SysDialogs.Warning('请填写车属单位类型');
    cbbtype.SetFocus;
    exit;
  end;

  with jsonCDSVehSave do
  begin
    Close;
    if cbbdistrictid.Id > 0 then
    begin
      districtid := cbbdistrictid.Id;
    end;
    if districtid = 0 then
    begin
      SysDialogs.Warning('请填写车正确的所属区域');
      cbbdistrictid.SetFocus;
      exit;
    end;
    Params.ParamByName('unit.id').Value := id;
    Params.ParamByName('unit.orgid').Value := orgid;
    Params.ParamByName('unit.name').Value := edtname.Text;
    Params.ParamByName('unit.code').Value := edtcode.Text;
    Params.ParamByName('unit.isactive').Value := isactive;
    Params.ParamByName('unit.createby').Value := createby;
    Params.ParamByName('unit.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('unit.islocaldelete').Value := islocaldelete;

    Params.ParamByName('unit.jianpin').Value := edtjianpin.Text;
    Params.ParamByName('unit.type').Value := cbbtype.ItemIndex;
    Params.ParamByName('unit.fullname').Value := edtfullname.Text;
    Params.ParamByName('unit.contactphone').Value := edtphone.Text;
    Params.ParamByName('unit.accountno').Value := edtaccountno.Text;
    Params.ParamByName('unit.contactperson').Value := edtperson.Text;
    Params.ParamByName('unit.districtid').Value := districtid;
    Params.ParamByName('unit.cardno').Value := nvhlpcard.Text;
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
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车属单位添加失败：' + E.Message);
      end;
    end;
  end;
end;


procedure TFrmUnitEdit.edtnameExit(Sender: TObject);
begin
  inherited;
  if (trim(edtname.Text)<>'') and
    (edtjianpin.Text='') then
   edtjianpin.Text:=GetPyChar(trim(edtname.Text)) ;
end;

procedure TFrmUnitEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtype.Active:=false;
  cbbtype.Active:=true;
end;

end.
