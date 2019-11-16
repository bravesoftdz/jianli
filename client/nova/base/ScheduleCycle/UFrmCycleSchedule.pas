unit UFrmCycleSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaEdit, NovaHelp,
  NovaCheckedComboBox, DB, DBClient, jsonClientDataSet, NovaHComboBox,
  Menus, NovaComboBox, NovaListView, ComCtrls;

type
  TFrmCycleSchedule = class(TSimpleEditForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaEdtName: TNovaEdit;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    jcdsSaveCycleschemesschedule: TjsonClientDataSet;
    grp1: TGroupBox;
    NovaListSchedule: TNovaListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure bbtnSaveClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    log: String;
  public
    { Public declarations }
    types : integer;
    createby, pid: integer;
    // createtime:string;
    // routeid:Int64;
  end;

var
  FrmCycleSchedule: TFrmCycleSchedule;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmCycleSchedule.bbtnSaveClick(Sender: TObject);
var
  msg, typelog: String;
  nResult: integer;
  sResult, schedulecontext: string;
begin
  inherited;

  if (NovaListSchedule.CheckedCount <= 0) then
  begin
    SysDialogs.Warning('请选择班次！');
    NovaListSchedule.SetFocus;
    exit;
  end;

  with jcdsSaveCycleschemesschedule do
  begin
    close;
    // Params.ParamByName('cycleschemesschedule.id').Value := id;
    // Params.ParamByName('cycleschemesschedule.orderno').Value := orderno;
    Params.ParamByName('cycleschemesschedule.scheduleids').Value :=
      NovaListSchedule.GetSelected;
    Params.ParamByName('cycleschemesschedule.cyclescheme.id').Value := pid;
    Params.ParamByName('cycleschemesschedule.createby').Value := createby;
    Params.ParamByName('types').Value :=types;

    // Params.ParamByName('cycleschemesschedule.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        // NovaHelpSchedule.SetFocus;
      end
      else
      begin
        if  types = 0 then
          typelog := '修改'
        else
          typelog := '添加';

        log := '添加循环班次：循环组名称=' + NovaEdtName.Text + ',循环开始日期=' + FormatDateTime
          ('yyyy-mm-dd', DateTpFromDate.Date) + ',循环开始日期=' + FormatDateTime
          ('yyyy-mm-dd', DateTpEndDate.Date) + ',循环班次有：';
        SysLog.WriteLog('班次循环:班次循环', typelog, log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次循环信息增加失败：' + E.Message);
      end;
    end;
  end;

end;


procedure TFrmCycleSchedule.N1Click(Sender: TObject);
begin
  inherited;
   NovaListSchedule.SelectAll;
end;

end.
