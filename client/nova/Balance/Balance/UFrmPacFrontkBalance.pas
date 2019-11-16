unit UFrmPacFrontkBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ExtCtrls, StdCtrls, NovaEdit, NovaHelp, ImgList,
  Buttons, DB, DBClient, jsonClientDataSet,services,NovaPrint,Generics.Collections;

type
  TFrmPacFrontkBalance = class(TSimpleEditForm)
    Label10: TLabel;
    NovaHelpUnit: TNovaHelp;
    shp1: TShape;
    Bevel6: TBevel;
    Bevel4: TBevel;
    Bevel3: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BtnPrint: TBitBtn;
    jcdssavebalance: TjsonClientDataSet;
    nvnos: TLabel;
    nvpieces: TLabel;
    nvbalancemoney: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    packbalanceno: string;
    ids : string;
    packmoney1 : Double;
    packprice1 : Double;
    nos,balanceid : string;
  end;
var
  FrmPacFrontkBalance: TFrmPacFrontkBalance;
implementation

{$R *.dfm}

procedure TFrmPacFrontkBalance.bbtnSaveClick(Sender: TObject);
var
  nResult : Integer;
  sResult,log : String;
begin
  inherited;
  if Trim(NovaHelpUnit.Text)='' then
  begin
   SysDialogs.Warning('结算单位不能为空');
   Exit;
  end;
  with jcdssavebalance do
  begin
    Active := false;
    Params.ParamValues['packbalance.packbalancemoney'] := StrToFloat(nvbalancemoney.Caption);
    Params.ParamValues['packbalance.packdeductmoney'] := 0;
    Params.ParamValues['packbalance.balanceunitname'] := NovaHelpUnit.Text;
    Params.ParamValues['packbalance.balanceip'] :=  SysInfo.LocalHostAddress;
    Params.ParamValues['packbalance.orgid'] := SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['packbalance.ids'] := ids;
    Params.ParamValues['packbalance.status'] := '0';
    Params.ParamValues['packbalance.datatype'] := '1';
    Params.ParamValues['packbalance.pieces'] := StrToInt(nvpieces.Caption);
    Params.ParamValues['packbalance.packmoney'] := packmoney1;
    Params.ParamValues['packbalance.packprice'] := packprice1;
    Params.ParamValues['packbalance.packnos'] := StrToInt(nvnos.Caption);
    log := '前台结算：货单= ' + nos + '; 运费='+FloatToStr(packmoney1)+'; 货款=' +
            FloatToStr(packprice1) +'; 结算金额 = '+nvbalancemoney.Caption+';票据张数='
            + nvnos.Caption + '; 结算人='+sysinfo.LoginUserInfo.UserName ;
    try
      Execute;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          balanceid := Params.ParamByName('packbalanceid').Value;
          packbalanceno := Params.ParamByName('packbalanceno').Value;
          if nResult = 1 then
          begin
            SysLog.WriteLog('行包管理->前台结算','结算',log);
            SysDialogs.ShowMessage(sResult);
            BtnPrint.Enabled := true;
            BtnPrint.SetFocus;
            bbtnSave.Enabled := false;
            // 开始打印结账单
          end
          else
          begin
            SysDialogs.Warning(sResult);
            bbtnSave.Enabled := true;
          end;
    except
      on E: Exception do
      begin
        SysDialogs.ShowMessage('结算失败:'+E.Message);
        SysLog.WriteErr('保存行包前台结算帐单失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmPacFrontkBalance.BtnPrintClick(Sender: TObject);
var
  billPrint: TNovaPrint;
  printValue: TDictionary<String, String>; // 输出单变量
  multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
  multipleValueValue: TDictionary<String, String>;
begin
  inherited;
  try
      printValue := TDictionary<String, String>.Create;
      billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('行包结算单',
        '行包前台结算'));
      printValue.Add('packbalancemoney',nvbalancemoney.Caption);
      printValue.Add('balanceunitname',NovaHelpUnit.Text);
      printValue.Add('balancetime', FormatDateTime('c',Now));
      printValue.Add('balanceby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('pieces', nvpieces.Caption);
      printValue.Add('packfee', FloatToStr(packmoney1));
      printValue.Add('packprice', FloatToStr(packprice1));
      printValue.Add('packnos', nvnos.Caption);
      printValue.Add('packbalanceno', packbalanceno);
      billPrint.SingleValue := printValue;
      billPrint.Print;
      ModalResult := mrok;

  except
    on E: Exception do
    begin
      SysLog.WriteErr('打印行包前台结算帐单失败：' + E.Message);
    end;

  end;
end;

procedure TFrmPacFrontkBalance.FormShow(Sender: TObject);
begin
  inherited;
  NovaHelpUnit.id := sysinfo.LoginUserInfo.OrgID;
  NovaHelpUnit.Text := sysinfo.LoginUserInfo.OrgName;
  NovaHelpUnit.SetFocus;
end;

end.
