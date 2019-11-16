unit UFrmDWardpenalize;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaEdit,UFrmDwardpenalizeEdt,Services,
  NovaComboBox, NovaHelp;

type
  TfrmWardpenalize = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbllbvehicleid: TLabel;
    lbl9: TLabel;
    dtpBegindate: TDateTimePicker;
    lbl4: TLabel;
    dtpEnddate: TDateTimePicker;
    nvcbbType: TNovaComboBox;
    nvdbgrdh1: TNvDbgridEh;
    jcdsDelete: TjsonClientDataSet;
    lrgntfldResultid: TLargeintField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResultcreatename: TWideStringField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultupdatename: TWideStringField;
    wdstrngfldResultdrivername: TWideStringField;
    wdstrngfldResultcontent: TWideStringField;
    wdstrngfldResultreason: TWideStringField;
    lrgntfldResultdeductdistance: TLargeintField;
    lrgntfldResultdeductscore: TLargeintField;
    lrgntfldResultdriverid: TLargeintField;
    wdstrngfldResulttype: TWideStringField;
    jcdsType: TjsonClientDataSet;
    wdstrngfldResulttypename: TWideStringField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultrewarddate: TDateField;
    nvhelpDriver: TNovaHelp;
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
  frmWardpenalize: TfrmWardpenalize;

implementation

{$R *.dfm}

procedure TfrmWardpenalize.FormCreate(Sender: TObject);
begin
  inherited;
  dtpEnddate.Date := Now;
  dtpBegindate.Date := Now;
  nvcbbType.Active := False;
  nvcbbType.Active :=True;
end;

procedure TfrmWardpenalize.tbtnDeleteClick(Sender: TObject);
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
        log := ' ɾ����ʻԱ:'+jcdsResult.FieldByName('drivername').AsString+'�Ľ��ͼ�¼'
              +',�������ͣ�'+jcdsResult.FieldByName('typename').AsString
              +',ԭ��:'+jcdsResult.FieldByName('reason').AsString;
        SysLog.WriteLog('��������->��ʻԱ���ͼ�¼����', 'ɾ��', log);
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

procedure TfrmWardpenalize.tbtnEditClick(Sender: TObject);
begin
  inherited;
 //�޸�
    if not dsResult.DataSet.Active then
      exit;
    if dsResult.DataSet.RecordCount < 1 then
      exit;
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('����ѡ����Ҫ�޸ĵļ�¼��');
    end;
    try
      frmDriverrewardpenalize := TfrmDriverrewardpenalize.Create(self);
      with frmDriverrewardpenalize do
      begin
        Caption:='�޸Ľ��ͼ�¼��Ϣ';
        id :=  jcdsResult.FieldByName('id').AsInteger;
        createby :=  jcdsResult.FieldByName('createby').AsString;
        createtime := jcdsResult.FieldByName('createtime').AsString;
        nvhelpDriver.Text := jcdsResult.FieldByName('drivername').AsString;
        nvhelpDriver.Id := jcdsResult.FieldByName('driverid').AsInteger;
        nvcbbType.SetItemIndexByCode(self.jcdsResult.FieldByName('type').AsString);
        nvedtResion.Text := jcdsResult.FieldByName('reason').AsString;
        mmoContent.Text := jcdsResult.FieldByName('content').AsString;
        dtpRewarddate.Date:=  jcdsResult.FieldByName('rewarddate').AsDateTime;
        nvedtDeductdistance.Text :=  jcdsResult.FieldByName('deductdistance').AsString;
        nvedtScore.Text :=  jcdsResult.FieldByName('deductscore').AsString;
        tname:= jcdsResult.FieldByName('drivername').AsString;
        types:=nvcbbType.Text;
        content:= jcdsResult.FieldByName('content').AsString;
        reason:= jcdsResult.FieldByName('reason').AsString;
        redate :=  jcdsResult.FieldByName('rewarddate').AsString;
        score :=  jcdsResult.FieldByName('deductscore').AsString;
        deductdistance :=  jcdsResult.FieldByName('deductdistance').AsString;
        nvhelpDriver.Enabled:=False;

        if nvcbbType.GetSelectCode = '0' then
          begin
          nvedtDeductdistance.Text :='';
          nvedtScore.Text :='';
          nvedtDeductdistance.Enabled := False;
          nvedtScore.Enabled := False;
          end
        else
        begin
          nvedtDeductdistance.Enabled := True;
          nvedtScore.Enabled := True;
        end;

       ShowModal;
       if ModalResult=mrok then
       begin
//        tbtnFilter.Click;
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id',id,[] );
       end;

      end;
    finally
      FreeAndNil(frmDriverrewardpenalize);
    end;
end;

procedure TfrmWardpenalize.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
   Active :=False;
   if (not (Trim(nvhelpDriver.Text) = '')) and (nvhelpDriver.Id>0)  then
   begin
      Params.ParamValues['filter_EQL_e!driverid']:=nvhelpDriver.id;
   end
   else
   begin
     Params.ParamValues['filter_EQL_e!driverid']:='';
   end;
      if nvcbbType.ItemIndex>0 then
        begin
           Params.ParamValues['filter_EQS_e!type']:=nvcbbType.GetSelectCode;
        end
      else
      begin
        Params.ParamValues['filter_EQS_e!type']:='';
      end;
     Params.ParamValues['filter_LED_e!rewarddate']:= formatdatetime('yyyy-mm-dd',dtpEnddate.Date); //С�ڵ��ڽ�������
     Params.ParamValues['filter_GED_e!rewarddate']:=formatdatetime('yyyy-mm-dd',dtpBegindate.Date); //���ڿ�ʼ����

   Active :=True;
  end;
end;

procedure TfrmWardpenalize.tbtnInsertClick(Sender: TObject);
var id_:Integer;
begin
  inherited;
//���
   frmDriverrewardpenalize := TfrmDriverrewardpenalize.Create(self);
  with frmDriverrewardpenalize do
  begin
    Caption := '��ӽ��ͼ�¼��Ϣ';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;

end;
end.