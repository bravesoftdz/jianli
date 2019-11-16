unit UFrmDeductManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaEdit, NovaComboBox;

type
  TFrmDeductManage = class(TSimpleCRUDForm)
    Label2: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    NovaCobType: TNovaComboBox;
    NovaEdtName: TNovaEdit;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsQryDeducttype: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultcode: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultprintname: TWideStringField;
    jcdsResultorderno: TIntegerField;
    jcdsResultdeducttype: TWideStringField;
    jcdsResultisexpress: TBooleanField;
    jcdsResultissum: TBooleanField;
    jcdsResultdeductmoney: TFloatField;
    jcdsResultdescription: TWideStringField;
    jcdsResultorgid: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsResultdeducttypename: TWideStringField;
    jcdsResultispriceitem: TBooleanField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jscdDelItem: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDeductManage: TFrmDeductManage;

implementation
uses UFrmDeductItems, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDeductManage.FormShow(Sender: TObject);
begin
  inherited;
  jcdsQryDeducttype.Active:=false;
  jcdsQryDeducttype.Active:=true;
  NovaHCbbOrg.Active:=false;
  NovaHCbbOrg.Active:=true;
end;

procedure TFrmDeductManage.tbtnDeleteClick(Sender: TObject);
var
  sResult,log: string;
  nResult: Integer;
  id:int64;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount <= 0 then
    Exit;
  id:=jcdsResult.FieldByName('id').AsLargeInt;
  if SysDialogs.Confirm('删除操作', '确认要删除该扣费信息吗？') then
    try
      with jscdDelItem do
      begin
        Active := False;
        Params.ParamValues['deductitem.id'] := id;
        Params.ParamValues['deductitem.updateby'] :=
          SysInfo.LoginUserInfo.UserID;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          log := '删除固定扣费项目：扣费项目='+jcdsResult.FieldByName('name').AsString+
          ',编码='+jcdsResult.FieldByName('code').AsString+
          ',打印名称='+jcdsResult.FieldByName('printname').AsString+
          ',序号='+jcdsResult.FieldByName('orderno').AsString+
          ',扣费类型='+jcdsResult.FieldByName('deducttypename').AsString+
          ',扣费金额='+jcdsResult.FieldByName('deductmoney').AsString+
          ',票价分项='+jcdsResult.FieldByName('ispriceitem').AsString+
          ',小计项='+jcdsResult.FieldByName('issum').AsString+
          ',表达式='+jcdsResult.FieldByName('isexpress').AsString;
          SysLog.WriteLog('结算管理—>固定扣费项目','删除',log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('删除结算扣费项目操作失败：' + e.Message);
      end;
    end;

end;

procedure TFrmDeductManage.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.Active then exit;
  if (jcdsResult.RecordCount=0) then exit;
  try
    FrmDeductItems := TFrmDeductItems.Create(self);
    with FrmDeductItems do
    begin
      caption := '修改扣费项目';
      deductitemid:=jcdsResult.FieldByName('id').AsLargeInt;
      createby:= jcdsResult.FieldByName('createby').AsLargeInt;
      createtime:= jcdsResult.FieldByName('createtime').AsString;
      NovaHCobOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
      NovaHCobOrg.Enabled:=false;
      NovaEdtName.Text:=jcdsResult.FieldByName('name').AsString;
      NovaEdtPrintName.Text:=jcdsResult.FieldByName('printname').AsString;
      NovaEdtCode.Text:=jcdsResult.FieldByName('code').AsString;
      NovaEdtOrderno.Text:=jcdsResult.FieldByName('orderno').AsString;
      UpDown1.Position:=jcdsResult.FieldByName('orderno').AsInteger;
      NovaCobType.ItemIndex:=jcdsResult.FieldByName('deducttype').AsInteger;
      ChbIsPriceItem.Checked:=jcdsResult.FieldByName('ispriceitem').AsBoolean;
      ChkIsExpress.Checked:=jcdsResult.FieldByName('isexpress').AsBoolean;
      if ChkIsExpress.Checked then
      begin
        LabRemark.Caption:='表达式';
      end
      else
      begin
        LabRemark.Caption:='描述';
      end;
      ChkIsSum.Checked:=jcdsResult.FieldByName('issum').AsBoolean;
      NovaEdtdeductmoney.Text:=jcdsResult.FieldByName('deductmoney').AsString;
      MeRemark.Text:=jcdsResult.FieldByName('description').AsString;
      if SysMainForm.showFormModal(FrmDeductItems, False) = mrok then
      begin
        curid := deductitemid;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmDeductItems);
  end;
end;

procedure TFrmDeductManage.tbtnFilterClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;
  if jcdsResult.Active and (jcdsResult.RecordCount>0) then
      curid:= jcdsResult.FieldByName('id').AsInteger;
  //jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_b!orgid'] := NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['filter_LIKES_b!name'] := Trim(NovaEdtName.Text);
    if NovaCobType.ItemIndex >= 0 then
      Params.ParamValues['filter_EQS_b!deducttype'] := NovaCobType.GetSelectCode
    else
      Params.ParamValues['filter_EQS_b!deducttype'] := null;
    Active := True;
    if (RecordCount > 0) and (curid > 0) then
    begin
      jcdsResult.Locate('id', curid, []);
    end;
  end;
  //jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmDeductManage.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  try
    FrmDeductItems := TFrmDeductItems.Create(self);
    with FrmDeductItems do
    begin
      caption := '添加扣费项目';
      if SysMainForm.showFormModal(FrmDeductItems, False) = mrok then
      begin
        curid := deductitemid;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmDeductItems);
  end;

end;

procedure TFrmDeductManage.ToolButton2Click(Sender: TObject);
begin
 { inherited;
  try
    FrmDeductTypes := TFrmDeductTypes.Create(self);
    with FrmDeductTypes do
    begin
      caption := '站点扣费信息设置';
      if SysMainForm.showFormModal(FrmDeductTypes, False) = mrok then
      begin
        //curid := deductitemid;
        //tbtnFilterClick(nil);
        //jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmDeductTypes);
  end;  }
end;

end.
