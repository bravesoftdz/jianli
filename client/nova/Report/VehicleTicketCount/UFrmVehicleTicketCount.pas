unit UFrmVehicleTicketCount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmVehicleTicketCount = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    lbl2: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlpdepartstation: TNovaHelp;
    lbl3: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    Label1: TLabel;
    Label2: TLabel;
    nvhlpvehicletype: TNovaHelp;
    nvhlpunit: TNovaHelp;
    lbl4: TLabel;
    cbbSellOrgid: TNovaCheckedComboBox;
    Label3: TLabel;
    nvhlpendstation: TNovaHelp;
    lbl7: TLabel;
    dtpBselldate: TDateTimePicker;
    lbl14: TLabel;
    dtpEselldate: TDateTimePicker;
    chkEmpty: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleTicketCount: TFrmVehicleTicketCount;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmVehicleTicketCount.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True  then
    begin
       dtpEselldate.Checked := True;
    end;
   if  dtpBselldate.Checked =False then
    begin
       dtpEselldate.Checked := False;
    end;
end;

procedure TFrmVehicleTicketCount.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True  then
  begin
     dtpBselldate.Checked := True;
  end;
 if  dtpEselldate.Checked =False then
  begin
     dtpBselldate.Checked := False;
  end;
end;

procedure TFrmVehicleTicketCount.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  nvckbOrgid.Active := True;
  dtpBselldate.DateTime := Now;
  dtpEselldate.DateTime := Now;
  nvckbOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
  cbbSellOrgid.Active := True;
  cbbSellOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmVehicleTicketCount.tbtnFilterClick(Sender: TObject);
var allTicketnum, allseatnum, allTicketdistance, allseatnumdistance : Int64;
    soldratio, disratio : Double;
    log:string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  if dtpBselldate.Checked then
  begin
    if FormatDateTime('yyyymmdd', dtpBselldate.Date) >
      FormatDateTime('yyyymmdd', dtpEselldate.Date) then
    begin
      SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
    end;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['sellorgid'] := cbbSellOrgid.GetSelectID;
    Params.ParamValues['departdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if dtpBselldate.Checked then
    begin
      Params.ParamValues['selldate'] :=  formatdatetime('yyyy-mm-dd',dtpBselldate.DateTime) + ' 00:00:01';
      Params.ParamValues['sellenddate'] :=  formatdatetime('yyyy-mm-dd',dtpEselldate.DateTime) + ' 23:59:59';  //��Ʊ����
    end
    else
    begin
      Params.ParamValues['selldate'] :='';
      Params.ParamValues['sellenddate'] :='';
    end;
    if Trim(nvhlpdepartstation.Text) = '' then
      Params.ParamValues['departstation'] := 0
    else
      Params.ParamValues['departstation'] := nvhlpdepartstation.Id;
    if Trim(nvhlpschedule.Text) = '' then
      Params.ParamValues['scheduleid'] := 0
    else
      Params.ParamValues['scheduleid'] := nvhlpschedule.Id;
    if Trim(nvhlproute.Text) = '' then
      Params.ParamValues['routeid'] := 0
    else
      Params.ParamValues['routeid'] := nvhlproute.Id;
    if Trim(nvhlpunit.Text) = '' then
      Params.ParamValues['unitid'] := 0
    else
      Params.ParamValues['unitid'] := nvhlpunit.Id;
    if Trim(nvhlpvehicletype.Text) = '' then
      Params.ParamValues['vehicletypeid'] := 0
    else
      Params.ParamValues['vehicletypeid'] := nvhlpvehicletype.Id;
    if Trim(nvhlpendstation.Text) = '' then
      Params.ParamValues['stationid'] := 0
    else
      Params.ParamValues['stationid'] := nvhlpendstation.Id;
    if chkEmpty.Checked then
      Params.ParamValues['isEmpty'] := True
    else
      params.ParamValues['isEmpty'] := False;
    Active := True;
    if recordcount > 0 then
    begin
      allTicketnum :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['soldeatnum']));
      allseatnum :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['seatnum']));
      allTicketdistance :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['solddistance']));
      allseatnumdistance :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['seatdistance']));
      if allTicketnum>0 then
      begin
        soldratio:= roundEx((allTicketdistance * 100 / allseatnumdistance), 2)   ;
        dbgrdhResult.FieldColumns['solddistance'].Footer.Value :=floattostr(soldratio)+'%';
        disratio := roundEx(allTicketnum * 100 / allseatnum, 2);
        dbgrdhResult.FieldColumns['seatdistance'].Footer.Value :=floattostr(disratio)+'%';
      end
      else
      begin
        dbgrdhResult.FieldColumns['solddistance'].Footer.Value :='0';

        dbgrdhResult.FieldColumns['seatdistance'].Footer.Value :='0';
      end;
    end
    else
    begin
      dbgrdhResult.FieldColumns['soldratio'].Footer.Value :='0';
      dbgrdhResult.FieldColumns['disratio'].Footer.Value :='0';
    end;
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)+','
      +',[��Ʊ����]��'+formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
      +'��'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[��λ���]��'+nvckbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log := log+',[��·]��'+nvhlpRoute.Text;
    if nvhlpschedule.Id <> 0 then
      log := log+',[��κ�]��'+nvhlpschedule.Text;
    if nvhlpunit.Id <>0 then
      log := log +',[Ӫ�˵�λ]��'+ nvhlpunit.Text;
    if nvhlpvehicletype.Id <>0 then
      log := log +',[�ƻ�����]��'+ nvhlpvehicletype.Text;
    if nvhlpdepartstation.Id  <>0 then
      log := log +',[�˳�վ]:'+ nvhlpdepartstation.Text;
    if Trim(cbbSellOrgid.GetSelectID) <>'' then
      log := log +',[��Ʊ����]:'+ cbbSellOrgid.Text;
    if nvhlpendstation.Id <>0 then
      log := log +',[����վ]:'+ nvhlpendstation.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->������Ʊ����ͳ��','��ѯ',log);

  end;
end;

end.
