unit UFrmBalaceDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ExtCtrls, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  DB, DBClient, jsonClientDataSet;

type
  TfrmBalaceDetail = class(TForm)
    grp3: TGroupBox;
    nvdbgrdhResult: TNvDbgridEh;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    dsResult: TDataSource;
    jcdsResultdetial: TjsonClientDataSet;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultdepartstationname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultstatus: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    wdstrngfldResultunitname: TWideStringField;
    wdstrngfldResultvehicleno: TWideStringField;
    wdstrngfldResultvehicletypname: TWideStringField;
    lrgntfldResultticketnum: TLargeintField;
    fltfldResulttotalamount: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    wdstrngfldResultprintip: TWideStringField;
    wdstrngfldResultprintbyname: TWideStringField;
    dtmfldResultprinttime: TDateTimeField;
    lrgntfldResultsupplyticketnum: TLargeintField;
    fltfldResultsupplyamount: TFloatField;
    fltfldResultsupplybalanceamount: TFloatField;
    wdstrngfldResultd1name: TWideStringField;
    wdstrngfldResultd2name: TWideStringField;
    wdstrngfldResultd3name: TWideStringField;
    wdstrngfldResultd4name: TWideStringField;
    wdstrngfldResults1name: TWideStringField;
    wdstrngfldResults2name: TWideStringField;
    wdstrngfldResulttype: TWideStringField;
    wdstrngfldResultworktype: TWideStringField;
    wdstrngfldResultdepartinvoicesno: TWideStringField;
    lrgntfldResultseatnum: TLargeintField;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultothterfee: TFloatField;
    fltfldResultagentfee: TFloatField;
    fltfldResultbalanceamount: TFloatField;
    wdstrngfldResultbalanceunitname: TWideStringField;
    fltfldResultmoreprice: TFloatField;
    jcdsWorktkypename: TjsonClientDataSet;
    jcdstypename: TjsonClientDataSet;
    wdstrngfldResultdetialworktypename: TWideStringField;
    wdstrngfldResultdetialtypename: TWideStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBalaceDetail: TfrmBalaceDetail;

implementation

{$R *.dfm}

end.
