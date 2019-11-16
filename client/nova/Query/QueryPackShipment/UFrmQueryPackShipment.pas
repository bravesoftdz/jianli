unit UFrmQueryPackShipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmQueryPackShipment = class(TSimpleCRUDForm)
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    jcdsResultshipprice: TFloatField;
    jcdsResultpackfee: TFloatField;
    jcdsResulthandfee: TFloatField;
    jcdsResultcustodial: TFloatField;
    jcdsResulttransitfee: TFloatField;
    jcdsResultinsurancefee: TFloatField;
    jcdsResultinsurance: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultORGID: TLargeintField;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    jcdsResultdeliveryfee: TFloatField;
    Label9: TLabel;
    nvhelpvehiclecode: TNovaHelp;
    jcdsResultorgname: TWideStringField;
    jcdsResultdepartdate: TWideStringField;
    jcdsResultpieces: TIntegerField;
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmQueryPackShipment: TFrmQueryPackShipment;

implementation

{$R *.dfm}

procedure TFrmQueryPackShipment.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmQueryPackShipment.FormCreate(Sender: TObject);
begin
  inherited;

  dtpstartdate.DateTime :=Now();
  dtpenddate.DateTime :=Now();

end;


procedure TFrmQueryPackShipment.FormShow(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := true;

end;

procedure TFrmQueryPackShipment.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
end;

procedure TFrmQueryPackShipment.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;


procedure TFrmQueryPackShipment.tbtnFilterClick(Sender: TObject);
begin
  inherited;
    nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('ÇëÑ¡Ôñ»ú¹¹£¡');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_p!orgid'] := nvcbborg.GetSelectID;
    {
    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime+1);
     }
     Params.ParamValues['filter_GED_p!createtime'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_p!createtime'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime+1);

    Params.ParamValues['filter_EQS_p!packtype'] := '0';
    Params.ParamValues['filter_INS_p!status'] := '(0,1)';
    if nvhelpvehiclecode.Id<=0 then
      Params.ParamValues['filter_EQL_p!vehicleid'] := ''
    else
      Params.ParamValues['filter_EQL_p!vehicleid'] := nvhelpvehiclecode.Id;

    Active := true;


  end;
end;

end.
