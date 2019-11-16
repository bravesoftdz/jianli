unit UFrmPrintTemplateTypeAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit,UDMPublic, DB,
  DBClient, jsonClientDataSet,Services, ImgList;

type
  TFrmPrintTemplateTypeAdd = class(TSimpleEditForm)
    lblname: TLabel;
    nvedtname: TNovaEdit;
    jcdsSavePrinttemplatetype: TjsonClientDataSet;
    lbl1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Int64;
  public
    { Public declarations }
    id:String;
    property operationid:Int64 read Foperationid;
  end;

var
  FrmPrintTemplateTypeAdd: TFrmPrintTemplateTypeAdd;

implementation

{$R *.dfm}

procedure TFrmPrintTemplateTypeAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowError('名称不能为空！');
    nvedtname.SetFocus;
    exit;
  end;
  with jcdsSavePrinttemplatetype do
  begin
    Params.ParamValues['printtemplatetype.name']:=trim(nvedtname.Text);
    if edittype=Tedittype.update then
    begin
      Params.ParamValues['printtemplatetype.id']:=id;
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

end.
