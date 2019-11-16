unit UFrmVipGiftExchangelog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox, DBGridEhGrouping, GridsEh,
  DBGridEh, NvDbgridEh, UICcardRW, CardManage;

type
  TfrmVipGiftExchangelog = class(TSimpleEditForm, Ivipcardfound)
    lbl1: TLabel;
    lbl10: TLabel;
    lbldate: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvdbgrdh1: TNvDbgridEh;
    jcdsEcahangeDetail: TjsonClientDataSet;
    ds1: TDataSource;
    btn2: TBitBtn;
    btn1: TBitBtn;
    lbl5: TLabel;
    nvhlpCustomerid: TNovaHelp;
    lbl2: TLabel;
    edtPhone: TNovaEdit;
    lbl6: TLabel;
    nvhlpVipGiftname: TNovaHelp;
    nvhlpUserid: TNovaHelp;
    nvhlpcardno: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure vipcardfound(vipCard:TVipCard);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Foperationid:Integer;
    vCard : TVipCard;
  public
    { Public declarations }
    customename,cardno : string;
    property operationid:Integer read Foperationid;
  end;

var
  frmVipGiftExchangelog: TfrmVipGiftExchangelog;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}


procedure TfrmVipGiftExchangelog.btn1Click(Sender: TObject);
begin
  inherited;
   //查询
  with jcdsEcahangeDetail do
  begin
    Active:=False;
    Params.ParamValues['filter_GED_vg!createtime'] :=
            formatdatetime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime)+' 00:00:00';
    Params.ParamValues['filter_LED_vg!createtime'] :=
            formatdatetime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime)+' 23:59:59';

    if (not (Trim(nvhlpUserid.Text)='')) and (nvhlpUserid.Id >0) then
      Params.ParamValues['filter_EQL_cby!id']:= nvhlpUserid.Id
    else
     Params.ParamValues['filter_EQL_cby!id']:='';

    if (not (Trim(nvhlpCustomerid.Text)='')) then
    Params.ParamByName('filter_EQL_c!id').Value := nvhlpCustomerid.Id
    else
    Params.ParamByName('filter_EQL_c!id').Value := '';

    if not (Trim(nvhlpVipGiftname.Text)='') then
    Params.ParamByName('filter_EQS_vt!name').Value  := nvhlpVipGiftname.Text
    else
    Params.ParamByName('filter_EQS_vt!name').Value  :='';

    Params.ParamByName('filter_LIKES_c!mobilephone').Value := edtPhone.Text;

     if Trim(nvhlpcardno.Text) = ''then
    begin
      Params.ParamValues['filter_LIKES_v!vipcardno'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_v!vipcardno'] := nvhlpcardno.Text;
    end;
    Active := True;
  end;
end;

procedure TfrmVipGiftExchangelog.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date:= Now-30;
  dtpenddate.Date:=Now;
    try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;

    setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
    setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
    setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
    setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
    setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
    setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;
   //读取卡号 ,查询vip卡相关信息
procedure TfrmVipGiftExchangelog.vipcardfound(vipCard: TVipCard);
var cardgarde:Integer;
begin
    vCard := vipCard;
  nvhlpcardno.Text := vCard.cardNo;
     //查询
  with jcdsEcahangeDetail do
  begin
    Active:=False;
    Params.ParamValues['filter_GED_vg!createtime'] :=
            formatdatetime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime)+' 00:00:00';
    Params.ParamValues['filter_LED_vg!createtime'] :=
            formatdatetime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime)+' 23:59:59';

    if (not (Trim(nvhlpUserid.Text)='')) and (nvhlpUserid.Id >0) then
      Params.ParamValues['filter_EQL_cby!id']:= nvhlpUserid.Id
    else
     Params.ParamValues['filter_EQL_cby!id']:='';

    if (not (Trim(nvhlpCustomerid.Text)='')) and (nvhlpCustomerid.Id >0) then
    Params.ParamByName('filter_EQL_c!id').Value := nvhlpCustomerid.Id
    else
    Params.ParamByName('filter_EQL_c!id').Value := '';

    if not (Trim(nvhlpVipGiftname.Text)='') then
    Params.ParamByName('filter_EQS_vt!name').Value  := nvhlpVipGiftname.Text
    else
    Params.ParamByName('filter_EQS_vt!name').Value  :='';

    Params.ParamByName('filter_EQS_c!mobilephone').Value := edtPhone.Text;
    Params.ParamByName('filter_EQS_v!vipcardno').Value  := vipCard.cardNo;
    Active := True;
  end;
end;

procedure TfrmVipGiftExchangelog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
 try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;


end.
