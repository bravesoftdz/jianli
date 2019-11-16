unit UFrmSchedulestatusStop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaListView, NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet;

type
  TFrmSchedulestatusStop = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    NovaHelpRoute: TNovaHelp;
    NovaHelpSchedule: TNovaHelp;
    lbl3: TLabel;
    rbRbtnCurSchedule: TRadioButton;
    rbCurRoute: TRadioButton;
    rbCurOrg: TRadioButton;
    dtpStartDay: TDateTimePicker;
    dtpEndDay: TDateTimePicker;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    NovaEdtSEDays: TNovaEdit;
    lbl7: TLabel;
    grp1: TGroupBox;
    NovaListSchedule: TNovaListView;
    jcsdStopScheduleplan: TjsonClientDataSet;
    cbbOpertype: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    lblstation: TLabel;
    nvhlpendstation: TNovaHelp;
    Label3: TLabel;
    Label5: TLabel;
    NovaEdtRemark: TNovaEdit;
    Label4: TLabel;
    Label6: TLabel;
    cbbReportName: TComboBox;
    procedure NovaHelpRouteIdChange(Sender: TObject);
    procedure rbCurOrgClick(Sender: TObject);
    procedure rbCurRouteClick(Sender: TObject);
    procedure rbRbtnCurScheduleClick(Sender: TObject);
    procedure dtpEndDayChange(Sender: TObject);
    procedure NovaEdtSEDaysChange(Sender: TObject);
    procedure dtpStartDayChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure cbbOpertypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHelpScheduleIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    orgid:Int64;
  end;

var
  FrmSchedulestatusStop: TFrmSchedulestatusStop;

implementation
uses PubFn, Services,UFrmSchedulestatusLog,  UDMPublic;
{$R *.dfm}

procedure TFrmSchedulestatusStop.bbtnSaveClick(Sender: TObject);
var
  types: string;
  nResult: integer;
  typeid: int64;
begin
  inherited;

  if cbbOpertype.ItemIndex<0 then
  begin
    SysDialogs.Warning('请选择操作类型！');
    cbbOpertype.SetFocus;
    Exit;
  end;
  if formatdatetime('yyyymmdd',DTPStartDay.Date )>formatdatetime('yyyymmdd',DTPEndDay.Date) then
  begin
    SysDialogs.Warning('开始日期不能大于结束日期！');
    exit;
  end;
  typeid := 0;
  if rbCurOrg.Checked then
  begin
    types := '0';
    typeid := SysInfo.LoginUserInfo.OrgID;
  end
  else if rbCurRoute.Checked then
  begin
    if ((trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.Id = 0)) then
    begin
      SysDialogs.Warning('请选择线路！');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    types := '2';//转为取班次ID
    typeid := NovaHelpRoute.Id;
  end
  else
  begin
    if (NovaHelpSchedule.Id <= 0) and (NovaListSchedule.CheckedCount <= 0) then
    begin
      SysDialogs.Warning('请选择班次！');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    types := '2';
  end;
//  if cbbOpertype.ItemIndex=0 then
//  begin
    if Trim(cbbReportName.Text)='' then
    begin
      SysDialogs.Warning('请输入申报人！');
      cbbReportName.SetFocus;
      exit;
    end;
//  end;
  screen.Cursor := crHourGlass;
  with jcsdStopScheduleplan do
  begin
    try
      active := false;
      if cbbOpertype.ItemIndex=0 then
        Params.ParamByName('scheduleplanlog.operationtype').Value := 'S'
      else
        Params.ParamByName('scheduleplanlog.operationtype').Value := 'C' ;

      Params.ParamByName('scheduleplanlog.typeid').Value := typeid;
      if NovaListSchedule.CheckedCount <= 0 then
        Params.ParamByName('scheduleplanlog.scheduleids')
          .Value := '(' + inttostr(NovaHelpSchedule.Id) + ')'
      else
        Params.ParamByName('scheduleplanlog.scheduleids')
          .Value := '(' + NovaListSchedule.GetSelected + ')';
      Params.ParamByName('scheduleplanlog.type').Value := types;
      Params.ParamByName('scheduleplanlog.createby').Value := SysInfo.LoginUserInfo.UserID;
      Params.ParamByName('scheduleplanlog.startdate').Value := formatdatetime
        ('yyyy-mm-dd', DTPStartDay.Date);
      Params.ParamByName('scheduleplanlog.enddate').Value := formatdatetime
        ('yyyy-mm-dd', DTPEndDay.Date);
      Params.ParamByName('scheduleplanlog.ip').Value := Sysinfo.LocalHostAddress;
      Params.ParamByName('scheduleplanlog.departstationid').Value := SysInfo.LoginUserInfo.StationID;
      Params.ParamByName('scheduleplanlog.orgid').Value := SysInfo.LoginUserInfo.OrgID;
      Params.ParamByName('vehiclelost.reason').Value := NovaEdtRemark.Text;
      if (nvhlpendstation.Text<>'') and (nvhlpendstation.Id>0) then
        Params.ParamByName('vehiclelost.vehicle.id').Value :=nvhlpendstation.Id
      else
        Params.ParamByName('vehiclelost.vehicle.id').Value :=null;
      if cbbOpertype.ItemIndex=0 then
        Params.ParamByName('vehiclelost.reportname').Value :=cbbReportName.Text
      else
        Params.ParamByName('vehiclelost.reportname').Value :=null;

      active := true;
      self.Enabled := false;
      nResult := Params.ParamByName('flag').Value;
      if nResult = 1 then
      begin
        jcsdStopScheduleplan.first;
        FrmSchedulestatusLog := TFrmSchedulestatusLog.Create(self);
        with FrmSchedulestatusLog do
        begin
          Memo1.Clear;
          begin
            while not jcsdStopScheduleplan.Eof do
            begin
              Memo1.lines.Add(trim(fieldbyname('result').asstring) + #13);
              jcsdStopScheduleplan.next;
            end;
          end;
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
        SysLog.WriteErr('班次停班处理失败：' + E.Message);
      end;
    end;
  end;
  ModalResult := mrok;

end;

procedure TFrmSchedulestatusStop.cbbOpertypeChange(Sender: TObject);
begin
  inherited;
    Self.Caption:=cbbOpertype.Text;
    //班次停班处理 ,恢复班次售票
  { if cbbOpertype.ItemIndex=0 then
   begin
     lblstation.Visible:=true;
     nvhlpendstation.Visible:=true;
     Label5.Visible:=true;
     Label4.Visible:=true;
     NovaEdtRemark.Visible:=true;
     cbbReportName.Visible:=true;
   end
   else
   begin
     lblstation.Visible:=False;
     nvhlpendstation.Visible:=False;
     Label5.Visible:=False;
     Label4.Visible:=False;
     NovaEdtRemark.Visible:=False;
     cbbReportName.Visible:=False;
   end;  }
end;

procedure TFrmSchedulestatusStop.dtpEndDayChange(Sender: TObject);
begin
  inherited;
  NovaEdtSEDays.Text:=inttostr(trunc(dtpEndDay.Date-dtpStartDay.Date+1));
end;

procedure TFrmSchedulestatusStop.dtpStartDayChange(Sender: TObject);
begin
  inherited;
  NovaEdtSEDays.Text:=inttostr(trunc(dtpEndDay.Date-dtpStartDay.Date));
end;

procedure TFrmSchedulestatusStop.FormShow(Sender: TObject);
var i : Integer;
begin
  inherited;
  cbbOpertypeChange(sender);
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

procedure TFrmSchedulestatusStop.NovaEdtSEDaysChange(Sender: TObject);
begin
  inherited;
  if ((NovaEdtSEDays.Text='') or (NovaEdtSEDays.Text='0'))then
    NovaEdtSEDays.Text:='1';
  dtpStartDay.OnChange:=nil;
  dtpEndDay.OnChange:=nil;
  dtpEndDay.Date:=dtpStartDay.Date+(strtoint(NovaEdtSEDays.Text)-1);
  dtpStartDay.OnChange:=dtpStartDayChange;
  dtpEndDay.OnChange:=dtpEndDayChange;
end;

procedure TFrmSchedulestatusStop.NovaHelpRouteIdChange(Sender: TObject);
begin
  inherited;
  with NovaListSchedule do
  begin
    active := false;
    Params.ParamValues['filter_EQL_r!id'] := NovaHelpRoute.Id;
    active := true;
  end;
end;

procedure TFrmSchedulestatusStop.NovaHelpScheduleIdChange(Sender: TObject);
var i:Integer;
begin
  inherited;
  with NovaListSchedule do
  begin
    for i := 0 to GetCount - 1 do
    begin
       NovaListSchedule.Items.Item[i].Checked:=false;
       if NovaHelpSchedule.Text = NovaListSchedule.Items.Item[i].SubItems.Strings[0] then
       begin
         NovaListSchedule.Items.Item[i].Checked:=True;
       end;
    end;
  end;
end;

procedure TFrmSchedulestatusStop.rbCurOrgClick(Sender: TObject);
begin
  inherited;
  NovaListSchedule.CheckAll(true);
  grp1.Enabled := false;
end;

procedure TFrmSchedulestatusStop.rbCurRouteClick(Sender: TObject);
begin
  inherited;
  NovaListSchedule.CheckAll(true);
  grp1.Enabled := false;
end;

procedure TFrmSchedulestatusStop.rbRbtnCurScheduleClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  grp1.Enabled := true;
  with NovaListSchedule do
  begin
    for i := 0 to GetCount - 1 do
    begin
        NovaListSchedule.Items.Item[i].Checked:=False;
        if NovaHelpSchedule.Text=NovaListSchedule.Items.Item[i].SubItems.Strings[0] then
        begin
          NovaListSchedule.Items.Item[i].Checked:=True;
        end;

    end;
  end;
end;

end.
