unit UFrmLocalSalerSyncOrg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,Services;

type
  TFrmLocalSalerSyncOrg = class(TSimpleCRUDForm)
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label2: TLabel;
    nvcbbNovachkPorg: TNovaCheckedComboBox;
    nvckbOrgid: TNovaCheckedComboBox;
    ChkSchedule: TCheckBox;
    lbl1: TLabel;
    cbbdatetype: TComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvcbbNovachkPorgCheckClick(Sender: TObject);
    procedure ChkScheduleClick(Sender: TObject);
    procedure cbbdatetypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLocalSalerSyncOrg: TFrmLocalSalerSyncOrg;

implementation
 uses   PubFn;
{$R *.dfm}

procedure TFrmLocalSalerSyncOrg.cbbdatetypeChange(Sender: TObject);
begin
  inherited;
 if cbbdatetype.ItemIndex=0 then
  begin
     dbgrdhResult.Columns[2].Visible:=True;
     dbgrdhResult.Columns[3].Visible:=False;
  end
  else if cbbdatetype.ItemIndex=1 then
  begin
     dbgrdhResult.Columns[2].Visible:=False;
     dbgrdhResult.Columns[3].Visible:=True;
  end;
end;

procedure TFrmLocalSalerSyncOrg.ChkScheduleClick(Sender: TObject);
begin
  inherited;
  if ChkSchedule.Checked then
    nvckbOrgid.CheckAll(true)
  else
     nvckbOrgid.CheckAll(false);
end;



procedure TFrmLocalSalerSyncOrg.FormShow(Sender: TObject);
begin
  inherited;
  nvcbbNovachkPorg.Active:= False;
  nvcbbNovachkPorg.Active := True;
  nvcbbNovachkPorg.OnCheckClick:=nil;
  nvcbbNovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  nvcbbNovachkPorg.OnCheckClick:= nvcbbNovachkPorgCheckClick;
  nvckbOrgid.Active := False;
  nvckbOrgid.Params.ParamValues['orgids']:=nvcbbNovachkPorg.GetSelectID;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckAll(true);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.Columns[2].Visible:=True;
  dbgrdhResult.Columns[3].Visible:=False;
  cbbdatetype.ItemIndex:=0;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmLocalSalerSyncOrg.nvcbbNovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if nvcbbNovachkPorg.GetSelectID<>'' then
  begin
    nvckbOrgid.Active := False;
    nvckbOrgid.Params.ParamValues['orgids']:=nvcbbNovachkPorg.GetSelectID;
    nvckbOrgid.Active := True;
    nvckbOrgid.CheckAll(true);
  end;
end;

procedure TFrmLocalSalerSyncOrg.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
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
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid'] := Sysinfo.LoginUserInfo.OrgID;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    params.ParamValues['datetype']:= cbbdatetype.ItemIndex;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У�[��Ʊ����]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if nvcbbNovachkPorg.GetSelectID <>'' then
      log  := log +',[�ֹ�˾]:'+nvcbbNovachkPorg.Text;
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[����]��'+nvckbOrgid.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��վ����վƱ���ܱ�','��ѯ',log);
  end
end;

end.
