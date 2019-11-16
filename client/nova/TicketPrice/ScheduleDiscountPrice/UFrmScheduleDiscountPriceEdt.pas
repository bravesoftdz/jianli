unit UFrmScheduleDiscountPriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, DB, DBClient, jsonClientDataSet, GridsEh, DBGridEh,
  NvDbgridEh, ComCtrls, NovaEdit;

type
  TFrmScheduleDiscountPriceEdt = class(TSimpleEditForm)
    Label1: TLabel;
    NovaEdtRoute: TNovaEdit;
    Label2: TLabel;
    NovaEditSchedule: TNovaEdit;
    Label5: TLabel;
    DateTpFromDate: TDateTimePicker;
    Label6: TLabel;
    DateTpEndDate: TDateTimePicker;
    chkIsSameRoute: TCheckBox;
    GroupBox1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    dsSchDiscountPrice: TDataSource;
    jcsdQrySchDiscountPrice: TjsonClientDataSet;
    jcsdQrySchDiscountPriceenddate: TDateField;
    jcsdQrySchDiscountPriceprice: TFloatField;
    jcsdQrySchDiscountPricecreatetime: TTimeField;
    jcsdQrySchDiscountPriceupdatetime: TTimeField;
    jcsdQrySchDiscountPriceid: TLargeintField;
    jcsdQrySchDiscountPricescheduleid: TLargeintField;
    jcsdQrySchDiscountPriceorgid: TLargeintField;
    jcsdQrySchDiscountPricecreateby: TLargeintField;
    jcsdQrySchDiscountPriceupdateby: TLargeintField;
    jcsdQrySchDiscountPricedepartstationid: TLargeintField;
    jcsdQrySchDiscountPricereachstationid: TLargeintField;
    jcsdQrySchDiscountPricesalenum: TIntegerField;
    jcsdQrySchDiscountPricedepartstation: TWideStringField;
    jcsdQrySchDiscountPricereachstation: TWideStringField;
    jcdsQryStation: TjsonClientDataSet;
    jcsdQrySchDiscountPricestartdate: TDateField;
    Label3: TLabel;
    NovaEditSaleNum: TNovaEdit;
    jcsdQrySchDiscountPricereferenceprice: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    startdate, enddate, log: string;
  public
    { Public declarations }
    createby, id: int64;
  end;

var
  FrmScheduleDiscountPriceEdt: TFrmScheduleDiscountPriceEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleDiscountPriceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, curstartdate, curenddate, result, salenum: string;
begin
  inherited;
  salenum := NovaEditSaleNum.text;
  curstartdate := formatdatetime('yyyy-mm-dd', DateTpFromDate.Date);
  curenddate := formatdatetime('yyyy-mm-dd', DateTpEndDate.Date);

  if curstartdate > curenddate then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;

  with jcsdQrySchDiscountPrice do
  begin
    Params.ParamValues['startdate'] := curstartdate;
    Params.ParamValues['enddate'] := curenddate;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Params.ParamValues['savesameroute'] := chkIsSameRoute.Checked;
    Params.ParamValues['salenum'] := salenum;
    ApplyUpdates(-1);

    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;

    if (nResult = 1) then
    begin
      log := '营运线路=' + NovaEdtRoute.text + ',班次号=' + NovaEditSchedule.text +
        ',开始日期=' + curstartdate + ',结束日期=' + curenddate;
      if chkIsSameRoute.Checked then
      begin
        log := log + ',同时复制到本线路其它班次。';
      end;
      result := '';
      with jcsdQrySchDiscountPrice do
        while (not eof) do
        begin
          result := result + '上车站=' + FieldByName('departstation')
            .AsString + ',到达站' + FieldByName('reachstation')
            .AsString + ',优惠票价=' + FieldByName('price')
            .AsString + ',可售张数=' + salenum;
          next;
        end;
      log := log + result;
      SysLog.WriteLog('票价管理——>优惠票价', '添加', log);
      SysDialogs.ShowMessage(sResult);
      ModalResult := mrok;
    end
    else
    begin
      SysDialogs.Warning(sResult);
    end;
  end;
end;

procedure TFrmScheduleDiscountPriceEdt.FormShow(Sender: TObject);
begin
  inherited;
  with jcdsQryStation do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Active := true;
  end;
  { with jcdsQryStopStation do
    begin
    Active := false;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Params.ParamValues['isdepart'] := false;
    Active := true;
    end; }
  with jcsdQrySchDiscountPrice do
  begin
    Active := false;
    Params.ParamValues['routeid'] := NovaEdtRoute.id;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Active := true;
  end;
  //回显可售张数
  if jcsdQrySchDiscountPrice.FieldByName('salenum').AsString <> '' then
  begin
    NovaEditSaleNum.text := jcsdQrySchDiscountPrice.FieldByName('salenum')
      .AsString;
  end;
  //修改时回显上次设置日期，新增时回显当前日期
  if jcsdQrySchDiscountPrice.FieldByName('startdate').AsString = '' then
  begin
    DateTpFromDate.DateTime := Date();
    DateTpEndDate.DateTime := Date();
  end
  else
  begin
    DateTpFromDate.DateTime := jcsdQrySchDiscountPrice.FieldByName('startdate')
      .AsDateTime;
    DateTpEndDate.DateTime := jcsdQrySchDiscountPrice.FieldByName('enddate')
      .AsDateTime;
  end;
end;

end.
