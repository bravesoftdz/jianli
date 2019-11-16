unit UFrmVipremainmoneytransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit;

type
  TFrmVipremainmoneytransfer = class(TSimpleCRUDForm)
    lbl1: TLabel;
    edtoldvipcardno: TNovaEdit;
    edtnewvipcardno: TNovaEdit;
    Label1: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVipremainmoneytransfer: TFrmVipremainmoneytransfer;

implementation

{$R *.dfm}

procedure TFrmVipremainmoneytransfer.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      if Trim(edtoldvipcardno.Text) = '' then
        Params.ParamValues['filter_LIKES_v!vipcardno'] := ''
      else
        Params.ParamValues['filter_LIKES_v!vipcardno'] := edtoldvipcardno.Text;
      if Trim(edtnewvipcardno.Text) = '' then
        Params.ParamValues['filter_LIKES_vi!vipcardno'] := ''
      else
        Params.ParamValues['filter_LIKES_vi!vipcardno'] := edtnewvipcardno.Text;
    Active := True;
  end;
end;

end.
