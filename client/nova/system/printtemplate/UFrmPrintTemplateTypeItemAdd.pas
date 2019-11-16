unit UFrmPrintTemplateTypeItemAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls,UDMPublic,Services,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet;

type
  TFrmPrintTemplateTypeItemAdd = class(TSimpleEditForm)
    lblitemname: TLabel;
    lblitemcode: TLabel;
    lblitemtype: TLabel;
    nvedtitemname: TNovaEdit;
    nvcbbitemtype: TNovaComboBox;
    nvedtitemcode: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    jcdsSavePrinttemplatetypeitem: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Int64;
  public
    { Public declarations }
    id,printtemplatetypeid,islist:String;
    property operationid:Int64 read Foperationid;
  end;

var
  FrmPrintTemplateTypeItemAdd: TFrmPrintTemplateTypeItemAdd;

implementation

{$R *.dfm}

procedure TFrmPrintTemplateTypeItemAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(nvedtitemname.Text)='' then
  begin
    SysDialogs.ShowError('名称不能为空！');
    nvedtitemname.SetFocus;
    exit;
  end;
  if trim(nvedtitemcode.Text)='' then
  begin
    SysDialogs.ShowError('编码不能为空！');
    nvedtitemcode.SetFocus;
    exit;
  end;
  if nvcbbitemtype.ItemIndex<0 then
  begin
    SysDialogs.ShowError('类型不能为空！');
    nvcbbitemtype.SetFocus;
    exit;
  end;

  with jcdsSavePrinttemplatetypeitem do
  begin
    Params.ParamValues['printtemplatetypeitem.itemname']:=trim(nvedtitemname.Text);
    Params.ParamValues['printtemplatetypeitem.itemcode']:=trim(nvedtitemcode.Text);
    Params.ParamValues['printtemplatetypeitem.islist']:=islist;
    Params.ParamValues['printtemplatetypeitem.itemtype']:=nvcbbitemtype.GetSelectCode;
    Params.ParamValues['printtemplatetypeitem.printtemplatetype.id']:=printtemplatetypeid;
    if edittype=Tedittype.update then
    begin
      Params.ParamValues['printtemplatetypeitem.id']:=id;
    end;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      Foperationid:=Params.ParamValues['operationid'];
      self.ModalResult:=mrok;
    end;
  end;
end;

procedure TFrmPrintTemplateTypeItemAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbitemtype.Active:=true;
end;

end.
