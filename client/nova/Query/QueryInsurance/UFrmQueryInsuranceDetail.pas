unit UFrmQueryInsuranceDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, Services;

type
  TFrmQueryInsuranceDetail = class(TSimpleCRUDForm)
    lbl1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbbOrgid: TNovaCheckedComboBox;
    cbb1: TNovaCheckedComboBox;
    cbbNovachkPorg: TNovaCheckedComboBox;
    cbb2: TNovaCheckedComboBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    Label9: TLabel;
    cbb3: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryInsuranceDetail: TFrmQueryInsuranceDetail;

implementation

{$R *.dfm}



procedure TFrmQueryInsuranceDetail.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True then
  begin
    dtpEselldate.Checked := True;
  end;
  if dtpBselldate.Checked =False then
  begin
    dtpEselldate.Checked := False;
  end;
end;

procedure TFrmQueryInsuranceDetail.dtpenddateChange(Sender: TObject);
begin
  inherited;
  if dtpenddate.Checked = True  then
  begin
     dtpstartdate.Checked := True;
  end;
 if  dtpenddate.Checked =False then
  begin
     dtpstartdate.Checked := False;
  end;
end;

procedure TFrmQueryInsuranceDetail.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True  then
  begin
     dtpBselldate.Checked := True;
  end;
 if  dtpEselldate.Checked =False then
  begin
     dtpBselldate.Checked := False;
  end;
end;

procedure TFrmQueryInsuranceDetail.dtpstartdateChange(Sender: TObject);
begin
  inherited;
   if dtpstartdate.Checked = True  then
  begin
     dtpenddate.Checked := True;
  end;
 if  dtpstartdate.Checked =False then
  begin
     dtpenddate.Checked := False;
  end;
end;

procedure TFrmQueryInsuranceDetail.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  dtpstartdate.Checked := False;
  dtpenddate.Checked := False;
  dtpBselldate.DateTime := Now;
  dtpEselldate.DateTime := Now;
  cbbOrgid.Active := False;
  cbbOrgid.Active := True;
  cbb3.Active := False;
  cbb3.Active := True;
  cbbNovachkPorg.Active := False;
  cbbNovachkPorg.Active := True;
  cbb2.Active := False;
  cbb2.Active := True;
  cbb1.Active := False;
  cbb1.Active := True;
end;

procedure TFrmQueryInsuranceDetail.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if dtpstartdate.checked then
  begin
    if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime
      ('yyyymmdd', dtpenddate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      exit;
    end;
  end;
  if dtpBselldate.checked then
  begin
    if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime
      ('yyyymmdd', dtpEselldate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      exit;
    end;
  end;

   if 31
      <= Trunc(dtpEselldate.Date-dtpBselldate.Date)
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;

  if 31
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;

  if dtpBselldate.checked or dtpstartdate.checked then
  begin
    with jcdsResult do
    begin
      Active := False;
      Params.ParamValues['filter_INS_i!orgid'] := cbbOrgid.GetSelectID;
      Params.ParamValues['filter_INS_s!orgid'] := cbb1.GetSelectID;
      if dtpstartdate.checked then
      begin
        Params.ParamValues['filter_GED_t!selltime'] := FormatDateTime
          ('yyyy-mm-dd', dtpstartdate.Date) + ' 00:00:01';
        Params.ParamValues['filter_LED_t!selltime'] := FormatDateTime
          ('yyyy-mm-dd', dtpenddate.Date) + ' 23:59:59';
      end
      else
      begin
        Params.ParamValues['filter_GED_t!selltime'] := '';
        Params.ParamValues['filter_LED_t!selltime'] := '';
      end;

      if dtpBselldate.checked then
      begin
        Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime
          ('yyyy-mm-dd', dtpBselldate.Date);
        Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime
          ('yyyy-mm-dd', dtpEselldate.Date);
      end
      else
      begin
        Params.ParamValues['filter_GED_t!departdate'] := '';
        Params.ParamValues['filter_LED_t!departdate'] := '';
      end;
      if Trim(cbb3.Text) = '' then
        Params.ParamValues['filter_INS_irs!id'] := ''
      else
        Params.ParamValues['filter_INS_irs!id'] := cbb3.GetSelectID;

      Active := True;
    end;
  end
  else
  begin
    SysDialogs.Warning('请选择售票日期或发车日期！');
    exit;
  end;
end;

end.
