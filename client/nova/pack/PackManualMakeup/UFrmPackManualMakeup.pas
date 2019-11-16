unit UFrmPackManualMakeup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, Services,
  NovaHComboBox, Buttons, NovaComboBox;

type
  TFrmPackManualMakeup = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lbl1: TLabel;
    departinvoicesno: TNovaEdit;
    Label4: TLabel;
    jcdsstatusname: TjsonClientDataSet;
    sendBdepartdate: TDateTimePicker;
    sendEdepartdate: TDateTimePicker;
    jcdsResultdepartdate: TDateField;
    jcdsResultdepartinvoicesno: TWideStringField;
    jcdsResultpackno: TWideStringField;
    jcdsResulttostationname: TWideStringField;
    jcdsResultshipprice: TFloatField;
    jcdsResultbalanceamount: TFloatField;
    jcdsResultstatus: TWideStringField;
    jcdsResultstatusname: TWideStringField;
    Label1: TLabel;
    novepackeno: TNovaEdit;
    jsonpackmanualrDel: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPackManualMakeup: TFrmPackManualMakeup;

implementation

uses UFrmPackManualMakeupAdds;
{$R *.dfm}

procedure TFrmPackManualMakeup.FormShow(Sender: TObject);
begin
  inherited;
  sendBdepartdate.DateTime := now();
  sendEdepartdate.DateTime := now();
  jcdsstatusname.Active := True;
end;

procedure TFrmPackManualMakeup.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
//  begin SysDialogs.Confirm('信息提示', '确认要删除该记录吗!')
if not SysDialogs.Confirm('提示', '确定要删除该信息吗？') then
  begin
    exit;
  end;


  with jsonpackmanualrDel do
  begin
    close;
  Params.ParamByName('packdepartinvoices.id').Value := jcdsResult.FieldByName
    ('id').AsInteger;
  Execute;
SysDialogs.showmessage(Params.ParamValues['msg']);
tbtnFilter.Click;
  end;

end;

procedure TFrmPackManualMakeup.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    if (FormatDateTime('yyyymmdd', sendBdepartdate.Date) > FormatDateTime
        ('yyyymmdd', sendEdepartdate.Date)) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      exit;
    end;

    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendBdepartdate.Date);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendEdepartdate.Date);

    if departinvoicesno.Text <> '' then
      Params.ParamValues['filter_LIKES_p!departinvoicesno'] :=
        departinvoicesno.Text
    else
      Params.ParamValues['filter_LIKES_p!departinvoicesno'] := '';

    if novepackeno.Text <> '' then
      Params.ParamValues['filter_LIKES_pk!packno'] := novepackeno.Text
    else
      Params.ParamValues['filter_LIKES_pk!packno'] := '';
    Active := True;
  end;

end;

procedure TFrmPackManualMakeup.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmPackManualMakeupAdds := TFrmPackManualMakeupAdds.Create(Self);

  with FrmPackManualMakeupAdds do
  begin
    Caption := '行包结算单补录';

    if SysMainForm.showFormModal(FrmPackManualMakeupAdds, False) = mrOk then
    begin
        tbtnFilter.Click;
    end;
  end;

end;

end.
