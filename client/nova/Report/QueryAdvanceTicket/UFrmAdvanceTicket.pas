unit UFrmAdvanceTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmAdvanceTicket = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl5: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlprecipients: TNovaHelp;
    lbl3: TLabel;
    nvcbbOrgid: TNovaCheckedComboBox;
    Label1: TLabel;
    nvhelpTicketoutlets: TNovaHelp;
    Label4: TLabel;
    NHelpRoute: TNovaHelp;
    chkIsCheck: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAdvanceTicket: TFrmAdvanceTicket;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmAdvanceTicket.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmAdvanceTicket.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if chkIsCheck.Checked then
      dbgrdhResult.Columns[2].Visible :=True
  else
      dbgrdhResult.Columns[2].Visible :=false;
end;

procedure TFrmAdvanceTicket.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
  if (nvcbbOrgid.GetCount = 0) or (nvcbbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
   if FormatDateTime('yyyy-mm-dd', dtpstartdate.Date) > FormatDateTime('yyyy-mm-dd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['startdate'] := Formatdatetime('yyyy-mm-dd',dtpstartdate.Date)+' 00:00:00';
    //FormatDateTime('yyyy-mm-dd',dtpstartdate.DateTime);
    Params.ParamValues['enddate'] :=  FormatDateTime('yyyy-mm-dd',dtpenddate.Date)+' 23:59:59';
    Params.ParamValues['orgid']:= nvcbbOrgid.GetSelectID;

    if Trim(nvhlprecipients.Text) = '' then
      Params.ParamValues['sellid'] := null
    else
      Params.ParamValues['sellid'] := nvhlprecipients.Id;

    if (NHelpRoute.Text <> '') and (NHelpRoute.Id > 0) then
        Params.ParamValues['routeid'] := NHelpRoute.Id
    else
        Params.ParamValues['routeid'] := null;

    //��Ʊ��
    if nvhelpTicketoutlets.Id>0 then
    begin
       Params.ParamValues['tosid']:=nvhelpTicketoutlets.Id;
    end
    else
    begin
       Params.ParamValues['tosid']:= '';
    end;
    if chkIsCheck.Checked then
       Params.ParamValues['groupbyroute']:='true'
    else
       Params.ParamValues['groupbyroute']:='false';

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������' + SysInfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);    Active := True;

    log :='[��������]��'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);
    if Trim(nvcbbOrgid.GetSelectID) <>'' then
      log := log +',[��Ʊ����]��'+nvcbbOrgid.Text;
    if nvhlprecipients.id <>0 then
      log  := log +',[��ƱԱ]:'+nvhlprecipients.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->Ԥ��Ʊ�����ѯ','��ѯ',log);
  end;
end;

end.
