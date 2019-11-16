unit UFrmTicketStaticsQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmTicketStaticsQuery = class(TSimpleCRUDForm)
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    Label3: TLabel;
    nhcbbticketunit: TNovaHComboBox;
    dtpenddate: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketStaticsQuery: TFrmTicketStaticsQuery;

implementation
uses PubFn, Services;
{$R *.dfm}

procedure TFrmTicketStaticsQuery.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
end;

procedure TFrmTicketStaticsQuery.tbtnFilterClick(Sender: TObject);
begin
  inherited;

  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('售票开始日期不能大于售票结束日期！');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['sellticketunit'] := nhcbbticketunit.ItemIndex;
    Params.ParamValues['beginselltime'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['endselltime'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date);

   Active := True;
  end;

end;

end.
