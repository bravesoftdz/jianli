unit UFrmSchedulemergeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls, NovaEdit,
  NovaHelp, Buttons, ExtCtrls, ComCtrls, NovaHComboBox, ImgList,SeatPlan,
   Generics.Collections;

type
  TFrmSchedulemergeEdit = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    lbl1: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    lbl12: TLabel;
    dtpolddepartdate: TDateTimePicker;
    edtoldroute: TNovaEdit;
    edtolddeparttime: TNovaEdit;
    cbbschedule: TNovaHelp;
    GroupBox2: TGroupBox;
    lbl2: TLabel;
    lbl5: TLabel;
    lbl13: TLabel;
    dtpdepartdate: TDateTimePicker;
    edtdeparttime: TNovaEdit;
    cbbnewscheduleplanid: TNovaHelp;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    scrlbxSeatPlan: TScrollBox;
    scrlbxnewSeatPlan: TScrollBox;
    Label1: TLabel;
    NovaEdtNewRoute: TNovaEdit;
    Label2: TLabel;
    CobReason: TComboBox;
    jcdsResultSchedulemergeSave: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpolddepartdateChange(Sender: TObject);
    procedure dtpdepartdateChange(Sender: TObject);
    procedure cbbscheduleIdChange(Sender: TObject);
    procedure cbbnewscheduleplanidIdChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    log : String;
    oldSeatPlan: TSeatPlanSelect;
    oldselectSeatStatus: TList<string>;
    oldseatpichelp: TSeatPicHelp;
    newSeatPlan: TSeatPlanSelect;
    newselectSeatStatus: TList<string>;
    newseatpichelp: TSeatPicHelp;

    { Private declarations }
  public
    { Public declarations }
    sign : Boolean;
    createby, createtime, parameter : string;
    id : Int64;

  end;

var
  FrmSchedulemergeEdit: TFrmSchedulemergeEdit;

implementation

uses Services, PubFn;
{$R *.dfm}



procedure TFrmSchedulemergeEdit.bbtnSaveClick(Sender: TObject);
var
  nResult,i,oldselects,newselects: Integer;
  sResult,oldselectseats,newselectseats: string;
begin
  inherited;
  if dtpolddepartdate.Date > dtpdepartdate.Date then
  begin
    SysDialogs.ShowMessage('计划并入班次发车日期不能小于原班次发车日期！');
    Exit;
  end;
  if cbbschedule.Id = 0 then
  begin
    SysDialogs.ShowMessage('请选择被并班次！');
    cbbschedule.SetFocus;
    Exit;
  end;
  if cbbnewscheduleplanid.Id = 0 then
  begin
    SysDialogs.ShowMessage('请选择并入班次！');
    cbbnewscheduleplanid.SetFocus;
    Exit;
  end;
  if Trim(CobReason.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择并班原因！');
    CobReason.SetFocus;
    Exit;
  end;
  if cbbschedule.Id = cbbnewscheduleplanid.Id then
  begin
    SysDialogs.ShowMessage('相同班次不能进行并班！');
    cbbnewscheduleplanid.SetFocus;
    Exit;
  end;
  if (oldSeatPlan.selectedSeats=nil) or (oldSeatPlan.selectedSeats.Count=0) then
  begin
      for I := 1 to oldSeatPlan.seatsStatus.Count  do
      begin
         if oldSeatPlan.seatsStatus.Items[i]='2' then
         begin
           oldselectseats:=oldselectseats+inttostr(i)+',';
           oldselects:=oldselects+1;
         end;
      end;
  end
  else
  begin
    for i := 0 to oldSeatPlan.selectedSeats.Count - 1 do
    begin
        oldselectseats := oldselectseats + IntToStr(oldSeatPlan.selectedSeats.Items[i]) + ',';
    end;
    oldselects:=oldSeatPlan.selectedSeats.Count;
  end;

  if (newSeatPlan.selectedSeats=nil) or (newSeatPlan.selectedSeats.Count=0) then
  begin
      for I := 1 to newSeatPlan.seatsStatus.Count  do
      begin
         if newSeatPlan.seatsStatus.Items[i]='0' then
         begin
           newselectseats:=newselectseats+inttostr(i)+',';
           newselects:=newselects+1;
         end;
      end;
  end
  else
  begin
    for i := 0 to newSeatPlan.selectedSeats.Count - 1 do
    begin
        newselectseats := newselectseats + IntToStr(newSeatPlan.selectedSeats.Items[i]) + ',';
    end;
    newselects:=newSeatPlan.selectedSeats.Count;
  end;
  if (oldselects=0) or (oldselectseats='') then
  begin
    SysDialogs.ShowMessage('被并班次无可并座位！');
    cbbschedule.SetFocus;
    Exit;
  end;

  if (oldselects>newSeatPlan.selectSeatNum) then
  begin
    SysDialogs.Warning('并入班次座位数不足！');
    cbbnewscheduleplanid.SetFocus;
    Exit;
  end;

  if (edtoldroute.Text<>NovaEdtNewRoute.Text) then
  begin
    if not SysDialogs.Confirm('信息确认','你确认对2个不同线路的班次进行并班？') then
    begin
      cbbnewscheduleplanid.SetFocus;
      Exit;
    end;
  end;
  //SysDialogs.ShowMessage(oldselectseats);
  //SysDialogs.ShowMessage(newselectseats);

  with jcdsResultSchedulemergeSave do
  begin
    Close;
    Params.ParamByName('schedulemerge.scheduleplanid').Value := cbbnewscheduleplanid.HelpFieldValue['id'];
    Params.ParamByName('schedulemerge.oldscheduleplanid').Value := cbbschedule.HelpFieldValue['id'];
    Params.ParamByName('schedulemerge.reason').Value := Trim(CobReason.Text);
    Params.ParamByName('schedulemerge.newscheduleid').Value := cbbnewscheduleplanid.HelpFieldValue['scheduleid'];
    Params.ParamByName('schedulemerge.oldscheduleid').Value := cbbschedule.HelpFieldValue['scheduleid'];
    Params.ParamByName('schedulemerge.departdate').Value := FormatDateTime('yyyy-mm-dd',dtpdepartdate.DateTime);
    Params.ParamByName('schedulestatuslog.departdate').Value := FormatDateTime('yyyy-mm-dd',dtpolddepartdate.DateTime);
    Params.ParamByName('schedulestatuslog.scheduleid').Value := cbbschedule.HelpFieldValue['scheduleid'];
    Params.ParamByName('schedulemerge.createby').Value := createby;
    Params.ParamByName('oldseats').Value := oldselectseats;
    Params.ParamByName('newseats').Value := newselectseats;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbschedule.SetFocus;
      end
      else
      begin
        log := '班次并班：原班次发车日期='+datetostr(dtpolddepartdate.Date)+',原计划班次='+cbbschedule.Text
        +',座位号:'+oldselectseats
        +',计划并入班次发车日期='+datetostr(dtpdepartdate.Date)+',计划并入班次='+cbbnewscheduleplanid.Text
        +',座位号:'+newselectseats;
        SysLog.WriteLog('调度管理->班次并班','并班',log);
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次并班失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmSchedulemergeEdit.dtpdepartdateChange(Sender: TObject);
begin
  inherited;
  with cbbnewscheduleplanid do
  begin
    Params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpdepartdate.Date);
  end;
  cbbnewscheduleplanid.Text := '';
  cbbnewscheduleplanid.Id:=0;
end;

procedure TFrmSchedulemergeEdit.dtpolddepartdateChange(Sender: TObject);
begin
  inherited;
  with cbbschedule do
  begin
    Params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpolddepartdate.Date);
  end;
  cbbschedule.Text := '';
  cbbschedule.Id:=0;
end;

procedure TFrmSchedulemergeEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Assigned(oldselectSeatStatus) then
     oldselectSeatStatus.Free;
  if Assigned(oldseatpichelp) then
    oldseatpichelp.Free;

  if Assigned(newselectSeatStatus) then
     newselectSeatStatus.Free;
  if Assigned(newseatpichelp) then
    newseatpichelp.Free;
  inherited;

end;

procedure TFrmSchedulemergeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpolddepartdate.DateTime := Now();
  dtpdepartdate.DateTime := Now();

  with cbbschedule do
  begin
    Params.ParamValues['filter_INS_t!orgid'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpolddepartdate.Date);
  end;

  with cbbnewscheduleplanid do
  begin
    Params.ParamValues['filter_INS_t!orgid'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpdepartdate.Date);
  end;


end;

procedure TFrmSchedulemergeEdit.FormShow(Sender: TObject);
begin
  inherited;
  parameter := getParametervalue('2014', SysInfo.LoginUserInfo.OrgID);

  oldseatpichelp := TSeatPicHelp.Create;
  oldselectSeatStatus := TList<string>.Create;
  oldselectSeatStatus.Add('2');
  oldSeatPlan := TSeatPlanSelect.Create(self);
  oldSeatPlan.defaultcellwidth := 54;
  oldSeatPlan.defaultcellheight := 48;
  oldSeatPlan.defaultcolcount := 11;
  oldSeatPlan.setShowspacename(false);
  oldSeatPlan.selectSeatStatus := oldselectSeatStatus;
  //oldSeatPlan.ShowHint:=true;
  oldSeatPlan.setParent(scrlbxSeatPlan);
  scrlbxSeatPlan.Visible:=false;

  newseatpichelp := TSeatPicHelp.Create;
  newselectSeatStatus := TList<string>.Create;
  newselectSeatStatus.Add('0');
  newSeatPlan := TSeatPlanSelect.Create(self);
  newSeatPlan.defaultcellwidth := 54;
  newSeatPlan.defaultcellheight := 48;
  newSeatPlan.defaultcolcount := 11;
  newSeatPlan.setShowspacename(false);
  newSeatPlan.selectSeatStatus := newselectSeatStatus;
  newSeatPlan.setParent(scrlbxnewSeatPlan);
  scrlbxnewSeatPlan.Visible:=false;

  cbbschedule.SetFocus;
end;

procedure TFrmSchedulemergeEdit.cbbscheduleIdChange(Sender: TObject);
var
  scheduleplanid:int64;
  selectcount,i:integer;
begin
  inherited;
  if cbbschedule.Id>0 then
  begin
      scheduleplanid:=cbbschedule.Id ;
      edtolddeparttime.Text:= cbbschedule.HelpFieldValue['departtime'];
      edtoldroute.Text:= cbbschedule.HelpFieldValue['routename'];
      oldseatpichelp.qryScheduleSeatstatus(scheduleplanid);
      oldseatpichelp.qrySeatstatus(scheduleplanid,true);
      oldSeatPlan.seatsStatus:= oldseatpichelp.seatsStatus;
      oldSeatPlan.seatshint := oldseatpichelp.seatshint;
      oldSeatPlan.seatstype:=oldseatpichelp.seatstype;
      if Assigned(oldSeatPlan.selectedSeats) then
         oldSeatPlan.selectedSeats.Clear;
      selectcount:=0;
      for I := 1 to oldSeatPlan.seatsStatus.Count  do
      begin
         if oldSeatPlan.seatsStatus.Items[i]='2' then
           selectcount:=selectcount+1;
      end;
      oldSeatPlan.selectSeatNum:=selectcount;
      oldSeatPlan.seatsTickettype := oldseatpichelp.seatsTickettype;
      oldSeatPlan.seatsreachstationname := oldseatpichelp.seatStation;
      if not scrlbxSeatPlan.Visible then
      begin
        scrlbxSeatPlan.Visible:=true;
      end;
      scrlbxSeatPlan.Refresh;
  end;
end;

procedure TFrmSchedulemergeEdit.cbbnewscheduleplanidIdChange(Sender: TObject);
var
  scheduleplanid:int64;
    selectcount,i:integer;
begin
  inherited;
  if cbbnewscheduleplanid.Id>0 then
  begin
      scheduleplanid:=cbbnewscheduleplanid.Id ;
      edtdeparttime.Text:= cbbnewscheduleplanid.HelpFieldValue['departtime'];
      NovaEdtNewRoute.Text:= cbbnewscheduleplanid.HelpFieldValue['routename'];
      newseatpichelp.qryScheduleSeatstatus(scheduleplanid);
      newseatpichelp.qrySeatstatus(scheduleplanid,true);
      newSeatPlan.seatsStatus:= newseatpichelp.seatsStatus;
      newSeatPlan.seatshint := newseatpichelp.seatshint;
      newSeatPlan.selectSeatStatus := newselectSeatStatus;
      newSeatPlan.seatstype:=newseatpichelp.seatstype;
      if Assigned(newSeatPlan.selectedSeats) then
         newSeatPlan.selectedSeats.Clear;
      selectcount:=0;
      for I := 1 to newSeatPlan.seatsStatus.Count  do
      begin
         if newSeatPlan.seatsStatus.Items[i]='0' then
           selectcount:=selectcount+1;
      end;
      newSeatPlan.selectSeatNum:=selectcount;
      newSeatPlan.seatsTickettype := newseatpichelp.seatsTickettype;
      newSeatPlan.seatsreachstationname := newseatpichelp.seatStation;
      if not scrlbxnewSeatPlan.Visible then
      begin
        scrlbxnewSeatPlan.Visible:=true;
      end;
      scrlbxnewSeatPlan.Refresh;
  end;

end;

end.
