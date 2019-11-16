unit UFrmDriver;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit,Services,UFrmDriverEdit,UFrmDriverworkexperienceEdt,
  UFrmDriverFamilyEidt, NvPrnDbgeh, NvDbgridEh, ZKFPEngXControl_TLB,jpeg,
  NovaCheckedComboBox;

type
  TfrmDriver= class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl2: TLabel;
    nvedtCode: TNovaEdit;
    nvedtName: TNovaEdit;
    lbl1: TLabel;
    lbl4: TLabel;
    nvedtDrivinglicense: TNovaEdit;
    lbl5: TLabel;
    lbl6: TLabel;
    nvedtQualification: TNovaEdit;
    nvcbbtypeDrivertype: TNovaComboBox;
    nvcbbtypeState: TNovaComboBox;
    lbl7: TLabel;
    chkOver: TCheckBox;
    grp3: TGroupBox;
    grp8: TGroupBox;
    tlb1: TToolBar;
    btn1: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btnUpdWork: TToolButton;
    btn5: TToolButton;
    btnDelWork: TToolButton;
    grp1: TGroupBox;
    tlb2: TToolBar;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btnUpdFamily: TToolButton;
    btn11: TToolButton;
    btnDelFamily: TToolButton;
    nvdbgrdhWork: TNvDbgridEh;
    jcdsWork: TjsonClientDataSet;
    dsWorkResult: TDataSource;
    dsFamliy: TDataSource;
    jcdsPoliticsstatus: TjsonClientDataSet;
    jcdsWorkstatus: TjsonClientDataSet;
    jcdsQualificationtype: TjsonClientDataSet;
    lbl8: TLabel;
    nvedtArchiceNo: TNovaEdit;
    jcdsDriverdelete: TjsonClientDataSet;
    jcdsEducation: TjsonClientDataSet;
    jcdsDelWork: TjsonClientDataSet;
    jcdsDelFamily: TjsonClientDataSet;
    dbgrdhroutestop:TNvDbgridEh ;
    jcdsFamily: TjsonClientDataSet;
    lrgntfldFamilyid: TLargeintField;
    wdstrngfldFamilyname: TWideStringField;
    wdstrngfldFamilypoliticsstatus: TWideStringField;
    wdstrngfldFamilyposition: TWideStringField;
    wdstrngfldFamilyrelation: TWideStringField;
    wdstrngfldFamilysex: TWideStringField;
    lrgntfldFamilyupdateby: TLargeintField;
    wdstrngfldFamilyworkunit: TWideStringField;
    lrgntfldFamilydriverid: TLargeintField;
    lrgntfldFamilycreateby: TLargeintField;
    wdstrngfldFamilycreatename: TWideStringField;
    wdstrngfldFamilyupdatename: TWideStringField;
    wdstrngfldFamilypoliticsstatusname: TWideStringField;
    imgLi: TImageList;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultarchiveno: TWideStringField;
    wdstrngfldResultcardno: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResultdrivinglicense: TWideStringField;
    wdstrngfldResulteducation: TWideStringField;
    wdstrngfldResultfamilyaddress: TWideStringField;
    wdstrngfldResultfamilyphone: TWideStringField;
    wdstrngfldResultidcard: TWideStringField;
    lrgntfldResultinitialkm: TLargeintField;
    blnfldResultissignedresponsibility: TBooleanField;
    blnfldResultistemporary: TBooleanField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultname: TWideStringField;
    wdstrngfldResultnativeplace: TWideStringField;
    lrgntfldResultorgid: TLargeintField;
    wdstrngfldResultpoliticsstatus: TWideStringField;
    wdstrngfldResultqualification: TWideStringField;
    wdstrngfldResultqualificationtype: TWideStringField;
    fltfldResultsalary: TFloatField;
    wdstrngfldResultsex: TWideStringField;
    wdstrngfldResultsubunit: TWideStringField;
    lrgntfldResultunitid: TLargeintField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultworkno: TWideStringField;
    wdstrngfldResultworkstatus: TWideStringField;
    wdstrngfldResultvehiclename: TWideStringField;
    wdstrngfldResultunitname: TWideStringField;
    wdstrngfldResulteducationname: TWideStringField;
    wdstrngfldResultworkstatusname: TWideStringField;
    wdstrngfldResultpoilticsstatusname: TWideStringField;
    wdstrngfldResultqualfacationtypename: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    chkNotOver: TCheckBox;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultdrivinglicenseenddate: TDateField;
    jcdsResultdrivinglicensefirstdate: TDateField;
    jcdsResultdrivinglicensestartdate: TDateField;
    jcdsResultqualificationenddate: TDateField;
    jcdsResultqualificationstartdate: TDateField;
    jcdsResultrecruitmentdate: TDateField;
    jcdsResultworkenddate: TDateField;
    jcdsResultworkstartdate: TDateField;
    jcdsFamilycreatetime: TDateTimeField;
    jcdsFamilyupdatetime: TDateTimeField;
    jcdsResultbirthday: TDateField;
    jcdsFamilybirthday: TDateField;
    jcdsFindPicture: TjsonClientDataSet;
    nvhelpUnit: TNovaHelp;
    lrgntfldResultvehicleid: TLargeintField;
    chktemp: TCheckBox;
    chkNtemp: TCheckBox;
    wdstrngfldResultqualifyvehicletype: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultjianpin: TWideStringField;
    Label1: TLabel;
    Label2: TLabel;
    chkYes: TCheckBox;
    chkNo: TCheckBox;
    procedure btn2Click(Sender: TObject);
    procedure btn8Click(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure btnUpdWorkClick(Sender: TObject);
    procedure btnDelWorkClick(Sender: TObject);
    procedure btnUpdFamilyClick(Sender: TObject);
    procedure btnDelFamilyClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure tbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure refreshWork;
    procedure refreshFamily;
  end;

var
  frmDriver: TfrmDriver;


implementation
uses UDMPublic,PubFn,UFrmDriverFinger;

{$R *.dfm}

procedure TfrmDriver.btn2Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 frmDriverworkexperience := TfrmDriverworkexperience.Create(self);
  with frmDriverworkexperience do
  begin
    Caption := '添加'+jcdsResult.FieldByName('name').AsString+'工作经历信息';
    driverid := jcdsResult.FieldByName('id').AsString;
    if SysMainForm.showFormModal(frmDriverworkexperience) = mrok then
    begin
      refreshWork ;
    end;
  end;
end;

procedure TfrmDriver.btn8Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
frmDriverFamily := TfrmDriverFamily.Create(self,self.functionItem);
  with frmDriverFamily do
  begin
    Caption := '添加'+jcdsResult.FieldByName('name').AsString+'家庭成员信息';
    driverid := jcdsResult.FieldByName('id').AsString;
    if SysMainForm.showFormModal(frmDriverFamily) = mrok then
    begin
       refreshFamily
    end;
  end;
end;

 //删除家庭成员
procedure TfrmDriver.btnDelFamilyClick(Sender: TObject);
begin
  inherited;
   if not dsFamliy.DataSet.Active then
    exit;
  if dsFamliy.DataSet.RecordCount < 1 then
    exit;
  if (jcdsFamily.RecordCount <= 0) and (jcdsFamily.RecNo <0 ) then
    exit;
   if not SysDialogs.Confirm('提示','确定要删除该驾驶员家庭成员信息吗？') then
    begin
      exit;
    end;
    with jcdsDelFamily do
    begin
      Params.ParamValues['delid']:=jcdsFamily.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        refreshFamily;
      end;
    end;
end;

 //删除工作经验
procedure TfrmDriver.btnDelWorkClick(Sender: TObject);
begin
  inherited;
   if not dsWorkResult.DataSet.Active then
    exit;
  if dsWorkResult.DataSet.RecordCount < 1 then
    exit;
   if not SysDialogs.Confirm('提示','确定要删除该驾驶员工作经历信息吗？') then
    begin
      exit;
    end;
    with jcdsDelWork do
    begin
      Params.ParamValues['delid']:=jcdsWork.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        refreshWork;
      end;
    end;

end;

//修改家庭成员
procedure TfrmDriver.btnUpdFamilyClick(Sender: TObject);
begin
  inherited;
  if not dsFamliy.DataSet.Active then
    exit;
  if dsFamliy.DataSet.RecordCount < 1 then
    exit;
  if (jcdsFamily.RecordCount <=0) and ( not jcdsFamily.Active) and (jcdsFamily.RecNo < 0) then
  begin
    SysDialogs.ShowError('请先选择需要修改的记录！');
    exit;
  end;

 frmDriverFamily := TfrmDriverFamily.Create(self,self.functionItem);
  with frmDriverFamily do
  begin
    Caption := '修改'+jcdsResult.FieldByName('name').AsString+'家庭成员信息';
    id :=jcdsFamily.FieldByName('id').AsInteger;
    isedt:=true;
    driverid := jcdsFamily.FieldByName('driverid').AsString;
    createby :=jcdsFamily.FieldByName('createby').AsString;
    createtime :=jcdsFamily.FieldByName('createtime').AsString;
    nvedtWorkunit.Text:= jcdsFamily.FieldByName('workunit').AsString;
    nvedtPosition.Text:= jcdsFamily.FieldByName('position').AsString;
    nvedtName.Text :=jcdsFamily.FieldByName('name').AsString;
    nvedtRelation.Text :=jcdsFamily.FieldByName('relation').AsString;
    dtpBirthdate.Date := jcdsFamily.FieldByName('birthday').AsDateTime;
    nvcbbPoliticsstatus.SetItemIndexByCode(self.jcdsFamily.FieldByName('politicsstatus').AsString);
    if jcdsFamily.FieldByName('sex').AsString='男' then
    begin
      rbMan.Checked := True;
      rbGrile.Checked := False;
    end
    else
    begin
      rbMan.Checked :=False;
      rbGrile.Checked :=True;
    end;

    if SysMainForm.showFormModal(frmDriverFamily) = mrok then
    begin
      refreshFamily
    end;
  end;
end;

//修改工作经验
procedure TfrmDriver.btnUpdWorkClick(Sender: TObject);
begin
  inherited;
  if not dsWorkResult.DataSet.Active then
    exit;
  if dsWorkResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsWork.RecordCount < 0) and (jcdsWork.RecNo < 0)  then
  begin
    SysDialogs.ShowError('请先选择需要修改的记录！');
    Exit;
  end
  else
  begin

    frmDriverworkexperience := TfrmDriverworkexperience.Create(self);
   with frmDriverworkexperience do
   begin
    Caption := '修改'+jcdsResult.FieldByName('name').AsString+'工作经历信息';
    id :=jcdsWork.FieldByName('id').AsInteger;
    isedt:=true;
    nvedtWorkunit.Text:= jcdsWork.FieldByName('workunit').AsString;
    nvedtPosition.Text:= jcdsWork.FieldByName('position').AsString;
    mmoMeRemark.Text := jcdsWork.FieldByName('remarks').AsString;
    dtpBegindate.Date :=jcdsWork.FieldByName('startdate').AsDateTime;
    dtpEnddate.Date :=jcdsWork.FieldByName('enddate').AsDateTime;
    driverid :=jcdsWork.FieldByName('driverid').AsString;
    createby := jcdsWork.FieldByName('createby').AsString;
    createtime := jcdsWork.FieldByName('createtime').AsString;
   if SysMainForm.showFormModal(frmDriverworkexperience) = mrok then
    begin
      refreshWork;
    end;
   end;

  end;
end;

procedure TfrmDriver.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  //证件已过期
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 if (jcdsResult.FieldByName('drivinglicenseenddate').AsDateTime<Now)
   or (jcdsResult.FieldByName('qualificationenddate').AsDateTime<Now)
   or (jcdsResult.FieldByName('workenddate').AsDateTime<Now) then
  begin
    Background := clRed;
  end;

end;

procedure TfrmDriver.FormCreate(Sender: TObject);
begin
  inherited;
jcdsWorkstatus.Active := False;
jcdsWorkstatus.Active :=True;
jcdsPoliticsstatus.Active := False;
jcdsPoliticsstatus.Active :=True;
jcdsEducation.Active := False;
jcdsEducation.Active :=True;
nvcbbtypeDrivertype.Active := False;
nvcbbtypeDrivertype.Active := True;
nvcbbtypeState.Active := False;
nvcbbtypeState.Active := True;

end;

procedure TfrmDriver.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
{ if dsResult.DataSet.RecordCount<1 then
  begin
    jcdsWork.Close;
    jcdsFamily.Close;
  end; }
end;

procedure TfrmDriver.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
 {  if jcdsResult.RecordCount <= 0 then
  begin
     jcdsWork.Close;
    jcdsFamily.Close;
    exit;
  end;
   refreshWork;
   refreshFamily ;}
end;


procedure TfrmDriver.refreshWork;
begin
if jcdsResult.RecordCount <= 0 then
  begin
    jcdsWork.Close;
    exit;
  end;
      with jcdsWork do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_w!driverid']:= jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end;
end;

procedure TfrmDriver.refreshFamily;
begin
if jcdsResult.RecordCount <= 0 then
  begin
    jcdsFamily.Close;
    exit;
  end;
  with jcdsFamily do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_f!driverid']:= jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end;
end;

procedure TfrmDriver.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该驾驶员档案吗？') then
    begin
      exit;
    end;
    with jcdsDriverdelete do
    begin
      Params.ParamValues['driverid']:=jcdsResult.FieldByName('id').AsString;
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
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TfrmDriver.tbtnEditClick(Sender: TObject);
var HexStr:String;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 frmDriverEdit := TfrmDriverEdit.Create(self);
  with frmDriverEdit do
  begin
    Caption := '修改驾驶员信息';
    id :=jcdsResult.FieldByName('id').AsInteger;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    isedit:=true;
    nvedtName.Text :=jcdsResult.FieldByName('name').AsString;
    nvedtJianpin.Text := jcdsResult.FieldByName('jianpin').AsString;
    nvedtCode.Text := jcdsResult.FieldByName('code').AsString;
    nvedtCarNO.Text := jcdsResult.FieldByName('cardno').AsString;
    nvedtFamilyPhone.Text :=jcdsResult.FieldByName('familyphone').AsString;
    nvedtIDcard.Text :=jcdsResult.FieldByName('idcard').AsString;
    nvedtAdress.Text :=jcdsResult.FieldByName('familyaddress').AsString;
    nvedtDrivinglicense.Text :=jcdsResult.FieldByName('drivinglicense').AsString;
    nvedtArchivenos.Text := jcdsResult.FieldByName('archiveno').AsString;
    nvedtQualification.Text := jcdsResult.FieldByName('qualification').AsString;
    nvedtInitialkm.Text :=jcdsResult.FieldByName('initialkm').AsString;
    nvedtWorkNO.Text := jcdsResult.FieldByName('workno').AsString;
    nvedtMovePhone.Text :=jcdsResult.FieldByName('mobilephone').AsString;
    nvedtSalary.Text := jcdsResult.FieldByName('salary').AsString;
    nvedtSubunit.Text:=  jcdsResult.FieldByName('subunit').AsString;
    nvedtNativeplace.Text :=jcdsResult.FieldByName('nativeplace').AsString;
    dtpDriveingstart.Date :=jcdsResult.FieldByName('drivinglicensestartdate').AsDateTime;
    dtpDriveingend.Date :=jcdsResult.FieldByName('drivinglicenseenddate').AsDateTime;
    dtpDrivinglicensefirstdate.Date  :=jcdsResult.FieldByName('drivinglicensefirstdate').AsDateTime;
    dtpQualificationstartdate.Date :=jcdsResult.FieldByName('qualificationstartdate').AsDateTime;
    dtpQualificationenddate.Date  :=jcdsResult.FieldByName('qualificationenddate').AsDateTime;
    dtpWorkstartdate.Date :=jcdsResult.FieldByName('workstartdate').AsDateTime;
    dtpWorkenddate.Date :=jcdsResult.FieldByName('workenddate').AsDateTime;
    dtpBirthdate.Date  :=jcdsResult.FieldByName('birthday').AsDateTime;
    dtpRecruitmentdate.Date  :=jcdsResult.FieldByName('recruitmentdate').AsDateTime;
    nvhelpUnit.Text := jcdsResult.FieldByName('unitname').AsString;
    nvhelpUnit.Id := jcdsResult.FieldByName('unitid').AsInteger;
//    nvhcbbVehicle.SetItemIndexByField('name',jcdsResult.FieldByName('vehiclename').AsString);
    NHelpRoute.id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    nvhlpVehicle.Text:= jcdsResult.FieldByName('vehiclename').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsString;
    nvhlpVehicle.Id:=jcdsResult.FieldByName('vehicleid').AsLargeInt;
    vehicle:=nvhlpVehicle.Text;
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
    if jcdsResult.FieldByName('issignedresponsibility').AsBoolean = true then
    begin
      chkResponsibility.Checked := True;
      isposibility :='是';
    end
    else
    begin
      chkResponsibility.Checked :=False;
      isposibility  :='否';
    end;


    if jcdsResult.FieldByName('istemporary').AsBoolean = true then
      begin
       chkTemp.Checked := True ;
       istemp:= '是'
      end
    else
    begin
      chkTemp.Checked :=False;
      istemp := '否'
    end;

    nvcbbEducation.SetItemIndexByCode(self.jcdsResult.FieldByName('education').AsString);
    nvcbbWorkstatus.SetItemIndexByCode(self.jcdsResult.FieldByName('workstatus').AsString);
    nvcbbQualificationtype.SetItemIndexByCode(self.jcdsResult.FieldByName('qualificationtype').AsString);
    nvcbbPoliticsstatus.SetItemIndexByCode(self.jcdsResult.FieldByName('politicsstatus').AsString);

    movephone:=jcdsResult.FieldByName('mobilephone').AsString;
    connetphone:=jcdsResult.FieldByName('familyphone').AsString;
    submit:=  jcdsResult.FieldByName('subunit').AsString;

    workstatus:=nvcbbWorkstatus.Text;
    tname:=jcdsResult.FieldByName('name').AsString;
    codess:= jcdsResult.FieldByName('code').AsString;
    idcard:=jcdsResult.FieldByName('idcard').AsString;
    cardno:= jcdsResult.FieldByName('cardno').AsString;
    education:=nvcbbEducation.Text;
    salary  := jcdsResult.FieldByName('salary').AsString;
   archiveno  := jcdsResult.FieldByName('archiveno').AsString;
   qualificationno  := jcdsResult.FieldByName('qualification').AsString;
   qualificationnoS :=jcdsResult.FieldByName('qualificationstartdate').AsString;
   qualificationnoE :=jcdsResult.FieldByName('qualificationenddate').AsString;
   drivinglicense :=jcdsResult.FieldByName('drivinglicense').AsString;
   drivinglicenseS :=jcdsResult.FieldByName('drivinglicensestartdate').AsString;
   drivinglicenseE :=jcdsResult.FieldByName('drivinglicenseenddate').AsString;
   workno := jcdsResult.FieldByName('workno').AsString;
   worknoS :=jcdsResult.FieldByName('workstartdate').AsString;
   worknoE :=jcdsResult.FieldByName('workenddate').AsString;
   qualificationtype:=nvcbbQualificationtype.Text;
   politicsstatus :=nvcbbPoliticsstatus.Text;
   birthday :=jcdsResult.FieldByName('birthday').AsString;
   edtVehicletype.Text :=  jcdsResult.FieldByName('qualifyvehicletype').AsString;
    with jcdsFindPicture do
    begin
    Active:=False;
      Params.ParamValues['filter_EQL_d!id']:= jcdsResult.FieldByName('id').AsInteger;
    Active := True;
     if recordcount > 0 then
      begin
        HexStr := FieldByName('picture').AsString;
        if (HexStr <> '') then
          imgImg_Picture1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
      end;
    end;
    //nvedtIDcard.Enabled:=false;
    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TfrmDriver.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active:=False;
    if not(((Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id<=0)) then
       Params.ParamValues['filter_EQL_u!id']:=  nvhelpUnit.Id
    else
      Params.ParamValues['filter_EQL_u!id']:= null;
      if nvcbbtypeDrivertype.ItemIndex > 0 then
      begin
        Params.ParamValues['filter_EQS_d!qualificationtype']:= nvcbbtypeDrivertype.GetSelectCode;
      end
      else
      begin
        Params.ParamValues['filter_EQS_d!qualificationtype']:='';
      end;
      if nvcbbtypeState.ItemIndex > 0 then
      begin
          Params.ParamValues['filter_EQS_d!workstatus']:= nvcbbtypeState.GetSelectCode;
      end
      else
      begin
         Params.ParamValues['filter_EQS_d!workstatus']:='';
      end;

      if  (chkNotOver.Checked  and chkOver.Checked) or (not chkNotOver.Checked  and not chkOver.Checked)  then
      begin
         Params.ParamValues['filter_LTD_d!drivinglicenseenddate']:='';
         Params.ParamValues['filter_GED_d!drivinglicenseenddate']:='';
      end
      else if chkNotOver.Checked then
      begin
         Params.ParamValues['filter_LTD_d!drivinglicenseenddate']:='';
         Params.ParamValues['filter_GED_d!drivinglicenseenddate']:=FormatDateTime('yyyy-mm-dd',Now);
      end
      else if chkOver.Checked then
      begin
      	Params.ParamValues['filter_LTD_d!drivinglicenseenddate']:=FormatDateTime('yyyy-mm-dd',Now);
        Params.ParamValues['filter_GED_d!drivinglicenseenddate']:='';
      end;

      if  (chkYes.Checked  and chkNo.Checked) or (not chkNo.Checked  and not chkYes.Checked)  then
      begin
         Params.ParamValues['filter_LTD_d!qualificationenddate']:='';
         Params.ParamValues['filter_GED_d!qualificationenddate']:='';
      end
      else if chkNo.Checked then
      begin
         Params.ParamValues['filter_LTD_d!qualificationenddate']:='';
         Params.ParamValues['filter_GED_d!qualificationenddate']:=FormatDateTime('yyyy-mm-dd',Now);
      end
      else if chkYes.Checked then
      begin
      	Params.ParamValues['filter_LTD_d!qualificationenddate']:=FormatDateTime('yyyy-mm-dd',Now);
        Params.ParamValues['filter_GED_d!qualificationenddate']:='';
      end;

      //证件已过期
//      if not chkNotOver.Checked  and chkOver.Checked then
//      begin
//         Params.ParamValues['filter_LTD_d!drivinglicenseenddate_OR_d!qualificationenddate_OR_d!workenddate']:=Now;
//      end
//      else
//      begin
//         Params.ParamValues['filter_LTD_d!drivinglicenseenddate_OR_d!qualificationenddate_OR_d!workenddate']:='';
//      end;
//      //证件未过期
//      if not chkOver.Checked  and chkNotOver.Checked then
//      begin
//         Params.ParamValues['filter_GED_d!drivinglicenseenddate_OR_d!qualificationenddate_OR_d!workenddate']:=Now;
//      end
//      else
//      begin
//         Params.ParamValues['filter_GED_d!drivinglicenseenddate_OR_d!qualificationenddate_OR_d!workenddate']:='';
//      end;
        //是否临时工
      if not chkNtemp.Checked and chktemp.Checked then
      begin
         Params.ParamValues['filter_EQB_d!istemporary']:=True;
      end
      //正式工
      else if not chktemp.Checked and chkNtemp.Checked then
      begin
         Params.ParamValues['filter_EQB_d!istemporary']:=False
      end
      else
      begin
         Params.ParamValues['filter_EQB_d!istemporary']:='';
      end;

      Params.ParamValues['filter_LIKES_d!name']:=  nvedtName.Text;
      Params.ParamValues['filter_LIKES_d!code']:= nvedtCode.Text;
      Params.ParamValues['filter_LIKES_d!qualification']:= nvedtQualification.Text;
      Params.ParamValues['filter_LIKES_d!archiveno']:= nvedtArchiceNo.Text;
      Params.ParamValues['filter_LIKES_d!drivinglicense']:= nvedtDrivinglicense.Text;
      //Params.ParamValues['filter_LIKES_d!archiveno']:= nvedtArchiceNo.Text;
    Active:=true;
  end;
   refreshWork;
   refreshFamily ;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TfrmDriver.tbtnInsertClick(Sender: TObject);
begin
  inherited;
 frmDriverEdit := TfrmDriverEdit.Create(self);
  with frmDriverEdit do
  begin
    Caption := '添加驾驶员档案信息';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;


procedure TfrmDriver.tbtnSaveClick(Sender: TObject);
begin
  inherited;
   FrmDriverFinger := TFrmDriverFinger.Create(self);
  try
    with FrmDriverFinger do
    begin
      Caption := '采集驾驶员指纹信息';
      if jcdsResult.Active and (jcdsResult.RecordCount>0) then
      begin
        NovaDriver.Id:=jcdsResult.FieldByName('id').AsLargeInt;
        NovaDriver.text:=jcdsResult.FieldByName('name').AsString;
      end;
      if SysMainForm.showFormModal(FrmDriverFinger,false) = mrok then
      begin
         //curid:=id;
        // tbtnFilterClick(Sender);
         //jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmDriverFinger);
  end;
end;
end.
