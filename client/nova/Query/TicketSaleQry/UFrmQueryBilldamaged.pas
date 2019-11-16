unit UFrmQueryBilldamaged;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQueryBilldamaged = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl11: TLabel;
    dtpStartRecordtime: TDateTimePicker;
    lbl5: TLabel;
    dtpEndRecordtime: TDateTimePicker;
    lbl3: TLabel;
    lbl6: TLabel;
    nvhlpUser: TNovaHelp;
    jcdsStatusname: TjsonClientDataSet;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbl4: TLabel;
    lbl2: TLabel;
    edtIP: TNovaEdit;
    nvhlpTicketoutlets: TNovaHelp;
    nvHcbbOrgnovahcbbtype: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
  end;

var
  frmQueryBilldamaged: TfrmQueryBilldamaged;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQueryBilldamaged.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpStartRecordtime.Date:=Now;
  dtpEndRecordtime.Date:=Now;
  nvHcbbOrgnovahcbbtype.Active:=false;
  nvHcbbOrgnovahcbbtype.Active:=true;
end;

procedure TfrmQueryBilldamaged.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpStartRecordtime.Date) > FormatDateTime('yyyymmdd',
    dtpEndRecordtime.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_o!id']:= nvckbOrgid.GetSelectID;
    log :=log +'[��������]:'+nvckbOrgid.Text;
     //�Ǽ�ʱ��
    Params.ParamValues['filter_GED_b!recordtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpStartRecordtime.DateTime);
    Params.ParamValues['filter_LED_b!recordtime'] :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpEndRecordtime.DateTime);
    log := log +' [�Ǽ�ʱ��]��'+ DateToStr(dtpStartRecordtime.DateTime)+'��'+DateToStr(dtpEndRecordtime.DateTime);


    if  (not (Trim(nvhlpUser.Text) = '')) and  (nvhlpUser.Id>0) then         //�Ǽ���
      begin
        Params.ParamValues['filter_EQL_u!id']:= nvhlpUser.HelpFieldValue['id'];
        log := log +' ,[�Ǽ���]:'+ nvhlpUser.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_u!id']:= '';
      end;

      if  (not (Trim(nvhlpTicketoutlets.Text) = '')) and  (nvhlpTicketoutlets.Id>0) then  //�Ǽ�վ��
      begin
        Params.ParamValues['filter_EQL_t!id']:= nvhlpTicketoutlets.HelpFieldValue['id'];
        log := log +' ,[�Ǽ�վ��]:'+nvhlpTicketoutlets.Text;
      end
    else
      begin
        Params.ParamValues['filter_EQL_t!id']:= '';
      end;

    if not (edtIP.Text = '') then
      begin
        Params.ParamValues['filter_LIKES_b!recordip']:= edtIP.Text ;
        log := log +' ,[�Ǽǻ���IP]'+edtIP.Text;
      end
    else
      begin
        Params.ParamValues['filter_LIKES_b!recordip']:= '';
      end;

   if (not (Trim(nvHcbbOrgnovahcbbtype.Text) = '')) and (nvHcbbOrgnovahcbbtype.ItemIndex>=0) then
    begin
      Params.ParamValues['filter_EQL_b!billtypeid']:= nvHcbbOrgnovahcbbtype.HelpFieldValue['id'];
      log := log +' ,[Ʊ������]'+nvHcbbOrgnovahcbbtype.Text;
    end
   else
    begin
      Params.ParamValues['filter_EQL_b!billtypeid']:= '';
    end;
    //���������־
    SysLog.WriteLog( '�ۺϲ�ѯ->��Ʊ�Ǽ����','��ѯ', '��ѯ������;'+log);
    Active:=true;
    log := '';
        dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
      dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ�Ǽ����ڣ�'+ formatdatetime('yyyy-mm-dd',dtpStartRecordtime.Date)
       +' ��'+formatdatetime('yyyy-mm-dd',dtpEndRecordtime.Date);

  end
end;

end.

