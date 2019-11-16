unit UFrmInsuretypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, NovaComboBox, NovaHComboBox, ImgList;

type
  TFrmInsuretypeEdit = class(TSimpleEditForm)
    lblorg: TLabel;
    lblinsurer: TLabel;
    lblcode: TLabel;
    lblname: TLabel;
    lblpremium: TLabel;
    lblmaxinsureamount: TLabel;
    lbldividedrate: TLabel;
    lbldescription: TLabel;
    jsonCDSInsuretypeSave: TjsonClientDataSet;
    cbborgid: TNovaHComboBox;
    cbbinsurersid: TNovaHComboBox;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    edtpremium: TNovaEdit;
    edtmaxinsureamount: TNovaEdit;
    edtdividedrate: TNovaEdit;
    mmodescription: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    edtYWmoney: TNovaEdit;
    edtSHmoney: TNovaEdit;
    edtEmoney: TNovaEdit;
    edtEMmoney: TNovaEdit;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    edt1: TEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtdividedrateExit(Sender: TObject);
    procedure cbborgidExit(Sender: TObject);
    procedure edtYWmoneyExit(Sender: TObject);
    procedure edtSHmoneyExit(Sender: TObject);
  private
    log : string;
    { Private declarations }
  public
    { Public declarations }
    id, createby,orgid,insurersid: LongWord;
    createtime: TDatetime;
    sign: Boolean;
  end;

var
  FrmInsuretypeEdit: TFrmInsuretypeEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmInsuretypeEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  with jsonCDSInsuretypeSave do
  begin
      Close;
    if cbbinsurersid.ItemIndex>=0 then
    begin
      insurersid := cbbinsurersid.HelpFieldValue['id'];
    end;
    if (trim(edtname.Text)='') then
    begin
      SysDialogs.Warning('请填写保险类型名称');
      edtname.SetFocus;
      exit;
    end;
    if (trim(edtcode.Text)='') then
    begin
      SysDialogs.Warning('请填写保险类型编码');
      edtcode.SetFocus;
      exit;
    end;
    if (Trim(cbborgid.Text) = '') then
    begin
      SysDialogs.Warning('请填写所属车站');
      cbborgid.SetFocus;
      exit;
    end;
    if (insurersid <= 0) then
    begin
      SysDialogs.Warning('请填写所属公司');
      cbbinsurersid.SetFocus;
      exit;
    end;
    if (Trim(edtpremium.Text) = '') then
    begin
      SysDialogs.Warning('请填写保险费用');
      edtpremium.SetFocus;
      exit;
    end;
    if (Trim(edtEmoney.Text) = '') then
    begin
      SysDialogs.Warning('请填写意外伤害保险金额');
      edtEmoney.SetFocus;
      exit;
    end;
    if (Trim(edtEMmoney.Text) = '') then
    begin
      SysDialogs.Warning('请填写意外伤害医疗保险金额');
      edtEMmoney.SetFocus;
      exit;
    end;
    if (Trim(edtmaxinsureamount.Text) = '') then
    begin
      SysDialogs.Warning('请填写最大保额');
      edtmaxinsureamount.SetFocus;
      exit;
    end;
    if (Trim(edtdividedrate.Text) = '') then
    begin
      SysDialogs.Warning('请填写车站所分成比例');
      edtdividedrate.SetFocus;
      exit;
    end;
    if StrToFloat(edtpremium.Text) < 0 then
    begin
      SysDialogs.Warning('保险费用不能小于0');
      edtpremium.SetFocus;
      exit;
    end;
    //太平洋保险意外费用（十堰）
    if StrToFloat(edtYWmoney.Text) < 0 then
    begin
      SysDialogs.Warning('意外医疗费用不能小于0');
      edtYWmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtSHmoney.Text) < 0 then
    begin
      SysDialogs.Warning('意外伤害费用不能小于0');
      edtSHmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtpremium.Text) <> StrToFloat(edtYWmoney.text)+StrToFloat(edtSHmoney.text) then
    begin
      SysDialogs.Warning('保险费用应该等于意外医疗费用与意外伤害费用之和');
      edtpremium.SetFocus;
      exit;
    end;
    if StrToFloat(edtEmoney.Text) < 0 then
    begin
      SysDialogs.Warning('意外伤害保险金额不能小于0');
      edtYWmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtEMmoney.Text) < 0 then
    begin
      SysDialogs.Warning('意外伤害医疗医疗保险金额用不能小于0');
      edtEMmoney.SetFocus;
      exit;
    end;
    if StrToFloat(edtmaxinsureamount.Text) < 0 then
    begin
      SysDialogs.Warning('最大保额不能小于0');
      edtmaxinsureamount.SetFocus;
      exit;
    end;
    Params.ParamByName('insuretype.id').Value :=id ;
    if cbborgid.ItemIndex>=0 then
    begin
      orgid := cbborgid.HelpFieldValue['id'];
    end;
    Params.ParamByName('insuretype.orgid').Value := orgid;
    Params.ParamByName('insuretype.insurersid').Value := insurersid;
    Params.ParamByName('insuretype.name').Value := edtname.Text;
    Params.ParamByName('insuretype.createby').Value := createby;
    Params.ParamByName('insuretype.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('insuretype.code').Value := edtcode.Text;
    Params.ParamByName('insuretype.premium').Value := edtpremium.Text;
    //意外费用与保险
    Params.ParamByName('insuretype.ywmoney').Value := edtYWmoney.Text;
    Params.ParamByName('insuretype.shmoney').Value := edtSHmoney.Text;
    Params.ParamByName('insuretype.emoney').Value  := edtEmoney.Text;
    Params.ParamByName('insuretype.emmoney').Value := edtEMmoney.Text;

    params.ParamByName('insuretype.maxinsureamount').Value := edtmaxinsureamount.Text;
    Params.ParamByName('insuretype.dividedrate').Value := StrToFloat(edtdividedrate.Text)/100;
    Params.ParamByName('insuretype.description').Value := mmodescription.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        if Pos('相同的车站不能存在相同的产品编码',sResult) >0 then
        begin
             edtcode.SetFocus;
        end
        else
        edtname.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '修改保险类型：所属机构=' + cbborgid.Text + ',保险公司='+cbbinsurersid.Text
          + ',产品编码='+edtcode.Text+',产品名称='+edtname.Text+',保险费用='+edtpremium.Text
          +',最大保额='+edtmaxinsureamount.Text+',车站所得分成='+edtdividedrate.Text
          +',说明='+mmodescription.Text
          +',意外医疗费='+edtYWmoney.Text+',意外伤害费='+edtSHmoney.text
          +',意外伤害保险金额='+edtEmoney.Text+',意外伤害医疗保险金额='+edtEMmoney.Text;
          SysLog.WriteLog('票据类型——>保险类型', '修改', log);
        end else
        begin
          log := '添加保险类型：所属机构=' + cbborgid.Text + ',保险公司='+cbbinsurersid.Text
          + ',产品编码='+edtcode.Text+',产品名称='+edtname.Text+',保险费用='+edtpremium.Text
          +',最大保额='+edtmaxinsureamount.Text+',车站所得分成='+edtdividedrate.Text
          +',说明='+mmodescription.Text
          +',意外医疗费='+edtYWmoney.Text+',意外伤害费='+edtSHmoney.text
          +',意外伤害保险金额='+edtEmoney.Text+',意外伤害医疗保险金额='+edtEMmoney.Text;
          SysLog.WriteLog('业务管理——>保险类型', '添加', log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保险类型信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmInsuretypeEdit.cbborgidExit(Sender: TObject);
begin
  inherited;
  with cbbinsurersid do
  begin
    Params.ParamValues['filter_EQL_t!orgid'] := cbborgid.HelpFieldValue['id'];
  end;
end;

procedure TFrmInsuretypeEdit.edtdividedrateExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdividedrate.Text) > 100) or (StrToFloat(edtdividedrate.Text) < 0) then
  begin
    SysDialogs.ShowMessage('请输入0-100之间的数');
    edtdividedrate.SetFocus;
    exit;
  end;
end;

procedure TFrmInsuretypeEdit.edtSHmoneyExit(Sender: TObject);
begin
  inherited;
  edtYWmoney.Text := FloatToStr( StrToFloat(edtpremium.text) - StrToFloat(edtSHmoney.Text) );
end;

procedure TFrmInsuretypeEdit.edtYWmoneyExit(Sender: TObject);
begin
  inherited;
  edtSHmoney.Text := FloatToStr( StrToFloat(edtpremium.text) - StrToFloat(edtYWmoney.Text) );
end;

procedure TFrmInsuretypeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbborgid.Active := false;
  cbborgid.Active := true;

  cbbinsurersid.Active := false;
  cbbinsurersid.Active := true;
end;

end.
