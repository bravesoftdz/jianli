unit UFrmInitcard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, StdCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin,
  ExtCtrls, UFrmInitcardEdit, NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox,
  NovaComboBox, UICcardRW;

type
  TFrmInit = class(TSimpleCRUDForm, IBaseCardfound)
    jsonCDSDelInit: TjsonClientDataSet;
    jcdstypename: TjsonClientDataSet;
    jcdsResultcardtype: TWideStringField;
    jcdsResultcardno: TWideStringField;
    jcdsResultserialnumber: TWideStringField;
    jcdsResultotherinfo: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResulttypename: TWideStringField;
    jcdsResultID: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    lbl1: TLabel;
    cbborg: TNovaCheckedComboBox;
    Label2: TLabel;
    Label3: TLabel;
    cbbtype: TNovaComboBox;
    wdstrngfldResultorgname: TWideStringField;
    edtcardno: TNovaEdit;
    Label1: TLabel;
    edtserialnumber: TNovaEdit;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure iccardfound(icCard:TBaseCard);
  public
    { Public declarations }
  end;

var
  FrmInit: TFrmInit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmInit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtype.Active := False;
  cbbtype.Active := True;

  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

procedure TFrmInit.FormShow(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmInit.iccardfound(icCard: TBaseCard);
begin
  edtcardno.Text := icCard.cardNo;
end;

procedure TFrmInit.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!orgid'] := cbborg.GetSelectID;
    if Trim(edtserialnumber.Text) = '' then
    begin
      Params.ParamValues['filter_LIKES_t!serialnumber'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_t!serialnumber'] := edtserialnumber.Text;
    end;
    if Trim(edtcardno.Text) = '' then
    begin
      Params.ParamValues['filter_LIKES_t!cardno'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_t!cardno'] := edtcardno.Text;
    end;
    if Trim(cbbtype.Text) = '' then
    begin
      Params.ParamValues['filter_EQS_t!cardtype'] := '';
    end else
    begin
      Params.ParamValues['filter_EQS_t!cardtype'] := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
    Active := true;
  end;
end;

procedure TFrmInit.tbtnInsertClick(Sender: TObject);
var FrmInitEdit : TFrmInitEdit;
begin
  inherited;
  with FrmInitEdit do
  begin
    FrmInitEdit := TFrmInitEdit.Create(self);
    Caption := '初始化智能卡信息';
    flag:=true;
    ShowModal;
    tbtnFilterClick(Sender);
    jcdsResult.Locate('id', id, []);
    FreeAndNil(FrmInitEdit);
  end;
end;

end.
