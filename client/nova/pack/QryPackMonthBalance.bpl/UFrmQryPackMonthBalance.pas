unit UFrmQryPackMonthBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, DateUtils,
  ComCtrls, Services,
  ToolWin, ExtCtrls;

type
  TFrmQryPackMonthBalance = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label2: TLabel;
    dtpBdepartdate: TDateTimePicker;
    dtpEdepartdate: TDateTimePicker;
    jcdsResultpackdepartinvoicesother: TFloatField;
    jcdsResultpackdepartinvoices: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultdepartdate: TDateField;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryPackMonthBalance: TFrmQryPackMonthBalance;

implementation

{$R *.dfm}

procedure TFrmQryPackMonthBalance.FormShow(Sender: TObject);
begin
  inherited;
  dtpBdepartdate.DateTime := now();
  dtpEdepartdate.DateTime := now();
end;

procedure TFrmQryPackMonthBalance.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymm', dtpBdepartdate.Date) > FormatDateTime
    ('yyyymm', dtpEdepartdate.Date) then
  begin
    SysDialogs.ShowMessage('开始月份不能大于结束月份！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    // 发车日期
    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', StartOfTheMonth(dtpBdepartdate.Date));

    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', EndOfTheMonth(dtpEdepartdate.Date));
    Active := True;
  end;
end;

end.
