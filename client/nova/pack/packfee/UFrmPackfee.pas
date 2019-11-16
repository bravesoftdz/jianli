unit UFrmPackfee;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services,UDMPublic,
  NvPrnDbgeh, NvDbgridEh,NovaCheckedComboBox, NovaHComboBox;

type
  TFrmPackfee = class(TSimpleCRUDForm)
    jcdsroutedelete: TjsonClientDataSet;
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    NovaCkbOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     log:string;
    
  public
  end;

var
  FrmPackfee: TFrmPackfee;

implementation
  uses UFrmPackfeeAdd;
{$R *.dfm}

procedure TFrmPackfee.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmPackfee.FormCreate(Sender: TObject);
begin
  inherited;

  NovaCkbOrg.Active := true;
end;

procedure TFrmPackfee.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmPackfee.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该收费标准吗？') then
    begin
      exit;
    end;
    with jcdsroutedelete do
    begin
      Params.ParamValues['packfee.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
      log := '删除' +jcdsResult.FieldByName('id').AsString+ '行包收费标准：所属机构='+
      jcdsResult.FieldByName('orgname').AsString+',起始里程='+
     jcdsResult.FieldByName('fromdistance').AsString+',截止里程='+
     jcdsResult.FieldByName('fromdistance').AsString+',起始重量='+
     jcdsResult.FieldByName('fromweight').AsString+',截止重量='+
     jcdsResult.FieldByName('toweight').AsString+',每件最低价='+
     jcdsResult.FieldByName('fee').AsString+',超每千克单价='+
     jcdsResult.FieldByName('feekg').AsString;
      SysLog.WriteLog('行包管理->收费标准设置','删除',log);
        tbtnFilter.Click;
      end;
    end;
//    jcdsResult.Delete;
//    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;
end;

procedure TFrmPackfee.tbtnEditClick(Sender: TObject);
 var id:Integer;
begin
  inherited;
if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmPackfeeAdd:=TFrmPackfeeAdd.Create(self,self.functionItem);
    try
      with FrmPackfeeAdd do
      begin
        Caption:='修改行包收费标准';
        edittype:=Tedittype.update;


        NovaCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
        NovaHelpPricetype.SetItemIndexByField('id', jcdsResult.FieldByName('packfeetypeid').AsLargeInt);
        packfeeid := self.jcdsResult.FieldByName('id').AsInteger;;
        nvedtfromdistance.Text := self.jcdsResult.FieldByName('fromdistance').AsString;
        nvedttodistance.Text := self.jcdsResult.FieldByName('todistance').AsString;
        nvedtfromweight.Text := self.jcdsResult.FieldByName('fromweight').AsString;
        nvedttoweight.Text := self.jcdsResult.FieldByName('toweight').AsString;
        nvedtfee.Text := self.jcdsResult.FieldByName('fee').AsString;
        nvedtfeekg.Text := self.jcdsResult.FieldByName('feekg').AsString;
        createby :=self.jcdsResult.FieldByName('createby').AsInteger;
        createtime :=self.jcdsResult.FieldByName('createtime').AsDateTime;
      end;
      if SysMainForm.showFormModal(FrmPackfeeAdd,false)=mrok then
      begin
        id := FrmPackfeeAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmPackfeeAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmPackfee.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount<=0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    NovaCkbOrg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active:=False;

    //Params.ParamValues['filter_INS_p!orgid'] := '('+IntToStr(NovaCbbOrg.HelpFieldValue['id'])+')';
    Params.ParamValues['filter_INS_p!orgid'] := NovaCkbOrg.GetSelectID;
    //jcdsResult.AfterScroll:=nil;
    try
      Active:=true;
      if recordcount>0 then
      begin

      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmPackfee.tbtnInsertClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  FrmPackfeeAdd:=TFrmPackfeeAdd.Create(self,self.functionItem);
  try
    FrmPackfeeAdd.Caption:='添加行包收费标准';
    FrmPackfeeAdd.edittype:=Tedittype.add;
    if SysMainForm.showFormModal(FrmPackfeeAdd,false)=mrOk then
    begin
      id := FrmPackfeeAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmPackfeeAdd);
  end;
end;

end.
