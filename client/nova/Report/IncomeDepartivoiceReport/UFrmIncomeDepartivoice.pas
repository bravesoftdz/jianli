unit UFrmIncomeDepartivoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TfrmIncomeDepartivoice = class(TSimpleCRUDForm)
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    nvhlpRoute: TNovaHelp;
    lbl2: TLabel;
    lbl9: TLabel;
    lbl1: TLabel;
    nvhlpBalanceunit: TNovaHelp;
    dtpsellmonth: TDateTimePicker;
    nvcbbOrgid: TNovaCheckedComboBox;
    lbl3: TLabel;
    nvcbbPrintOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIncomeDepartivoice: TfrmIncomeDepartivoice;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmIncomeDepartivoice.FormShow(Sender: TObject);
begin
  inherited;
  dtpsellmonth.Date := Now;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbPrintOrg.Active := False;
  nvcbbPrintOrg.Active := True;
  nvcbbPrintOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmIncomeDepartivoice.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  truetake: double;
  aa,log:string;
begin
  inherited;
  if (nvcbbOrgid.GetCount = 0) or (nvcbbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ���λ�����');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid']:= nvcbbOrgid.GetSelectID;
    Params.ParamValues['month'] := DateToStr(dtpsellmonth.Date);
    if (not (Trim(nvhlpBalanceunit.Text) = '')) and (nvhlpBalanceunit.Id>0) then         //��λ
      begin
        Params.ParamValues['unitid']:= nvhlpBalanceunit.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['unitid']:= '';
      end;

    if not (nvhlpRoute.Id = 0 ) then
      begin
        Params.ParamValues['routeid']:= nvhlpRoute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['routeid']:= '';
      end;

    if not (nvcbbPrintOrg.GetSelectID = '' ) then
      begin
        Params.ParamValues['checkstationid']:= nvcbbPrintOrg.GetSelectID;
      end
    else
      begin
        Params.ParamValues['checkstationid']:= '';
      end;
    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�����·ݣ�'+ DateToStr(dtpsellmonth.Date);

    log := '��ѯ�����У�[�����·�]'+formatdatetime('yyyy-MM', dtpsellmonth.Date) ;
    if Trim(nvcbbOrgid.Text)<>'' then
      log := log+',[��λ���]��'+nvcbbOrgid.Text;
    if Trim(nvcbbPrintOrg.Text) <> '' then
      log := log +',[������λ]��'+nvcbbPrintOrg.Text ;
    if Trim(nvhlproute.Text) <> '' then
      log := log +',[��·]��'+nvhlproute.Text ;
    if Trim(nvhlpBalanceunit.Text) <> '' then
      log := log +',[���㵥λ]��'+nvhlpBalanceunit.Text ;
     log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->Ӫ������ͳ�Ʊ�','��ѯ',log);

  end;

end;

end.
