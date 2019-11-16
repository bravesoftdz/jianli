unit UFrmDptotherDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, StdCtrls, GridsEh, DBGridEh, NvDbgridEh, DB,
  DBClient, jsonClientDataSet;

type
  TFrmDptotherDetail = class(TForm)
    nvdbgrdhdbgrdh1: TNvDbgridEh;
    mmo: TMemo;
    jcdsQrydepartinvoicesotherdetail: TjsonClientDataSet;
    dsResult: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDptotherDetail: TFrmDptotherDetail;

implementation

{$R *.dfm}

procedure TFrmDptotherDetail.FormShow(Sender: TObject);
begin
  Self.Width := trunc(Screen.Width * 0.6);
  Self.Height := trunc(Screen.Height * 0.45)
end;

end.
