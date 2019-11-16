unit UFrmBilldamaged;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmBilldamagedEdit;

type
  TFrmBilldamaged = class(TSimpleCRUDForm)
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBilldamaged: TFrmBilldamaged;

implementation

{$R *.dfm}

procedure TFrmBilldamaged.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    Active := True;
  end;
end;

procedure TFrmBilldamaged.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmBilldamagedEdit do
  begin
    FrmBilldamagedEdit := TFrmBilldamagedEdit.Create(Self);
    Caption := '»µÆ±µÇ¼Ç';
    sign := true;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Self);
    end;
  end;
end;

end.
