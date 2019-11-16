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
    if not SysDialogs.Confirm('��ʾ','ȷ��Ҫɾ�����շѱ�׼��') then
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
      log := 'ɾ��' +jcdsResult.FieldByName('id').AsString+ '�а��շѱ�׼����������='+
      jcdsResult.FieldByName('orgname').AsString+',��ʼ���='+
     jcdsResult.FieldByName('fromdistance').AsString+',��ֹ���='+
     jcdsResult.FieldByName('fromdistance').AsString+',��ʼ����='+
     jcdsResult.FieldByName('fromweight').AsString+',��ֹ����='+
     jcdsResult.FieldByName('toweight').AsString+',ÿ����ͼ�='+
     jcdsResult.FieldByName('fee').AsString+',��ÿǧ�˵���='+
     jcdsResult.FieldByName('feekg').AsString;
      SysLog.WriteLog('�а�����->�շѱ�׼����','ɾ��',log);
        tbtnFilter.Click;
      end;
    end;
//    jcdsResult.Delete;
//    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('����ѡ����Ҫɾ���ļ�¼��');
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
        Caption:='�޸��а��շѱ�׼';
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
    SysDialogs.ShowInfo('����ѡ����Ҫ�޸ĵļ�¼��');
  end;
end;

procedure TFrmPackfee.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount<=0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
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
        SysLog.WriteErr('���ʧ�ܣ�' + E.Message);
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
    FrmPackfeeAdd.Caption:='����а��շѱ�׼';
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
