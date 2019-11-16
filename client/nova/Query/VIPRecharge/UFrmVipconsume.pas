unit UFrmVipconsume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmVipconsume = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlpcardno: TNovaHelp;
    jcdstypename: TjsonClientDataSet;
    jcdsgradename: TjsonClientDataSet;
    jcdspaymethod: TjsonClientDataSet;
    jcdsticketstatus: TjsonClientDataSet;
    jcdssellway: TjsonClientDataSet;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultvipcardno: TWideStringField;
    wdstrngfldResultvipgrade: TWideStringField;
    wdstrngfldResultvipgradename: TWideStringField;
    fltfldResultmoneychange: TFloatField;
    fltfldResultpointchange: TFloatField;
    fltfldResultremainmoney: TFloatField;
    fltfldResultremainpoint: TFloatField;
    wdstrngfldResultcreatename: TWideStringField;
    dtmfldResultcreatetime: TDateTimeField;
    n: TLargeintField;
    fltfldResultmoney: TFloatField;
    fltfldResultvipamount: TFloatField;
    wdstrngfldResulttype: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    datasource: TDataSource;
    jcdsResultdetail: TjsonClientDataSet;
    WideStringField1: TWideStringField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    WideStringField4: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    WideStringField5: TWideStringField;
    DateTimeField1: TDateTimeField;
    LargeintField1: TLargeintField;
    WideStringField6: TWideStringField;
    DateTimeField2: TDateTimeField;
    WideStringField7: TWideStringField;
    DateTimeField3: TDateTimeField;
    WideStringField8: TWideStringField;
    WideStringField9: TWideStringField;
    WideStringField10: TWideStringField;
    WideStringField11: TWideStringField;
    WideStringField12: TWideStringField;
    WideStringField13: TWideStringField;
    WideStringField14: TWideStringField;
    WideStringField15: TWideStringField;
    WideStringField16: TWideStringField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    WideStringField17: TWideStringField;
    WideStringField18: TWideStringField;
    WideStringField19: TWideStringField;
    FloatField7: TFloatField;
    Label1: TLabel;
    edtCoustomername: TNovaEdit;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVipconsume: TFrmVipconsume;

implementation

uses Services;
{$R *.dfm}

procedure TFrmVipconsume.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmVipconsume.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount<1 then
  begin
    jcdsResultdetail.Close;
  end;
end;

procedure TFrmVipconsume.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
      exit;
  if dsResult.DataSet.RecordCount<1 then
      exit;
  with jcdsResultdetail do
    begin
      Active:=false;
      Params.ParamByName('filter_EQL_vc!id').Value:=jcdsResult.FieldByName('id').AsLargeInt;
      Active:=true;
    end;
end;

procedure TFrmVipconsume.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_vc!createtime'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime) + ' 00:00:01';
      Params.ParamValues['filter_LED_vc!createtime'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime) + ' 23:59:59';
      Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcardno.Text;
      Params.ParamValues['filter_LIKES_c!name'] := edtCoustomername.Text;
    Active := True;
  end;
end;

end.
