unit UFrmAgentCal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet;

type
  TFrmAgentCal = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    NovaEdtRate: TNovaEdit;
    LabInfo: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    jsonqryAdditionFee: TjsonClientDataSet;
    jsonqryAdditionFeeid: TLargeintField;
    jsonqryAdditionFeename: TWideStringField;
    jsonqryAdditionFeedeductmoney: TFloatField;
    jsonqryAdditionFeestationid: TLargeintField;
    jsonqryAdditionFeevehicleid: TLargeintField;
    jsonqryAdditionFeeorgid: TLargeintField;
    jsonqryAdditionFeeticketnum: TLargeintField;
    jsonqryAdditionFeetotalfee: TLargeintField;
  private
    { Private declarations }
  public
    { Public declarations }
    curinvoicesids: String;
    curvehicle_id: int64;
  end;

var
  FrmAgentCal: TFrmAgentCal;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

end.
