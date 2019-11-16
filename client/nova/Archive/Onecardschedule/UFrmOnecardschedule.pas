unit UFrmOnecardschedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping, NovaComboBox, NovaHComboBox;

type
  TFrmOnecardschedule = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lblSelltype: TLabel;
    nvcbbSelltype: TNovaComboBox;
    nvdbgrdh1: TNvDbgridEh;
    nvdbgrdh2: TNvDbgridEh;
    jcdsDelPerselldays: TjsonClientDataSet;
    nvHcbbOrg: TNovaHComboBox;
    lbl1: TLabel;
    lbl6: TLabel;
    dtpStartdates: TDateTimePicker;
    dtpEnddatee: TDateTimePicker;
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
  FrmOnecardschedule: TFrmOnecardschedule;

implementation
  uses PubFn, Services,UFrmOnecardscheduleEdit,UDMPublic;
{$R *.dfm}

procedure TFrmOnecardschedule.FormShow(Sender: TObject);
begin
  inherited;
   nvHcbbOrg.Active := False;
  nvHcbbOrg.Active := True;
  //nvHcbbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  dtpStartdates.Date := Now;
  dtpEnddatee.Date:=Now;
end;

procedure TFrmOnecardschedule.tbtnDeleteClick(Sender: TObject);
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
        +' ��һ��ͨ������ , ������ͣ�'+jcdsResult.FieldByName('typename').AsString;
        if jcdsResult.FieldByName('typecode').AsString='1' then
        begin
          log := log+' , ��·���ƣ�'+jcdsResult.FieldByName('typeidname').AsString
        end;
         if jcdsResult.FieldByName('typecode').AsString='2' then
        begin
          log := log+' , ��κţ�'+jcdsResult.FieldByName('typeidname').AsString
        end;
          log:= log+' , �ð��������Ч��Ϊ'+ jcdsResult.FieldByName('startdate').AsString
              +' �� '+jcdsResult.FieldByName('enddate').AsString ;
        SysLog.WriteLog('һ��ͨ�����ι���', 'ɾ��', log);
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

procedure TFrmOnecardschedule.tbtnEditClick(Sender: TObject);
var tid:string;
begin
  frmOnecardscheduleEdit := TfrmOnecardscheduleEdit.Create(self);
  try
    with frmOnecardscheduleEdit do
    begin
      edittype:=Tedittype.update;
      Caption := '�޸�һ��ͨ������';
      id := jcdsResult.FieldByName('id').AsInteger;
      orgname := jcdsResult.FieldByName('orgname').AsString;
      nvhcbbOrgid.SetItemIndexByField('name',
      jcdsResult.FieldByName('orgname').AsString);
      nvcbbSelltype.Text := jcdsResult.FieldByName('typename').AsString;
      types := jcdsResult.FieldByName('typecode').AsString;
      nvcbbSelltype.ItemIndex := jcdsResult.FieldByName('typecode').AsInteger;
//      days:=  jcdsResult.FieldByName('perserlldays').AsString;
      dtpStart.Date := jcdsResult.FieldByName('startdate').AsDateTime;
      dtpEnd.Date:= jcdsResult.FieldByName('enddate').AsDateTime;
      startdate := jcdsResult.FieldByName('startdate').AsString;
      enddate :=jcdsResult.FieldByName('enddate').AsString;
      remarks :=  jcdsResult.FieldByName('remarks').AsString;
      mmoMeRemark.Text :=  jcdsResult.FieldByName('remarks').AsString;
      createby:=jcdsResult.FieldByName('createby').AsLargeInt;
      createtime:=jcdsResult.FieldByName('createtime').AsString;
      typeid := jcdsResult.FieldByName('typeid').AsString;
      nvcbbSelltype.Enabled:= False;
      nvhcbbOrgid.Enabled:=False;
      if jcdsResult.FieldByName('typecode').AsString <> '0' then
      begin
      with  jcdsSchedule do
        begin
           Active := false;
          Params.ParamByName('orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
          Params.ParamValues['type'] := jcdsResult.FieldByName('typecode').AsString;
          Params.ParamValues['isupdate'] := 'true';
          Params.ParamValues['id'] := jcdsResult.FieldByName('typeid').AsString;
          Active := true;
        end;
      end;

      ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
  finally
    FreeAndNil(frmOnecardscheduleEdit);
  end;

end;

procedure TFrmOnecardschedule.tbtnFilterClick(Sender: TObject);
begin
   if nvHcbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtpStartdates.Date) > FormatDateTime('yyyymmdd',
    dtpEnddatee.Date) )then
  begin
    SysDialogs.ShowMessage('��Ч��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

with jcdsResult do
  begin
   Active := False;
    Params.ParamByName('filter_EQL_o!id').Value := nvHcbbOrg.HelpFieldValue['id'];

    Params.ParamByName('startdate').Value
              :=formatdatetime('yyyy-mm-dd',dtpStartdates.Date);

    Params.ParamByName('enddate').Value
              :=formatdatetime('yyyy-mm-dd',dtpEnddatee.Date)   ;


    if nvcbbSelltype.ItemIndex >= 0 then
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

procedure TFrmOnecardschedule.tbtnInsertClick(Sender: TObject);
begin
  inherited;

   frmOnecardscheduleEdit := TfrmOnecardscheduleEdit.Create(self);
  with frmOnecardscheduleEdit do
  begin
    Caption := '���һ��ͨ������';
     edittype:=add;
      createby:=SysInfo.LoginUserInfo.UserID;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;

end;

end.
