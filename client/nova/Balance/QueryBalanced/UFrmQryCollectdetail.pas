unit UFrmQryCollectdetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, jsonClientDataSet, StdCtrls,
  ExtCtrls, GridsEh, DBGridEh, NvDbgridEh,UDMPublic;

type
  TFrmQryCollectdetail = class(TForm)
    nvdbgrdhResultPrint: TNvDbgridEh;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    dsResult: TDataSource;
    jcdsResultdetail: TjsonClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryCollectdetail: TFrmQryCollectdetail;

implementation

{$R *.dfm}

end.
