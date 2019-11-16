unit UFrmTicketdeliverEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet, ImgList;

type
  TFrmTicketdeliverEdit = class(TSimpleEditForm)
    lbl4: TLabel;
    lbl5: TLabel;
    jcdsResultTicketdeliverSave: TjsonClientDataSet;
    lbl1: TLabel;
    lbl10: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl2: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    nvhlpdeliverby: TNovaHelp;
    edtserviceprice: TNovaEdit;
    edtclientname: TNovaEdit;
    edtclientphone: TNovaEdit;
    edtarea: TNovaEdit;
    edtaddress: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sign : Boolean;
    id, orgid, createby, createtime, deliverdate, isturnover, turnoverid : string;
  end;

var
  FrmTicketdeliverEdit: TFrmTicketdeliverEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTicketdeliverEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: LongWord;
  sResult: string;
begin
  if (trim(edtarea.Text)='') then
  begin
    SysDialogs.Warning('«ÎÃÓ–¥ÀÕ∆±«¯”Ú');
    edtarea.SetFocus;
    exit;
  end;
  if (trim(edtaddress.Text)='') then
  begin
    SysDialogs.Warning('«ÎÃÓ–¥ÀÕ∆±µÿ÷∑');
    edtaddress.SetFocus;
    exit;
  end;
  if (Trim(nvhlpdeliverby.Text) = '') then
  begin
    SysDialogs.Warning('«ÎÃÓ–¥ÀÕ∆±»À');
    nvhlpdeliverby.SetFocus;
    exit;
  end;
  if (Trim(edtclientphone.Text) = '') then
  begin
    SysDialogs.Warning('«ÎÃÓ–¥ ’∆±»ÀµÁª∞∫≈¬Î');
    edtclientphone.SetFocus;
    exit;
  end;
  with jcdsResultTicketdeliverSave do
  begin
    Close;
    Params.ParamByName('ticketdeliver.id').Value := id ;
    Params.ParamByName('ticketdeliver.orgid').Value := orgid ;
    Params.ParamByName('ticketdeliver.isturnover').Value := isturnover;
    Params.ParamByName('ticketdeliver.turnoverid').Value := turnoverid;
    Params.ParamByName('ticketdeliver.area').Value := edtarea.Text;
    Params.ParamByName('ticketdeliver.address').Value := edtaddress.Text;
    Params.ParamByName('ticketdeliver.createby').Value := createby;
    Params.ParamByName('ticketdeliver.createtime').Value := createtime;
    Params.ParamByName('ticketdeliver.serviceprice').Value := edtserviceprice.Text;
    Params.ParamByName('ticketdeliver.clientname').Value := edtclientname.Text;
    Params.ParamByName('ticketdeliver.clientphone').Value := edtclientphone.Text;
    Params.ParamByName('ticketdeliver.deliverby').Value := nvhlpdeliverby.Text;
    Params.ParamByName('ticketdeliver.deliverdate').Value := deliverdate;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtarea.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('ÀÕ∆±º«¬º√˜œ∏ÃÌº” ß∞‹£∫' + E.Message);
      end;
    end;
  end;
end;


end.
