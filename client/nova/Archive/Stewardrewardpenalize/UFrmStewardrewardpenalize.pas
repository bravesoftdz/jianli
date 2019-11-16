unit UFrmStewardrewardpenalize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaEdit,UFrmStewardrewardpenalizeEdit,Services,
  NovaComboBox, NovaHelp;

type
  TfrmStewardrewardpenalize = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbllbvehicleid: TLabel;
    lbl9: TLabel;
    dtpBegindate: TDateTimePicker;
    lbl4: TLabel;
    dtpEnddate: TDateTimePicker;
    lrgntfldResultid: TLargeintField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResultcontent: TWideStringField;
    wdstrngfldResultreason: TWideStringField;
    wdstrngfldResulttype: TWideStringField;
    lrgntfldResultupdateby: TLargeintField;
    lrgntfldResultstewardid: TLargeintField;
    wdstrngfldResultstewardname: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    jcdsType: TjsonClientDataSet;
    wdstrngfldResulttypename: TWideStringField;
    nvcbbType: TNovaComboBox;
    nvdbgrdh1: TNvDbgridEh;
    jcdsDelete: TjsonClientDataSet;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultrewarddate: TDateField;
    nvhelpSteward: TNovaHelp;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStewardrewardpenalize: TfrmStewardrewardpenalize;

implementation

{$R *.dfm}

procedure TfrmStewardrewardpenalize.FormCreate(Sender: TObject);
begin
  inherited;
  dtpEnddate.Date := Now;
  dtpBegindate.Date := Now;
  nvcbbType.Active := False;
  nvcbbType.Active :=True;
end;

procedure TfrmStewardrewardpenalize.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
    // ɾ��
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('��ʾ','ȷ��Ҫɾ���ü�¼��') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['delid']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
       log := ' ɾ������Ա:'+jcdsResult.FieldByName('stewardname').AsString+'�Ľ��ͼ�¼,���ͣ�'
              +jcdsResult.FieldByName('typename').AsString
              +',ԭ��'+jcdsResult.FieldByName('reason').AsString;
      SysLog.WriteLog('��������->����Ա���ͼ�¼����', 'ɾ��', log);
      log:='';
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
    SysDialogs.ShowError('����ѡ����Ҫɾ���ļ�¼��');
  end;
end;

procedure TfrmStewardrewardpenalize.tbtnEditClick(Sender: TObject);
begin
  inherited;
 //�޸�
 if not dsResult.DataSet.Active then
  exit;
if dsResult.DataSet.RecordCount < 1 then
  exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0)  then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('����ѡ����Ҫ�޸ĵļ�¼��');
    end;
    try
      frmStewardrewardpenalizeEdt := TfrmStewardrewardpenalizeEdt.Create(self);
      with frmStewardrewardpenalizeEdt do
      begin
        Caption:='�޸ĳ���Ա������Ϣ';
        isedit:= True;
        id :=  jcdsResult.FieldByName('id').AsInteger;
        createby :=  jcdsResult.FieldByName('createby').AsString;
        createtime := jcdsResult.FieldByName('createtime').AsString;
        nvhelpSteward.Text := jcdsResult.FieldByName('stewardname').AsString;
        tname := jcdsResult.FieldByName('stewardname').AsString;
        nvhelpSteward.Id := jcdsResult.FieldByName('stewardid').AsInteger;
        nvcbbType.SetItemIndexByCode(self.jcdsResult.FieldByName('type').AsString);
        types:= jcdsResult.FieldByName('type').AsString;
        typenames := jcdsResult.FieldByName('typename').AsString;
        nvedtResion.Text := jcdsResult.FieldByName('reason').AsString;
        reason := jcdsResult.FieldByName('reason').AsString;
        mmoContent.Text := jcdsResult.FieldByName('content').AsString;
        content:= jcdsResult.FieldByName('content').AsString;
        dtpRewarddate.Date := jcdsResult.FieldByName('rewarddate').AsDateTime;
        redate := jcdsResult.FieldByName('rewarddate').AsString;
        nvhelpSteward.Enabled:=False;
          ShowModal;
        if ModalResult =mrok then
        begin
         tbtnFilterClick(Sender);
         jcdsResult.Locate('id',id,[] );
        end;
      end;
    finally
      FreeAndNil(frmStewardrewardpenalizeEdt);
    end;
  end;
end;

procedure TfrmStewardrewardpenalize.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
   Active :=False;
   if (not (Trim(nvhelpSteward.Text) = '')) and (nvhelpSteward.Id>0)  then
   begin
      Params.ParamValues['filter_EQL_e!stewardid']:=nvhelpSteward.id;
   end
   else
   begin
     Params.ParamValues['filter_EQL_e!stewardid']:='';
   end;
    if nvcbbType.ItemIndex>0 then
      begin
         Params.ParamValues['filter_EQS_e!type']:=nvcbbType.GetSelectCode;
      end
    else
    begin
      Params.ParamValues['filter_EQS_e!type']:='';
    end;
    Params.ParamValues['filter_LED_e!rewarddate']:= formatdatetime('c',dtpEnddate.Date);
    Params.ParamValues['filter_GED_e!rewarddate']:=formatdatetime('c',dtpBegindate.Date);

   Active :=True;
  end;
end;

procedure TfrmStewardrewardpenalize.tbtnInsertClick(Sender: TObject);
var id_:Integer;
begin
  inherited;
//���
   frmStewardrewardpenalizeEdt := TfrmStewardrewardpenalizeEdt.Create(self);
  with frmStewardrewardpenalizeEdt do
  begin
    Caption:='��ӳ���Ա������Ϣ';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[]);
    end;
  end;
end;

end.
