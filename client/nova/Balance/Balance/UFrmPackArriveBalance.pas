unit UFrmPackArriveBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ExtCtrls, StdCtrls, ImgList, Buttons, ComCtrls,
  NovaEdit, NovaHelp,Services, DB, DBClient, jsonClientDataSet,NovaPrint,
  Generics.Collections;

type
  TFrmPackArriveBalance = class(TSimpleEditForm)
    Label1: TLabel;
    shp1: TShape;
    Label2: TLabel;
    Label3: TLabel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Bevel6: TBevel;
    Label10: TLabel;
    packbalancenum: TLabel;
    packfee: TLabel;
    packprice: TLabel;
    packbalancemoney: TLabel;
    NovaHelpUnit: TNovaHelp;
    jsonsavepackbalance: TjsonClientDataSet;
    BtnPrint: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure BtnPrintClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    pieces : Integer;
    nos,ids,balanceid,balanceno : string;

  end;

var
  FrmPackArriveBalance: TFrmPackArriveBalance;

implementation

{$R *.dfm}



procedure TFrmPackArriveBalance.bbtnSaveClick(Sender: TObject);
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
  with jsonsavepackbalance do
  begin
    Active := false;
    Params.ParamValues['packbalance.packbalancemoney'] := StrToFloat(packbalancemoney.Caption);
    Params.ParamValues['packbalance.packdeductmoney'] := 0;
    Params.ParamValues['packbalance.balanceunitname'] := NovaHelpUnit.Text;
    Params.ParamValues['packbalance.balanceip'] :=  SysInfo.LocalHostAddress;
    Params.ParamValues['packbalance.orgid'] := SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['packbalance.ids'] := ids;
    Params.ParamValues['packbalance.status'] := '0';
    Params.ParamValues['packbalance.datatype'] := '0';
    Params.ParamValues['packbalance.pieces'] := pieces;
    Params.ParamValues['packbalance.packmoney'] := StrToFloat(packfee.Caption);
    Params.ParamValues['packbalance.packprice'] := StrToFloat(packprice.Caption);
    Params.ParamValues['packbalance.packnos'] := StrToInt(packbalancenum.Caption);
    log := '出库结算：货单= ' + nos + '; 运费='+packfee.Caption+'; 货款=' +
            packprice.Caption +'; 结算金额 = '+packbalancemoney.Caption+';票据张数='
            + packbalancenum.Caption + '; 结算人='+sysinfo.LoginUserInfo.UserName ;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      balanceid := Params.ParamByName('packbalanceid').Value;
      balanceno := Params.ParamByName('packbalanceno').Value;
      if nResult = 1 then
      begin
        SysLog.WriteLog('行包管理->出库结算','结算',log);
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
        SysLog.WriteErr('保存行包出库结算帐单失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmPackArriveBalance.BtnPrintClick(Sender: TObject);
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
        '行包出库结算'));
      printValue.Add('packbalancemoney', packbalancemoney.Caption);
      printValue.Add('balanceunitname', NovaHelpUnit.Text);
      printValue.Add('balancetime', FormatDateTime('c',Now));
      printValue.Add('balanceby', SysInfo.LoginUserInfo.UserName);
      printValue.Add('packfee', packfee.Caption);
      printValue.Add('packprice', packprice.Caption);
      printValue.Add('packnos', packbalancenum.Caption);
      printValue.Add('packbalanceno', balanceno);
      billPrint.SingleValue := printValue;
      billPrint.Print;
      ModalResult := mrok;

  except
    on E: exception do
    begin
      SysLog.WriteErr('打印行包出库结算帐单失败：' + E.Message);
    end;

  end;
end;


procedure TFrmPackArriveBalance.FormShow(Sender: TObject);
begin
  inherited;
  NovaHelpUnit.Id := SysInfo.LoginUserInfo.OrgID;
  NovaHelpUnit.Text := SysInfo.LoginUserInfo.OrgName;
  NovaHelpUnit.SetFocus;
  packbalancemoney.Caption := FloatToStr(StrToFloat(packfee.Caption) + StrToFloat(packprice.Caption));
end;


end.
