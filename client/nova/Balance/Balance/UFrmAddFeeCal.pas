unit UFrmAddFeeCal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB, DBClient,
  jsonClientDataSet;

type
  TFrmAddFeeCal = class(TSimpleEditForm)
    NvdbgridfEE: TNvDbgridEh;
    jsonqryAdditionFee: TjsonClientDataSet;
    DataSource1: TDataSource;
    jsonqryAdditionFeeid: TLargeintField;
    jsonqryAdditionFeename: TWideStringField;
    jsonqryAdditionFeedeductmoney: TFloatField;
    jsonqryAdditionFeestationid: TLargeintField;
    jsonqryAdditionFeevehicleid: TLargeintField;
    jsonqryAdditionFeeorgid: TLargeintField;
    jsonqryAdditionFeeticketnum: TLargeintField;
    jsonqryAdditionFeetotalfee: TFloatField;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure jsonqryAdditionFeedeductmoneyChange(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    curinvoicesids,curinvoicesidsother: String;
    curvehicle_id: int64;
  end;

var
  FrmAddFeeCal: TFrmAddFeeCal;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAddFeeCal.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
begin
  inherited;
  with jsonqryAdditionFee do
  begin
    if jsonqryAdditionFee.ChangeCount > 0 then
    begin
      ApplyUpdates(-1);
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
        ModalResult := mrok;
    end
    else
    begin
      ModalResult := mrok;
    end;
  end;
end;

procedure TFrmAddFeeCal.FormShow(Sender: TObject);
begin
  inherited;
  with jsonqryAdditionFee do
  begin
    active := false;
    Params.ParamValues['vehicleid'] := curvehicle_id;
    Params.ParamValues['orgid'] := SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['invoicesids'] := curinvoicesids;
    Params.ParamValues['otherinvoicesids'] := curinvoicesidsother;
    active := true;
  end;
end;

procedure TFrmAddFeeCal.jsonqryAdditionFeedeductmoneyChange(Sender: TField);
var
  price: double;
begin
  inherited;
  if Sender.Value = null then
  begin
    Sender.Value := 0;
  end;
  price := Sender.Value;
  jsonqryAdditionFee.FieldByName('totalfee').Value :=
    jsonqryAdditionFee.FieldByName('ticketnum').AsInteger * price;
 jsonqryAdditionFee.Post;
end;

end.
