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
  if SysDialogs.Confirm('ɾ������', 'ȷ��Ҫɾ���ÿ۷���Ϣ��') then
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
          log := 'ɾ���̶��۷���Ŀ���۷���Ŀ='+jcdsResult.FieldByName('name').AsString+
          ',����='+jcdsResult.FieldByName('code').AsString+
          ',��ӡ����='+jcdsResult.FieldByName('printname').AsString+
          ',���='+jcdsResult.FieldByName('orderno').AsString+
          ',�۷�����='+jcdsResult.FieldByName('deducttypename').AsString+
          ',�۷ѽ��='+jcdsResult.FieldByName('deductmoney').AsString+
          ',Ʊ�۷���='+jcdsResult.FieldByName('ispriceitem').AsString+
          ',С����='+jcdsResult.FieldByName('issum').AsString+
          ',���ʽ='+jcdsResult.FieldByName('isexpress').AsString;
          SysLog.WriteLog('�������>�̶��۷���Ŀ','ɾ��',log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('ɾ������۷���Ŀ����ʧ�ܣ�' + e.Message);
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
      caption := '�޸Ŀ۷���Ŀ';
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
        LabRemark.Caption:='���ʽ';
      end
      else
      begin
        LabRemark.Caption:='����';
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
      caption := '��ӿ۷���Ŀ';
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
      caption := 'վ��۷���Ϣ����';
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
