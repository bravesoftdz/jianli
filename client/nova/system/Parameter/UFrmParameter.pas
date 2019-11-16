unit UFrmParameter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox;

type
  TFrmParameter = class(TSimpleCRUDForm)
    lblOrg: TLabel;
    lblcode: TLabel;
    lblType: TLabel;
    lblParamvalue: TLabel;
    nvcbbtype: TNovaComboBox;
    nvedtVlaue: TNovaEdit;
    nvedtCode: TNovaEdit;
    nvckbOrg: TNovaCheckedComboBox;
    wdstrngfldResultorgname: TWideStringField;
    nvedtRemark: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    nvedtUnit: TNovaEdit;
    wdstrngfldResulttype: TWideStringField;
    wdstrngfldResultunit: TWideStringField;
    lrgntfldResultdid: TLargeintField;
    lrgntfldResultorgids: TLargeintField;
    wdstrngfldResultremark: TWideStringField;
    wdstrngfldResultiseditable: TBooleanField;
    lrgntfldResultpid: TLargeintField;
    chkYes: TCheckBox;
    chkNo: TCheckBox;
    jcdsTypename: TjsonClientDataSet;
    wdstrngfldResulttypename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    wdstrngfldResultshowvalue: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure nvedtCodeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    var Tsystem,Tsellticket,Treturnticket,Tcheckticket,
    Tdeparted,Tdepartmanage,Task,Tbalance,Tpersell,
    Tcancelticket,Tchangeticket,Tscheduleplan,
    Tvichlesafe,Tvipcard:Boolean;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
  end;

var
  FrmParameter: TFrmParameter;

implementation

uses UFrmParameterAdd, Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmParameter.FormShow(Sender: TObject);
begin
  inherited;
  nvckbOrg.Active := False;
  nvckbOrg.Active := True;
  nvckbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbtype.Active := False;
  nvcbbtype.Active := True;
  jcdsTypename.Active := False;
  jcdsTypename.Active := True;
end;

procedure TFrmParameter.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{E829E21F-F69D-42BA-B34F-F74583E4DA86}' then
  begin
    Tsystem := aEnable  //���в�ѯϵͳ��Ȩ��
  end ;
  if GUIDToString(key)='{79DEEB19-F507-4014-928A-18BB44B5B604}' then
  begin
    Tsellticket := aEnable   //��Ʊ
  end;
  if GUIDToString(key)='{9847EF90-8E73-4DCE-94B9-A9E7AB962070}' then
  begin
    Treturnticket := aEnable   //��Ʊ
  end;
  if GUIDToString(key) ='{B06D37D4-C9B6-48A2-AC58-DD57A13F66FA}' then
  begin
    Tcheckticket := aEnable //��Ʊ
  end;
  if GUIDToString(key) ='{C22CF1D9-6AD4-4BF9-983E-74B80679127F}' then
  begin
    Tdeparted := aEnable //����
  end;
  if GUIDToString(key) ='{F1C7D222-AD00-4DD6-B04F-B9C9656521D5}' then
  begin
    Tdepartmanage := aEnable //����
  end;
  if GUIDToString(key) ='{5C5D1C63-04F1-4288-B106-E183850050A7}' then
  begin
    Task := aEnable ;//��Ʊ��ѯ
  end ;
  if GUIDToString(key) ='{7663CDA5-B28D-4B34-BA32-FAB3B710D897}' then
  begin
    Tbalance :=aEnable;  //����
  end;
  if GUIDToString(key) ='{249AF39F-C374-4732-B4A0-2C3467844625}' then
  begin
     Tpersell:=aEnable;//��Ʊ
  end;
  if GUIDToString(key) ='{DE601407-9996-48C4-8E86-4316B8A33302}' then
  begin
     Tcancelticket :=aEnable;//��Ʊ
  end;
  if GUIDToString(key) ='{F150BE56-5AEF-4548-AD89-8151D41F3CD3}' then
  begin
     Tchangeticket:=aEnable;//��ǩ
  end;
  if GUIDToString(key) ='{5C39499D-A885-4E24-8E80-4CDBB316BB09}' then
  begin
     Tscheduleplan:=aEnable;//��μƻ�
  end;
  if GUIDToString(key) ='{E9C3FC93-A17F-49C3-B87E-9E0900B00EAB}' then
  begin
     Tvichlesafe:=aEnable;//������ȫ
  end;
   if GUIDToString(key) = '{214466EB-7267-45C4-B496-1C9A8584DB54}' then
  begin
     Tvipcard:=aEnable;//��Ա��
  end;
end;

procedure TFrmParameter.nvedtCodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
     tbtnFilterClick(Sender);
  end;
end;

procedure TFrmParameter.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if  jcdsResult.FieldByName('oid').AsInteger <> SysInfo.LoginUserInfo.OrgID then
  begin
     SysDialogs.Warning('��ѡ��Ĳ��������ڱ�������������ɾ����');
     exit;
  end
  else
  begin
     SysDialogs.Warning(SysInfo.LoginUserInfo.UserName);
  end;
end;

procedure TFrmParameter.tbtnEditClick(Sender: TObject);
var
  detailid,createby: integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if  not jcdsResult.FieldByName('iseditable').AsBoolean then
  begin
     SysDialogs.Warning('��ѡ��Ĳ������ɱ༭');
     exit;
  end;

  if (jcdsResult.FieldByName('typename').AsString='ϵͳ') and (not(Tsystem))
    or((jcdsResult.FieldByName('typename').AsString='��Ʊ') and (not(tsellticket)))
    or ((jcdsResult.FieldByName('typename').AsString='��Ʊ') and (not(Treturnticket)))
    or ((jcdsResult.FieldByName('typename').AsString='��Ʊ') and (not(Tcheckticket)))
    or ((jcdsResult.FieldByName('typename').AsString='����') and (not(Tdeparted)))
    or ((jcdsResult.FieldByName('typename').AsString='����') and (not(Tdepartmanage)))
    or ((jcdsResult.FieldByName('typename').AsString='��Ʊ��ѯ') and (not(Task)))
    or ((jcdsResult.FieldByName('typename').AsString='����') and (not(Tbalance) ))
    or ((jcdsResult.FieldByName('typename').AsString='��Ʊ') and (not(Tpersell) ))
    or ((jcdsResult.FieldByName('typename').AsString='��Ʊ') and (not(Tcancelticket) ))
    or ((jcdsResult.FieldByName('typename').AsString='��ǩ') and (not(Tchangeticket) ))
    or ((jcdsResult.FieldByName('typename').AsString='��μƻ�') and (not(Tscheduleplan) ))
    or ((jcdsResult.FieldByName('typename').AsString='����') and (not(Tvichlesafe) ))
    or ((jcdsResult.FieldByName('typename').AsString='��Ա��') and (not(Tvipcard) ))
  then
  begin
     SysDialogs.Warning('��û���޸ĸò������ͼ�¼��Ȩ�ޣ�');
     exit;
  end;

  FrmParameterAdd := TFrmParameterAdd.Create(Self);
  with FrmParameterAdd do
  begin
    Caption := '�޸Ĳ�����Ϣ';
    flag := false;
    parameterid := jcdsResult.FieldByName('pid').AsInteger;
    detailid := jcdsResult.FieldByName('did').AsInteger;
    orgid := jcdsResult.FieldByName('orgids').AsInteger;
    nvhcbbOrg.Text  :=jcdsResult.FieldByName('orgname').AsString;
   // detailid :=  jcdsResult.FieldByName('did').AsInteger;
    nvedtCode.Text := jcdsResult.FieldByName('code').AsString;
    nvcbbtype.Text := jcdsResult.FieldByName('typename').AsString;
    nvedtValue.Text := jcdsResult.FieldByName('showvalue').AsString;
    mmoDeseription.Text := jcdsResult.FieldByName('remark').AsString;
    unitname := jcdsResult.FieldByName('unit').AsString;
    isedt := True;
    nvhcbbOrg.SetItemIndexByField('name',jcdsResult.FieldByName('orgname').AsString);
    if SysMainForm.showFormModal(FrmParameterAdd,False) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('did', id, []);
    end;
  end;
end;

procedure TFrmParameter.tbtnFilterClick(Sender: TObject);
var
  orgid:Integer;
  isaction: string;
  values:string;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if nvcbbtype.GetSelectID > 0 then
      begin
         Params.ParamByName('filter_EQS_p!type').Value := nvcbbtype.GetSelectCode;
      end
    else
      begin
         Params.ParamByName('filter_EQS_p!type').Value := '';
      end;

    if nvckbOrg.CheckedCount<=0 then
    begin
      SysDialogs.ShowError('������ѡ��һ������!');
      nvckbOrg.SetFocus;
      exit;
    end;

    Params.ParamByName('filter_INS_oa!id').Value := nvckbOrg.GetSelectID;
    Params.ParamByName('orgids').Value := nvckbOrg.GetSelectID;

    if chkYes.Checked and  not chkNo.Checked Then
      begin
        Params.ParamByName('filter_EQB_p!iseditable').Value :=  '1';
      end
    else if chkNo.Checked and  not chkYes.Checked  then
      begin
        Params.ParamByName('filter_EQB_p!iseditable').Value := '0';
      end
    else
     begin
        Params.ParamByName('filter_EQB_p!iseditable').Value := '';
     end;

    Params.ParamByName('filter_EQS_p!code').Value := nvedtCode.Text;
//    Params.ParamByName('filter_LIKES_p!value_OR_d!value').Value := nvedtVlaue.Text;
    Params.ParamByName('filter_LIKES_p!unit').Value := nvedtUnit.Text;
    Params.ParamByName('filter_LIKES_p!remark').Value := nvedtRemark.Text;

    Active := True;
  end;
end;

end.
