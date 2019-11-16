unit UFrmComplexfee;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  UFrmComplexfeeEdit, NvPrnDbgeh, NvDbgridEh, NovaEdit,
  NovaCheckedComboBox, NovaHelp, Generics.Collections, NovaPrint;

type
  TFrmComplexfee = class(TSimpleCRUDForm)
    jcdsdel: TjsonClientDataSet;
    Label2: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    nvhlpUser: TNovaHelp;
    Label1: TLabel;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl5: TLabel;
    dtpEdepartdate: TDateTimePicker;
    jcdsComplexfeeSave: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
  private
    { Private declarations }
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
  public
    { Public declarations }
  end;

var
  FrmComplexfee: TFrmComplexfee;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmComplexfee.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.Active :=true;
  dtpBdepartdate.Date := now;
  dtpEdepartdate.Date := now;
end;

procedure TFrmComplexfee.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('��ʾ','ȷ��Ҫɾ���ü�¼��') then
    begin
      exit;
    end;
    with jcdsdel do
    begin
      Params.ParamValues['complexfee.id']:=jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['complexfee.orgid']:=jcdsResult.FieldByName('orgid').AsString;
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
    SysDialogs.ShowInfo('����ѡ����Ҫɾ���ļ�¼��');
  end;
end;

procedure TFrmComplexfee.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  FrmComplexfeeEdit := TFrmComplexfeeEdit.Create(self);
  try
    with FrmComplexfeeEdit do
    begin
      Caption := '�޸��ۺ��շ���Ϣ';
      edittype:=Tedittype.update;
      id:=self.jcdsResult.FieldByName('id').AsInteger;
      createtime:=self.jcdsResult.FieldByName('createtime').AsString;
      createby:=self.jcdsResult.FieldByName('createby').AsString;
      orgid := self.jcdsResult.FieldByName('orgid').AsInteger;
      edtCostomer.Text:= self.jcdsResult.FieldByName('customer').AsString;
      nvtype.Text := self.jcdsResult.FieldByName('feetype').AsString;
      nvedtfee.Text := self.jcdsResult.FieldByName('fee').AsString;
      feetype := self.jcdsResult.FieldByName('feetype').AsString;
      fee := self.jcdsResult.FieldByName('fee').AsString;
      customer := self.jcdsResult.FieldByName('customer').AsString;
      printtime := self.jcdsResult.FieldByName('printtime').AsString;
      remarks := self.jcdsResult.FieldByName('remarks').AsString;
      nvedtRemarks.Text := self.jcdsResult.FieldByName('remarks').AsString;
      nvhelpUserid.Text := self.jcdsResult.FieldByName('operatorname').AsString;
      nvhelpUserid.Id :=  self.jcdsResult.FieldByName('operatorid').AsInteger;
      operatorname  := self.jcdsResult.FieldByName('operatorname').AsString;
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(tbtnFilter);
        jcdsResult.Locate('id',id,[] );
      end;
    end;
  finally
    FreeAndNil(FrmComplexfeeEdit);
  end;
end;

procedure TFrmComplexfee.tbtnFilterClick(Sender: TObject);
var vipgradename,tempstring:string;
i:integer;
begin
  inherited;
  if (NovaCkbOrg.CheckedCount=0) then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    NovaCkbOrg.SetFocus;
    exit;
  end;
  if FormatDateTime('yyyymmdd',dtpBdepartdate.Date)>FormatDateTime('yyyymmdd',
     dtpEdepartdate.Date) then
     begin
       SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������!');
       exit;
     end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_cx!orgid'] := NovaCkbOrg.GetSelectID;
    if nvhlpUser.Id > 0 then
        Params.ParamValues['filter_EQL_cx!operator'] := nvhlpUser.Id
    else
        Params.ParamValues['filter_EQL_cx!operator'] := '';

    Params.ParamValues['filter_GED_cx!printtime'] :=
                formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)+' 00:00:00';
    Params.ParamValues['filter_LED_cx!printtime'] :=
                formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date)+' 23:59:59';
                
    Active := true;
  end;
end;

procedure TFrmComplexfee.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmComplexfeeEdit := TFrmComplexfeeEdit.Create(self);
  try
    with FrmComplexfeeEdit do
    begin
      Caption := '����ۺ��շ�';
      edittype:=Tedittype.add;
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(tbtnFilter);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmComplexfeeEdit);
  end;
end;

procedure TFrmComplexfee.ToolButton50Click(Sender: TObject);
var   optype,log, templtename :string;
begin
  inherited;
  with jcdsComplexfeeSave do
  begin
    Close;
    Params.ParamValues['complexfee.customer']
                := self.jcdsResult.FieldByName('customer').AsString;
    Params.ParamValues['complexfee.feetype']
                := self.jcdsResult.FieldByName('feetype').AsString ;
    Params.ParamValues['complexfee.fee']
                := self.jcdsResult.FieldByName('fee').AsString ;
    Params.ParamValues['complexfee.printtime']
                := formatdatetime('yyyy-mm-dd hh:mm:ss',now) ;
    Params.ParamValues['complexfee.remarks']
                := self.jcdsResult.FieldByName('remarks').AsString ;
    Params.ParamValues['complexfee.operator']
                := self.jcdsResult.FieldByName('operatorid').AsString ;
    Params.ParamValues['complexfee.orgid']
                := self.jcdsResult.FieldByName('orgid').AsString ;
    Params.ParamValues['complexfee.id']
                := self.jcdsResult.FieldByName('id').AsString ;
    Params.ParamByName('complexfee.createby').Value
                := self.jcdsResult.FieldByName('createby').AsString ;
    Params.ParamByName('complexfee.createtime').Value
                := self.jcdsResult.FieldByName('createtime').AsString ;
   Params.ParamByName('complexfee.updateby').Value
                := SysInfo.LoginUserInfo.UserID;
    Params.ParamByName('complexfee.updatetime').Value
                := formatdatetime('yyyy-mm-dd hh:mm:ss',now) ;
   try
      Execute;
       if (Params.ParamByName('flag').Value <> 1) then
      begin
         SysDialogs.ShowMessage('��ӡʧ�ܣ�');
      end
      else
      begin
        optype :='���´�ӡ�ۺ��շ�';
        log := SysInfo.LoginUserInfo.OrgName+'���û�:'+SysInfo.LoginUserInfo.UserName
              +'��[��ӡʱ��]:'+formatdatetime('yyyy-mm-dd',now)
              +'��[�ͻ���]'+self.jcdsResult.FieldByName('customer').AsString
              +'��[���]'+self.jcdsResult.FieldByName('feetype').AsString
              +'��[���]'+self.jcdsResult.FieldByName('fee').AsString
              +'��[������]'+self.jcdsResult.FieldByName('operatorname').AsString;
        SysLog.WriteLog('�������->�ۺ��շ���Ϣ����', optype, log);

        templtename := TNovaPrint.GetTicketModelName('�ۺ��շ���Ϣ', '�ۺ��շ���Ϣ');
        if not Assigned(billPrint) then
          billPrint := TNovaPrint.Create(self, templtename);
        if not Assigned(printValue) then
          printValue := TDictionary<String, String>.Create
        else
            printValue.Clear;
        printValue.Add('orgname',self.jcdsResult.FieldByName('orgname').AsString);
        printValue.Add('customer',self.jcdsResult.FieldByName('customer').AsString);
        printValue.Add('feetype', self.jcdsResult.FieldByName('feetype').AsString);
        printValue.Add('fee',  self.jcdsResult.FieldByName('fee').AsString);
        printValue.Add('operator', self.jcdsResult.FieldByName('operatorname').AsString);
        printValue.Add('printtime', formatdatetime('yyyy-mm-dd',now));
        printValue.Add('remarks', self.jcdsResult.FieldByName('remarks').AsString);
        billPrint.SingleValue := printValue;
        billPrint.Print;
      end;

   finally

   end;
  end;


end;

end.
