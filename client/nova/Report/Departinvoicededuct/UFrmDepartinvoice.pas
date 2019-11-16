unit UFrmDepartinvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls;

type
  TFrmDepartinvoice = class(TSimpleCRUDForm)
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDepartinvoice: TFrmDepartinvoice;

implementation

{$R *.dfm}

procedure TFrmDepartinvoice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;

    Active := True;
  end;

end;

end.
