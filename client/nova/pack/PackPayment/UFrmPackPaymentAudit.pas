unit UFrmPackPaymentAudit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, DB, DBClient, jsonClientDataSet;

type
  TFrmPackPaymentAudit = class(TSimpleEditForm)
    Label1: TLabel;
    nvedtorgname: TNovaEdit;
    Label14: TLabel;
    nvedtsellby: TNovaEdit;
    lblsendpacks: TLabel;
    nvedtsendpacks: TNovaEdit;
    lblsendpackamount: TLabel;
    nvedtsendpackamount: TNovaEdit;
    lblpickups: TLabel;
    nvedtpickups: TNovaEdit;
    lblpickupamount: TLabel;
    nvedtpickupamount: TNovaEdit;
    Label51: TLabel;
    nvedtmoneypayable: TNovaEdit;
    Label4: TLabel;
    nvedtactupmoney: TNovaEdit;
    lbl4: TLabel;
    dtpupmoneydate: TDateTimePicker;
    Label10: TLabel;
    nvedtlost: TNovaEdit;
    Label5: TLabel;
    dtpreceipttime: TDateTimePicker;
    jcdspacktturnoverAudit: TjsonClientDataSet;
    Label2: TLabel;
    nvedtpackstrike: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    Foperationid: Integer;
    log:string;
  public
    { Public declarations }
    pactturnoverdetailid:string;
  packtturnoverid:Integer;//	number(10)	n
  upmoneydate:TDateTime;//	date	n			Ӫ������
  sellby:Integer;//	number(10)	n			����Ա
  sendpacks:Integer;//	number(6)	y			�������
  sendpackamount:Double;//	number(10,2)	n			����Ӫ��
  pickups:Integer;//	number(6)	y			�������
  pickupamount:Double;//	number(10,2)	y			����Ӫ��
  goods:Integer;//	number(6)	y			�Ĵ����
  goodsamount:Double;//	number(10,2)	y			�Ĵ�Ӫ��
  moneypayable:Double;//	number(10,2)	y			Ӧ�ɿ�
  actupmoney:Double;//	number(10,2)	y			ʵ�ɿ�
  receiver:Integer;//	number(10)	y			�տ���id
  receipttime:TDateTime;//	date	y			�տ�ʱ��
  receiptip:string;//	varchar2(20)	y			�տ�ip
  remak:string;//	varchar2(50)	y			��ע
  orgid:Integer;//	number(10)	y			��վ����id
  createtime:TDateTime;//	date	n	sysdate
  createby:Integer;//	number(10)	n
  updatetime:TDateTime;//	date	n	sysdate
  updateby:Integer;//	number(10)	n

  //�������һ��ɿ�
  as_sendpacks,as_pickups,as_depositpieces,as_recaptionspieces,
  as_sendpackamount,as_pickupamount,as_goodsamount,as_moneypayable,
  as_upmoneydate,as_lastlost:string;

  property operationid: Integer read Foperationid;
  end;

var
  FrmPackPaymentAudit: TFrmPackPaymentAudit;

implementation
uses Services,PubFn;

{$R *.dfm}

procedure TFrmPackPaymentAudit.bbtnSaveClick(Sender: TObject);
begin
  inherited;

   with jcdspacktturnoverAudit do
  begin
    Active :=false;
    Params.ParamValues['pactturnoverdetailid']:= pactturnoverdetailid;// �а��ɿ���ϸ��ID
    bbtnSave.Enabled :=false;
    Execute;
    bbtnSave.Enabled :=true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled :=false;
      if packtturnoverid > 0 then
 //       result := '�޸�'
      else
 //       result := '���';

 //     SysLog.WriteLog('�а�����->�а����',result,log);

      self.ModalResult := mrOk;

    end;

    Foperationid := Params.ParamValues['packtturnoverid'];

  end;



end;

end.
