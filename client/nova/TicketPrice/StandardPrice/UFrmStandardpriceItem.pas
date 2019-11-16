unit UFrmStandardpriceItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB, DBClient,
  jsonClientDataSet, StdCtrls, Buttons, ExtCtrls;

type
  TFrmStandardpriceItem = class(TForm)
    pnlEditBox: TPanel;
    Bevel1: TBevel;
    pnlOperation: TPanel;
    bbtnClose: TBitBtn;
    jscdqryStandardPriceItem: TjsonClientDataSet;
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleid,vehicletypeid,departstationid, reachstationid:integer;
    tickettype:string;
  end;

var
  FrmStandardpriceItem: TFrmStandardpriceItem;

implementation
uses PubFn, Services,UDMPublic;
{$R *.dfm}

procedure TFrmStandardpriceItem.FormShow(Sender: TObject);
begin
    with jscdqryStandardPriceItem do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_s!scheduleid'] := scheduleid;
    Params.ParamValues['filter_EQL_s!vehicletypeid'] := vehicletypeid;
    Params.ParamValues['filter_EQL_s!departstationid'] := departstationid;
    Params.ParamValues['filter_EQL_s!reachstationid'] := reachstationid;
    Params.ParamValues['filter_EQC_sd!tickettype'] := tickettype;
    Active := true;
  end;
end;

end.
