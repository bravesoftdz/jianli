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
          result := '修改'
        else
          result := '添加';
        {log := result+'结算固定扣费项目：扣费项目='+NovaEdtName.Text+',扣费类型='+
        NovaCobType.Text+',打印名称='+NovaEdtPrintName.Text+',编码='+
        NovaEdtCode.Text+',序号='+NovaEdtOrderno.Text+ ',是否票价分项='+
        bToStr(ChbIsPriceItem.Checked)+',是否表达式='+bToStr(ChkIsExpress.Checked)+ ',是否小计项='+
        bToStr(ChkIsSum.Checked)+',扣费金额='+NovaEdtdeductmoney.Text;
        SysLog.WriteLog('结算管理->扣费管理',result,log);  }
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
      SysLog.WriteErr('保存线路扣费信息操作失败：' + E.Message);
    end;
  end;
end;

end.
