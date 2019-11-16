unit UFrmOvertimePlaninfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, ComCtrls, NovaHelp, NovaEdit, DBGridEhGrouping, GridsEh,
  DBGridEh, NvDbgridEh;

type
  TFrmOvertimePlaninfo = class(TSimpleEditForm)
    jcdsQryScheduleplan: TjsonClientDataSet;
    jcdsQryScheduleplanid: TLargeintField;
    jcdsQryScheduleplanorgname: TWideStringField;
    jcdsQryScheduleplanroutename: TWideStringField;
    jcdsQryScheduleplancode: TWideStringField;
    jcdsQryScheduleplandistricttype: TWideStringField;
    jcdsQryScheduleplandistricttypename: TWideStringField;
    jcdsQryScheduleplanendstationid: TLargeintField;
    jcdsQryScheduleplanendtime: TWideStringField;
    jcdsQryScheduleplanfixedreserveseatnum: TIntegerField;
    jcdsQryScheduleplanhighdistance: TIntegerField;
    jcdsQryScheduleplaniscanmixcheck: TBooleanField;
    jcdsQryScheduleplanislinework: TBooleanField;
    jcdsQryScheduleplanisoriginator: TBooleanField;
    jcdsQryScheduleplanisovertime: TBooleanField;
    jcdsQryScheduleplanisproprietary: TBooleanField;
    jcdsQryScheduleplanissaleafterreport: TBooleanField;
    jcdsQryScheduleplanissellable: TBooleanField;
    jcdsQryScheduleplanissellreturnticket: TBooleanField;
    jcdsQryScheduleplanorgid: TLargeintField;
    jcdsQryScheduleplanruntime: TFloatField;
    jcdsQryScheduleplanscheduleid: TLargeintField;
    jcdsQryScheduleplanscheduletype: TWideStringField;
    jcdsQryScheduleplanseatnum: TIntegerField;
    jcdsQryScheduleplansoldeatnum: TIntegerField;
    jcdsQryScheduleplanspacinginterval: TIntegerField;
    jcdsQryScheduleplanstartstationid: TLargeintField;
    jcdsQryScheduleplanstarttime: TWideStringField;
    jcdsQryScheduleplanunautocancelreserveseatnum: TIntegerField;
    jcdsQryScheduleplanworktype: TWideStringField;
    jcdsQryScheduleplanworktypename: TWideStringField;
    jcdsQryScheduleplanworkways: TWideStringField;
    jcdsQryScheduleplanworkwaysname: TWideStringField;
    jcdsQryScheduleplandepartstation: TWideStringField;
    jcdsQryScheduleplanreachstation: TWideStringField;
    jcdsQryScheduleplanbuspark: TWideStringField;
    jcdsQryScheduleplandeparttime: TWideStringField;
    jcdsQryScheduleplanisbegincheck: TBooleanField;
    jcdsQryScheduleplanisdeparted: TBooleanField;
    jcdsQryScheduleplanisreported: TBooleanField;
    jcdsQryScheduleplanstatus: TWideStringField;
    jcdsQryScheduleplanticketentrance: TWideStringField;
    jcdsQryScheduleplanautocancelreserveseatnum: TIntegerField;
    jcdsQryScheduleplanscheduletypename: TWideStringField;
    jcdsQryScheduleplanrouteid: TLargeintField;
    jcdsQryScheduleplanvehicleno: TWideStringField;
    jcdsQryScheduleplanbrandname: TWideStringField;
    jcdsQryScheduleplanbrandmodelid: TLargeintField;
    jcdsQryScheduleplandriver1: TWideStringField;
    jcdsQryScheduleplandriver2: TWideStringField;
    jcdsQryScheduleplandriver3: TWideStringField;
    jcdsQryScheduleplansteward1: TWideStringField;
    jcdsQryScheduleplanvehicletypename: TWideStringField;
    jcdsQryScheduleplanschedulestatus: TWideStringField;
    jcdsQryScheduleplandepartdate: TDateField;
    jcdsQryScheduleplancreatetime: TDateTimeField;
    GroupBox3: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    Splitter1: TSplitter;
    GroupBox1: TGroupBox;
    dbgrdhResult: TNvDbgridEh;
    dsResult: TDataSource;
    jcdsQryTicketprice: TjsonClientDataSet;
    jcdsQryTicketpricedepartstation: TWideStringField;
    jcdsQryTicketpricereachstation: TWideStringField;
    jcdsQryTicketpricefullprice: TFloatField;
    jcdsQryTicketpricehalfprice: TFloatField;
    jcdsQryTicketpriceissellable: TBooleanField;
    jcdsQryTicketpriceresidueseatnum: TIntegerField;
    jcdsQryTicketpriceseatnum: TIntegerField;
    jcdsQryTicketpriceseattype: TWideStringField;
    jcdsQryTicketpricesoldeatnum: TIntegerField;
    jcdsQryTicketpricestudentprice: TFloatField;
    jcdsQryTicketpricetoplimitprice: TFloatField;
    jcdsQryTicketpricelowerlimitprice: TFloatField;
    jcdsQryTicketpriceseattypename: TWideStringField;
    jcdsQryTicketpriceruntime: TFloatField;
    jcdsQryTicketpriceid: TLargeintField;
    jcdsQryTicketpriceunautocancelreserveseatnum: TIntegerField;
    jcdsQryTicketpricefixedreserveseatnum: TIntegerField;
    jcdsQryTicketpriceautocancelreserveseatnum: TIntegerField;
    jcdsQryTicketpricestationservicefee: TFloatField;
    jcdsQryTicketpricefueladditionfee: TFloatField;
    dsTicketprice: TDataSource;
    jcdsQrySeatType: TjsonClientDataSet;
    jcsdWorkType: TjsonClientDataSet;
    jcdsworkways: TjsonClientDataSet;
    jcdsDISTRICTTYPE: TjsonClientDataSet;
    jcdstype: TjsonClientDataSet;
    jcdsScheduleStatus: TjsonClientDataSet;
    jcdsQryScheduleplandistance: TIntegerField;
    jcdsQryTicketpricedistance: TLargeintField;
    jcdsQryTicketpricebalancedistance: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsQryScheduleplanAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    procedure qryTicketprice(scheduleplanid: int64);
  public
    { Public declarations }
    scheduleid: int64;
  end;

var
  FrmOvertimePlaninfo: TFrmOvertimePlaninfo;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmOvertimePlaninfo.FormCreate(Sender: TObject);
begin
  inherited;
  jcdsQrySeatType.Active := false;
  jcdsQrySeatType.Active := true;

  jcsdWorkType.Active := false;
  jcsdWorkType.Active := true;

  jcdsworkways.Active := false;
  jcdsworkways.Active := true;
  jcdsDISTRICTTYPE.Active := false;
  jcdsDISTRICTTYPE.Active := true;

  jcdstype.Active := false;
  jcdstype.Active := true;

  jcdsQrySeatType.Active := false;
  jcdsQrySeatType.Active := true;
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := true;
end;

procedure TFrmOvertimePlaninfo.FormShow(Sender: TObject);
begin
  inherited;
  bbtnClose.Left:=(pnlOperation.Width div 2)-(bbtnClose.Width div 2);
  jcdsQryScheduleplan.AfterScroll := nil;
  with jcdsQryScheduleplan do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_s!id'] := scheduleid;
    Params.ParamValues['filter_GED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', now);
    Params.ParamValues['filter_LED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', now + 20);
    Active := true;
    if RecordCount <= 0 then
    begin
      jcdsQryTicketprice.Close;
      jcdsQryTicketprice.Close;
    end
    else
    begin
      qryTicketprice(jcdsQryScheduleplan.FieldByName('id').AsLargeInt);
    end;
  end;
  jcdsQryScheduleplan.AfterScroll := jcdsQryScheduleplanAfterScroll;
end;

procedure TFrmOvertimePlaninfo.jcdsQryScheduleplanAfterScroll
  (DataSet: TDataSet);
begin
  inherited;
  qryTicketprice(jcdsQryScheduleplan.FieldByName('id').AsLargeInt);
end;

procedure TFrmOvertimePlaninfo.qryTicketprice(scheduleplanid: int64);
begin
  with jcdsQryTicketprice do
  begin
    Active := false;
    Params.ParamValues['scheduleplan.id'] := scheduleplanid;
    Active := true;
  end;
end;

end.
