unit UFrmInsurerEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, NovaHComboBox, ImgList, NovaComboBox;

type
  TFrmInsurerEdit = class(TSimpleEditForm)
    lblname: TLabel;
    lbladdress: TLabel;
    lbl4: TLabel;
    lblphone: TLabel;
    jsonCDSInsurerSave: TjsonClientDataSet;
    edtname: TNovaEdit;
    edtcontactperson: TNovaEdit;
    edtcontactphone: TNovaEdit;
    edtaddress: TMemo;
    lbl1: TLabel;
    lbldistricttype: TLabel;
    nvcbbinterfacetype: TNovaComboBox;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    nvedtbankcode: TNovaEdit;
    nvedtselladdress: TNovaEdit;
    nvedtreturnaddress: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby, orgid: LongWord;
    createtime: TDatetime;
    sign: Boolean;
    synccode : string;
  end;

var
  FrmInsurerEdit: TFrmInsurerEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInsurerEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if (trim(edtname.Text)='') then
  begin
    SysDialogs.Warning('请填写保险公司名称');
    edtname.SetFocus;
    exit;
  end;
  with jsonCDSInsurerSave do
  begin
    Close;
    Params.ParamByName('insurer.id').Value :=id ;
    Params.ParamByName('insurer.orgid').Value := orgid;
    Params.ParamByName('insurer.name').Value := edtname.Text;
    Params.ParamByName('insurer.createby').Value := createby;
    Params.ParamByName('insurer.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('insurer.address').Value := edtaddress.Text;
    Params.ParamByName('insurer.contactphone').Value := edtcontactphone.Text;
    Params.ParamByName('insurer.contactperson').Value := edtContactPerson.Text;
    if nvcbbinterfacetype.ItemIndex>=0 then
      Params.ParamByName('insurer.interfacetype').Value := nvcbbinterfacetype.GetSelectCode
    else
      Params.ParamByName('insurer.interfacetype').Value := null;
    Params.ParamByName('insurer.selladdress').Value := nvedtselladdress.Text;
    Params.ParamByName('insurer.returnaddress').Value := nvedtreturnaddress.Text;
    Params.ParamByName('insurer.bankcode').Value := nvedtbankcode.Text;
    //params.ParamByName('insurer.synccode').Value := synccode;
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
        SysLog.WriteErr('保险公司信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmInsurerEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbinterfacetype.Active:=true;
end;

end.
