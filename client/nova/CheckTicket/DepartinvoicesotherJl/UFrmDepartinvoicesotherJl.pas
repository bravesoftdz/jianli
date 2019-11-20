unit UFrmDepartinvoicesotherJl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls;

type
  TfrmDepartinvoicesotherJl = class(TSimpleCRUDForm)
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDepartinvoicesotherJl: TfrmDepartinvoicesotherJl;

implementation

{$R *.dfm}

procedure TfrmDepartinvoicesotherJl.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=false;
    Active:=True;
  end;
end;

end.
