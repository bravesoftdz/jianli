unit UFrmchoosecheckticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, GridsEh,
  DBGridEh, NvDbgridEh, DB, DBClient, jsonClientDataSet;

type
  TFrmchoosecheckticket = class(TSimpleEditForm)
    dbgrdhResult: TNvDbgridEh;
    jcdsQryDetail: TjsonClientDataSet;
    jcdsqrymulticketnodetail: TjsonClientDataSet;
    dsResult: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    chooseticketno:string;
    ticketsellid,scheduleplanid1 :Int64;
    departdate1:String;
  //  ticketentrance:String;
   // departdate1:String;
  end;

var
  Frmchoosecheckticket: TFrmchoosecheckticket;

implementation
 uses UFrmCheckTicket;
{$R *.dfm}

procedure TFrmchoosecheckticket.bbtnSaveClick(Sender: TObject);
var ticketno:string;
//ticketsellid:String;
scheduleplanid1 :Int64;
result:Boolean;
departdate1:string;
begin
  inherited;
  ticketsellid:=jcdsqrymulticketnodetail.FieldByName('ticketsellid').AsInteger;
  scheduleplanid1:=  jcdsqrymulticketnodetail.FieldByName('scheduleplanid').AsInteger;
  ModalResult := mrok;
end;

procedure TFrmchoosecheckticket.FormKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
   bbtnSaveClick(Sender);
  end;
end;

procedure TFrmchoosecheckticket.FormShow(Sender: TObject);
begin
  inherited;

  with jcdsqrymulticketnodetail do
  begin
    Active:=False;
    Params.ParamValues['ticketno']:= chooseticketno;
    Params.ParamValues['departdate1']:= departdate1;
    Active:=True;
  end;
end;

end.
