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
    SysDialogs.Warning('��ѡ���Σ�');
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
          typelog := '�޸�'
        else
          typelog := '���';

        log := '���ѭ����Σ�ѭ��������=' + NovaEdtName.Text + ',ѭ����ʼ����=' + FormatDateTime
          ('yyyy-mm-dd', DateTpFromDate.Date) + ',ѭ����ʼ����=' + FormatDateTime
          ('yyyy-mm-dd', DateTpEndDate.Date) + ',ѭ������У�';
        SysLog.WriteLog('���ѭ��:���ѭ��', typelog, log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���ѭ����Ϣ����ʧ�ܣ�' + E.Message);
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
