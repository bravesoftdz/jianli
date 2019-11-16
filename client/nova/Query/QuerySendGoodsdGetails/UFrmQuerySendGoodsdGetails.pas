unit UFrmQuerySendGoodsdGetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit, NovaComboBox, Services;

type
  TFrmQuerySendGoodsdGetails = class(TSimpleCRUDForm)
    Label5: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Novahelpsenderuser: TNovaEdit;
    Novahelpsenderphoneno: TNovaEdit;
    nvhelpvehicleno: TNovaHelp;
    Label6: TLabel;
    Label7: TLabel;
    novahelpStation: TNovaHelp;
    Label8: TLabel;
    sendstartdate: TDateTimePicker;
    sendenddate: TDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    novehelppackno: TNovaEdit;
    Label11: TLabel;
    novahelpconsigneeuser: TNovaEdit;
    novahelpconsigneephone: TNovaEdit;
    Label12: TLabel;
    nvhelpsignby: TNovaHelp;
    nvhelpsellby: TNovaHelp;
    jcdsgoodstype: TjsonClientDataSet;
    jcdsshiptype: TjsonClientDataSet;
    jcdspaymethod: TjsonClientDataSet;
    jscdsstutas: TjsonClientDataSet;
    jcdspacked: TjsonClientDataSet;
    jcdsResult2: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQuerySendGoodsdGetails: TFrmQuerySendGoodsdGetails;

implementation

{$R *.dfm}

procedure TFrmQuerySendGoodsdGetails.FormShow(Sender: TObject);
begin
  inherited;
  jcdsgoodstype.Active := True;
  jcdsshiptype.Active := True;
 jcdspaymethod.Active :=True;
 jscdsstutas.Active :=True;
  jcdspacked.Active :=True;
  sendstartdate.DateTime := now();
  sendenddate.DateTime := now();
end;

procedure TFrmQuerySendGoodsdGetails.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult2 do
  begin
    Active := False;
    if FormatDateTime('yyyymmdd', sendstartdate.Date) > FormatDateTime
      ('yyyymmdd', sendenddate.Date) then
    begin
      SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
      exit;
    end;
    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendstartdate.Date);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendenddate.Date); // ���  ����

    if novahelpStation.Id > 0 then
      Params.ParamValues['filter_EQS_p!sendstationid'] := novahelpStation.Id
    else
      Params.ParamValues['filter_EQS_p!sendstationid'] := ''; // ���  Ŀ�ĵ�

    if novehelppackno.Text <> '' then
      Params.ParamValues['filter_LIKES_p!packno'] := novehelppackno.Text
    else
      Params.ParamValues['filter_LIKES_p!packno'] := ''; // ���  �а�����

      if Novahelpsenderuser.Text <> '' then
      Params.ParamValues['filter_LIKES_p!sender'] := Novahelpsenderuser.Text
    else
      Params.ParamValues['filter_LIKES_p!sender'] := ''; //������

    if Novahelpsenderphoneno.Text <> '' then
      Params.ParamValues['filter_LIKES_p!senderphone'] := Novahelpsenderphoneno.Text
    else
      Params.ParamValues['filter_LIKES_p!senderphone'] := '';       // ���  �����˵绰
//    Novahelpsenderuser
    if novahelpconsigneeuser.Text <> '' then
      Params.ParamValues['filter_LIKES_p!consignee'] :=
        novahelpconsigneeuser.Text
    else
      Params.ParamValues['filter_LIKES_p!consignee'] := ''; // ��� �ջ���

    if novahelpconsigneephone.Text <> '' then
      Params.ParamValues['filter_LIKES_p!consigneephone'] :=
        novahelpconsigneephone.Text
    else
      Params.ParamValues['filter_LIKES_p!consigneephone'] := ''; // ���  �ջ��˵绰
    if nvhelpvehicleno.Id > 0 then
      Params.ParamValues['filter_EQS_p!vehicleid'] := nvhelpvehicleno.Id
    else
      Params.ParamValues['filter_EQS_p!vehicleid'] := ''; // ���  ���ƺ�


       if nvhelpsellby.Id > 0 then
      Params.ParamValues['filter_EQS_p!sellby'] := nvhelpsellby.Id
    else
      Params.ParamValues['filter_EQS_p!sellby'] := '';    //����Ա

      if nvhelpsignby.Id > 0 then
      Params.ParamValues['filter_EQS_p!signby'] := nvhelpsignby.Id
    else
      Params.ParamValues['filter_EQS_p!signby'] := '';    //ǩ��Ա

    Active := True;
  end;

end;

end.
