unit UFrmCarryControlAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet,UDMPublic,Services, NovaComboBox, NovaHComboBox,PubFn,LogIntf,
  Designer;

type
  TFrmCarryControlAdd = class(TSimpleEditForm)
    lbldistricttype: TLabel;
    lbl2: TLabel;
    lblstartstation: TLabel;
    lbl1: TLabel;
    nvedtmodulecode: TNovaEdit;
    lblname: TLabel;
    nvedtformula: TNovaEdit;
    lbl3: TLabel;
    jcdscarrycontrol: TjsonClientDataSet;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    nvedtdescribe: TNovaEdit;
    bbtntrim: TBitBtn;
    bbtngetp: TBitBtn;
    bbtngetd: TBitBtn;
    bbtnRound: TBitBtn;
    procedure bbtnSaveClick(Sender: TObject);
    procedure bbtntrimClick(Sender: TObject);
    procedure bbtngetdClick(Sender: TObject);
    procedure bbtngetpClick(Sender: TObject);
    procedure bbtnRoundClick(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;

    function checkFormula(Sstr:string):Boolean;
  public
    { Public declarations }
    id:Integer;
    modulecode:string;
    describe:string;
    formula:string;
    flag, isactive:boolean;
    property operationid:Integer read Foperationid;
  end;

var
  FrmCarryControlAdd: TFrmCarryControlAdd;

implementation

{$R *.dfm}



{  功能：检验指定公式是否存在方法错误
   参数：       Sstr:string  检验的字符串
   返回值   true/false  逻辑值
}
function TFrmCarryControlAdd.checkFormula(Sstr:string):Boolean;
begin
  //1.检验指定公式字符串()是否配对
  if (getSubStrNum('(',trim(Sstr)) <> getSubStrNum(')',trim(Sstr))) then
  begin
    Result:=False;
    Exit;
  end;
  //2.检验指定的函数是否规格如:Trime(E) E必须是大写

end;

procedure TFrmCarryControlAdd.bbtngetdClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getD(m,n)';
end;

procedure TFrmCarryControlAdd.bbtngetpClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getP(m,n)';
end;

procedure TFrmCarryControlAdd.bbtnRoundClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getRound(m,n)';
end;

procedure TFrmCarryControlAdd.bbtnSaveClick(Sender: TObject);
var
  OperFlag:string;
begin
  inherited;
  OperFlag:='添加进位规则';
  //检验开始
  if Trim(nvedtmodulecode.Text)='' then
  begin
    SysDialogs.ShowMessage('规则代码不能为空!');
    nvedtmodulecode.SetFocus;
    exit;
  end;
  if Trim(nvedtdescribe.Text)='' then
  begin
    SysDialogs.ShowMessage('规则名称不能为空!');
    nvedtdescribe.SetFocus;
    exit;
  end;
  if Trim(nvedtformula.Text)='' then
  begin
    SysDialogs.ShowMessage('规则公式不能为空!');
    nvedtformula.SetFocus;
    exit;
  end;
  //检验规则公式 如：公式的括号是否配对等。
   if not checkFormula(trim(nvedtformula.Text)) then
   begin
     SysDialogs.ShowMessage('您输入的规则公式有存在不合法,请核对！');
     nvedtformula.SetFocus;
     Exit;
   end;
  //检验结束
  with jcdscarrycontrol do
  begin
    //后台Action判断如果Id是空为新增 不为空是修改
    Params.ParamValues['carrycontrol.id']:=id;
    Params.ParamValues['carrycontrol.modulecode']:=Trim(nvedtmodulecode.Text);
    Params.ParamValues['carrycontrol.describe']:= Trim(nvedtdescribe.Text);
    Params.ParamValues['carrycontrol.formula']:= Trim(nvedtformula.Text);
    Execute;

    if Pos('修改',trim(Params.ParamValues['msg']))>0 then
    begin
      OperFlag:='修改进位规则';
    end;
    //第三个参数视情况而定，可以记录更加详细的添加内容
    SysLog.WriteLog('进位规则管理',trim(OperFlag),'modulecode='+Trim(nvedtmodulecode.Text)+',describe='+Trim(nvedtdescribe.Text));
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;

  end;
end;

procedure TFrmCarryControlAdd.bbtntrimClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getInt(E)';

end;

end.
