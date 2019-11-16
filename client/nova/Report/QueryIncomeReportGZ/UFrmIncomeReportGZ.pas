unit UFrmIncomeReportGZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmIncomeReportGZ  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    lbl3: TLabel;
    dtpStart: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    Label1: TLabel;
    nvhlpRoute: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIncomeReportGZ: TfrmIncomeReportGZ;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmIncomeReportGZ.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpStart.Date := Now;
  dtpEnd.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmIncomeReportGZ.jcdsResultAfterOpen(DataSet: TDataSet);
var  footers :TColumnFooterEh;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    
  end;
end;

procedure TfrmIncomeReportGZ.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if (nvckbOrgid.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvckbOrgid.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    log := '��ѯ�����У�[����] ��'+ FormatDateTime('yyyy-mm-dd', dtpStart.Date)
              +'��'+FormatDateTime('yyyy-mm-dd', dtpEnd.Date);
    Params.ParamValues['orgids']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate']
          := FormatDateTime('yyyy-mm-dd', dtpStart.Date);
    Params.ParamValues['enddate']
          := FormatDateTime('yyyy-mm-dd', dtpEnd.Date);
    log:= log+'[����]��'+nvckbOrgid.Text;
     // ��·
    if nvhlpRoute.Id > 0 then
    begin
      Params.ParamValues['routeid'] := nvhlpRoute.Id ;
      log:= log+'[��·����]��'+nvhlpRoute.Text;
    end
    else
      Params.ParamValues['routeid'] := '';

    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    //log := log+'����ѯ���:���� '+ inttostr(RecordCount) +' ����¼��';

    SysLog.WriteLog('����ͳ��->��λӪ��ͳ�Ʊ�-����','��ѯ',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='��ѯ���ڣ�'
              + FormatDateTime('yyyy-mm-dd', dtpStart.Date)
              +'��'+FormatDateTime('yyyy-mm-dd', dtpEnd.Date);
    Active:=true;
    end
end;

end.
