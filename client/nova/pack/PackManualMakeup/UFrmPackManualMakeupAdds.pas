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
    SysDialogs.Warning('行包结算单号和受理单号不能同时为空！');
    Exit;
  end;
  if (Trim(departpacknoname.Text) = '') then
  begin
    SysDialogs.Warning('行包结算单号不能为空！');
    Exit;
  end;
  if (Trim(nvhelptostation.Text) = '') then
  begin
    SysDialogs.Warning('目的地不能为空！');
    Exit;
  end;
  if (Trim(nvedtshipprice.Text) = '') then
  begin
    SysDialogs.Warning('运费不能为空！');
    Exit;
  end;
   if (Trim(NovaHelpVehicleNo.Text) = '') then
   begin
   SysDialogs.Warning('车牌号不能为空！');
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
    // // log := '添加票据类型：编码='+edtcode.Text+',类型='+cbbmedium.Text+',名称='
    // // +edtname.Text+',打印名称='+edtprintname.Text+',票面价值='+edtparvalue.Text+
    // // ',每本张数='+edtnumperbox.Text+',票号长度='+edtticketnolength.Text+',描述='+
    // // mmodes.Text;
    // // SysLog.WriteLog('票据类型——>票据类型','添加',log);
    //
    // ModalResult := mrok;
    // end;
    // except
    // on E: Exception do
    // begin
    // SysLog.WriteErr('行包结算单补录失败：' + E.Message);
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
