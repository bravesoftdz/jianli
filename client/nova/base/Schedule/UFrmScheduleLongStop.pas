unit UFrmScheduleLongStop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaEdit,
  NovaComboBox, NovaHelp, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmScheduleLongStop = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    dpStartDate: TDateTimePicker;
    dpEndDate: TDateTimePicker;
    nvccbReason: TNovaComboBox;
    nhelpapproveby: TNovaHelp;
    jcdsScheduleLongsave: TjsonClientDataSet;
    NedtSchedule: TNovaHelp;
    lbl2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure dpStartDateExit(Sender: TObject);
    procedure dpEndDateExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby, curid: integer;
    createtime, reason: string;
  end;

var
  FrmScheduleLongStop: TFrmScheduleLongStop;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleLongStop.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, log: string;
begin
  inherited;
  if (trim(NedtSchedule.Text) = '') or (NedtSchedule.id = 0) then
  begin
    NedtSchedule.SetFocus;
    SysDialogs.Warning('请输入长停的班次！');
    exit;
  end;

  if dpEndDate.Date < dpStartDate.Date then
  begin
    dpEndDate.SetFocus;
    SysDialogs.Warning('截止日期必须大于开始日期！');
    exit;
  end;
  if trim(nvccbReason.Text) = '' then
  begin
    nvccbReason.SetFocus;
    SysDialogs.Warning('请填写长停原因！');
    exit;
  end;
  if nhelpapproveby.id <= 0 then
  begin
    nvccbReason.SetFocus;
    SysDialogs.Warning('请输入批准人！');
    exit;
  end;

  with jcdsScheduleLongsave do
  begin
    close;
    if id > 0 then
      log := '修改长停信息:班次号=' + NedtSchedule.Text
    else
      log := '添加长停信息:班次号=' + NedtSchedule.Text;

    log := log + ',开始日期=' + FormatDateTime('yyyy-mm-dd', dpStartDate.DateTime);
    log := log + ',结束日期=' + FormatDateTime('yyyy-mm-dd', dpEndDate.DateTime);
    log := log + ',原因=' + nvccbReason.Text;
    log := log + ',批准人=' + nhelpapproveby.Text;
    Params.ParamByName('schedulelongstop.id').Value := id;
    Params.ParamByName('schedulelongstop.schedule.id').Value := NedtSchedule.id;
    Params.ParamByName('schedulelongstop.startdate').Value := FormatDateTime
      ('yyyy-mm-dd', dpStartDate.DateTime);
    Params.ParamByName('schedulelongstop.enddate').Value := FormatDateTime
      ('yyyy-mm-dd', dpEndDate.DateTime);
    Params.ParamByName('schedulelongstop.reason').Value := nvccbReason.Text;
    Params.ParamByName('schedulelongstop.approveby').Value := nhelpapproveby.id;
    Params.ParamByName('schedulelongstop.createby').Value := createby;
    //记录历史原因
    Params.ParamByName('digitaldictionarydetail.createby').Value := createby;
    Params.ParamByName('digitaldictionarydetail.id').Value := nvccbReason.GetSelectID();
    Params.ParamByName('digitaldictionarydetail.value').Value := nvccbReason.Text;
    if createtime <> '' then
      Params.ParamByName('schedulelongstop.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      curid := NedtSchedule.id;
      if (nResult <= 0) then
      begin
        dpStartDate.SetFocus;
      end
      else
      begin
        SysLog.WriteLog('添加、修改班次长停信息', '添加、修改', log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次长停信息增加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmScheduleLongStop.dpEndDateExit(Sender: TObject);
begin
  inherited;
  dpStartDate.Date := trunc(dpStartDate.Date);
  dpEndDate.Date := trunc(dpEndDate.Date);
  if dpStartDate.Date > dpEndDate.Date then
  begin
    dpEndDate.Date := dpStartDate.Date;
  end;
end;

procedure TFrmScheduleLongStop.dpStartDateExit(Sender: TObject);
begin
  inherited;
  if dpStartDate.Date > dpEndDate.Date then
  begin
    dpEndDate.Date := dpStartDate.Date;
  end;
end;

procedure TFrmScheduleLongStop.FormShow(Sender: TObject);
begin
  inherited;
  nvccbReason.Active := false;
  nvccbReason.Active := true;
  if (edittype = add) then
  begin
    dpStartDate.Date := now;
    // dpEndDate.Date := now;
  end
  else
    nvccbReason.ItemIndex := nvccbReason.Items.IndexOf(reason);
end;

end.
