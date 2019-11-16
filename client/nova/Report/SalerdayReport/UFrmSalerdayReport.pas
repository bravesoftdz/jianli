unit UFrmSalerdayReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,Services;

type
  TFrmSalerdayReport = class(TSimpleCRUDForm)
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    chkByselldate: TCheckBox;
    chkByseller: TCheckBox;
    lbl1: TLabel;
    Label2: TLabel;
    nvcbbOrgid: TNovaCheckedComboBox;
    NovachkPorg: TNovaCheckedComboBox;
    salebylist: TNovaCheckedComboBox;
    Nvtaketicketplace: TNovaCheckedComboBox;
    Label3: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure chkBysellerClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSalerdayReport: TFrmSalerdayReport;

implementation
uses   PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmSalerdayReport.chkBysellerClick(Sender: TObject);
begin
  inherited;
  if not chkByseller.Checked then   begin
    //chkByseller.Checked := false;
    salebylist.Visible := false;
  end;
  if chkByseller.Checked then begin
    salebylist.Visible := true;
  end;

end;

procedure TFrmSalerdayReport.FormCreate(Sender: TObject);
begin
  inherited;
  dbgrdhResult.OddRowColor:=clMoneyGreen; //��������ɫ
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  salebylist.Visible := false;
  salebylist.active := false;
  salebylist.Active := true;
  Nvtaketicketplace.Active := false;
  Nvtaketicketplace.Active := true;

end;

procedure TFrmSalerdayReport.FormShow(Sender: TObject);
var
  moreprice:string;
begin
  inherited;
  moreprice:=  getParametervalue('5001', Sysinfo.LoginUserInfo.OrgID);
  if moreprice='1' then
      dbgrdhResult.Columns[26].Visible:=true
  else
      dbgrdhResult.Columns[26].Visible:=false;
  //nvckbOrgid.Active := False;
  //nvckbOrgid.Active := True;
 // nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmSalerdayReport.jcdsResultAfterOpen(DataSet: TDataSet);
begin
   if DataSet.RecordCount>0 then
  begin
    //ֻ�а���Ʊ����ͳ�Ƶ�ʱ�򣬲Ż���ʾ�����յ�����Ʊ���롱25
    if chkByselldate.Checked then
    begin
       dbgrdhResult.Columns[1].Visible := True;
       dbgrdhResult.Columns[25].Visible := True
    end
    else
    begin
       dbgrdhResult.Columns[1].Visible := False;
       dbgrdhResult.Columns[25].Visible := False;
    end;
    if chkByseller.Checked then
    begin
       dbgrdhResult.Columns[2].Visible := True ;
       dbgrdhResult.Columns[3].Visible := True
    end
    else
    begin
       dbgrdhResult.Columns[2].Visible := False;
       dbgrdhResult.Columns[3].Visible := False;
    end;

  end;

end;

procedure TFrmSalerdayReport.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);
  end;
end;

procedure TFrmSalerdayReport.tbtnFilterClick(Sender: TObject);
var log : string;
begin
  if nvcbbOrgid.GetSelectID='' then
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
  if chkByselldate.Checked and chkByseller.Checked and
    (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date))
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvcbbOrgid.GetSelectID;
    Params.ParamValues['sellerids'] := salebylist.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Params.ParamValues['ticketoutletid'] := Nvtaketicketplace.GetSelectID;

      //�Ƿ���������
    if chkByselldate.Checked then
      Params.ParamValues['isbyselldate']:= 'true'
    else
      Params.ParamValues['isbyselldate']:= 'false';

      //�Ƿ���ƱԱ
    if chkByseller.Checked then
      Params.ParamValues['isbyseller']:= 'true'
    else
      Params.ParamValues['isbyseller']:= 'false';

    Active := True;
     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;


    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
        +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У�[��Ʊ����]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvcbbOrgid.GetSelectID) <>'' then
      log := log +',[����]��'+nvcbbOrgid.Text;
    if chkByselldate.Checked then
      log:= log+',['+chkByselldate.Caption+']';
    if chkByseller.Checked then
      log := log +',['+chkByseller.Caption+']';
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��ƱԱ��Ʊ����ձ���','��ѯ',log);

  end
end;


end.
