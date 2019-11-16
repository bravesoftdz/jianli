unit UFrmSecuritycheckplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, StdCtrls, NovaComboBox, ComCtrls,
  NovaEdit, DB, DBClient, jsonClientDataSet, PrnDbgeh, ImgList, GridsEh,
  DBGridEh, ToolWin, ExtCtrls, UFrmSecuritycheckplanEdit, NvPrnDbgeh, NvDbgridEh,
  NovaHelp;

type
  TFrmSec = class(TSimpleCRUDForm)
    Label8: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    startdate: TDateTimePicker;
    enddate: TDateTimePicker;
    cbbperiodtype: TNovaComboBox;
    jsonCDSDelSec: TjsonClientDataSet;
    jcdsperiodname: TjsonClientDataSet;
    jcdsResultunitname: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultperiodtype: TWideStringField;
    jcdsResultvehicleid: TLargeintField;
    jcdsResultunitid: TLargeintField;
    jcdsResultperiodtypename: TWideStringField;
    jcdsResultperiod: TIntegerField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultmodelid: TWideStringField;
    jcdsResultstartdate: TDateField;
    jcdsResultenddate: TDateField;
    lrgntfldResultid: TLargeintField;
    Label1: TLabel;
    Label2: TLabel;
    nvhlpcode: TNovaHelp;
    nvhlpunit: TNovaHelp;
    nvhlpbrand: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSec: TFrmSec;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSec.FormCreate(Sender: TObject);
begin
  inherited;
  startdate.DateTime := Now();
  enddate.DateTime := Now();

  cbbperiodtype.Active:= false;
  cbbperiodtype.Active:= true;
end;

procedure TFrmSec.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDelSec do
  try
    close;
    log := '删除安检计划：车牌号='+jcdsResult.FieldByName('vehicleno').AsString;
    Params.ParamByName('securitycheckplan.id').Value := jcdsResult.FieldByName('id').AsInteger;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除安检计划','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('安检信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmSec.tbtnEditClick(Sender: TObject);
var
  i: Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmSecuritycheckplanEdit do
  begin
    FrmSecuritycheckplanEdit := TFrmSecuritycheckplanEdit.Create(self);
    Caption := '修改安检计划信息';
    flag:=false;
    id := jcdsResult.FieldByName('id').AsInteger;
    vehicleid :=  jcdsResult.FieldByName('vehicleid').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    edtperiod.Text := jcdsResult.FieldByName('period').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    nvhlpcode.Text := jcdsResult.FieldByName('vehicleno').AsString;
    //FrmSecuritycheckplanEdit.cbbperiodtype.Text := jcdsResult.FieldByName('periodtype').AsString;
    cbbstartdate.DateTime := jcdsResult.FieldByName('startdate').AsDateTime;
    dtpenddate.DateTime := jcdsResult.FieldByName('enddate').AsDateTime;
    for i := 0 to cbbperiodtype.Items.Count - 1 do
    begin
      try
        if TCommInfo(cbbperiodtype.Items.Objects[i]).Value= jcdsResult.FieldByName('periodtype').AsString then
        begin
          cbbperiodtype.ItemIndex:= i;
          break;
        end;
      except

      end;
    end;
    nvhlpcode.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('vehicleid',vehicleid,[] );
    end;
  end;
end;

procedure TFrmSec.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
    Params.ParamValues['filter_GED_t!startdate_OR_enddate'] := FormatDateTime('yyyy-mm-dd', startdate.DateTime - 1);
    Params.ParamValues['filter_LED_t!startdate_OR_enddate'] := FormatDateTime('yyyy-mm-dd', enddate.DateTime);
    if trim(cbbperiodtype.Text)= '' then
    begin
      Params.ParamValues['filter_LIKES_t!periodtype'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_t!periodtype'] := TCommInfo(cbbperiodtype.Items.Objects[cbbperiodtype.ItemIndex]).Value;;
    end;
    if nvhlpcode.Id = 0 then
      Params.ParamValues['filter_EQL_v!id'] := ''
    else
    Params.ParamValues['filter_EQL_v!id'] := nvhlpcode.Id;
    if nvhlpunit.Id = 0 then
      Params.ParamValues['filter_EQL_un!id'] := ''
    else
    Params.ParamValues['filter_EQL_un!id'] := nvhlpunit.Id;
    if nvhlpbrand.Id = 0 then
      Params.ParamValues['filter_EQL_ve!id'] := ''
    else
    Params.ParamValues['filter_EQL_ve!id'] := nvhlpbrand.Id;
    Active:= true;
  end;
end;

procedure TFrmSec.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmSecuritycheckplanEdit do
  begin
    FrmSecuritycheckplanEdit := TFrmSecuritycheckplanEdit.Create(Self);
    Caption := '添加车辆安检计划信息';
    flag := true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
