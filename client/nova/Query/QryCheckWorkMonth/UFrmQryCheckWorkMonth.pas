unit UFrmQryCheckWorkMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls,Services, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmQryCheckWorkMonth = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    Label9: TLabel;
    nvhelpUserid: TNovaHelp;
    lbl5: TLabel;
    lbl11: TLabel;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpEdepartdate: TDateTimePicker;
    dtpBdepartdate: TDateTimePicker;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryCheckWorkMonth: TFrmQryCheckWorkMonth;

implementation
uses UDMPublic;
{$R *.dfm}

procedure TFrmQryCheckWorkMonth.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True  then
    begin
       dtpEselldate.Checked := True;
    end;
   if  dtpBselldate.Checked =False then
    begin
       dtpEselldate.Checked := False;
    end;
end;

procedure TFrmQryCheckWorkMonth.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
end;

procedure TFrmQryCheckWorkMonth.FormShow(Sender: TObject);
begin
  inherited;
  dtpBselldate.DateTime := Now;
  dtpEselldate.DateTime := Now;
  dtpBselldate.Checked := False;
  dtpEselldate.Checked := False;
  dtpBdepartdate.DateTime := Now;
  dtpEdepartdate.DateTime := Now;
end;

procedure TFrmQryCheckWorkMonth.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;

  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) )then
  begin
    SysDialogs.ShowMessage('打单开始日期不能大于结束日期！');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) )then
  begin
    SysDialogs.ShowMessage('发车开始日期不能大于结束日期！');
    exit;
  end;


  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_GED_dis!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_dis!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
    if dtpBselldate.Checked then
    begin
      Params.ParamValues['filter_GED_dis!printtime'] :=  formatdatetime('yyyy-mm-dd',dtpBselldate.DateTime);
      Params.ParamValues['filter_LED_dis!printtime'] :=  formatdatetime('yyyy-mm-dd 23:59:59',dtpEselldate.DateTime);
    end else
    begin
      Params.ParamValues['filter_GED_dis!printtime'] :=  null;
      Params.ParamValues['filter_LED_dis!printtime'] :=  null;
    end;
    Params.ParamValues['filter_INS_sp!orgid']:= nvckbOrgid.GetSelectID;
    if nvhelpUserid.Id>0 then
      begin
        Params.ParamValues['filter_EQL_dis!printby']:= nvhelpUserid.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_dis!printby']:= '';
      end;

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName
     +' 售票机构：'+nvckbOrgid.Text;


    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    Active := True;
  end;

end;

end.
