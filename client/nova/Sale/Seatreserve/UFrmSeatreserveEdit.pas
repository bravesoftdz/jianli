unit UFrmSeatreserveEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaComboBox,
  NovaHComboBox, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmSeatreserveEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtorg: TNovaEdit;
    edtticketoutlets: TNovaEdit;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    edtdepartdate: TNovaEdit;
    edtdeparttime: TNovaEdit;
    edtreachstation: TNovaEdit;
    edtsellstatus: TNovaEdit;
    edtseatno: TNovaEdit;
    cbbtickettype: TNovaHComboBox;
    edtfull: TNovaEdit;
    jcdsResultSeatreserveSave: TjsonClientDataSet;
    jcdsResult: TjsonClientDataSet;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultticketoutletname: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    dtmfldResultdepartdate: TDateTimeField;
    wdstrngfldResultseatno: TWideStringField;
    wdstrngfldResulttickettypename: TWideStringField;
    wdstrngfldResultfullprice: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultserviceprice: TWideStringField;
    wdstrngfldResultstatusname: TWideStringField;
    wdstrngfldResultreservename: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultcertificatetypename: TWideStringField;
    wdstrngfldResultcertificateno: TWideStringField;
    wdstrngfldResultfamilyphone: TWideStringField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    dtmfldResultcreatetime: TDateTimeField;
    wdstrngfldResultupdatename: TWideStringField;
    dtmfldResultupdatetime: TDateTimeField;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultdeparttime: TWideStringField;
    dtmfldResultreservetime: TDateTimeField;
    wdstrngfldResultcertificatetype: TWideStringField;
    wdstrngfldResultstatus2: TWideStringField;
    lrgntfldResultcustomerid: TLargeintField;
    jcdsResultstatus: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id : string;
    sign : Boolean;
  end;

var
  FrmSeatreserveEdit: TFrmSeatreserveEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmSeatreserveEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: LongWord;
  sResult: string;
begin
  inherited;
  if cbbtickettype.Text = '' then
  begin
    SysDialogs.ShowMessage('«Î—°‘Ò∆±÷÷');
    cbbtickettype.SetFocus;
    Exit;
  end;

  with jcdsResultSeatreserveSave do
  begin
    Close;
    Params.ParamByName('seatreserve.id').Value := id;
    Params.ParamByName('seatreserve.tickettype').Value := cbbtickettype.HelpFieldValue['code'];
    Params.ParamByName('seatreserve.fullprice').Value := edtfull.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbtickettype.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('∂©∆±¡ÙŒª €≥ˆ ß∞‹£∫' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSeatreserveEdit.FormShow(Sender: TObject);
begin
  inherited;
  cbbtickettype.Active := False;
  cbbtickettype.Active := True;
end;

end.
