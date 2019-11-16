unit UFrmPackTurnoverError;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls;

type
  TFrmPackTurnoverError = class(TSimpleCRUDForm)
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    cbQueryType: TComboBox;
    lblreason: TLabel;
    Cobdatafrom: TComboBox;
    procedure tbtnCloseClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbQueryTypeChange(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    function SplitString(src, dec: string): TStringList; stdcall;
  public
    { Public declarations }
  end;

var
  FrmPackTurnoverError: TFrmPackTurnoverError;

implementation

uses Services, PubFn, UFrmPackTurnoverdifadjust;
{$R *.dfm}

procedure TFrmPackTurnoverError.jcdsResultAfterOpen(DataSet: TDataSet);
var
title: string;
  I, j, idx, h: Integer;
  Columns: TDBGridColumnsEh;
  Column_n: TColumnEh;
  st: TStringList;
begin
  inherited;
  if DataSet.RecordCount > 0 then
  begin
 //   DataSet.First;

//    title := jcdsResult.FieldByName('title').AsString;
//    st := SplitString(title, ':');
//    Columns := dbgrdhResult.Columns;
//    for I := 0 to DataSet.FieldCount - 1 do
//    begin
//      Column_n := Columns.Add;
//      Column_n.FieldName := st[I];
//      Column_n.Width := 60;
//      Column_n.title.Caption := st[I];
//      if I > 0 then
//        Column_n.DisplayFormat := '#0.0';
//    end;
//    DataSet.Delete;
//    dbgrdhResult.Columns.Items[0].Width := 100;
//    dbgrdhResult.Columns.Items[0].Footer.value := '合计';
//    dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtCount;
//    dbgrdhResult.DataSource := dsResult;
//    for I := 0 to DataSet.FieldCount - 1 do
//    begin
//      dbgrdhResult.Columns.Items[I].Footer.ValueType := fvtSum;
//    end;
  end;

end;

procedure TFrmPackTurnoverError.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmPackTurnoverError.tbtnEditClick(Sender: TObject);
begin
  inherited;
  FrmPackTurnoverdifadjust := TFrmPackTurnoverdifadjust.Create(self);
  try
    with FrmPackTurnoverdifadjust do
    begin
      if SysMainForm.showFormModal(FrmPackTurnoverdifadjust, false) = mrok then
      begin
        // jcdsResultAfterScroll(nil);
      end;
    end;
  finally
    FreeAndNil(FrmPackTurnoverdifadjust);
  end;
end;

procedure TFrmPackTurnoverError.tbtnFilterClick(Sender: TObject);
var
  title: string;
  I, j, idx, h: Integer;
  Columns: TDBGridColumnsEh;
  Column_n: TColumnEh;
  st: TStringList;
begin
  inherited;
  try

//    dbgrdhResult.Columns.Clear;

    with jcdsResult do
    begin
      Active := false;
      Params.ParamValues['filter_GED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
      Params.ParamValues['querytype'] := cbQueryType.ItemIndex;

      if Cobdatafrom.ItemIndex >= 0 then
      begin
        Params.ParamValues['packdatafrom'] := Cobdatafrom.ItemIndex;
      end
      else
      begin
        Params.ParamValues['packdatafrom'] := '';
      end;

      Active := true;
      dbgrdhResult.PrintInfo.PageTopRight := '日期:' + FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime)
        + ' 至 ' + FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime);
      dbgrdhResult.PrintInfo.PageFooterRight :=
        '审核人:' + SysInfo.LoginUserInfo.UserName;
      end;
      except
        on E: exception do
        begin
          SysLog.WriteErr('处理失败：' + E.Message);
        end;
      end;

    end;

    procedure TFrmPackTurnoverError.cbQueryTypeChange(Sender: TObject);
    begin
      inherited;
      tbtnFilterClick(Sender);
    end;

    procedure TFrmPackTurnoverError.FormShow(Sender: TObject);
    begin
      inherited;
      dtpstartdate.DateTime := now;
      dtpenddate.DateTime := now;
    end;

    function TFrmPackTurnoverError.SplitString(src, dec: string): TStringList;
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
