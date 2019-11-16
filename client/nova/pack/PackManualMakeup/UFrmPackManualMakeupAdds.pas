unit UFrmPackManualMakeupAdds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaHelp, ComCtrls, NovaEdit, Services;

type
  TFrmPackManualMakeupAdds = class(TSimpleEditForm)
    novepackno: TNovaEdit;
    Label2: TLabel;
    Label1: TLabel;
    departpacknoname: TNovaEdit;
    Label6: TLabel;
    dtpdepartdate: TDateTimePicker;
    Label3: TLabel;
    nvhelptostation: TNovaHelp;
    nvedtshipprice: TNovaEdit;
    Label33: TLabel;
    jcdsFindpackAndDepinfo: TjsonClientDataSet;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    jcdsSavedepartdatevoice: TjsonClientDataSet;
    Label9: TLabel;
    nvedtbalanceprice: TNovaEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    NovaHelpVehicleNo: TNovaHelp;
    Label5: TLabel;
    jcdsFindpackedepartinvoiceAndDepinfo: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure novepacknoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvedtshippriceChange(Sender: TObject);

  private
    { Private declarations }
    msg: String;
    packdepartinvoiceid: string;
    ismodifybalanceprice:boolean;
  public
    { Public declarations }
  end;

var
  FrmPackManualMakeupAdds: TFrmPackManualMakeupAdds;

implementation
uses PubFn;
{$R *.dfm}

procedure TFrmPackManualMakeupAdds.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (Trim(departpacknoname.Text) = '') and (Trim(novepackno.Text) = '') then
  begin
    SysDialogs.Warning('�а����㵥�ź������Ų���ͬʱΪ�գ�');
    Exit;
  end;
  if (Trim(departpacknoname.Text) = '') then
  begin
    SysDialogs.Warning('�а����㵥�Ų���Ϊ�գ�');
    Exit;
  end;
  if (Trim(nvhelptostation.Text) = '') then
  begin
    SysDialogs.Warning('Ŀ�ĵز���Ϊ�գ�');
    Exit;
  end;
  if (Trim(nvedtshipprice.Text) = '') then
  begin
    SysDialogs.Warning('�˷Ѳ���Ϊ�գ�');
    Exit;
  end;
   if (Trim(NovaHelpVehicleNo.Text) = '') then
   begin
   SysDialogs.Warning('���ƺŲ���Ϊ�գ�');
   Exit;
   end;
  with jcdsSavedepartdatevoice do
  begin
    Close;
    Params.ParamValues['packDeparvo.packdepartinvoicesid'] :=
      packdepartinvoiceid;
    Params.ParamValues['packDeparvo.vehicleid'] := NovaHelpVehicleNo.Id;
    Params.ParamValues['packDeparvo.tostationid'] := nvhelptostation.Id;
    Params.ParamValues['packDeparvo.departinvoicesno'] := departpacknoname.Text;
    Params.ParamValues['packDeparvo.shipprice'] := nvedtshipprice.Text;
    Params.ParamValues['packDeparvo.balancemount'] := nvedtbalanceprice.Text;
    Params.ParamValues['packDeparvo.departdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpdepartdate.DateTime);
    Execute;
    if Params.ParamValues['flag']<>1 then
    begin
         SysDialogs.ShowMessage(Params.ParamValues['msg']);
         departpacknoname.SetFocus;
    end
    else
    begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
        ModalResult := mrok;
    end;
    // FrmPackManualMakeupAdds.Close;
    // try
    // Execute;
    // nResult := Params.ParamByName('flag').Value;
    // sResult := Params.ParamByName('msg').Value;
    // SysDialogs.ShowMessage(sResult);
    // if (nResult <= 0) then
    // begin
    // novepackno.SetFocus;
    // end
    // else
    // begin
    // // log := '���Ʊ�����ͣ�����='+edtcode.Text+',����='+cbbmedium.Text+',����='
    // // +edtname.Text+',��ӡ����='+edtprintname.Text+',Ʊ���ֵ='+edtparvalue.Text+
    // // ',ÿ������='+edtnumperbox.Text+',Ʊ�ų���='+edtticketnolength.Text+',����='+
    // // mmodes.Text;
    // // SysLog.WriteLog('Ʊ�����͡���>Ʊ������','���',log);
    //
    // ModalResult := mrok;
    // end;
    // except
    // on E: Exception do
    // begin
    // SysLog.WriteErr('�а����㵥��¼ʧ�ܣ�' + E.Message);
    // end;
    // end;
  end;
end;

procedure TFrmPackManualMakeupAdds.FormShow(Sender: TObject);
begin
  inherited;
  dtpdepartdate.DateTime := now();
  ismodifybalanceprice:=true;
end;

procedure TFrmPackManualMakeupAdds.novepacknoExit(Sender: TObject);
begin
  inherited;
  if novepackno.Text <> '' then
  begin

    with jcdsFindpackAndDepinfo do
    begin
      Active := false;
      Params.ParamValues['packno'] := novepackno.Text;
      Active := True;
      if Params.ParamValues['flag']<>1 then
      begin
          SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;

      if RecordCount > 0 then
      begin
        departpacknoname.Text := FieldByName('departinvoicesno').AsString;
        nvhelptostation.Id := FieldByName('tostationid').AsInteger;
        nvhelptostation.Text := FieldByName('tostationname').AsString;
        dtpdepartdate.DateTime := FieldByName('departdate').AsDateTime;
        nvedtshipprice.Text := FieldByName('shipprice').AsString;
        NovaHelpVehicleNo.Id := FieldByName('vehicleid').AsInteger;
        NovaHelpVehicleNo.Text := FieldByName('vehicleno').AsString;
        nvedtbalanceprice.Text := FieldByName('balanceamount').AsString;
        packdepartinvoiceid := FieldByName('packdepartinvoiceid').AsString;
        ismodifybalanceprice:=false;
      end;
    end;
  end;

end;

procedure TFrmPackManualMakeupAdds.nvedtshippriceChange(Sender: TObject);
var balancerate:String;
begin
  inherited;
  if ismodifybalanceprice then
  begin
      balancerate := getParametervalue('8099', sysInfo.LoginUserInfo.OrgID);
      nvedtbalanceprice.Text := floattostr(strtofloat(balancerate)*strtofloat(nvedtshipprice.Text));
  end;

end;

end.
