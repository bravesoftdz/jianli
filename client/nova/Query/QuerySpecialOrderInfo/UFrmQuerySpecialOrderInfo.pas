unit UFrmQuerySpecialOrderInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaCheckedComboBox,Services;

type
  TfrmQuerySpecialOrderInfo = class(TSimpleCRUDForm)
    lbl1: TLabel;
    cbbOrgid: TNovaCheckedComboBox;
    lbl17: TLabel;
    edtTicketno: TNovaEdit;
    lbl2: TLabel;
    lbl7: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpBselldate: TDateTimePicker;
    lbl3: TLabel;
    lbl14: TLabel;
    dtpenddate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    qry1: TjsonClientDataSet;
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQuerySpecialOrderInfo: TfrmQuerySpecialOrderInfo;

implementation

{$R *.dfm}

procedure TfrmQuerySpecialOrderInfo.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True then
  begin
    dtpEselldate.Checked := True;
  end;
  if dtpBselldate.Checked = False then
  begin
    dtpEselldate.Checked := False;
  end;
end;

procedure TfrmQuerySpecialOrderInfo.dtpenddateChange(Sender: TObject);
begin
  inherited;
  if dtpenddate.Checked = True then
  begin
    dtpstartdate.Checked := True;
  end;
  if dtpenddate.Checked = False then
  begin
    dtpstartdate.Checked := False;
  end;
end;

procedure TfrmQuerySpecialOrderInfo.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True then
  begin
    dtpBselldate.Checked := True;
  end;
  if dtpEselldate.Checked = False then
  begin
    dtpBselldate.Checked := False;
  end;
end;

procedure TfrmQuerySpecialOrderInfo.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  if dtpstartdate.Checked = True then
  begin
    dtpenddate.Checked := True;
  end;
  if dtpstartdate.Checked = False then
  begin
    dtpenddate.Checked := False;
  end;
end;

procedure TfrmQuerySpecialOrderInfo.FormCreate(Sender: TObject);
begin
  inherited;
  cbbOrgid.active := False;
  cbbOrgid.active := True;
  dtpenddate.Date := now;
  dtpstartdate.Date := now;
  dtpBselldate.Date := now;
  dtpEselldate.Date := now;
end;

procedure TfrmQuerySpecialOrderInfo.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)
  then
  begin
    SysDialogs.ShowMessage('退票开始日期不能大于结束日期！');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date)
  then
  begin
    SysDialogs.ShowMessage('订票开始日期不能大于结束日期！');
    exit;
  end;

    with qry1 do
    begin
    active := False;

    if dtpstartdate.Checked and dtpenddate.Checked then
    begin
      Params.ParamValues['filter_GED_so!returntime'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.Date) + ' 00:00:00';
      Params.ParamValues['filter_LED_so!returntime'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.Date) + ' 23:59:59';
    end
    else
    begin
      Params.ParamValues['filter_GED_so!returntime'] := null;
      Params.ParamValues['filter_LED_so!returntime'] := null;
    end;
    if dtpBselldate.Checked and dtpEselldate.Checked then
    begin
      Params.ParamValues['filter_GED_so!createtime'] := FormatDateTime
        ('yyyy-mm-dd', dtpBselldate.Date) + ' 00:00:00';
      Params.ParamValues['filter_LED_so!createtime'] := FormatDateTime
        ('yyyy-mm-dd', dtpEselldate.Date) + ' 23:59:59';
    end
    else
    begin
      Params.ParamValues['filter_GED_so!createtime'] := null;
      Params.ParamValues['filter_LED_so!createtime'] := null;
    end;
    if edtTicketno.text<>'' then
    begin
    Params.ParamValues['filter_EQS_so!orderno'] := edtTicketno.text;
    end
    else
    begin
      Params.ParamValues['filter_EQS_so!orderno'] :=null;
    end;
    active := True;
    end;
end;

end.
