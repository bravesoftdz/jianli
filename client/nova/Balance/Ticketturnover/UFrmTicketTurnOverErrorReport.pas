unit UFrmTicketTurnOverErrorReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, StdCtrls, ComCtrls, NvPrnDbgeh,
  DB, DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh,
  ToolWin, ExtCtrls;

type
  TFrmTicketTurnOverErrorReport = class(TSimpleCRUDForm)
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    cbQueryType: TComboBox;
    Label1: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure cbQueryTypeChange(Sender: TObject);
    procedure tbtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function SplitString(src, dec: string): TStringList; stdcall;
  public
    { Public declarations }
  end;

var
  FrmTicketTurnOverErrorReport: TFrmTicketTurnOverErrorReport;

implementation

uses PubFn, Services;
{$R *.dfm}

procedure TFrmTicketTurnOverErrorReport.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  Self.Close;
end;

procedure TFrmTicketTurnOverErrorReport.tbtnFilterClick(Sender: TObject);
var
  title: string;
  I, j, idx, h: Integer;
  Columns: TDBGridColumnsEh;
  Column_n: TColumnEh;
  st: TStringList;
begin
  inherited;
  if FormatDateTime('yyyymmdd',dtpstartdate.Date)>FormatDateTime('yyyymmdd',
     dtpenddate.Date) then
     begin
       SysDialogs.ShowMessage('开始日期不能大于结束日期!');
       exit;
     end;

  try
    dbgrdhResult.Columns.Clear;

    with jcdsResult do
    begin
      Active := false;
      Params.ParamValues['filter_GED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
      Params.ParamValues['querytype'] := cbQueryType.ItemIndex;
      Active := true;
      dbgrdhResult.PrintInfo.PageTopRight := '票款日期:' + FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime) + ' 至 ' + FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
      dbgrdhResult.PrintInfo.PageFooterRight :=
        '审核人:' + SysInfo.LoginUserInfo.UserName;
      if recordcount > 0 then
      begin
        dbgrdhResult.Columns.BeginUpdate;
        title := Params.ParamValues['title'];
        st := SplitString(title, ':');
        Columns := dbgrdhResult.Columns;
        for I := 0 to FieldCount - 1 do
        begin
          Column_n := Columns.Add;
          Column_n.FieldName := st[I];
          Column_n.Width := 60;
          Column_n.title.Caption := st[I];
          if I > 0 then
            Column_n.DisplayFormat := '#0.0';
        end;
        dbgrdhResult.Columns.Items[0].Width := 100;
        dbgrdhResult.Columns.Items[0].Footer.value := '合计';
        dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtStaticText;
        dbgrdhResult.DataSource := dsResult;
        for I := 1 to FieldCount - 1 do
        begin
          dbgrdhResult.Columns.Items[I].Footer.ValueType := fvtSum;
        end;
      end;
//      dbgrdhResult.Columns.EndUpdate;
      dbgrdhResult.Refresh;
    end;

  except
    on E: exception do
    begin
      SysLog.WriteErr('处理失败：' + E.Message);
    end;
  end;
end;

procedure TFrmTicketTurnOverErrorReport.cbQueryTypeChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(Sender);
end;

procedure TFrmTicketTurnOverErrorReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime:= now;
  dtpenddate.DateTime:= now;
end;

function TFrmTicketTurnOverErrorReport.SplitString(src, dec: string)
  : TStringList;
var
  I: Integer;
  str: string;
begin
  result := TStringList.Create;
  repeat
    I := pos(dec, src);
    str := copy(src, 1, I - 1);
    if (str = '') and (I > 0) then
    begin
      delete(src, 1, length(dec));
      continue;
    end;
    if I > 0 then
    begin
      result.Add(str);
      delete(src, 1, I + length(dec) - 1);
    end;
  until I <= 0;
  if src <> '' then
    result.Add(src);

end;

end.
