unit UFrmQuerySendGoodsd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls ,Services, NovaEdit, NovaHelp, NovaComboBox;

type
  TFrmQuerySendGoodsd = class(TSimpleCRUDForm)
    jcdsgoodstype: TjsonClientDataSet;
    jcdsResultsendstationname: TWideStringField;
    jcdsResultpackno: TWideStringField;
    jcdsResulttostationname: TWideStringField;
    jcdsResultpackname: TWideStringField;
    jcdsResultgoodtype: TWideStringField;
    jcdsResultgoodtypename: TWideStringField;
    jcdsResultpieces: TWideStringField;
    jcdsResultweight: TFloatField;
    jcdsResultsender: TWideStringField;
    jcdsResultsenderphone: TWideStringField;
    jcdsResultsenderaddress: TWideStringField;
    jcdsResultconsignee: TWideStringField;
    jcdsResultconsigneephone: TWideStringField;
    jcdsResultconsigneeaddress: TWideStringField;
    jcdsResultdepartdate: TDateField;
    jcdsResultshiptype: TWideStringField;
    jcdsshiptype: TjsonClientDataSet;
    jcdsResultshiptypename: TWideStringField;
    jcdspaymethod: TjsonClientDataSet;
    jcdsResultpaymethod: TWideStringField;
    jcdsResultpaymethodname: TWideStringField;
    jcdspackstatus: TjsonClientDataSet;
    jcdspacked: TjsonClientDataSet;
    jcdsResultpackstatus: TWideStringField;
    jcdsResultpackstatusname: TWideStringField;
    jcdsResultsellby: TWideStringField;
    jcdsResultsingbillno: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultsignby: TWideStringField;
    jcdsResultsigntime: TDateField;
    sendstartdate: TDateTimePicker;
    Label9: TLabel;
    sendenddate: TDateTimePicker;
    Label10: TLabel;
    jcdsResultvolume: TWideStringField;
    jcdsResultpacked: TWideStringField;
    jcdsResultpackedname: TWideStringField;
    jcdsResultshipprice: TFloatField;
    jcdsResultpackfee: TFloatField;
    jcdsResulthandfee: TFloatField;
    jcdsResulttransitfee: TFloatField;
    jcdsResultinsurancefee: TFloatField;
    jcdsResultdeliveryfee: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResultservicefee: TFloatField;
    jcdsResultpackprice: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultremak: TWideStringField;
    jcdsResultcreatetime: TDateField;
    jcdsResultcreateby: TWideStringField;
    jcdsResultupdatetime: TDateField;
    jcdsResultupdateby: TWideStringField;
    Label6: TLabel;
    nvhelpsellby: TNovaHelp;
    Label7: TLabel;
    nvhelpsignby: TNovaHelp;
    Label3: TLabel;
    novehelppackno: TNovaEdit;
    Label1: TLabel;
    Novahelpsenderuser: TNovaEdit;
    Label5: TLabel;
    Novahelpsenderphoneno: TNovaEdit;
    Label8: TLabel;
    novahelpStation: TNovaHelp;
    Label11: TLabel;
    novahelpconsigneeuser: TNovaEdit;
    Label12: TLabel;
    novahelpconsigneephone: TNovaEdit;
    Label2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    Novapackstatus: TNovaComboBox;
    Label4: TLabel;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultdriverhpone: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQuerySendGoodsd: TFrmQuerySendGoodsd;

implementation

{$R *.dfm}

procedure TFrmQuerySendGoodsd.FormCreate(Sender: TObject);
begin
  inherited;
jcdsgoodstype.Active := True;
jcdsshiptype.Active := True;
jcdspaymethod.Active := True;
jcdspackstatus.Active := True;
 sendstartdate.DateTime := now();
  sendenddate.DateTime := now();
  Novapackstatus.Active := true;
end;

procedure TFrmQuerySendGoodsd.FormShow(Sender: TObject);
begin
  inherited;
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
  Novapackstatus.Items.Delete(3);
end;

procedure TFrmQuerySendGoodsd.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
       if FormatDateTime('yyyymmdd', sendstartdate.Date) > FormatDateTime
      ('yyyymmdd', sendenddate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      exit;
    end;
    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendstartdate.Date);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendenddate.Date); // 入参  日期

     if novahelpStation.Id > 0 then
      Params.ParamValues['filter_EQS_p!tostationid'] := novahelpStation.Id
    else
      Params.ParamValues['filter_EQS_p!tostationid'] := ''; // 入参  目的地

    if novehelppackno.Text <> '' then
      Params.ParamValues['filter_LIKES_p!packno'] := novehelppackno.Text
    else
      Params.ParamValues['filter_LIKES_p!packno'] := ''; // 入参  行包单号

     if Novahelpsenderuser.Text <> '' then
     Params.ParamValues['filter_LIKES_p!sender'] := Novahelpsenderuser.Text
    else
     Params.ParamValues['filter_LIKES_p!sender'] := ''; //托运人

    if Novahelpsenderphoneno.Text <> '' then
      Params.ParamValues['filter_LIKES_p!senderphone'] := Novahelpsenderphoneno.Text
    else
      Params.ParamValues['filter_LIKES_p!senderphone'] := '';       // 入参  托运人电话
//    Novahelpsenderuser
    if novahelpconsigneeuser.Text <> '' then
      Params.ParamValues['filter_LIKES_p!consignee'] :=
        novahelpconsigneeuser.Text
    else
      Params.ParamValues['filter_LIKES_p!consignee'] := ''; // 入参 收货人

    if novahelpconsigneephone.Text <> '' then
      Params.ParamValues['filter_LIKES_p!consigneephone'] :=
        novahelpconsigneephone.Text
    else
      Params.ParamValues['filter_LIKES_p!consigneephone'] := ''; // 入参  收货人电话//
   if nvhelpvehicleno.Id > 0 then
     Params.ParamValues['filter_EQS_p!vehicleid'] := nvhelpvehicleno.Id
    else
      Params.ParamValues['filter_EQS_p!vehicleid'] := ''; // 入参  车牌号

       if nvhelpsellby.Id > 0 then
      Params.ParamValues['filter_EQS_p!sellby'] := nvhelpsellby.Id
    else
      Params.ParamValues['filter_EQS_p!sellby'] := '';    //受理员

      if nvhelpsignby.Id > 0 then
      Params.ParamValues['filter_EQS_p!signby'] := nvhelpsignby.Id
   else
      Params.ParamValues['filter_EQS_p!signby'] := '';    //签发员

      if Novapackstatus.ItemIndex < 0 then
      Params.ParamValues['filter_EQS_p!status'] := ''
    else
      Params.ParamValues['filter_EQS_p!status'] := Novapackstatus.GetSelectCode;
    Active := True;
  end
end;
end.
