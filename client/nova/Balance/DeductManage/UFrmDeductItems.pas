unit UFrmDeductItems;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaComboBox, DB, DBClient, jsonClientDataSet, NovaHComboBox;

type
  TFrmDeductItems = class(TSimpleEditForm)
    Label2: TLabel;
    Label6: TLabel;
    LabRemark: TLabel;
    LabDeduct: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaCobType: TNovaComboBox;
    NovaEdtName: TNovaEdit;
    MeRemark: TMemo;
    NovaEdtdeductmoney: TNovaEdit;
    ChbIsPriceItem: TCheckBox;
    Label5: TLabel;
    NovaEdtCode: TNovaEdit;
    Label7: TLabel;
    NovaEdtPrintName: TNovaEdit;
    Label8: TLabel;
    NovaEdtOrderno: TNovaEdit;
    UpDown1: TUpDown;
    ChkIsExpress: TCheckBox;
    ChkIsSum: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    GroupBox1: TGroupBox;
    Label11: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    jscdSaveDeducts: TjsonClientDataSet;
    Label16: TLabel;
    NovaHCobOrg: TNovaHComboBox;
    Label17: TLabel;
    ChkIsprintitem: TCheckBox;
    Label18: TLabel;
    Label19: TLabel;
    procedure NovaEdtNameExit(Sender: TObject);
    procedure NovaEdtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnSaveClick(Sender: TObject);
    procedure ChbIsPriceItemClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ChkIsExpressClick(Sender: TObject);
    procedure MeRemarkChange(Sender: TObject);
  private
    { Private declarations }
    function bToStr(value: boolean): String;
  public
    { Public declarations }
    deductitemid: int64;
    createtime: String;
    createby: int64;
  end;

var
  FrmDeductItems: TFrmDeductItems;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDeductItems.bbtnSaveClick(Sender: TObject);
var
  msg, log: String;
  nResult: integer;
  sResult: string;
  item, preitem: Char;
  str, result: string;
  i, leftcount, rightcount: integer;
begin
  inherited;
  if trim(NovaEdtName.Text) = '' then
  begin
    SysDialogs.Warning('请输入扣费名称！');
    NovaEdtName.SetFocus;
    exit;
  end;
  if trim(NovaEdtPrintName.Text) = '' then
  begin
    SysDialogs.Warning('请输入打印名称！');
    NovaEdtPrintName.SetFocus;
    exit;
  end;
  if trim(NovaEdtCode.Text) = '' then
  begin
    SysDialogs.Warning('请输入编码！');
    NovaEdtCode.SetFocus;
    exit;
  end;
  if (trim(NovaEdtCode.Text) = 'A') or (trim(NovaEdtCode.Text) = 'B') then
  begin
    SysDialogs.Warning('请输入编码不允许是系统默认的编码！');
    NovaEdtCode.SetFocus;
    exit;
  end;
  if ChkIsExpress.Checked then
  begin
    if trim(MeRemark.Text) = '' then
    begin
      SysDialogs.Warning('请输入表达式！');
      MeRemark.SetFocus;
      exit;
    end;
    str := MeRemark.Text;
    for i := 1 to length(str) do
    begin
      item := str[i];
      preitem := str[i + 1];
      if ((item in ['A' .. 'Z']) and (preitem in ['0' .. '9'])) or
        (preitem in ['A' .. 'Z']) and (item in ['0' .. '9']) or
        ((item in ['A' .. 'Z']) and (preitem in ['A' .. 'Z'])) or
        (preitem in ['A' .. 'Z']) and (item in ['A' .. 'Z']) or
        ((item in ['+', '-', '/', '*', '.']) and (preitem in ['+', '-', '/',
          '*', '.'])) then
      begin
        SysDialogs.Warning(Label5.caption + '输入有误，请检查输入是否正确？');
        MeRemark.SetFocus;
        exit;
      end;
      if item = '(' then
        leftcount := leftcount + 1;
      if item = ')' then
        rightcount := rightcount + 1;

    end;
    if leftcount <> rightcount then
    begin
      SysDialogs.Warning(Label5.caption + '的括号数不对，请检查输入是否正确？');
      MeRemark.SetFocus;
      exit;
    end;
  end;
  try
    with jscdSaveDeducts do
    begin
      active := false;
      Params.ParamValues['deductitem.id'] := deductitemid;
      Params.ParamValues['deductitem.createby'] := createby;
      Params.ParamValues['deductitem.createtime'] := createtime;
      Params.ParamValues['deductitem.code'] := trim(NovaEdtCode.Text);
      Params.ParamValues['deductitem.name'] := trim(NovaEdtName.Text);
      Params.ParamValues['deductitem.printname'] := trim(NovaEdtPrintName.Text);
      Params.ParamValues['deductitem.orderno'] := NovaEdtOrderno.Text;

      Params.ParamValues['deductitem.deducttype'] := NovaCobType.ItemIndex;
      Params.ParamValues['deductitem.orgid'] := NovaHCobOrg.HelpFieldValue
        ['id'];
      Params.ParamValues['deductitem.ispriceitem'] := ChbIsPriceItem.Checked;
      Params.ParamValues['deductitem.isexpress'] := ChkIsExpress.Checked;
      Params.ParamValues['deductitem.issum'] := ChkIsSum.Checked;
      Params.ParamValues['deductitem.isprintitem'] := ChkIsprintitem.Checked;
      Params.ParamValues['deductitem.isactive'] := true;
      Params.ParamValues['deductitem.deductmoney'] := NovaEdtdeductmoney.Text;
      Params.ParamValues['deductitem.description'] := MeRemark.Text;

      execute;
      nResult := Params.ParamByName('flag').value;
      sResult := Params.ParamByName('msg').value;
      if (nResult = 1) then
      begin
        if deductitemid > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '结算固定扣费项目：扣费项目=' + NovaEdtName.Text + ',扣费类型=' +
          NovaCobType.Text + ',打印名称=' + NovaEdtPrintName.Text + ',编码=' +
          NovaEdtCode.Text + ',序号=' + NovaEdtOrderno.Text + ',是否票价分项=' + bToStr
          (ChbIsPriceItem.Checked) + ',是否表达式=' + bToStr(ChkIsExpress.Checked)
          + ',是否小计项=' + bToStr(ChkIsSum.Checked)
          + ',扣费金额=' + NovaEdtdeductmoney.Text;
        SysLog.WriteLog('结算管理->扣费管理', result, log);
        deductitemid := Params.ParamByName('deductitemid').value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtName.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysDialogs.ShowMessage(E.Message);
      SysLog.WriteErr('保存扣费管理项目操作失败：' + E.Message);
    end;
  end;

end;

function TFrmDeductItems.bToStr(value: boolean): String;
begin
  if value then
    result := '是'
  else
    result := '否';
end;

procedure TFrmDeductItems.ChbIsPriceItemClick(Sender: TObject);
begin
  inherited;
  if ChbIsPriceItem.Checked then
  begin
    ChkIsSum.Enabled := false;
    ChkIsSum.Checked := false;
  end
  else
  begin
    ChkIsSum.Enabled := true;
  end;
end;

procedure TFrmDeductItems.ChkIsExpressClick(Sender: TObject);
begin
  inherited;
  if ChkIsExpress.Checked then
  begin
    LabRemark.Caption:='表达式';
    ChbIsPriceItem.Checked:=false;      
  end
  else
  begin
    LabRemark.Caption:='描述';  
  end;
  LabRemark.Left:=MeRemark.Left- LabRemark.Width-4;  
end;

procedure TFrmDeductItems.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCobType.active := false;
  NovaCobType.active := true;
  NovaCobType.ItemIndex := 0;
  NovaHCobOrg.active := false;
  NovaHCobOrg.active := true;
  NovaHCobOrg.ItemIndex := 0;
end;

procedure TFrmDeductItems.FormShow(Sender: TObject);
begin
  inherited;
  LabRemark.Left:=MeRemark.Left- LabRemark.Width-4;     
  if NovaEdtName.Enabled then
    NovaEdtName.SetFocus;
end;

procedure TFrmDeductItems.MeRemarkChange(Sender: TObject);
VAR
  str: String;
  i: integer;
  item: Char;
begin
  inherited;
  str := MeRemark.Text;
  for i := 1 to length(str) do
  begin
    item := str[i];
    if (item in ['+', '-', '*', '/']) then
    begin
      ChkIsExpress.Checked := true;
      ChkIsExpress.Enabled := false;
      ChbIsPriceItem.Enabled := false;
      ChbIsPriceItem.Checked := false;
      NovaEdtdeductmoney.Enabled := false;
      LabRemark.Caption:='表达式';      
      LabRemark.Left:=MeRemark.Left- LabRemark.Width-4;
      exit;
    end;
  end;
  ChkIsExpress.Checked := false;
  NovaEdtdeductmoney.Enabled := true;
  LabRemark.Caption:='描述';
end;

procedure TFrmDeductItems.NovaEdtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', 'A' .. 'Z', 'a' .. 'z', #8, #13]) then
    Key := #0;
end;

procedure TFrmDeductItems.NovaEdtNameExit(Sender: TObject);
begin
  inherited;
  if NovaEdtPrintName.Text = '' then
    NovaEdtPrintName.Text := self.NovaEdtName.Text;
end;

end.
