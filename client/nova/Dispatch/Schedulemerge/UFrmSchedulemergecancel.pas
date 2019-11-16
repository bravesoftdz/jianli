unit UFrmSchedulemergecancel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList;

type
  TFrmSchedulemergecancel = class(TSimpleEditForm)
    lblschedule: TLabel;
    lbloldschedule: TLabel;
    edtschedule: TNovaEdit;
    edtoldschedule: TNovaEdit;
    lbl3: TLabel;
    mmoreason: TMemo;
    jcdsResultSchedulemergecancelSave: TjsonClientDataSet;
    lbl7: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    edtroute: TNovaEdit;
    edtseatnum: TNovaEdit;
    edtsoldeatnum: TNovaEdit;
    edtdeparttime: TNovaEdit;
    lbl6: TLabel;
    lbl8: TLabel;
    lbl10: TLabel;
    lbl12: TLabel;
    edtoldroute: TNovaEdit;
    edtoldseatnum: TNovaEdit;
    edtoldsoldeatnum: TNovaEdit;
    edtolddeparttime: TNovaEdit;
    ds1: TDataSource;
    jcdsResultplanschedule: TjsonClientDataSet;
    wdstrngfld1: TWideStringField;
    wdstrngfld2: TWideStringField;
    shrtntfld1: TShortintField;
    shrtntfld2: TShortintField;
    dsResult: TDataSource;
    jcdsResultschedule: TjsonClientDataSet;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    shrtntfldResultsoldeatnum: TShortintField;
    shrtntfldResultseatnum: TShortintField;
    lbl16: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    sign : Boolean;
    schedulemergeid, oldscheduleplanid, scheduleplanid, oldscheduleid : string;
  end;

var
  FrmSchedulemergecancel: TFrmSchedulemergecancel;

implementation

uses Services;
{$R *.dfm}

procedure TFrmSchedulemergecancel.bbtnSaveClick(Sender: TObject);
var nResult : LongWord;
    sResult : string;
begin
  inherited;
  if Trim(mmoreason.Text) = '' then
  begin
    SysDialogs.ShowMessage('请先填写取消并班原因！');
    mmoreason.SetFocus;
    Exit;
  end;
  with jcdsResultSchedulemergecancelSave do
  begin
    Close;
    Params.ParamByName('schedulemergecancel.schedulemergeid').Value := schedulemergeid;
    Params.ParamByName('schedulemergecancel.reason').Value := mmoreason.Text;
    Params.ParamByName('oldscheduleplanid').Value := oldscheduleplanid;
    Params.ParamByName('schedulemergecancel.oldscheduleplanid').Value := oldscheduleplanid;
    Params.ParamByName('schedulemergecancel.scheduleplanid').Value := scheduleplanid;
    Params.ParamByName('schedulemergecancel.oldscheduleid').Value := oldscheduleid;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtschedule.SetFocus;
      end
      else
      begin
        log := '取消班次并班：并入班次:'+edtschedule.Text+',原班次:'+edtoldschedule.Text
              +',取消并班原因:'+mmoreason.Text;
        SysLog.WriteLog('调度管理->班次并班','取消并班',log);
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

procedure TFrmSchedulemergecancel.FormShow(Sender: TObject);
begin
  inherited;
   with jcdsResultplanschedule do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_t!id'] := scheduleplanid; //nvhlpscheduleplanid.Id;
    Active := True;
  end;

  if not ds1.DataSet.Active then
    exit;
  if ds1.DataSet.RecordCount < 1 then
    exit;
  with FrmSchedulemergecancel do
  begin
    edtroute.Text := jcdsResultplanschedule.FieldByName('routename').AsString;
    edtseatnum.Text := jcdsResultplanschedule.FieldByName('seatnum').AsString;
    edtsoldeatnum.Text := jcdsResultplanschedule.FieldByName('soldeatnum').AsString;
    edtdeparttime.Text := jcdsResultplanschedule.FieldByName('departtime').AsString;
  end;


  with jcdsResultschedule do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_t!id'] := oldscheduleplanid; //nvhlpscheduleplanid.Id;
    Active := True;
  end;

  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmSchedulemergecancel do
  begin
    edtoldroute.Text := jcdsResultschedule.FieldByName('routename').AsString;
    edtoldseatnum.Text := jcdsResultschedule.FieldByName('seatnum').AsString;
    edtoldsoldeatnum.Text := jcdsResultschedule.FieldByName('soldeatnum').AsString;
    edtolddeparttime.Text := jcdsResultschedule.FieldByName('departtime').AsString;
  end;
end;

end.
