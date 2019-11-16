unit UFrmTicketTurnOverOther;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  UDMPublic, jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh,
  StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, Services,
  NovaHComboBox;

type
  TfrmTicketTurnOverOther = class(TSimpleCRUDForm)
    lbl4: TLabel;
    lbl3: TLabel;
    Label3: TLabel;
    dtpstartdate: TDateTimePicker;
    cbborg: TNovaHComboBox;
    dtpenddate: TDateTimePicker;
    Label9: TLabel;
    nvhelpUserid: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketTurnOverOther: TfrmTicketTurnOverOther;

implementation

uses UFrmTicketTurnOverOtherAdd;
{$R *.dfm}

procedure TfrmTicketTurnOverOther.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
  cbborg.SetItemIndexByField('id', SysInfo.LoginUserInfo.OrgID);
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
end;

procedure TfrmTicketTurnOverOther.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyy-mm-dd', dtpstartdate.Date) > FormatDateTime
    ('yyyy-mm-dd', dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    // 所属机构
    Params.ParamValues['filter_EQL_o!id'] := cbborg.HelpFieldValue['id'];
    // 日期
    Params.ParamValues['filter_GED_tto!tickettime'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_tto!tickettime'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);
    // 售票员
    if Trim(nvhelpUserid.Text) = '' then
    begin
      Params.ParamByName('filter_EQL_u1!id').Value := null;
    end
    else
    begin
      Params.ParamByName('filter_EQL_u1!id').Value := nvhelpUserid.id;
    end;

    Active := True;
  end;
end;

procedure TfrmTicketTurnOverOther.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  // 添加
  FrmTicketTurnOverOtherAdd := TFrmTicketTurnOverOtherAdd.Create(self);
  try
    with FrmTicketTurnOverOtherAdd do
    begin
      Caption := '手工单缴款';
      id := 0;
      if SysMainForm.showFormModal(FrmTicketTurnOverOtherAdd, False) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmTicketTurnOverOtherAdd);
  end;
end;

end.


