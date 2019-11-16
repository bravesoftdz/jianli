unit UFrmTicketLossAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaHelp, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB,
  DBClient, jsonClientDataSet,Services;

type
  TFrmTicketLossAdd = class(TSimpleEditForm)
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpstarttime: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    lbl8: TLabel;
    nvhlpArrStation: TNovaHelp;
    GroupBox1: TGroupBox;
    dbgrdhResult: TNvDbgridEh;
    filterBtn: TButton;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jcdsResultSearch: TjsonClientDataSet;
    dsResultAdd: TDataSource;
    NovaHelpSchedule: TNovaHelp;
    jcdsResultAdd: TjsonClientDataSet;
    jcdsResultAddid: TLargeintField;
    jcdsResultAddPACKTYPE: TWideStringField;
    jcdsResultAddpacktypevalue: TWideStringField;
    jcdsResultAddSENDSTATIONID: TLargeintField;
    jcdsResultAddsendstationname: TWideStringField;
    jcdsResultAddTOSTATIONID: TLargeintField;
    jcdsResultAddtostationname: TWideStringField;
    jcdsResultAddname: TWideStringField;
    jcdsResultAddGOODTYPE: TWideStringField;
    jcdsResultAddgoodtypevalue: TWideStringField;
    jcdsResultAddSCHEDULEID: TLargeintField;
    jcdsResultAddschedulename: TWideStringField;
    jcdsResultAddunloadfee: TFloatField;
    jcdsResultAddVEHICLEID: TLargeintField;
    jcdsResultAddvehiclecode: TWideStringField;
    jcdsResultAdddepartdate: TDateTimeField;
    jcdsResultAddpackno: TWideStringField;
    jcdsResultAddinvoiceno: TWideStringField;
    jcdsResultAddSELLBY: TLargeintField;
    jcdsResultAddsellbyname: TWideStringField;
    jcdsResultAddpieces: TIntegerField;
    jcdsResultAddweight: TFloatField;
    jcdsResultAddvolume: TWideStringField;
    jcdsResultAddPACKED: TWideStringField;
    jcdsResultAddpackedvalue: TWideStringField;
    jcdsResultAddshipprice: TFloatField;
    jcdsResultAddpackfee: TFloatField;
    jcdsResultAddhandfee: TFloatField;
    jcdsResultAddcustodial: TFloatField;
    jcdsResultAddtransitfee: TFloatField;
    jcdsResultAddinsuredamount: TFloatField;
    jcdsResultAddinsurancefee: TFloatField;
    jcdsResultAddinsurance: TFloatField;
    jcdsResultAdddeliveryfee: TFloatField;
    jcdsResultAddotherfee: TFloatField;
    jcdsResultAddtotalfee: TFloatField;
    jcdsResultAddlocation: TWideStringField;
    jcdsResultAddpackprice: TFloatField;
    jcdsResultAddsender: TWideStringField;
    jcdsResultAddsenderphone: TWideStringField;
    jcdsResultAddsenderaddress: TWideStringField;
    jcdsResultAddconsignee: TWideStringField;
    jcdsResultAddconsigneephone: TWideStringField;
    jcdsResultAddconsigneeaddress: TWideStringField;
    jcdsResultAddCERTIFICATETYPE: TWideStringField;
    jcdsResultAddcertificatetypevalue: TWideStringField;
    jcdsResultAddcertificateno: TWideStringField;
    jcdsResultAddSHIPTYPE: TWideStringField;
    jcdsResultAddshiptypevalue: TWideStringField;
    jcdsResultAddPAYMETHOD: TWideStringField;
    jcdsResultAddpaymethodvalue: TWideStringField;
    jcdsResultAddSTATUS: TWideStringField;
    jcdsResultAddstatusvalue: TWideStringField;
    jcdsResultAddvaluables: TBooleanField;
    jcdsResultAddPACKTTURNOVERID: TLargeintField;
    jcdsResultAddremak: TWideStringField;
    jcdsResultAddORGID: TLargeintField;
    jcdsResultAddcreatetime: TDateTimeField;
    jcdsResultAddcreateby: TLargeintField;
    jcdsResultAddupdatetime: TDateTimeField;
    jcdsResultAddupdateby: TLargeintField;
    jcdsResultAddupdatebyname: TWideStringField;
    jcdsResultAddischoose: TBooleanField;
    jcdsResultAddsignby: TLargeintField;
    jcdsResultAddsignbyname: TWideStringField;
    jcdsResultAddsigntime: TDateTimeField;
    jcdsResultAddsingbillno: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure filterBtnClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketLossAdd: TFrmTicketLossAdd;

implementation

{$R *.dfm}

procedure TFrmTicketLossAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not SysDialogs.Confirm('提示', '确定要挂失此车票吗？') then
    begin
      Exit;
    end;
  if (jcdsResultSearch.Active = true) and (jcdsResultSearch.RecNo > 0) then
  begin
     try
        with jcdsResultAdd do
        begin
          Active := false;
          Params.ParamValues['ts.id'] := jcdsResultSearch.FieldByName('id').AsString;
          try
               Active := true;
          except on E: exception do
               SysDialogs.ShowMessage(E.tostring());
          end;
          filterBtn.Click;
//          showMessage('ssss');
//          showMessage(Params.ParamValues['msg']);
//          if Params.ParamValues['msg'] <> '' then
//          begin
//            SysDialogs.ShowMessage(Params.ParamValues['msg']);
//          end;
//          if Params.ParamValues['flag'] = 1 then
//          begin
//            filterBtn.Click;
//          end;
        end;
     except on E: exception do
        begin
           SysDialogs.ShowMessage(E.tostring());
        end;
     end;
  end;
end;

procedure TFrmTicketLossAdd.filterBtnClick(Sender: TObject);
begin
  inherited;
  with jcdsResultSearch do
  begin
    try
    Active := false;
    Params.ParamValues['ts.scheduleid'] := NovaHelpSchedule.Id;
    Params.ParamValues['ts.departdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    if FormatDateTime('hh:mm', dtpstarttime.DateTime)<>'00:00' then
        Params.ParamValues['ts.departtime'] := FormatDateTime('hh:mm', dtpstarttime.DateTime)
    else
        Params.ParamValues['ts.departtime'] := null;
    Params.ParamValues['ts.reachstationid'] := nvhlpArrStation.Id;
    Active := true;
    except
      on E: exception do
        SysDialogs.ShowMessage(E.tostring());
    end;
  end;
end;

procedure TFrmTicketLossAdd.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := NOW;

end;

end.
