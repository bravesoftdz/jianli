unit UFrmVehicleturnover;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, UFrmVehicleturnoverEdit,
  NovaCheckedComboBox;

type
  TFrmVehicleturnover = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    jsonCDSDelvehicleturnover: TjsonClientDataSet;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpcode: TNovaHelp;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehicleturnover: TFrmVehicleturnover;

implementation

uses Services;
{$R *.dfm}

procedure TFrmVehicleturnover.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmVehicleturnover.tbtnDeleteClick(Sender: TObject);
var
  nResult: LongWord;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDelvehicleturnover do
  try
    close;
    Params.ParamByName('vehicleturnover.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('车辆缴款记录删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmVehicleturnover.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  //新增开始日期大于结束日期提示，add by liyi 20150330
   if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsResult do
  begin
    Active:= false;
    if Trim(nvhlpcode.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_t!vehicleid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_t!vehicleid'] := nvhlpcode.Id
    end;
    if cbborg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_t!receiptorgid'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_t!receiptorgid'] := cbborg.GetSelectID;
    Params.ParamValues['filter_GED_t!turnovertime'] := FormatDateTime('yyyy-mm-dd', (dtpstartdate.DateTime - 1));
    Params.ParamValues['filter_LED_t!turnovertime'] := FormatDateTime('yyyy-mm-dd', (dtpenddate.DateTime + 1));
    Active:= true;
  end;
end;

procedure TFrmVehicleturnover.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmvehicleturnoverEdit do
  begin
    FrmVehicleturnoverEdit := TFrmVehicleturnoverEdit.Create(Self);
    Caption:= '添加车辆缴款信息';
    sign:= true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

end.
