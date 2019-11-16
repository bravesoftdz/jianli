unit UFrmPrintTemplate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmPrintTemplateAdd, NovaEdit, NovaHComboBox,UDMPublic,
  Services, UFrmPrintTemplatePlan, PrintTemplatePlan,WinSkinData, NovaPrint,
  Generics.Collections;

type
  TFrmPrintTemplate = class(TSimpleCRUDForm)
    lbltemplatetype: TLabel;
    lblname: TLabel;
    Nvhcbbtemplatetype: TNovaHComboBox;
    nvedtname: TNovaEdit;
    jcdsDeletePrinttemplate: TjsonClientDataSet;
    scrlbxplan: TScrollBox;
    gbitems: TGroupBox;
    nvdbgrdhitems: TNvDbgridEh;
    spl1: TSplitter;
    ds1: TDataSource;
    jcdsqueryitem: TjsonClientDataSet;
    jcdsprintValueType: TjsonClientDataSet;
    jcdsCopyPrintTemplate: TjsonClientDataSet;

    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure ToolButton53Click(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);

  private
    { Private declarations }
    printTemplatePlan:TPrintTemplatePlan;
    procedure TestPrint;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmPrintTemplate: TFrmPrintTemplate;

implementation

{$R *.dfm}

procedure TFrmPrintTemplate.FormCreate(Sender: TObject);
begin
  inherited;
  Nvhcbbtemplatetype.Active:=true;
  jcdsprintValueType.Active:=true;
end;

procedure TFrmPrintTemplate.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{3B582BFB-7232-4B1B-94F3-00C4A87CCDA2}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{37F48239-5857-4090-B1CB-30ECDA3BA1CB}' then //修改
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{28ECD28B-453F-4AB3-AE57-70534B4948BC}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{B0FDD9D9-CE45-4A9F-B757-53DF6F4751FA}' then //设置
  begin
    ToolButton52.Enabled:=aEnable;
  end;
end;

procedure TFrmPrintTemplate.jcdsResultAfterScroll(DataSet: TDataSet);
var i,counts:integer;
begin
  inherited;
  if Assigned(printTemplatePlan) then
  begin
    FreeAndNil(printTemplatePlan);
  end;
  with jcdsqueryitem do
  begin
    Active:=false;
    Params.ParamValues['filter_EQL_pti!printtemplate.id']:=jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end;
  printTemplatePlan:=TPrintTemplatePlan(displayPrintTemplate(jcdsResult,jcdsqueryitem,scrlbxPlan));
//  scrlbxplan.Height:=printTemplatePlan.height+2;
  { TODO : 动态控件皮肤化有问题 }
  DMPublic.SkinData1.UpdateSkinControl(self);
//  SysDialogs.ShowMessage(DMPublic.SkinData1.Skin3rd.Text);
//  DMPublic.SkinData1.AddNestForm(self,printTemplatePlan);
end;

procedure TFrmPrintTemplate.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该打印模板吗？') then
    begin
      exit;
    end;
    with jcdsDeletePrinttemplate do
    begin
      Params.ParamValues['printtemplate.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;;
end;

procedure TFrmPrintTemplate.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmPrintTemplateAdd:=TFrmPrintTemplateAdd.Create(self);
    with FrmPrintTemplateAdd do
    begin
      try
        Caption:='修改打印模板';
        edittype:=TEditType.update;
        cbgeneratedetail.Visible:=false;
        Nvhcbbtemplatetype.SetItemIndexByField('id',self.jcdsResult.FieldByName('printtemplatetypeid').AsLargeInt);
        nvedtname.Text:=self.jcdsResult.FieldByName('name').AsString;
        nvedtrowperpage.Text:=self.jcdsResult.FieldByName('rowperpage').AsString;
        nvedtrowspace.Text:=self.jcdsResult.FieldByName('rowspace').AsString;
        nvcbbprintername.Text:=self.jcdsResult.FieldByName('printername').AsString;
        lblimagepath.Caption:=self.jcdsResult.FieldByName('backgroundimage').AsString;
        nvedtcolumnsperpage.Text:=self.jcdsResult.FieldByName('columnsperpage').AsString;
        nvedtheight.Text:=self.jcdsResult.FieldByName('height').AsString;
        nvedtheightcorrection.Text:=self.jcdsResult.FieldByName('heightcorrection').AsString;
        nvedtwidth.Text:=self.jcdsResult.FieldByName('width').AsString;
        nvedtleft.Text:=self.jcdsResult.FieldByName('left').AsString;
        nvedttop.Text:=self.jcdsResult.FieldByName('top').AsString;
        id:=self.jcdsResult.FieldByName('id').AsString;
        createtime:=self.jcdsResult.FieldByName('createtime').AsString;
        createby:=self.jcdsResult.FieldByName('createby').AsString;
        ChkAutoPages.Checked:=jcdsResult.FieldByName('autopages').AsBoolean;
        if SysMainForm.showFormModal(FrmPrintTemplateAdd,False)=mrOk then
        begin
          self.tbtnFilter.Click;
          self.jcdsResult.Locate('id',operationid,[]);
        end;
      finally
        FreeAndNil(FrmPrintTemplateAdd);
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmPrintTemplate.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=false;
    if (Nvhcbbtemplatetype.ItemIndex>=0) and (trim(Nvhcbbtemplatetype.Text)<>'') then
    begin
      Params.ParamValues['filter_EQL_ptt!id']:=Nvhcbbtemplatetype.HelpFieldValue['id'];
    end
    else
    begin
      Params.ParamValues['filter_EQL_ptt!id']:=null;
    end;
    Params.ParamValues['filter_LIKES_pt!name']:=Trim(nvedtname.Text);
    Active:=true;
  end;
end;

procedure TFrmPrintTemplate.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmPrintTemplateAdd:=TFrmPrintTemplateAdd.Create(self);
  with FrmPrintTemplateAdd do
  begin
    try
      Caption:='添加打印模板';
      edittype:=TEditType.add;
      cbgeneratedetail.Visible:=true;
      if SysMainForm.showFormModal(FrmPrintTemplateAdd,False)=mrOk then
      begin
        self.tbtnFilter.Click;
        self.jcdsResult.Locate('id',operationid,[]);
      end;
    finally
      FreeAndNil(FrmPrintTemplateAdd);
    end;
  end;
end;

procedure TFrmPrintTemplate.tbtnSaveClick(Sender: TObject);
var  nResult: integer;
     sResult: String;
     printtemplateId : Largeint;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;

    with jcdsCopyPrintTemplate do
    begin
      jcdsCopyPrintTemplate.Active := False;
      Params.ParamValues['printtemplate.id']:= jcdsResult.FieldByName('id').AsString;

      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        if sResult <> '' then
          SysDialogs.ShowMessage(sResult);
        if nResult > 0 then
        begin
          printtemplateId := Params.ParamByName('printtemplateId').value;
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id', printtemplateId, []);
        end;
      except
        on E: Exception do
        begin
          SysLog.WriteErr('模板复制操作失败：' + E.Message);
        end;
      end;
    end;
end;

procedure TFrmPrintTemplate.TestPrint;
var novaPrint:TNovaPrint;
    i:integer;
    printRecordCount:integer;
    testStr:string;
begin
  inherited;
  if (jcdsResult.Active=false) or (jcdsResult.RecordCount<=0) then
  begin
    SysDialogs.ShowInfo('请先选择需要测试打印的模板！');
    exit;
  end
  else
  begin
    if (jcdsqueryitem.Active=false) or (jcdsqueryitem.RecordCount<=0) then
    begin
      SysDialogs.ShowInfo('该模块没有添加打印项，请先添加打印项！');
      exit;
    end
  end;
  printRecordCount:=jcdsResult.FieldByName('rowperpage').AsInteger*jcdsResult.FieldByName('columnsperpage').AsInteger+1;
  with jcdsqueryitem do
  begin
    DisableControls;
    try
      First;
      novaPrint:=TNovaPrint.create(Self,jcdsResult.FieldByName('name').AsString);
      while not Eof do
      begin
        if FieldByName('valuetype').AsInteger<2 then
        begin
          next;
          Continue;
        end;
        if FieldByName('islist').AsBoolean then
        begin
          for I := 0 to printRecordCount - 1 do
          begin
            if novaPrint.MultipleValue.Count<i+1 then
            begin
              novaPrint.MultipleValue.Add(TDictionary<String,String>.Create);
            end;
            //打印类型（0画线、1固定标题、2字符串、3大写数字、4小写数字、5日期时间、6-条形码）
            case FieldByName('valuetype').AsInteger of
            0:;
            1:testStr:=FieldByName('title').AsString;
            2:begin
              if FieldByName('itemtype').AsString='1' then  //项目数据类型（0普通、1数值、2日期、3纯数字）
                testStr:='123.4'
              else if FieldByName('itemtype').AsString='2' then
                testStr:=DateTimeToStr(now)
              else if FieldByName('itemtype').AsString='3' then
                testStr:='1234567890'
              else
                testStr:=FieldByName('title').AsString;
              end;
            3,4:testStr:='123.4'+inttostr(i);
            5:testStr:=DateTimeToStr(now);
            6:testStr:='1234567890';
            end;
            novaPrint.MultipleValue.Items[i].AddOrSetValue(FieldByName('itemcode').AsString,testStr);
          end;
        end
        else
        begin
          case FieldByName('valuetype').AsInteger of
          0:;
          1:testStr:=FieldByName('title').AsString;
          2:begin
              if FieldByName('itemtype').AsString='1' then //项目数据类型（0普通、1数值、2日期、3纯数字）
                testStr:='123.4'
              else if FieldByName('itemtype').AsString='2' then
                testStr:=DateTimeToStr(now)
              else if FieldByName('itemtype').AsString='3' then
                testStr:='1234567890'
              else
                testStr:=FieldByName('title').AsString;
            end;
          3,4:testStr:='123.4';
          5:testStr:=DateTimeToStr(now);
          6:testStr:='1234567890';
          end;
          novaPrint.SingleValue.AddOrSetValue(FieldByName('itemcode').AsString,testStr);
        end;
        next;
      end;
      novaPrint.Print;
    finally
      EnableControls;
    end;
  end;
end;

procedure TFrmPrintTemplate.ToolButton52Click(Sender: TObject);
var operationid:Int64;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmPrintTemplatePlan:=TFrmPrintTemplatePlan.Create(self);
    with FrmPrintTemplatePlan do
    begin
      try
        Caption:='设置打印模板';
        cdsPrintTemplate:=jcdsResult;
        printtemplate_id:=self.jcdsResult.FieldByName('id').AsString;
        printtemplate_height:=self.jcdsResult.FieldByName('height').AsInteger;
        printtemplatetype_id:=self.jcdsResult.FieldByName('printtemplatetypeid').AsString;
        printtemplate_backgroundimage:=self.jcdsResult.FieldByName('backgroundimage').AsString;
        printtemplate_width:=self.jcdsResult.FieldByName('width').AsInteger;
        printtemplate_top:=self.jcdsResult.FieldByName('top').AsInteger;
        printtemplate_left:=self.jcdsResult.FieldByName('left').AsInteger;
        printtemplate_rowperpage:=self.jcdsResult.FieldByName('rowperpage').AsInteger;
        printtemplate_rowspace:=self.jcdsResult.FieldByName('rowspace').AsInteger;
        printtemplate_columnsperpage:=self.jcdsResult.FieldByName('columnsperpage').AsInteger;
        operationid:=self.jcdsResult.FieldByName('id').AsLargeInt;
        if SysMainForm.showFormModal(FrmPrintTemplatePlan,False)=mrOk then
        begin
          self.tbtnFilter.Click;
          self.jcdsResult.Locate('id',operationid,[]);
        end;
      finally
        FreeAndNil(FrmPrintTemplatePlan);
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要设置的模板！');
  end;
end;

procedure TFrmPrintTemplate.ToolButton53Click(Sender: TObject);
begin
  inherited;
  TestPrint;
end;

end.
