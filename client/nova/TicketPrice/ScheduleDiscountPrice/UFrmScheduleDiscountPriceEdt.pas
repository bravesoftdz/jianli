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
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
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
      log := 'Ӫ����·=' + NovaEdtRoute.text + ',��κ�=' + NovaEditSchedule.text +
        ',��ʼ����=' + curstartdate + ',��������=' + curenddate;
      if chkIsSameRoute.Checked then
      begin
        log := log + ',ͬʱ���Ƶ�����·������Ρ�';
      end;
      result := '';
      with jcsdQrySchDiscountPrice do
        while (not eof) do
        begin
          result := result + '�ϳ�վ=' + FieldByName('departstation')
            .AsString + ',����վ' + FieldByName('reachstation')
            .AsString + ',�Ż�Ʊ��=' + FieldByName('price')
            .AsString + ',��������=' + salenum;
          next;
        end;
      log := log + result;
      SysLog.WriteLog('Ʊ�۹�����>�Ż�Ʊ��', '���', log);
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
  //���Կ�������
  if jcsdQrySchDiscountPrice.FieldByName('salenum').AsString <> '' then
  begin
    NovaEditSaleNum.text := jcsdQrySchDiscountPrice.FieldByName('salenum')
      .AsString;
  end;
  //�޸�ʱ�����ϴ��������ڣ�����ʱ���Ե�ǰ����
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
