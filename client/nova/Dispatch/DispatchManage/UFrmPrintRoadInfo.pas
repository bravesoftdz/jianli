unit UFrmPrintRoadInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ImgList;

type
  TFrmPrintRoadInfo = class(TSimpleEditForm)
    Label1: TLabel;
    lbl3: TLabel;
    NovaEdtDays: TNovaEdit;
    Label2: TLabel;
    MeRemark: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrintRoadInfo: TFrmPrintRoadInfo;

implementation
uses PubFn, Services,  UDMPublic;
{$R *.dfm}

procedure TFrmPrintRoadInfo.bbtnSaveClick(Sender: TObject);
begin
  inherited;
    if trim(NovaEdtDays.Text)='' then
  begin
    SysDialogs.ShowError('请输入有效天数');
    NovaEdtDays.SetFocus;
    exit;
  end;
  ModalResult := mrok;
end;

end.
