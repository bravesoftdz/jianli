unit UFrmQryBalancedetailPrint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, jsonClientDataSet, StdCtrls,
  ExtCtrls, GridsEh, DBGridEh, NvDbgridEh;

type
  TFrmQryBanlancedetailPrint = class(TForm)
    nvdbgrdhResultPrint: TNvDbgridEh;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    dsResult: TDataSource;
    jcdsResultdetailPrint: TjsonClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryBanlancedetailPrint: TFrmQryBanlancedetailPrint;

implementation

{$R *.dfm}

end.
