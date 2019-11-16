unit UFrmQueryRouteDataSummary;

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
  TCrackNvDbgridEh = class(TNvDbgridEh);
  TfrmQueryRouteDataSummary = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    nvhlpRoute: TNovaHelp;
    chkBynormal: TCheckBox;
    chkBylatter: TCheckBox;
    Label2: TLabel;
    NovaChkPrintOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpComStarChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryRouteDataSummary: TfrmQueryRouteDataSummary;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryRouteDataSummary.dtpComEndChange(Sender: TObject);
begin
   if not(dtpComEnd.Date=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date)
   then
   begin
      dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
   end;
end;

procedure TfrmQueryRouteDataSummary.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
   dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
end;

procedure TfrmQueryRouteDataSummary.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  chkBylatter.Checked := True;
  chkBynormal.Checked := True;
end;

procedure TfrmQueryRouteDataSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now;
  dtpComEnd.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  NovaChkPrintOrg.Active := False;
  NovaChkPrintOrg.Active := True;
  NovaChkPrintOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryRouteDataSummary.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
      if trim(NovaChkPrintOrg.Text)='' then
      begin
        dbgrdhResult.Columns[1].Visible :=false;
      end
      else
      begin
        dbgrdhResult.Columns[1].Visible :=true;
      end;
  end;
end;

procedure TfrmQueryRouteDataSummary.tbtnFilterClick(Sender: TObject);
var
  log:string;

  pstr:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//����ѡ��ʱ��bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('��ѡ���λ�����');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpComStar.Date) > FormatDateTime('yyyymmdd',
    dtpComEnd.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
   { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
  begin
    SysDialogs.Warning('ͬ�����������������ڷ�������������!');
    Exit;
  end; }
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    begin
    Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['filter_EQL_r!id']:= '';
    end;
    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComStar.Date);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date);
      Params.ParamValues['filter_INS_vr!reportorgid'] := NovaChkPrintOrg.GetSelectID;

    //�Ƿ��������
    if chkBylatter.Checked then
    begin
      Params.ParamValues['isbylatter']:= 'true';
      pstr :='����';
    end
    else
      Params.ParamValues['isbylatter']:= 'false';

      //�Ƿ�����
    if chkBynormal.Checked then
    begin
      Params.ParamValues['isbynormal']:= 'true';
      pstr :='�Ӱ�';
    end
    else
      Params.ParamValues['isbynormal']:= 'false';

    Active := True;

    if chkBynormal.Checked and chkBylatter.Checked then
    begin
      pstr :='';
    end;

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' ͬ�����ڣ�'+ formatdatetime('yyyy-mm-dd',dtpComStar.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',dtpComEnd.Date)+'  '+pstr;

   log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)
      +'[ͬ������] �� '+FormatDateTime('yyyy-mm-dd',dtpComStar.Date)
      +' �� '+FormatDateTime('yyyy-mm-dd',dtpComEnd.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log := log +',[��·]:'+ nvhlpRoute.Text;
    if chkBylatter.Checked then
      log := log +',[���Ӱ೵ͳ��]' ;
    if chkBynormal.Checked then
      log := log +',[�����೵ͳ��]';

    log := log+' ��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->վ��ֹ�˾��������������ܱ�','��ѯ',log);
  end;

end;

end.

