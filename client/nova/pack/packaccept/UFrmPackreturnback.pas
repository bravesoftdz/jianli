unit UFrmPackreturnback;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Services,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet, ComCtrls, NovaHelp;

type
  TFrmPackreturnback = class(TSimpleEditForm)
    nvedtfee: TNovaEdit;
    Label1: TLabel;
    jcdsreturnbackResult: TjsonClientDataSet;
    jcdsreturnbackResultid: TLargeintField;
    jcdsreturnbackResultPACKTYPE: TWideStringField;
    jcdsreturnbackResultpacktypevalue: TWideStringField;
    jcdsreturnbackResultSENDSTATIONID: TLargeintField;
    jcdsreturnbackResultsendstationname: TWideStringField;
    jcdsreturnbackResultTOSTATIONID: TLargeintField;
    jcdsreturnbackResulttostationname: TWideStringField;
    jcdsreturnbackResultname: TWideStringField;
    jcdsreturnbackResultGOODTYPE: TWideStringField;
    jcdsreturnbackResultgoodtypevalue: TWideStringField;
    jcdsreturnbackResultSCHEDULEID: TLargeintField;
    jcdsreturnbackResultschedulename: TWideStringField;
    jcdsreturnbackResultunloadfee: TFloatField;
    jcdsreturnbackResultVEHICLEID: TLargeintField;
    jcdsreturnbackResultvehiclecode: TWideStringField;
    jcdsreturnbackResultdepartdate: TDateTimeField;
    jcdsreturnbackResultpackno: TWideStringField;
    jcdsreturnbackResultinvoiceno: TWideStringField;
    jcdsreturnbackResultSELLBY: TLargeintField;
    jcdsreturnbackResultsellbyname: TWideStringField;
    jcdsreturnbackResultpieces: TIntegerField;
    jcdsreturnbackResultweight: TFloatField;
    jcdsreturnbackResultvolume: TWideStringField;
    jcdsreturnbackResultPACKED: TWideStringField;
    jcdsreturnbackResultpackedvalue: TWideStringField;
    jcdsreturnbackResultshipprice: TFloatField;
    jcdsreturnbackResultpackfee: TFloatField;
    jcdsreturnbackResulthandfee: TFloatField;
    jcdsreturnbackResultcustodial: TFloatField;
    jcdsreturnbackResulttransitfee: TFloatField;
    jcdsreturnbackResultinsuredamount: TFloatField;
    jcdsreturnbackResultinsurancefee: TFloatField;
    jcdsreturnbackResultinsurance: TFloatField;
    jcdsreturnbackResultdeliveryfee: TFloatField;
    jcdsreturnbackResultotherfee: TFloatField;
    jcdsreturnbackResulttotalfee: TFloatField;
    jcdsreturnbackResultlocation: TWideStringField;
    jcdsreturnbackResultpackprice: TFloatField;
    jcdsreturnbackResultsender: TWideStringField;
    jcdsreturnbackResultsenderphone: TWideStringField;
    jcdsreturnbackResultsenderaddress: TWideStringField;
    jcdsreturnbackResultconsignee: TWideStringField;
    jcdsreturnbackResultconsigneephone: TWideStringField;
    jcdsreturnbackResultconsigneeaddress: TWideStringField;
    jcdsreturnbackResultCERTIFICATETYPE: TWideStringField;
    jcdsreturnbackResultcertificatetypevalue: TWideStringField;
    jcdsreturnbackResultcertificateno: TWideStringField;
    jcdsreturnbackResultSHIPTYPE: TWideStringField;
    jcdsreturnbackResultshiptypevalue: TWideStringField;
    jcdsreturnbackResultPAYMETHOD: TWideStringField;
    jcdsreturnbackResultpaymethodvalue: TWideStringField;
    jcdsreturnbackResultSTATUS: TWideStringField;
    jcdsreturnbackResultstatusvalue: TWideStringField;
    jcdsreturnbackResultvaluables: TBooleanField;
    jcdsreturnbackResultPACKTTURNOVERID: TLargeintField;
    jcdsreturnbackResultremak: TWideStringField;
    jcdsreturnbackResultORGID: TLargeintField;
    jcdsreturnbackResultcreatetime: TDateTimeField;
    jcdsreturnbackResultcreateby: TLargeintField;
    jcdsreturnbackResultupdatetime: TDateTimeField;
    jcdsreturnbackResultupdateby: TLargeintField;
    jcdsreturnbackResultupdatebyname: TWideStringField;
    jcdsreturnbackResultischoose: TBooleanField;
    jcdsreturnbackResultsignby: TLargeintField;
    jcdsreturnbackResultsignbyname: TWideStringField;
    jcdsreturnbackResultsigntime: TDateTimeField;
    jcdsreturnbackResultsingbillno: TWideStringField;
    Label17: TLabel;
    nvedtaccepter: TNovaEdit;
    Label6: TLabel;
    dtpdepartdate: TDateTimePicker;
    Label29: TLabel;
    nvedtpackno: TNovaEdit;
    Label2: TLabel;
    nvhelptostation: TNovaHelp;
    Label51: TLabel;
    nvedttotalfee: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    packid : Integer;
  end;

var
  FrmPackreturnback: TFrmPackreturnback;

implementation

{$R *.dfm}

procedure TFrmPackreturnback.bbtnSaveClick(Sender: TObject);
var result : String;
    log : String;
begin
  inherited;
  with jcdsreturnbackResult do
  begin

      Active := false;
      Params.ParamValues['preturnback.packid'] := packid;
      Params.ParamValues['preturnback.fee'] := nvedtfee.Text;
      try
        Active := true;
       except
      on E: Exception do
        SysDialogs.ShowMessage(E.tostring);
      end;
//      SysDialogs.showMessage(Params.ParamValues['msg']);
      if Params.ParamValues['flag'] < 0 then
      begin
       exit;
      end;
      result := '行包退票';
      log := result + '行包id:'+InttoStr(packid)+',手续费:'+nvedtfee.Text;
      SysLog.WriteLog('行包管理->行包受理', result, log);
      self.ModalResult := mrOk;


  end;
end;

end.
