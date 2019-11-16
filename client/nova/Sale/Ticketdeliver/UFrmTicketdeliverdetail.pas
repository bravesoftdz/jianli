unit UFrmTicketdeliverdetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  ComCtrls, NovaEdit, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmTicketdeliverdetail = class(TSimpleEditForm)
    lbl3: TLabel;
    lbl4: TLabel;
    edtarea: TNovaEdit;
    jcdsResultTicketdeliverSave: TjsonClientDataSet;
    edtticketno: TNovaEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl5: TLabel;
    lbl2: TLabel;
    edtcount: TNovaEdit;
    edtendticketno: TNovaEdit;
    lbl1: TLabel;
    lbl6: TLabel;
    edtaddress: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtticketnoChange(Sender: TObject);
    procedure edtcountChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby, createtime, ticketdeliverid : string;
    sign : boolean;
  end;

var
  FrmTicketdeliverdetail: TFrmTicketdeliverdetail;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTicketdeliverdetail.bbtnSaveClick(Sender: TObject);
var nResult : Integer;
    sResult : string;
begin
  inherited;
  if Trim(edtcount.Text) = '' then
  begin
    SysDialogs.ShowMessage('送票的数量不能为0，请重新输入！');
    edtcount.SetFocus;
    Exit;
  end;

  with jcdsResultTicketdeliverSave do
  begin
    Close;
    Params.ParamByName('ticketdeliverdetail.id').Value := id ;
    Params.ParamByName('ticketdeliverdetail.createby').Value := createby;
    Params.ParamByName('ticketdeliverdetail.createtime').Value := createtime;
    Params.ParamByName('ticketdeliverdetail.ticketno').Value := edtticketno.Text;
    Params.ParamByName('ticketdeliverdetail.deliverid').Value := ticketdeliverid;
    params.ParamByName('count').Value := edtcount.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtticketno.SetFocus;
      end
      else
      begin
        ticketdeliverid := params.ParamByName('deliverid').Value;
//        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('送票记录明细添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTicketdeliverdetail.edtcountChange(Sender: TObject);
var count : Integer;
    ticketno : string;
begin
  inherited;
  count := StrToInt(edtticketno.Text) + StrToInt(edtcount.Text) - 1;
  ticketno := IntToStr(count);
  while Length(edtticketno.Text) - Length(ticketno) > 0 do
  begin
    ticketno := '0' + ticketno;
  end;
  edtendticketno.Text := ticketno;
end;

procedure TFrmTicketdeliverdetail.edtticketnoChange(Sender: TObject);
var ticketno : string;
begin
  inherited;
  edtendticketno.Text := edtticketno.Text;
  ticketno := IntToStr(StrToInt(edtticketno.Text) + StrToInt(edtcount.Text) - 1);
  while Length(edtticketno.Text) - Length(ticketno) > 0 do
  begin
    ticketno := '0' + ticketno;
  end;
  edtendticketno.Text := ticketno;
end;

end.
