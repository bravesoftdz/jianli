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
  upmoneydate:TDateTime;//	date	n			营收日期
  sellby:Integer;//	number(10)	n			办理员
  sendpacks:Integer;//	number(6)	y			受理件数
  sendpackamount:Double;//	number(10,2)	n			受理营收
  pickups:Integer;//	number(6)	y			提领件数
  pickupamount:Double;//	number(10,2)	y			提领营收
  goods:Integer;//	number(6)	y			寄存件数
  goodsamount:Double;//	number(10,2)	y			寄存营收
  moneypayable:Double;//	number(10,2)	y			应缴款
  actupmoney:Double;//	number(10,2)	y			实缴款
  receiver:Integer;//	number(10)	y			收款人id
  receipttime:TDateTime;//	date	y			收款时间
  receiptip:string;//	varchar2(20)	y			收款ip
  remak:string;//	varchar2(50)	y			备注
  orgid:Integer;//	number(10)	y			收站机构id
  createtime:TDateTime;//	date	n	sysdate
  createby:Integer;//	number(10)	n
  updatetime:TDateTime;//	date	n	sysdate
  updateby:Integer;//	number(10)	n

  //多个日期一起缴款
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
    Params.ParamValues['pactturnoverdetailid']:= pactturnoverdetailid;// 行包缴款明细表ID
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
 //       result := '修改'
      else
 //       result := '添加';

 //     SysLog.WriteLog('行包管理->行包审核',result,log);

      self.ModalResult := mrOk;

    end;

    Foperationid := Params.ParamValues['packtturnoverid'];

  end;



end;

end.
