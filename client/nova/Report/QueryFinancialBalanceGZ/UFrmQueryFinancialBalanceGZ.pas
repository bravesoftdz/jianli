unit UFrmQueryFinancialBalanceGZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryFinancialBalanceGZ  = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryFinancialBalanceGZ: TfrmQueryFinancialBalanceGZ;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryFinancialBalanceGZ.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryFinancialBalanceGZ.jcdsResultAfterOpen(DataSet: TDataSet);
var  footers :TColumnFooterEh;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    
  end;
end;

procedure TfrmQueryFinancialBalanceGZ.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;

  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['orgids']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate']
          := FormatDateTime('yyyy-mm', dtpstartdate.Date)+'-01';
    Params.ParamValues['enddate']
          := FormatDateTime('yyyy-mm', dtpstartdate.Date)+'-31';
   
    log := '��ѯ�����У�[��Ʊ�·�]'+ formatdatetime('yyyy-MM',dtpstartdate.Date);
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    //log := log+'����ѯ���:���� '+ inttostr(RecordCount) +' ����¼��';

    SysLog.WriteLog('����ͳ��->��������֧��ƽ���-����','��ѯ',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ�·ݣ�'+ formatdatetime('yyyy-MM',now);

    Active:=true;
    end
end;

end.
