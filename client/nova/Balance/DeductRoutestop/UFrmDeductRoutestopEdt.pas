unit UFrmDeductRoutestopEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHelp;

type
  TFrmDeductRoutestopEdt = class(TSimpleEditForm)
    jscdSaveDeducts: TjsonClientDataSet;
    Label1: TLabel;
    NovaHelp1: TNovaHelp;
    NovaHelp2: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:int64;
  end;

var
  FrmDeductRoutestopEdt: TFrmDeductRoutestopEdt;

implementation
 uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDeductRoutestopEdt.bbtnSaveClick(Sender: TObject);
var
  msg,log: String;
  nResult: integer;
  sResult: string;
  str,result:string;
begin
  inherited;
try
    with jscdSaveDeducts do
    begin
      active := false;
    {  Params.ParamValues['deductitem.id'] := deductitemid;
      Params.ParamValues['deductitem.createby'] :=createby;
      Params.ParamValues['deductitem.createtime'] := createtime;
      Params.ParamValues['deductitem.code'] := trim(NovaEdtCode.Text);
      Params.ParamValues['deductitem.name'] :=trim(NovaEdtName.Text);
      Params.ParamValues['deductitem.printname'] := trim(NovaEdtPrintName.Text);
      Params.ParamValues['deductitem.orderno'] :=NovaEdtOrderno.Text; }



      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        {log := result+'����̶��۷���Ŀ���۷���Ŀ='+NovaEdtName.Text+',�۷�����='+
        NovaCobType.Text+',��ӡ����='+NovaEdtPrintName.Text+',����='+
        NovaEdtCode.Text+',���='+NovaEdtOrderno.Text+ ',�Ƿ�Ʊ�۷���='+
        bToStr(ChbIsPriceItem.Checked)+',�Ƿ���ʽ='+bToStr(ChkIsExpress.Checked)+ ',�Ƿ�С����='+
        bToStr(ChkIsSum.Checked)+',�۷ѽ��='+NovaEdtdeductmoney.Text;
        SysLog.WriteLog('�������->�۷ѹ���',result,log);  }
        id := Params.ParamByName('deductitemid').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        //NovaEdtName.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysDialogs.ShowMessage(E.Message);
      SysLog.WriteErr('������·�۷���Ϣ����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

end.
