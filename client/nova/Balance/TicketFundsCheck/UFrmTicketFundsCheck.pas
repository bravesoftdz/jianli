unit UFrmTicketFundsCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls,
  NvPrnDbgeh, NvDbgridEh, NovaHComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmTicketFundsCheck = class(TSimpleCRUDForm)
    lbl1: TLabel;
    NvDbgridEh1: TNvDbgridEh;
    nvhlpcode: TNovaHelp;
    Label6: TLabel;
    Label4: TLabel;
    balanceStartDate: TDateTimePicker;
    balanceEndDate: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmTicketFundsCheck: TFrmTicketFundsCheck;

implementation

uses  PubFn;
{$R *.dfm}

procedure TFrmTicketFundsCheck.FormShow(Sender: TObject);
begin
  inherited;
  balanceStartDate.Date:= Now;
  balanceEndDate.Date:= NOW;
end;

procedure TFrmTicketFundsCheck.tbtnFilterClick(Sender: TObject);
begin
  inherited;

  if FormatDateTime('yyyy-mm-dd', balanceStartDate.Date) > FormatDateTime
    ('yyyy-mm-dd', balanceEndDate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;
        Params.ParamByName('vehicleno').Value := nvhlpcode.Text;
        Params.ParamValues['balanceStartDate'] := FormatDateTime('yyyy-mm-dd', balanceStartDate.Date);
        Params.ParamValues['balanceEndDate'] := FormatDateTime('yyyy-mm-dd', balanceEndDate.Date);
    Active := True;
  end
end;

end.
