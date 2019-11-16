unit UFrmScheduleLongStopInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh,
  ComCtrls, ToolWin, StdCtrls, ImgList, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHelp;

type
  TFrmScheduleLongStopInfo = class(TSimpleEditForm)
    ImageList1: TImageList;
    GroupBox3: TGroupBox;
    ToolBar1: TToolBar;
    ToolButton5: TToolButton;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    NvDbgridEh1: TNvDbgridEh;
    Panel1: TPanel;
    Label3: TLabel;
    NovaHelpSchedule: TNovaHelp;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    dbgrdhResult: TNvDbgridEh;
    Panel3: TPanel;
    Splitter2: TSplitter;
    GroupBox4: TGroupBox;
    ToolBar3: TToolBar;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton23: TToolButton;
    ToolButton22: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    DBGridEh2: TNvDbgridEh;
    GroupBox2: TGroupBox;
    ToolBar2: TToolBar;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    NvDbgridEh2: TNvDbgridEh;
    jcdsScheduleLong: TjsonClientDataSet;
    jscdDelScheduleLong: TjsonClientDataSet;
    DataSource1: TDataSource;
    Label6: TLabel;
    NovaEdtRoute: TNovaEdit;
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure qrySchedulelongStop(scheduleid: integer);
  public
    { Public declarations }
  end;

var
  FrmScheduleLongStopInfo: TFrmScheduleLongStopInfo;

implementation

uses PubFn, Services, UFrmScheduleLongStop, UDMPublic;
{$R *.dfm}
{ TFrmScheduleLongStopInfo }

procedure TFrmScheduleLongStopInfo.bbtnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFrmScheduleLongStopInfo.FormResize(Sender: TObject);
begin
//
end;

procedure TFrmScheduleLongStopInfo.FormShow(Sender: TObject);
begin
  inherited;
  bbtnClose.Left:=328;
  if NovaHelpSchedule.Id > 0 then
    qrySchedulelongStop(NovaHelpSchedule.Id);

end;

procedure TFrmScheduleLongStopInfo.qrySchedulelongStop(scheduleid: integer);
begin
  with jcdsScheduleLong do
  begin
    active := false;
    Params.ParamValues['schedule.id'] := scheduleid;
    active := true;
  end;
end;

procedure TFrmScheduleLongStopInfo.ToolButton2Click(Sender: TObject);
begin
  inherited;
  FrmScheduleLongStop := TFrmScheduleLongStop.Create(self);
  try
    with FrmScheduleLongStop do
    begin
      Caption := '添加班次长停信息';
      createby := SysInfo.LoginUserInfo.UserID;
      NedtSchedule.id := NovaHelpSchedule.Id;
      NedtSchedule.text := NovaHelpSchedule.text;
      edittype := add;
      if SysMainForm.showFormModal(FrmScheduleLongStop, false) = mrok then
      begin
        qrySchedulelongStop(curid);
      end;
    end;
  finally
    FreeAndNil(FrmScheduleLongStop);
  end;
end;

procedure TFrmScheduleLongStopInfo.ToolButton4Click(Sender: TObject);
begin
  inherited;
    if not jcdsScheduleLong.Active then
    exit;
  if jcdsScheduleLong.RecordCount <= 0 then
    exit;
   FrmScheduleLongStop := TFrmScheduleLongStop.Create(self);
  with FrmScheduleLongStop do
  begin
    Caption := '修改班次长停信息';
    createby := SysInfo.LoginUserInfo.UserID;
    NedtSchedule.id:= jcdsScheduleLong.FieldByName('scheduleid').AsInteger;
    NedtSchedule.text:=jcdsScheduleLong.FieldByName('code').AsString;
    edittype:=TEditType.update;
    dpStartDate.Date:=jcdsScheduleLong.FieldByName('startdate').AsDateTime;
    dpEndDate.Date:=jcdsScheduleLong.FieldByName('enddate').AsDateTime;
    reason:=jcdsScheduleLong.FieldByName('reason').AsString;
    id :=jcdsScheduleLong.FieldByName('id').AsInteger;
    nhelpapproveby.Text:=jcdsScheduleLong.FieldByName('approvename').AsString;
    nhelpapproveby.id:=jcdsScheduleLong.FieldByName('approveby').AsInteger;
    createtime := jcdsScheduleLong.FieldByName('createtime').AsString;
    createby := jcdsScheduleLong.FieldByName('createby').AsInteger;
    if SysMainForm.showFormModal(FrmScheduleLongStop) = mrok then
    begin
       qrySchedulelongStop(curid);
    end;
  end;
end;

procedure TFrmScheduleLongStopInfo.ToolButton6Click(Sender: TObject);
var
  sResult,log: string;
  nResult,scheduleid:integer;
begin
  inherited;
  if not jcdsScheduleLong.Active then
    exit;
  if jcdsScheduleLong.RecordCount <= 0 then
    exit;
  scheduleid:= jcdsScheduleLong.FieldByName('scheduleid').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该长停信息吗？') then
  with jscdDelScheduleLong do
  begin
    Active := false;
    log:='班次号='+ jcdsScheduleLong.FieldByName('code').AsString;
    Params.ParamValues['schedulelongstop.id'] := jcdsScheduleLong.FieldByName('id')
      .AsInteger;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除班次长停信息', '删除', log);
      qrySchedulelongStop(scheduleid) ;
    end;
  end;

end;

end.
