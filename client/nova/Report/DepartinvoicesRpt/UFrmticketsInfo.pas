unit UFrmticketsInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, ExtCtrls, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  DB, DBClient, jsonClientDataSet;

type
  TfrmticketsInfo = class(TForm)
    grp3: TGroupBox;
    dsResult: TDataSource;
    jcdsTicketinfo: TjsonClientDataSet;
    wdstrngfldResultdpartname: TWideStringField;
    wdstrngfldResultreachname: TWideStringField;
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    wdstrngfldResultpaymethod: TWideStringField;
    wdstrngfldResultsellway: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    blnfldResultislinework: TBooleanField;
    intgrfldResultcarrychildnum: TIntegerField;
    lrgntfldResultdistance: TLargeintField;
    fltfldResultfullprice: TFloatField;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    fltfldResultticketprice: TFloatField;
    wdstrngfldResultticketentrance: TWideStringField;
    wdstrngfldResultbuspark: TWideStringField;
    wdstrngfldResultticketoutletname: TWideStringField;
    wdstrngfldResultsellip: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResulthticketoutlesname: TWideStringField;
    wdstrngfldResulthoutletsaddress: TWideStringField;
    wdstrngfldResultcheckedname: TWideStringField;
    wdstrngfldResultcheckstationname: TWideStringField;
    wdstrngfldResultdepartinvoicesbyname: TWideStringField;
    fltfldResultotherfee: TFloatField;
    jcdsTicketinfovehiclebrandmodelname: TWideStringField;
    dtmfldResultchecktime: TDateTimeField;
    wdstrngfldResulttickettypename: TWideStringField;
    jcdsTicketinfocomputefee: TFloatField;
    jcdsTicketinfocoolairfee: TFloatField;
    jcdsTicketinfoadditionfee: TFloatField;
    fltfldResultservicefee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultserviceprice: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultsubtotal: TFloatField;
    jcdsTicketinfomoreprice: TFloatField;
    jcdsTicketinfoselltime: TDateTimeField;
    wdstrngfldResultroutename: TWideStringField;
    blnfldResultisovertime: TBooleanField;
    wdstrngfldResultvehicletypename: TWideStringField;
    jcdsPaymethod: TjsonClientDataSet;
    jcdsSellway: TjsonClientDataSet;
    dbgrdhResult: TNvDbgridEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmticketsInfo: TfrmticketsInfo;

implementation

{$R *.dfm}

end.
