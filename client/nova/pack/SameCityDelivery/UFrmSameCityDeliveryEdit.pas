unit UFrmSameCityDeliveryEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Services, Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaComboBox,
  UDMPublic, NovaHelp, NovaEdit, DB, DBClient, jsonClientDataSet, ComCtrls;

type
  TFrmSameCityDeliveryEditForm = class(TSimpleEditForm)
    jcdspackdeliveryupdate: TjsonClientDataSet;
    Label4: TLabel;
    nvedtoutbound: TNovaHelp;
    nvedtdiliver: TNovaHelp;
    Label6: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    lbl4: TLabel;
    outdate: TDateTimePicker;
    Label1: TLabel;
    dilivedate: TDateTimePicker;
    nvedtdiliveno: TNovaEdit;
    Label3: TLabel;
    Label2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    id : Integer;
    log : string;
  public
    { Public declarations }
    packdiliveryid : Integer;
    updatetime:TDateTime;//date	n	sys;//date
	  updateby:Integer;//number(10)	n
  end;

var
  FrmSameCityDeliveryEditForm: TFrmSameCityDeliveryEditForm;

implementation
{$R *.dfm}

procedure TFrmSameCityDeliveryEditForm.bbtnSaveClick(Sender: TObject);
var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result: string;
  packstatus: string;
  packstatusvalue: string;
begin
  inherited;
  if trim(nvedtdiliveno.Text) = '' then
  begin
    SysDialogs.ShowMessage('送货单号不能为空!');
    nvedtdiliveno.SetFocus;
    exit;
  end;
  if nvedtoutbound.id = 0 then
  begin
    SysDialogs.ShowMessage('出库人不能为空!');
    nvedtoutbound.SetFocus;
    exit;
  end;
  if nvedtdiliver.id = 0 then
  begin
    SysDialogs.ShowMessage('送货人不能为空!');
    nvedtdiliver.SetFocus;
    exit;
  end;

  try
    with jcdspackdeliveryupdate do
    begin
      Active := false;
      Params.ParamValues['packdilivery.id'] := packdiliveryid;
      Params.ParamByName('packdilivery.diliveno').Value := trim(nvedtdiliveno.Text); // 送货单号
      Params.ParamByName('packdilivery.outbound').Value := nvedtoutbound.id; // 出库人
      Params.ParamByName('packdilivery.outdate').Value := FormatDateTime('yyyy-mm-dd', outdate.Date); // 出库日期
      Params.ParamByName('packdilivery.diliver').Value := nvedtdiliver.id; // 送货人
      Params.ParamByName('packdilivery.dilivedate').Value := FormatDateTime('yyyy-mm-dd', dilivedate.Date); // 送货日期

      bbtnSave.Enabled := false;
      Execute;
      bbtnSave.Enabled := true;
      if Params.ParamValues['msg'] <> '' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag'] = 1 then
      begin
        bbtnSave.Enabled := false;
        result := '修改：';
        log := result + VarToStr(Params.ParamValues['packdilivery.id'])
          + '同城送货：所属机构=' + SysInfo.LoginUserInfo.OrgName + ',送包单号=' + trim
          (nvedtdiliveno.Text) + ',' + '出库人=' + nvedtoutbound.Text + ',出库日期=' +
          FormatDateTime('yyyy-mm-dd', outdate.Date)
          + ',送货人=' + nvedtdiliver.Text + ',送货日期=' + FormatDateTime
          ('yyyy-mm-dd', dilivedate.Date);
        SysLog.WriteLog('行包管理->同城送货', result, log);

        self.ModalResult := mrOk;
      end;
    end;
  except on E:exception do
  begin
    showMessage(e.ToString);
  end;
  end;
end;

procedure TFrmSameCityDeliveryEditForm.FormCreate(Sender: TObject);
begin
  inherited;
//  packdiliveryid := 0;
//  with FrmSameCityDeliveryForm.jcdsResult do
//  begin
//    self.nvedtdiliveno.Text := FindField('diliveno').AsString;
//    self.nvedtoutbound.Text := FindField('outboundname').AsString;
//    self.nvedtoutbound.id := FindField('outbound').AsInteger;
//    self.outdate.DateTime := FindField('outdate').AsDateTime;
//    self.nvedtdiliver.Text := FindField('dilivername').AsString;
//    self.nvedtdiliver.id := FindField('diliver').AsInteger;
//    self.dilivedate.DateTime := FindField('dilivedate').AsDateTime;
//  end;

end;

end.
