unit UFrmBalanceformulaEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  DB, DBClient, jsonClientDataSet, NovaHComboBox, ImgList, NovaCheckedComboBox;

type
  TFrmBalanceformulaEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEditName: TNovaEdit;
    Label4: TLabel;
    NovaCobBType: TNovaComboBox;
    MeRemark: TMemo;
    jcdsSaveFormula: TjsonClientDataSet;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    NovaHCobParent: TNovaHComboBox;
    Label9: TLabel;
    Label10: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    NovaEdtFormula: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    id, createby: int64;
    createtime: String;
    isdefault, isaudited, isauditpass: boolean;
  end;

var
  FrmBalanceformulaEdt: TFrmBalanceformulaEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmBalanceformulaEdt.bbtnSaveClick(Sender: TObject);
var
  nResult, leftcount, rightcount, i: integer;
  sResult, str,result: String;
  nextitem, item: widechar;
begin
  inherited;
  if NovaCobBType.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择公式类型！');
    NovaCobBType.SetFocus;
    exit;
  end;
  if trim(NovaEditName.Text) = '' then
  begin
    SysDialogs.Warning('请填写公式名称！');
    NovaEditName.SetFocus;
    exit;
  end;
  if trim(NovaEdtFormula.Text) = '' then
  begin
    SysDialogs.Warning('请填写公式！');
    NovaEdtFormula.SetFocus;
    exit;
  end;

  leftcount := 0;
  rightcount := 0;
  if length(NovaEdtFormula.Text) > 1 then
  begin
    str := NovaEdtFormula.Text;
    for i := 1 to length(str) do
    begin
      item := str[i];
      {if i < length(str) then
      begin
        nextitem := str[i + 1];
        if SysUtils.CharInSet(item, ['A' .. 'Z']) and SysUtils.CharInSet
          (nextitem, ['A' .. 'Z']) then
        begin
          SysDialogs.Warning('你输入的计算公式有误，请检查输入是否正确？');
          NovaEdtFormula.SetFocus;
          exit;
        end;
      end; }
      if item = '(' then
        leftcount := leftcount + 1;
      if item = ')' then
        rightcount := rightcount + 1;

    end;
    if leftcount <> rightcount then
    begin
      SysDialogs.Warning('公式的括号数不对，请检查输入是否正确？');
      NovaEdtFormula.SetFocus;
      exit;
    end;
  end;

  try
    with jcdsSaveFormula do
    begin
      active := false;
      Params.ParamValues['balanceformula.id'] := id;
      Params.ParamValues['balanceformula.formula'] := trim(NovaEdtFormula.Text);
      Params.ParamValues['balanceformula.orgid'] := NovaHCbbOrg.HelpFieldValue
      ['id'];
      Params.ParamValues['balanceformula.formulatype'] :=
        NovaCobBType.GetSelectCode;
      Params.ParamValues['balanceformula.formulaname'] := trim
        (NovaEditName.Text);
      if NovaHCobParent.ItemIndex >= 0 then
        Params.ParamValues['balanceformula.parentid'] :=
          NovaHCobParent.HelpFieldValue['id']
      else
        Params.ParamValues['balanceformula.parentid'] := 0;
      Params.ParamValues['balanceformula.isdefault'] := isdefault;
      Params.ParamValues['balanceformula.createby'] := createby;
      Params.ParamValues['balanceformula.createtime'] := createtime;
      Params.ParamValues['balanceformula.isaudited'] := isaudited;
      Params.ParamValues['balanceformula.isauditpass'] := isauditpass;
      Params.ParamValues['balanceformula.description'] := MeRemark.Text;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '结算公式设置：扣费公式类型='+NovaCobBType.Text+',所属扣费项目='+
        NovaHCobParent.Text+',扣费公式名称='+NovaEditName.Text+',计算公式='+
        NovaEdtFormula.Text+',描述='+MeRemark.Text;
        SysLog.WriteLog('结算管理->结算公式设置',result,log);
        id := Params.ParamByName('curid').Value;
        SysDialogs.ShowMessage(sResult);
        if sResult = '该公式扣费名称已经存在，请重新输入！' then
        Exit;
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtFormula.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存结算公式操作失败：' + E.Message);
    end;
  end;
end;

procedure TFrmBalanceformulaEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.active := false;
  NovaHCbbOrg.active := true;
  NovaCobBType.active := false;
  NovaCobBType.active := true;
  with NovaHCobParent do
  begin
    active := false;
    Params.ParamValues['filter_EQL_t!orgid'] := Sysinfo.LoginUserInfo.OrgID;
    active := true;
  end;
end;

end.
