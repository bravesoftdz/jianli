unit UFrmSchedulemerge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmSchedulemergeEdit, UFrmSchedulemergecancel,
  NovaHComboBox, NovaEdit, NovaHelp, FunctionItemIntf, NovaCheckedComboBox;

type
  TFrmSchedulemerge = class(TSimpleCRUDForm)
    grp1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    ds1: TDataSource;
    jcdsResult1: TjsonClientDataSet;
    lbldate: TLabel;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    lblschedule: TLabel;
    nvhlpschedule: TNovaHelp;
    cbborg: TNovaCheckedComboBox;
    lbl3: TLabel;
    lbl4: TLabel;
    dtpOldstart: TDateTimePicker;
    dtpOldend: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSchedulemerge: TFrmSchedulemerge;

implementation

uses Services,PubFn;
{$R *.dfm}


procedure TFrmSchedulemerge.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmSchedulemerge.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now()-15;
  dtpenddate.Date := Now();
  dtpOldstart.Date := Now()-15;
  dtpOldend.Date := Now();

end;

procedure TFrmSchedulemerge.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
 { if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsResult1.Close;
  end; }
end;

procedure TFrmSchedulemerge.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
 { if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jcdsResult1 do
  begin
    Active:=false;
      Params.ParamValues['filter_EQL_s!schedulemergeid'] :=jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end; }
end;

procedure TFrmSchedulemerge.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with jcdsResult do
  begin
    if FieldByName('iscancel').AsBoolean then
    begin
      SysDialogs.ShowMessage('被并的班次：' + FieldByName('oldcode').AsString + ' 已取消并班.');
      Locate('id',FieldByName('id').AsString,[] );
      if not (State in [dsEdit,dsInsert]) then
      begin
        Edit;
      end;
      Exit;
    end;
  end;
  with FrmSchedulemergecancel do
  begin
    FrmSchedulemergecancel := TFrmschedulemergecancel.create(Self);
    Caption := '取消班次并班';
    sign := True;
    schedulemergeid := jcdsResult.FieldByName('id').AsString;
    edtschedule.Text := jcdsResult.FieldByName('newcode').AsString;
    edtoldschedule.Text := jcdsResult.FieldByName('oldcode').AsString;
    oldscheduleplanid := jcdsResult.FieldByName('oldscheduleplanid').AsString;
    scheduleplanid := jcdsResult.FieldByName('scheduleplanid').AsString;
    oldscheduleid := jcdsResult.FieldByName('oldscheduleid').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',schedulemergeid,[])
    end;
  end;
end;

procedure TFrmSchedulemerge.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
      Params.ParamValues['filter_GED_ols!departdate'] := FormatDateTime('yyyy-mm-dd',dtpOldstart.Date);
      Params.ParamValues['filter_LED_ols!departdate'] := FormatDateTime('yyyy-mm-dd',dtpOldend.Date);

      if cbborg.CheckedCount = 0 then
        Params.ParamValues['filter_INS_t!orgid'] := SysInfo.LoginUserInfo.OrgIDs
      else
        Params.ParamValues['filter_INS_t!orgid'] := cbborg.GetSelectID;
      if Trim(nvhlpschedule.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!newscheduleid_OR_oldscheduleid'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!newscheduleid_OR_oldscheduleid'] := nvhlpschedule.Id;
      end;
    jcdsResult.AfterScroll:=nil;
    try      Active:=true;      if recordcount>0 then      begin        jcdsResultAfterScroll(nil);      end;    finally      jcdsResult.AfterScroll:=jcdsResultAfterScroll;    end;
    Active := True;
  end;
  
end;

procedure TFrmSchedulemerge.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmSchedulemergeEdit do
  begin
    FrmSchedulemergeEdit := TFrmSchedulemergeEdit.Create(self);
    Caption := '班次并班';
    sign:=true;
    //id := jcdsResult.FieldByName('id').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      //jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
