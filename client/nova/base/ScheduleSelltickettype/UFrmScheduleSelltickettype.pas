unit UFrmScheduleSelltickettype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping, NovaComboBox, NovaHComboBox;

type
  TFrmScheduleSelltickettype = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lblSelltype: TLabel;
    nvcbbSelltype: TNovaComboBox;
    nvdbgrdh1: TNvDbgridEh;
    nvdbgrdh2: TNvDbgridEh;
    jcdsDelPerselldays: TjsonClientDataSet;
    nvHcbbOrgid: TNovaHComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduleSelltickettype: TFrmScheduleSelltickettype;

implementation
  uses PubFn, Services,UFrmScheduleSelltickettypeEdit,UDMPublic;
{$R *.dfm}

procedure TFrmScheduleSelltickettype.FormShow(Sender: TObject);
begin
  inherited;
   nvHcbbOrgid.Active := False;
  nvHcbbOrgid.Active := True;
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
end;

procedure TFrmScheduleSelltickettype.tbtnDeleteClick(Sender: TObject);
var  nResult: integer;
  sResult,log: string;
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jcdsDelPerselldays do
    try
      close;
      Params.ParamByName('id').Value := jcdsResult.FieldByName('id').AsString;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := ' ɾ��'+jcdsResult.FieldByName('orgname').AsString
        +' , ������ͣ�'+jcdsResult.FieldByName('typename').AsString;
        if jcdsResult.FieldByName('typecode').AsString='1' then
        begin
          log := log+', ��·���ƣ�'+jcdsResult.FieldByName('typeidname').AsString ;
        end;
         if jcdsResult.FieldByName('typecode').AsString='2' then
        begin
          log := log+', ��κţ�'+jcdsResult.FieldByName('typeidname').AsString ;
        end;
        log := log+', Ʊ�֣�'+jcdsResult.FieldByName('tickettypename').AsString;
        SysLog.WriteLog('���Ԥ��Ʊ�ֹ���', 'ɾ��', log);
        log:='';
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('ɾ��ʧ�ܣ�' + E.Message);
      end;
    end;

end;

procedure TFrmScheduleSelltickettype.tbtnEditClick(Sender: TObject);
begin
  frmScheduleSelltickettypeEdit := TfrmScheduleSelltickettypeEdit.Create(self);
  try
    with frmScheduleSelltickettypeEdit do
    begin
      edittype:=Tedittype.update;
      Caption := '�޸İ��Ԥ��Ʊ�ֿ���';
      id := jcdsResult.FieldByName('id').AsInteger;
      orgname := jcdsResult.FieldByName('orgname').AsString;
      nvhcbbOrg.SetItemIndexByField('name',
      jcdsResult.FieldByName('orgname').AsString);
      nvcbbSelltype.Text := jcdsResult.FieldByName('typename').AsString;
      nvcbbSelltype.ItemIndex := jcdsResult.FieldByName('typecode').AsInteger;
      nvcbbtype.Text :=jcdsResult.FieldByName('canselltypevalue').AsString;
      nvcbbtype.ItemIndex := jcdsResult.FieldByName('canselltype').AsInteger;
      nvedtvalue.Text :=jcdsResult.FieldByName('cansellvalue').AsString;

      tid := jcdsResult.FieldByName('tickettypeid').AsString;
      nvcbbTickettypes.SetCheck(jcdsResult.FieldByName('tickettypeid').AsInteger-1,True);
      tname := jcdsResult.FieldByName('tickettypename').AsString;
      remarks :=  jcdsResult.FieldByName('remarks').AsString;
      mmoMeRemark.Text :=  jcdsResult.FieldByName('remarks').AsString;
      createby:=jcdsResult.FieldByName('createby').AsLargeInt;
      createtime:=jcdsResult.FieldByName('createtime').AsString;
      typeid := jcdsResult.FieldByName('typeid').AsString;
      nvhcbbOrg.Enabled := False;
      nvcbbSelltype.Enabled:= False;


      if jcdsResult.FieldByName('typecode').AsString <> '0' then
      begin
      with  jcdsSchedule do
        begin
           Active := false;
          Params.ParamByName('orgid').Value := nvHcbbOrg.HelpFieldValue['id'];
          Params.ParamValues['type'] := jcdsResult.FieldByName('typecode').AsString;
          Params.ParamValues['isupdate'] := 'true';
          Params.ParamValues['id'] := id;
          Active := true;
        end;
      end;

      if SysMainForm.showFormModal(frmScheduleSelltickettypeEdit, False) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(frmScheduleSelltickettypeEdit);
  end;

end;

procedure TFrmScheduleSelltickettype.tbtnFilterClick(Sender: TObject);
begin
   if nvHcbbOrgid.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;

with jcdsResult do
  begin
   Active := False;
    Params.ParamByName('filter_EQL_o!id').Value := nvHcbbOrgid.HelpFieldValue['id'];


    if nvcbbSelltype.ItemIndex > 0 then
    begin
      Params.ParamValues['filter_EQS_spd!type'] := nvcbbSelltype.GetSelectCode;
    end
    else
    begin
      Params.ParamValues['filter_EQS_spd!type'] := '';
    end;
    Active := True;
  end;


end;

procedure TFrmScheduleSelltickettype.tbtnInsertClick(Sender: TObject);

begin
  inherited;
  frmScheduleSelltickettypeEdit := TfrmScheduleSelltickettypeEdit.Create(self);
  try
    with frmScheduleSelltickettypeEdit do
    begin
      Caption := '��Ӱ��Ԥ��Ʊ�ֿ���';
      edittype:=add;
      createby:=SysInfo.LoginUserInfo.UserID;
//      lblRemark.Left := 57;
//      lblRemark.Top := 158;
//      mmoMeRemark.Left := 92;
//      mmoMeRemark.Top := 155 ;
      if SysMainForm.showFormModal(frmScheduleSelltickettypeEdit, False) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(frmScheduleSelltickettypeEdit);
  end;

end;

end.
