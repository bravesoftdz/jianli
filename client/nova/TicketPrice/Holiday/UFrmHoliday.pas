unit UFrmHoliday;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaComboBox;

type
  TFrmHoliday = class(TSimpleCRUDForm)
    Label1: TLabel;
    NovaCbbHolidayType: TNovaComboBox;
    Label5: TLabel;
    NovaEdtHoliday: TNovaEdit;
    jcdsResulttype: TWideStringField;
    jcdsQryHolidayType: TjsonClientDataSet;
    jcdsResultfullname: TWideStringField;
    jcdsResulttypename: TWideStringField;
    jcdsResultusername: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultorgid: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsDelHoliday: TjsonClientDataSet;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultenddate: TDateField;
    jcdsResultstartdate: TDateField;
    jcdsResultsynccode: TWideStringField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmHoliday: TFrmHoliday;

implementation
uses UFrmHolidayEdt,PubFn, Services,UDMPublic;
{$R *.dfm}

procedure TFrmHoliday.FormShow(Sender: TObject);
begin
  inherited;
  NovaCbbHolidayType.Active:=false;
  NovaCbbHolidayType.Active:=true;
  jcdsQryHolidayType.Active:=false;
  jcdsQryHolidayType.Active:=true;
end;

procedure TFrmHoliday.tbtnCancelClick(Sender: TObject);
begin
  inherited;
  NovaCbbHolidayType.ItemIndex:=-1;
  NovaEdtHoliday.Clear;
  tbtnFilterClick(Sender);
end;

procedure TFrmHoliday.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult,scheduleid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  if SysDialogs.Confirm('ɾ������','ȷ��Ҫɾ���ý�����Ϣ��') then
  with jcdsDelHoliday do
  begin
    Active := false;
    Params.ParamValues['holiday.id'] := jcdsResult.FieldByName('id').AsLargeInt;
    Params.ParamValues['holiday.createby'] := jcdsResult.FieldByName('createby').AsLargeInt;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
      log := 'ɾ��������Ϣ���ã�����='+jcdsResult.FieldByName('typename').AsString+
      ',�Զ�������='+jcdsResult.FieldByName('fullname').AsString+',��ʼ����='
      +jcdsResult.FieldByName('startdate').AsString+',��������='
      +jcdsResult.FieldByName('enddate').AsString;
      SysLog.WriteLog('Ʊ�۹�����>������Ϣ����','ɾ��',log);
      SysDialogs.ShowMessage(sResult);
      tbtnFilterClick(sender);
    end
    else
      SysDialogs.Warning(sResult);
  end;

end;

procedure TFrmHoliday.tbtnEditClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount<=0 then
     exit;

  FrmHolidayEdt := TFrmHolidayEdt.Create(self);
  try
    with FrmHolidayEdt do
    begin
      Caption := '�޸Ľ�����Ϣ';
      createby := SysInfo.LoginUserInfo.UserID;
      orgid    := SysInfo.LoginUserInfo.OrgID;
      curid:=  jcdsResult.FieldByName('id').AsLargeInt;
      id:=  jcdsResult.FieldByName('id').AsLargeInt;
      createtime:=  jcdsResult.FieldByName('createtime').AsString;
      holidaytypename:=  jcdsResult.FieldByName('typename').AsString;
      synccode:=  jcdsResult.FieldByName('synccode').AsString;
      NovaEdtHoliday.Text:=  jcdsResult.FieldByName('fullname').AsString;
      DateTpFromDate.Date:= jcdsResult.FieldByName('startdate').AsDateTime;
      DateTpEndDate.Date:= jcdsResult.FieldByName('enddate').AsDateTime;
      NovaCbbHolidayType.ItemIndex:=NovaCbbHolidayType.Items.IndexOf(holidaytypename);
      edittype := Tedittype.update;
      if SysMainForm.showFormModal(FrmHolidayEdt,false) = mrok then
      begin
         curid:=id;
         tbtnFilterClick(Sender);
         jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmHolidayEdt);
  end;

end;

procedure TFrmHoliday.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if NovaCbbHolidayType.ItemIndex>0 then
       Params.ParamValues['filter_EQS_h!type'] := NovaCbbHolidayType.GetSelectCode
    else
       Params.ParamValues['filter_EQS_h!type'] :=null;

    Params.ParamValues['filter_LIKES_h!fullname'] := trim(NovaEdtHoliday.text);
    Active := true;
  end;
end;

procedure TFrmHoliday.tbtnInsertClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;
  FrmHolidayEdt := TFrmHolidayEdt.Create(self);
  try
    with FrmHolidayEdt do
    begin
      Caption := '��ӽ�����Ϣ';
      createby := SysInfo.LoginUserInfo.UserID;
      orgid    := SysInfo.LoginUserInfo.OrgID;
      edittype := add;
      if SysMainForm.showFormModal(FrmHolidayEdt,false) = mrok then
      begin
         curid:=id;
         tbtnFilterClick(Sender);
         jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmHolidayEdt);
  end;
end;

end.
