unit UFrmScheduleRouteBalanceRpt;

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
  TfrmScheduleRouteBalanceRpt = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    nvhlpvehicleno: TNovaHelp;
    lblendstationname: TLabel;
    nvhlpendstation: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ChangeDateOrder(dates: TDateTime);
  public
    { Public declarations }
  end;

var
  frmScheduleRouteBalanceRpt: TfrmScheduleRouteBalanceRpt;

implementation

uses SystemInstance, SysInfoIntf,PubFn,DateUtils;
{$R *.dfm}

procedure TfrmScheduleRouteBalanceRpt.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmScheduleRouteBalanceRpt.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  //dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmScheduleRouteBalanceRpt.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  peplodistance1: double;
  alldistance1: Int64;
  allseatnum1: Int64;
  checkticketnum1: Int64;
  truetake: double;
  _truetake: double;
  aa,log:string;
begin
  inherited;
  if (nvckbOrgid.GetCount = 0) or (nvckbOrgid.Text = '') then
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
  if Trunc(dtpenddate.Date-dtpstartdate.Date)>=31
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ�������ܳ���31��,������ѡ��!');
    exit;
  end;
  ChangeDateOrder(dtpstartdate.Date);
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    if nvhlpvehicleno.Id>0 then
      Params.ParamValues['vehicleid'] := nvhlpvehicleno.Id
    else
      Params.ParamValues['vehicleid'] := '';
    if nvhlpendstation.Id > 0 then
    Params.ParamValues['stationid'] :=nvhlpendstation.HelpFieldValue['id']
    else
    Params.ParamValues['stationid'] :='';


    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Active := True;

     dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

    log := '��ѯ�����У��������ڴ� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',������'+nvckbOrgid.Text;
    if nvhlpvehicleno.Id <> 0 then
      log := log +',����:'+ nvhlpvehicleno.Text;
    if nvhlpendstation.Id <> 0 then
      log := log +',��վ:'+ nvhlpendstation.Text;
    log := log+'����ѯ���:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->���߽���ͳ�Ʊ�','��ѯ',log);
  end;

end;

procedure TfrmScheduleRouteBalanceRpt.ChangeDateOrder(dates:TDateTime);
var I,orderDate,endDate,lastDateOfmm,temp:Integer;
    curcolumn:TColumnTitleEh;
begin
  inherited;

//  SysDialogs.ShowMessage('ѡ�����ڵ��·ݣ�'+FormatDateTime('m',dtpstartdate.Date));
//  SysDialogs.ShowMessage('ѡ�������'+FormatDateTime('d',dtpstartdate.Date));
//  SysDialogs.ShowMessage('�������һ�죺'+FormatDateTime('dd',EndOfTheMonth(dtpstartdate.Date)));
  //ѡ��Ŀ�ʼ����
  orderDate := StrToInt(FormatDateTime('dd',dtpstartdate.Date));
  //ѡ��Ľ�������
  endDate := StrToInt(FormatDateTime('dd',dtpenddate.Date));
  //ѡ��Ŀ�ʼ���ڵ������һ��
  lastDateOfmm := StrToInt(FormatDateTime('dd',EndOfTheMonth(dtpstartdate.Date)));
  temp :=0;
  // ѡ�������������ͬһ�·�
 if FormatDateTime('m',dtpstartdate.Date)=FormatDateTime('m',dtpenddate.Date)
 then
 begin
  for I := orderDate to endDate do
  begin
    curcolumn :=dbgrdhResult.Columns[3+temp].Title;
    curcolumn.Caption := IntToStr(orderDate)+'||����';
    dbgrdhResult.Columns[3+temp].FieldName := 'date'+IntToStr(orderDate);
    dbgrdhResult.Columns[3+temp].Visible := True;
    temp := temp+1 ;
    orderDate := orderDate+1;
    end;
  //��ѡ����������ⲻ��Ҫ��ʾ������
  if temp<=31 then
  begin
    for I := temp to 31 do
    begin
       dbgrdhResult.Columns[3+temp].Visible :=False;
       temp := temp+1;
    end;
  end;
 end
 else
 begin
  for I := orderDate to lastDateOfmm do
  begin
    curcolumn :=dbgrdhResult.Columns[3+temp].Title;
    curcolumn.Caption := IntToStr(orderDate)+'||����';
    dbgrdhResult.Columns[3+temp].FieldName := 'date'+IntToStr(orderDate);
    dbgrdhResult.Columns[3+temp].Visible := True;
    temp := temp+1 ;
    orderDate := orderDate+1;
    end;
    orderDate :=1;
   for I := orderDate to endDate do
  begin
    curcolumn :=dbgrdhResult.Columns[3+temp].Title;
    curcolumn.Caption := IntToStr(orderDate)+'||����';
    dbgrdhResult.Columns[3+temp].FieldName := 'Bdate'+IntToStr(orderDate);
    dbgrdhResult.Columns[3+temp].Visible := True;
    temp := temp+1 ;
    orderDate := orderDate+1;
    end;
   //��ѡ���������ⲻ��Ҫ��ʾ������
  if temp<=31 then
  begin
    for I := temp to 31 do
    begin
       dbgrdhResult.Columns[3+temp].Visible :=False;
       temp := temp+1;
    end;
  end;

 end;
end;

end.
