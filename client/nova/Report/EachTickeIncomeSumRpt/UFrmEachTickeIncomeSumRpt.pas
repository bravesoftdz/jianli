unit UFrmEachTickeIncomeSumRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping;

type
  TFrmEachTickeIncomeSumRpt = class(TSimpleCRUDForm)
    Label10: TLabel;
    NovaChkSaleOrg: TNovaCheckedComboBox;
    Label1: TLabel;
    Label2: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmEachTickeIncomeSumRpt: TFrmEachTickeIncomeSumRpt;

implementation
  uses PubFn, Services;
{$R *.dfm}

procedure TFrmEachTickeIncomeSumRpt.FormShow(Sender: TObject);
begin
  inherited;
  NovaChkSaleOrg.Active := False;
  NovaChkSaleOrg.Active := true;
  NovaChkSaleOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBselldate.Date:=now;
  dtpEselldate.Date:=now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmEachTickeIncomeSumRpt.tbtnFilterClick(Sender: TObject);
var days:Integer;
    log : string;
begin
  inherited;
 if NovaChkSaleOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;

  if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  days :=StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID));
  if   days <= Trunc(dtpEselldate.Date-dtpBselldate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����('+IntToStr(days)+'),������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_INS_ts!orgid'] := NovaChkSaleOrg.GetSelectID;
    Params.ParamValues['filter_GED_ts!selldate']
                        :=  formatdatetime('yyyy-mm-dd',dtpBselldate.DateTime);
    Params.ParamValues['filter_LED_ts!selldate']
                        :=  formatdatetime('yyyy-mm-dd',dtpEselldate.DateTime);
    Active := true;

     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
     dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);

    log := '��ѯ�����У�[��Ʊ����]��'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' �� '+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);
    if Trim(NovaChkSaleOrg.GetSelectID) <>'' then
      log := log +',[��Ʊ����]��'+NovaChkSaleOrg.Text;
    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��վ���ۻ���Ӫ�ջ��ܱ�','��ѯ',log);
  end;
end;

end.
