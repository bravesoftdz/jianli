unit UFrmGenExecutePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaListView,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmGenExecutePrice = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaHelpRoute: TNovaHelp;
    DTPBuildStartDay: TDateTimePicker;
    DTPBuildEndDay: TDateTimePicker;
    NovaHelpSchedule: TNovaHelp;
    NovaListSchedule: TNovaListView;
    Label5: TLabel;
    RbtnCurSchedule: TRadioButton;
    RbtnCurRoute: TRadioButton;
    RbtnCurOrg: TRadioButton;
    NovaEdtSEDays: TNovaEdit;
    Label6: TLabel;
    jcdsGenScheduleplan: TjsonClientDataSet;
    Label7: TLabel;
    Label8: TLabel;
    CbbOperType: TComboBox;
    LabInfo: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpRouteIdChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CbbOperTypeChange(Sender: TObject);
    procedure RbtnCurRouteClick(Sender: TObject);
    procedure RbtnCurOrgClick(Sender: TObject);
    procedure RbtnCurScheduleClick(Sender: TObject);
    procedure DTPBuildStartDayChange(Sender: TObject);
    procedure DTPBuildEndDayChange(Sender: TObject);
    procedure NovaEdtSEDaysChange(Sender: TObject);
  private
    { Private declarations }
     day:integer;
     log : String;
  public
    { Public declarations }
    scheduleplanlog: string;
    createby, routeid, orgid: int64;
  end;

var
  FrmGenExecutePrice: TFrmGenExecutePrice;

implementation

uses PubFn, Services, UFrmGenLog, UDMPublic;
{$R *.dfm}

procedure TFrmGenExecutePrice.bbtnSaveClick(Sender: TObject);
var
  operationtype, types: string;
  nResult: integer;
  typeid: int64;
begin
  inherited;
  if FormatDateTime('yyyymmdd',DTPBuildStartDay.Date)>
      FormatDateTime('yyyymmdd',DTPBuildEndDay.Date)  then
  begin
     SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
     DTPBuildEndDay.SetFocus;
     exit;
  end;
  if (DTPBuildEndDay.Date-trunc(now))>day then
  begin
     SysDialogs.ShowMessage('�����������ܳ���'+inttostr(day)+'�죡');
     DTPBuildEndDay.SetFocus;
     exit;
  end;
  typeid := 0;
  if RbtnCurOrg.Checked then
  begin
    types := '0';
    typeid := orgid;
  end
  else if RbtnCurRoute.Checked then
  begin
    if ((trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.Id = 0)) then
    begin
      SysDialogs.Warning('��ѡ����·��');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    types := '1';
    typeid := NovaHelpRoute.Id;
  end
  else
  begin
    if (NovaHelpSchedule.Id <= 0) and (NovaListSchedule.CheckedCount <= 0) then
    begin
      SysDialogs.Warning('��ѡ���Σ�');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    types := '2';
  end;
  if CbbOperType.ItemIndex = 1 then
  begin
    if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ð�θ����ڶε�Ӫ�˼ƻ���') then
      exit;
    operationtype := 'D' ;
    LabInfo.Caption:='����ɾ�����Ӫ�˼ƻ���Ϣ�����Եȡ�������';
  end
  else
  begin
    operationtype := 'C';
    LabInfo.Caption:='�������ɰ��Ӫ�˼ƻ���Ϣ�����Եȡ�������';
  end;
  LabInfo.Refresh;
  screen.Cursor := crHourGlass;

  with jcdsGenScheduleplan do
  begin
    try
      active := false;
      Params.ParamByName('scheduleplanlog.typeid').Value := typeid;
      if NovaListSchedule.CheckedCount <= 0 then
        Params.ParamByName('scheduleplanlog.scheduleids')
          .Value := '(' + inttostr(NovaHelpSchedule.Id) + ')'
      else
        Params.ParamByName('scheduleplanlog.scheduleids')
          .Value := '(' + NovaListSchedule.GetSelected + ')';
      Params.ParamByName('scheduleplanlog.type').Value := types;
      Params.ParamByName('scheduleplanlog.operationtype').Value :=
        operationtype;
      Params.ParamByName('scheduleplanlog.createby').Value := createby;

      Params.ParamByName('scheduleplanlog.startdate').Value := formatdatetime
        ('yyyy-mm-dd', DTPBuildStartDay.Date);
      Params.ParamByName('scheduleplanlog.enddate').Value := formatdatetime
        ('yyyy-mm-dd', DTPBuildEndDay.Date);
      Params.ParamByName('scheduleplanlog.ip').Value :=
        Sysinfo.LocalHostAddress;
      Params.ParamByName('scheduleplanlog.orgid').Value := orgid;
      Params.ParamByName('scheduleplanlog.userid').Value := createby;

      active := true;
      self.Enabled := false;
      nResult := Params.ParamByName('flag').Value;
      LabInfo.Caption:='';
      if nResult = 1 then
      begin
          log := '����Ӫ�˼ƻ���Ӫ����·='+NovaHelpRoute.Text+',ѡ������=';
          if RbtnCurSchedule.Checked then
            log := log + '��ǰѡ�а��'+NovaHelpSchedule.Text;
          if RbtnCurRoute.Checked then
            log := log + '����·���а��';
          if RbtnCurOrg.Checked then
            log := log + '���������а��';
          log := log + ',��������='+CbbOperType.Text+',��������='+formatdatetime
          ('yyyy-mm-dd', DTPBuildStartDay.Date)+'��'+formatdatetime
          ('yyyy-mm-dd', DTPBuildEndDay.Date)+',��='+NovaEdtSEDays.Text+'��';
           SysLog.WriteLog('Ʊ�۹�����>Ӫ�˼ƻ�����',CbbOperType.Text,log);
        jcdsGenScheduleplan.first;
        FrmGenLog := TFrmGenLog.Create(self);
        with FrmGenLog do
        begin
          Memo1.Clear;
          begin
            while not jcdsGenScheduleplan.Eof do
            begin
              Memo1.lines.Add(trim(fieldbyname('result').asstring) + #13);
              jcdsGenScheduleplan.next;
            end;
          end;
          scheduleplanlog := Memo1.Text;
          ShowModal;
        end;
      end;
      close;
      self.Enabled := true;
      screen.Cursor := crDefault;
    except
      on E: Exception do
      begin
        self.Enabled := true;
        screen.Cursor := crDefault;
        SysLog.WriteErr('Ӫ�˼ƻ�����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
  ModalResult := mrok;
end;

procedure TFrmGenExecutePrice.CbbOperTypeChange(Sender: TObject);
begin
  inherited;
  if (CbbOperType.ItemIndex = 0) then
  begin
    bbtnSave.Caption := '&S ��ʼ����';
  end
  else
  begin
    bbtnSave.Caption := '&D ��ʼɾ��';
  end;
end;

procedure TFrmGenExecutePrice.DTPBuildEndDayChange(Sender: TObject);
begin
  inherited;
  NovaEdtSEDays.Text:=inttostr(trunc(DTPBuildEndDay.Date-DTPBuildStartDay.Date)+1);
end;

procedure TFrmGenExecutePrice.DTPBuildStartDayChange(Sender: TObject);
begin
  inherited;
  NovaEdtSEDays.Text:=inttostr(trunc(DTPBuildEndDay.Date-DTPBuildStartDay.Date)+1);
end;
procedure TFrmGenExecutePrice.NovaEdtSEDaysChange(Sender: TObject);
begin
  inherited;
  if ((NovaEdtSEDays.Text='') or (NovaEdtSEDays.Text='0'))then
    NovaEdtSEDays.Text:='1';
  DTPBuildStartDay.OnChange:=nil;
  DTPBuildEndDay.OnChange:=nil;
  DTPBuildEndDay.Date:=DTPBuildStartDay.Date+(strtoint(NovaEdtSEDays.Text)-1);
  DTPBuildStartDay.OnChange:=DTPBuildStartDayChange;
  DTPBuildEndDay.OnChange:=DTPBuildEndDayChange;
end;
procedure TFrmGenExecutePrice.FormShow(Sender: TObject);
var i : Integer;
begin
  inherited;

  day:=StrToInt(getParametervalue('0009', Sysinfo.LoginUserInfo.OrgID));
  if NovaHelpSchedule.Text<>'' then
  begin
    with NovaListSchedule do
    begin
      for i := 0 to GetCount - 1 do
        begin

          if NovaHelpSchedule.Text = (NovaListSchedule.Items.Item[i].SubItems.Strings[0]) then
          begin
            NovaListSchedule.Items.Item[i].Checked:=True;
          end;
        end;
    end;
  end;
end;

procedure TFrmGenExecutePrice.NovaHelpRouteIdChange(Sender: TObject);
begin
  inherited;
  with NovaListSchedule do
  begin
    active := false;
    Params.ParamValues['routeid'] := NovaHelpRoute.Id;
    active := true;
  end;
end;

procedure TFrmGenExecutePrice.RbtnCurOrgClick(Sender: TObject);
begin
  inherited;
  NovaListSchedule.CheckAll(true);
  GroupBox1.Enabled := false;
end;

procedure TFrmGenExecutePrice.RbtnCurRouteClick(Sender: TObject);
begin
  inherited;
  NovaListSchedule.CheckAll(true);
  GroupBox1.Enabled := false;

end;

procedure TFrmGenExecutePrice.RbtnCurScheduleClick(Sender: TObject);
begin
  inherited;
  GroupBox1.Enabled := true;
end;



end.
