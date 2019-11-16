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
   SysDialogs.Warning('���㵥λ����Ϊ��');
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
    log := 'ǰ̨���㣺����= ' + nos + '; �˷�='+FloatToStr(packmoney1)+'; ����=' +
            FloatToStr(packprice1) +'; ������ = '+nvbalancemoney.Caption+';Ʊ������='
            + nvnos.Caption + '; ������='+sysinfo.LoginUserInfo.UserName ;
    try
      Execute;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          balanceid := Params.ParamByName('packbalanceid').Value;
          packbalanceno := Params.ParamByName('packbalanceno').Value;
          if nResult = 1 then
          begin
            SysLog.WriteLog('�а�����->ǰ̨����','����',log);
            SysDialogs.ShowMessage(sResult);
            BtnPrint.Enabled := true;
            BtnPrint.SetFocus;
            bbtnSave.Enabled := false;
            // ��ʼ��ӡ���˵�
          end
          else
          begin
            SysDialogs.Warning(sResult);
            bbtnSave.Enabled := true;
          end;
    except
      on E: Exception do
      begin
        SysDialogs.ShowMessage('����ʧ��:'+E.Message);
        SysLog.WriteErr('�����а�ǰ̨�����ʵ�ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmPacFrontkBalance.BtnPrintClick(Sender: TObject);
var
  billPrint: TNovaPrint;
  printValue: TDictionary<String, String>; // ���������
  multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
  multipleValueValue: TDictionary<String, String>;
begin
  inherited;
  try
      printValue := TDictionary<String, String>.Create;
      billPrint := TNovaPrint.Create(self, TNovaPrint.GetTicketModelName('�а����㵥',
        '�а�ǰ̨����'));
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
      SysLog.WriteErr('��ӡ�а�ǰ̨�����ʵ�ʧ�ܣ�' + E.Message);
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
