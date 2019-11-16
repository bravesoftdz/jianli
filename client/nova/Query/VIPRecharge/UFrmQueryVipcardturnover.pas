unit UFrmQueryVipcardturnover;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmQueryVipturnover = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    nvhlpseller: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isprint,turnoverid : Integer;
  end;

var
  FrmQueryVipturnover: TFrmQueryVipturnover;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmQueryVipturnover.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  if isprint = 1 then
  begin
    tbtnInsert.Visible := True;
  end;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmQueryVipturnover.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd',dtpstartdate.Date)>FormatDateTime('yyyymmdd',
  dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期!');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_v!turnoverdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime) + ' 00:00:00';
      Params.ParamValues['filter_LED_v!turnoverdate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime)+ ' 23:59:59';
      if Trim(nvhlpseller.Text) = '' then
        Params.ParamValues['filter_EQL_v!sellid'] := ''
      else
        Params.ParamValues['filter_EQL_v!sellid'] := nvhlpseller.Id;

    Active := True;
  end;
end;

end.
