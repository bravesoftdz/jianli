unit UFrmEmployee;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaCheckedComboBox,UFrmEmployeeEdit,Services;

type
  TfrmEmployee = class(TSimpleCRUDForm)
    nvckbOrgid: TNovaCheckedComboBox;
    lbl3: TLabel;
    lbl2: TLabel;
    nvedtCode: TNovaEdit;
    lbl1: TLabel;
    nvedtName: TNovaEdit;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultcode: TWideStringField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResulteducation: TWideStringField;
    wdstrngfldResultfamilyaddress: TWideStringField;
    wdstrngfldResultfamilyphone: TWideStringField;
    wdstrngfldResultidcard: TWideStringField;
    blnfldResultistemporary: TBooleanField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultname: TWideStringField;
    wdstrngfldResultnativeplace: TWideStringField;
    lrgntfldResultorgid: TLargeintField;
    wdstrngfldResultposition: TWideStringField;
    fltfldResultsalary: TFloatField;
    wdstrngfldResultsex: TWideStringField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    jcdsEducation: TjsonClientDataSet;
    jcdsPosition: TjsonClientDataSet;
    wdstrngfldResultpositionname: TWideStringField;
    wdstrngfldResulteducationame: TWideStringField;
    jcdsDelete: TjsonClientDataSet;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultbirthday: TDateField;
    jcdsFindPicture: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmployee: TfrmEmployee;

implementation
uses UDMPublic,PubFn;

{$R *.dfm}


procedure TfrmEmployee.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
       // 删除
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该员工档案吗？') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['delid']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' 删除员工:'+jcdsResult.FieldByName('name').AsString+'的档案记录';
      SysLog.WriteLog('员工档案管理', '删除', log);
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
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TfrmEmployee.tbtnEditClick(Sender: TObject);
var HexStr:string;curid:int64;
begin
  inherited;
  //修改
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0)  then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('请先选择需要修改的记录！');
    end;
    try
      frmEmployeeEdt := TfrmEmployeeEdt.Create(self);
      with frmEmployeeEdt do
      begin
        Caption:='修改员工档案信息';
        iseditS := True;
        id :=  jcdsResult.FieldByName('id').AsInteger;
        createby :=  jcdsResult.FieldByName('createby').AsString;
        createtime := jcdsResult.FieldByName('createtime').AsString;
        nvedtName.Text :=jcdsResult.FieldByName('name').AsString;
        nvedtCode.Text :=jcdsResult.FieldByName('code').AsString;
        codess :=jcdsResult.FieldByName('code').AsString;
        nvedtIDcard.Text :=jcdsResult.FieldByName('idcard').AsString;
        nvedtFamilyPhone.Text:=jcdsResult.FieldByName('familyphone').AsString;
        nvedtMovePhone.Text:=jcdsResult.FieldByName('mobilephone').AsString;
        nvedtNativeplace.Text:=jcdsResult.FieldByName('nativeplace').AsString;
        nvedtAdress.Text:=jcdsResult.FieldByName('familyaddress').AsString;
        nvedtSalary.Text:=jcdsResult.FieldByName('salary').AsString;
        dtpBirthdate.Date:=jcdsResult.FieldByName('birthday').AsDateTime;
        nvcbbEducation.SetItemIndexByCode(self.jcdsResult.FieldByName('education').AsString);
        nvcbbPosition.SetItemIndexByCode(self.jcdsResult.FieldByName('position').AsString);
        nvhelpOrg.Text := jcdsResult.FieldByName('Orgname').AsString;
        nvhelpOrg.Id := jcdsResult.FieldByName('orgid').AsInteger;
        orgname:= jcdsResult.FieldByName('Orgname').AsString;
        tname:=jcdsResult.FieldByName('name').AsString;
        idcard:=jcdsResult.FieldByName('idcard').AsString;
        salary:=jcdsResult.FieldByName('salary').AsString;
        education :=nvcbbEducation.Text;
        position :=nvcbbPosition.Text;
        if jcdsResult.FieldByName('sex').AsString='男' then
          begin
            rbMan.Checked := True;
            rbGrile.Checked := False;
          end
        else
        begin
          rbMan.Checked :=False;
          rbGrile.Checked :=True;
        end;
       if jcdsResult.FieldByName('istemporary').AsBoolean = true then
         chkTemp.Checked := True
       else
          chkTemp.Checked :=False;

        with jcdsFindPicture do
        begin
          Active:=False;
          Params.ParamValues['filter_EQL_e!id']:= jcdsResult.FieldByName('id').AsInteger;
          Active := True;
          if recordcount > 0 then
            begin
            HexStr := FieldByName('picture').AsString;
            if (HexStr <> '') then
            imgImg_Picture1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
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
      FreeAndNil(frmEmployeeEdt);
    end;
  end;
end;

procedure TfrmEmployee.tbtnFilterClick(Sender: TObject);
begin
  inherited;
   with jcdsResult do
  begin
    Active:=False;
      Params.ParamValues['filter_INS_o!id']:=  nvckbOrgid.GetSelectID;
      Params.ParamValues['filter_LIKES_e!name']:=nvedtName.Text;
      Params.ParamValues['filter_LIKES_e!code']:=nvedtCode.Text;
    Active:=True;
    end;
end;

procedure TfrmEmployee.tbtnInsertClick(Sender: TObject);
begin
  inherited;
 //添加
   frmEmployeeEdt := TfrmEmployeeEdt.Create(self);
  with frmEmployeeEdt do
  begin
   try
    Caption := '添加员工档案信息';
     ShowModal;
     if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
   finally
    FreeAndNil(frmEmployeeEdt);
   end;
  end;
end;

procedure TfrmEmployee.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
end;

end.