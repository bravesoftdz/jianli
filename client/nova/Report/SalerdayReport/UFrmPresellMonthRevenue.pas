unit UFrmPresellMonthRevenue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,DateUtils;

type
  TFrmPresellMonthRevenue = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    dtpsellmonth: TDateTimePicker;
    NovaCkbOrg: TNovaCheckedComboBox;
    chkIsSellLocal: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPresellMonthRevenue: TFrmPresellMonthRevenue;

implementation
 uses   PubFn,Services;
{$R *.dfm}

procedure TFrmPresellMonthRevenue.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpsellmonth.Date := IncMonth(Now,-1);
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmPresellMonthRevenue.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if NovaCkbOrg.CheckedCount=0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['month'] := DateToStr(dtpsellmonth.Date);
    if chkIsSellLocal.Checked then
    begin
      Params.ParamValues['isSellLocal'] := 'true';
    end
    else
    begin
      Params.ParamValues['isSellLocal'] := 'false';
    end;
    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ�·ݣ�'+ formatdatetime('yyyy-mm',dtpsellmonth.Date);;
    Active := True;
    log := '��ѯ�����У�[��Ʊ�·�]�� '+ formatdatetime('yyyy-MM',dtpsellmonth.Date);
    if Trim(NovaCkbOrg.GetSelectID) <>'' then
      log := log +',[����]��'+NovaCkbOrg.Text;
    if chkIsSellLocal.Checked then
      log := log +'��[��ѡ ��վ�۱�վƱ]';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��;վԤ��Ʊ��ѯ��������»��ܣ�','��ѯ',log);
  end
end;

end.
