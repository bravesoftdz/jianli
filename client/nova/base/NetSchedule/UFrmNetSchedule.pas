unit UFrmNetSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmNetSchedule = class(TSimpleCRUDForm)
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    Splitter2: TSplitter;
    Panel4: TPanel;
    ilsmalltools: TImageList;
    gbroutestop: TGroupBox;
    dbgrdhroutestop: TNvDbgridEh;
    tlbstop: TToolBar;
    tbtn2: TToolButton;
    tbtnaddstop: TToolButton;
    tbtn7: TToolButton;
    tbtnUpdatestop: TToolButton;
    tbtn8: TToolButton;
    tbtndelstop: TToolButton;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    lbl1: TLabel;
    nvcbbOrgid: TNovaCheckedComboBox;
    jscdQryOtherSchedule: TjsonClientDataSet;
    DataSource1: TDataSource;
    jscdQryStation: TjsonClientDataSet;
    DataSource2: TDataSource;
    jscdScheduledetailid: TjsonClientDataSet;
    Label8: TLabel;
    NHelpRoute: TNovaHelp;
    jscdDelNetSchedule: TjsonClientDataSet;
    jscdDelSchedulestop: TjsonClientDataSet;
    procedure FormResize(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnaddstopClick(Sender: TObject);
    procedure tbtndelstopClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
  private
    { Private declarations }
        procedure QryOtherSchedule(netscheduleid:int64);
        procedure QrySchedulestop(netscheduleid:int64);

  public
    { Public declarations }
  end;

var
  FrmNetSchedule: TFrmNetSchedule;

implementation

uses UDMPublic, UFrmNetScheduleStation,Services, PubFn, UFrmNetScheduleAdd;
{$R *.dfm}

procedure TFrmNetSchedule.FormResize(Sender: TObject);
begin
  inherited;
  Panel2.Width := self.Width div 2;
  Panel3.Height := Panel2.Height div 3;
end;

procedure TFrmNetSchedule.FormShow(Sender: TObject);
begin
  inherited;
  nvcbbOrgid.Active:=false;
  nvcbbOrgid.Active:=true;
end;

procedure TFrmNetSchedule.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount=0 then
  begin
    exit;
  end;
 QryOtherSchedule(jcdsResult.FieldByName('id').AsLargeInt);
 QrySchedulestop(jcdsResult.FieldByName('id').AsLargeInt);
end;

procedure TFrmNetSchedule.QryOtherSchedule(netscheduleid: int64);
begin
  with jscdQryOtherSchedule do
  begin
    Active := false;
    Params.ParamValues['netscheduleid'] :=netscheduleid ;
    Active := true;
  end;
end;

procedure TFrmNetSchedule.QrySchedulestop(netscheduleid: int64);
begin
  with jscdQryStation do
  begin
    Active := false;
    Params.ParamValues['netscheduleid'] :=netscheduleid ;
    Active := true;
  end;
end;

procedure TFrmNetSchedule.tbtnaddstopClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount=0 then
    exit;
  FrmNetScheduleAdd := TFrmNetScheduleAdd.Create(self);
  try
    with FrmNetScheduleAdd do
    begin
      FrmNetScheduleAdd.Caption := '添加联网配客班次';
      FrmNetScheduleAdd.edittype := Tedittype.add;
      operationid:=  jcdsResult.FieldByName('id').AsLargeInt;
      NovaHStartOrg.Text:=  jcdsResult.FieldByName('orgname').AsString;
      NovaHStartOrg.id:=  jcdsResult.FieldByName('orgid').AsLargeInt;
      NovaHStartOrg.ReadOnly:=true;
      nvhlpschedule.Text:=  jcdsResult.FieldByName('code').AsString;
      nvhlpschedule.id:=  jcdsResult.FieldByName('startscheduleid').AsLargeInt;
      nvhlpschedule.ReadOnly:=true;
      if SysMainForm.showFormModal(FrmNetScheduleAdd, false) = mrOk then
      begin
         QryOtherSchedule(jcdsResult.FieldByName('id').AsLargeInt);
        //id := FrmNetScheduleAdd.operationid;
        //tbtnFilter.Click;
        //jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmNetScheduleAdd);
  end;
end;

procedure TFrmNetSchedule.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除配客班次信息吗？') then
    begin
      exit;
    end;
    with jscdDelNetSchedule do
    begin
      Params.ParamValues['netscheduleid']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      SysDialogs.ShowMessage(Params.ParamValues['actionResultStr']);
      if Params.ParamValues['actionResult']=1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;
end;

procedure TFrmNetSchedule.tbtndelstopClick(Sender: TObject);
begin
  inherited;
  if (jscdQryOtherSchedule.Active=True) and (jscdQryOtherSchedule.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除配客班次吗？') then
    begin
      exit;
    end;
    with jscdScheduledetailid do
    begin
      Params.ParamValues['netscheduledetailid']:=jscdQryOtherSchedule.FieldByName('id').AsString;
      Execute;
      SysDialogs.ShowMessage(Params.ParamValues['actionResultStr']);
      if Params.ParamValues['actionResult']=1 then
      begin
        //tbtnFilter.Click;
         QryOtherSchedule(jcdsResult.FieldByName('id').AsLargeInt);
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;
end;

procedure TFrmNetSchedule.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if nvcbbOrgid.GetSelectID<>'' then
       Params.ParamValues['filter_INS_o!id'] := nvcbbOrgid.GetSelectID
    else
       Params.ParamValues['filter_INS_o!id'] := null;
    if NHelpRoute.Id>0 then
        Params.ParamValues['filter_EQL_sc!routeid'] := NHelpRoute.Id
    else
        Params.ParamValues['filter_EQL_sc!routeid'] := null;
    Active := true;
    if recordcount=0 then
    begin
      jscdQryOtherSchedule.Close;
      jscdQryStation.Close;
    end;
  end;
end;

procedure TFrmNetSchedule.tbtnInsertClick(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  FrmNetScheduleAdd := TFrmNetScheduleAdd.Create(self);
  try
    FrmNetScheduleAdd.Caption := '添加联网配客班次';
    FrmNetScheduleAdd.edittype := Tedittype.add;
    if SysMainForm.showFormModal(FrmNetScheduleAdd, false) = mrOk then
    begin
      id := FrmNetScheduleAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id', id, []);
    end;
  finally
    FreeAndNil(FrmNetScheduleAdd);
  end;
end;

procedure TFrmNetSchedule.ToolButton2Click(Sender: TObject);
var
  id: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount=0 then
    exit;
  FrmNetScheduleStation := TFrmNetScheduleStation.Create(self);
  try
    with FrmNetScheduleStation do
    begin
      FrmNetScheduleStation.Caption := '添加联网配客班次停靠点';
      EdtRoute.Text:=  jcdsResult.FieldByName('routename').AsString;
      netscheduleid:= jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmNetScheduleStation, false) = mrOk then
      begin
         id:=operationid;
         QrySchedulestop(jcdsResult.FieldByName('id').AsLargeInt);
         jscdQryStation.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmNetScheduleStation);
  end;

end;

procedure TFrmNetSchedule.ToolButton6Click(Sender: TObject);
begin
  inherited;
  if (jscdQryStation.Active=True) and (jscdQryStation.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除配客班次停靠点吗？') then
    begin
      exit;
    end;
    with jscdDelSchedulestop do
    begin
      Params.ParamValues['netscheduledetailid']:=jscdQryStation.FieldByName('id').AsString;
      Execute;
      SysDialogs.ShowMessage(Params.ParamValues['actionResultStr']);
      if Params.ParamValues['actionResult']=1 then
      begin
        //tbtnFilter.Click;
         QrySchedulestop(jcdsResult.FieldByName('id').AsLargeInt);
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;
end;

end.
