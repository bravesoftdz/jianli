unit UFrmViproomcheckin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
   ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit,Services,NvPrnDbgeh, NvDbgridEh,FunctionItemIntf,
  UFrmViproomcheckinEdit, NovaCheckedComboBox, UICcardRW, CardManage;

type
  TfrmViproomcheckin= class(TSimpleCRUDForm, Ivipcardfound)
    lbl3: TLabel;
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    grp3: TGroupBox;
    grp8: TGroupBox;
    nvdbgrdhTicke: TNvDbgridEh;
    grp1: TGroupBox;
    grp2: TGroupBox;
    tlb2: TToolBar;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    btn11: TToolButton;
    btn12: TToolButton;
    nvdbgrdh1: TNvDbgridEh;
    lbl2: TLabel;
    lbl17: TLabel;
    edtTicketno: TNovaEdit;
    lbl4: TLabel;
    nvhlpschedule: TNovaHelp;
    dtpEdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl11: TLabel;
    nvhlpCustomerid: TNovaHelp;
    lbl6: TLabel;
    edtTicketentrance: TNovaEdit;
    nvhlpcard: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure vipcardfound(vipCard:TVipCard);
    procedure nvhlpcardIdChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
//    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    functiontype :string;
    vipBaseCard : TVipCard;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;
    parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); override;
  end;

var
  frmViproomcheckin: TfrmViproomcheckin;

implementation
uses UDMPublic,PubFn;

{$R *.dfm}
constructor TfrmViproomcheckin.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;checkpermission:boolean);
begin
  inherited;
  //功能类型  0会员进入贵宾室登记，1 历史记录查询
  functiontype:=parameter.strings[0];
  if functiontype='0' then
  begin
     lbl3.Visible:= False;
     nvckbOrgid.Visible:= False;
     lbl11.Visible:= False;
     dtpBdepartdate.Visible:= False;
     lbl5.Visible := False;
     dtpEdepartdate.Visible:=False;
     lbl1.Top:=14;
     lbl1.Left:=39;
     nvhlpCustomerid.Top:=12;
     nvhlpCustomerid.Left:=98;
     lbl4.Top:=14;
     lbl4.Left:=239;
     nvhlpschedule.Left:=287;
     nvhlpschedule.Top:=12;
     lbl2.Top:=14;
     lbl2.Left:=405;
     nvhlpcard.Top:=12;
     nvhlpcard.Left :=440;
     lbl6.Top:=43;
     lbl6.Left:=53;
     edtTicketentrance.Top:=40;
     edtTicketentrance.Left:=98;
     lbl17.Top:=43;
     lbl17.Left:=253;
     edtTicketno.Top:=40;
     edtTicketno.Left:=284;

  end;

end;


procedure TfrmViproomcheckin.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpBdepartdate.Date:= Now;
  dtpEdepartdate.Date:=Now;

end;


procedure TfrmViproomcheckin.FormShow(Sender: TObject);
begin
  inherited;
   if functiontype='0' then
  begin
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
end;

procedure TfrmViproomcheckin.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  //查询
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_ckby!orgid']:=  nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_s!code']:=  nvhlpschedule.Text;
    Params.ParamValues['filter_EQS_ts!ticketno']:= edtTicketno.Text;
    Params.ParamValues['filter_LIKES_ct!name'] := nvhlpCustomerid.Text;
    Params.ParamValues['filter_GED_vr!checkintime'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)+' 00:00:00';
    Params.ParamValues['filter_LED_vr!checkintime'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date)+' 23:59:59';
    Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcard.Text;
    Params.ParamValues['filter_EQS_ts!ticketentrance'] := edtTicketentrance.Text;

    Active := True;
  end;
end;


procedure TfrmViproomcheckin.tbtnInsertClick(Sender: TObject);
begin
  inherited;

end;

//读取卡号 ,查询vip卡相关信息
procedure TfrmViproomcheckin.vipcardfound(vipCard: TVipCard );
var cardnoname,cardamout,cardgardename:string;
cardgarde:Integer;
Sender: TObject;
begin
  vipBaseCard := vipCard;
  cardnoname := vipBaseCard.cardNo;
 if functiontype='0' then   //登记：打开登记窗口
 begin
    cardamout:= CurrToStr(vipBaseCard.amount);
    cardgarde:=  Integer(vipBaseCard.cardGrade );

    if cardgarde =0 then
     cardgardename :='一卡通'
    else if cardgarde=1 then
     cardgardename :='普卡'
    else if cardgarde =2 then
     cardgardename:='金卡' ;

  if cardgarde=0  then
  begin
    SysDialogs.Warning('一卡通不能进入贵宾室！');
    exit
  end;

  frmViproomcheckinEdit := TfrmViproomcheckinEdit.Create(self);
  with frmViproomcheckinEdit do
  begin
    Caption := '会员进入贵宾室登记';
    edtcardno.Text :=  cardnoname;
    edtVipgrade.Text :=cardgardename;
    edtVipAmount.Text  :=cardamout;
    //根据卡号读取vipID 和姓名
    with jcdsFindcardInfo do
    begin
      Active:=False;
      Params.ParamByName('cardno').Value := cardnoname;
      Active := True;
    end;
    if jcdsFindcardInfo.RecNo>=0 then
    begin
      vipid :=jcdsFindcardInfo.FieldByName('vipid').AsInteger;
      edtName.Text :=jcdsFindcardInfo.FieldByName('customername').AsString;
    end;

    ShowModal;
    //nvhlpcard.Text :=cardnoname;
    if ModalResult = mrok then
    begin
//       with jcdsResult do
//      begin
//        Active:=False;
//        Params.ParamValues['filter_INS_ckby!orgid']:=  nvckbOrgid.GetSelectID;
//        Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcard.Text;
//        Params.ParamValues['filter_EQS_s!code']:=  nvhlpschedule.Text;
//        Params.ParamValues['filter_EQS_ts!ticketno']:= edtTicketno.Text;
//        Params.ParamValues['filter_LIKES_ct!name'] := nvhlpCustomerid.Text;
//        Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
//        Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
//        //Params.ParamValues['filter_EQS_v!vipcardno'] := cardnoname;
//        Active:= True;
//      end;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
 end
 else  //查询历史记录，调用查询按钮
 begin
    nvhlpcard.Text:= vipBaseCard.cardNo;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_ckby!orgid']:=  nvckbOrgid.GetSelectID;
    Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcard.Text;
    Params.ParamValues['filter_EQS_s!code']:=  nvhlpschedule.Text;
    Params.ParamValues['filter_EQS_ts!ticketno']:= edtTicketno.Text;
    Params.ParamValues['filter_LIKES_ct!name'] := nvhlpCustomerid.Text;
    Params.ParamValues['filter_GED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    Params.ParamValues['filter_LED_ts!departdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);

    Active:= True;
  end;
 end;

end;

procedure TfrmViproomcheckin.nvhlpcardIdChange(Sender: TObject);
begin
  inherited;
   with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_ckby!orgid']:=  nvckbOrgid.GetSelectID;
    if (not (Trim(nvhlpcard.Text)='')) and (nvhlpcard.Id >0)then
    Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcard.Text;
    Active:= True;
  end;
end;

procedure TfrmViproomcheckin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
   if functiontype='0' then
  begin
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
  end;

end;

end.
