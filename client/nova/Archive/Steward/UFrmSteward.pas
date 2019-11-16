unit UFrmSteward;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit,Services,UFrmStewardEdit,NvPrnDbgeh, NvDbgridEh,
  UFrmStewarworkexperienceEdt, NovaCheckedComboBox;

type
  TfrmSteward= class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl2: TLabel;
    nvedtCode: TNovaEdit;
    nvedtName: TNovaEdit;
    lbl1: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    nvedtQualification: TNovaEdit;
    nvcbbGrade: TNovaComboBox;
    chkOverDate: TCheckBox;
    grp3: TGroupBox;
    grp8: TGroupBox;
    tlb1: TToolBar;
    btn1: TToolButton;
    btn2: TToolButton;
    btn3: TToolButton;
    btn4: TToolButton;
    btn5: TToolButton;
    btn6: TToolButton;
    nvdbgrdhWork: TNvDbgridEh;
    jcdsStewardWork: TjsonClientDataSet;
    dsWorkResult: TDataSource;
    jcdsGradename: TjsonClientDataSet;
    jcdsEducation: TjsonClientDataSet;
    nvedtArchiceNo: TNovaEdit;
    lbl8: TLabel;
    jcdsDelete: TjsonClientDataSet;
    imgLi: TImageList;
    jcdsDelWork: TjsonClientDataSet;
    jcdsPoliticsstatus: TjsonClientDataSet;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultarchiveno: TWideStringField;
    wdstrngfldResultcardno: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResulteducation: TWideStringField;
    wdstrngfldResultfamilyaddress: TWideStringField;
    wdstrngfldResultfamilyphone: TWideStringField;
    wdstrngfldResultgrade: TWideStringField;
    wdstrngfldResultidcard: TWideStringField;
    blnfldResultistemporary: TBooleanField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultname: TWideStringField;
    wdstrngfldResultnativeplace: TWideStringField;
    lrgntfldResultorgid: TLargeintField;
    wdstrngfldResultpoliticsstatus: TWideStringField;
    wdstrngfldResultqualificationno: TWideStringField;
    fltfldResultsalary: TFloatField;
    wdstrngfldResultsex: TWideStringField;
    lrgntfldResultunitid: TLargeintField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultunitname: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultpoliticsstatusname: TWideStringField;
    wdstrngfldResultgradename: TWideStringField;
    wdstrngfldResulteducationname: TWideStringField;
    chkNotOver: TCheckBox;
    wdstrngfldResultupdatename: TWideStringField;
    jcdsResultbirthday: TDateField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultqualificationenddate: TDateField;
    jcdsResultqualificationstartdate: TDateField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsFindPicture: TjsonClientDataSet;
    nvhelpUnit: TNovaHelp;
    jcdsResultjianpin: TWideStringField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultvehicleid: TLargeintField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure btn4Click(Sender: TObject);
    procedure btn6Click(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure tbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure refreshWork;
  end;

var
  frmSteward: TfrmSteward;

implementation
uses UDMPublic,PubFn,UFrmStewardFinger;

{$R *.dfm}




procedure TfrmSteward.btn2Click(Sender: TObject);
begin
  inherited;
   //添加工作经验
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  frmStewadworkexperience := TfrmStewadworkexperience.Create(self);
  with frmStewadworkexperience do
  begin
    Caption := '添加'+jcdsResult.FieldByName('name').AsString+'工作经验信息';
    stewardid := jcdsResult.FieldByName('id').AsString;
    if SysMainForm.showFormModal(frmStewadworkexperience) = mrok then
    begin
      refreshWork;
    end;
  end;
end;

procedure TfrmSteward.btn4Click(Sender: TObject);
var id:Integer;
begin
  inherited;
  if not dsWorkResult.DataSet.Active then
    exit;
  if dsWorkResult.DataSet.RecordCount < 1 then
    exit;
 if (jcdsStewardWork.Active=True) and (jcdsStewardWork.RecNo>=0) then
  begin
   frmStewadworkexperience := TfrmStewadworkexperience.Create(self);
    try
      with frmStewadworkexperience do
      begin
        Caption:='修改'+jcdsResult.FieldByName('name').AsString+'工作经验';
        edittype:=Tedittype.update;
        id :=  jcdsStewardWork.FieldByName('id').AsString;
        nvedtWorkunit.Text := jcdsStewardWork.FieldByName('workunit').AsString;
        nvedtPosition.Text :=jcdsStewardWork.FieldByName('position').AsString;
        mmoMeResume.Text :=jcdsStewardWork.FieldByName('resume').AsString;
        dtpEnddate.Date :=jcdsStewardWork.FieldByName('enddate').AsDateTime;
        dtpBegindate.Date :=jcdsStewardWork.FieldByName('startdate').AsDateTime;
        stewardid :=  jcdsStewardWork.FieldByName('stewardid').AsString;
        createby :=  jcdsStewardWork.FieldByName('createby').AsString;
        createtime:=  jcdsStewardWork.FieldByName('createtime').AsString;
      end;
      if SysMainForm.showFormModal(frmStewadworkexperience,False)=mrok then
      begin
        id := frmStewadworkexperience.operationid;
        jcdsStewardWork.Locate('id',id,[]);
      end;
    finally
      refreshWork;
      FreeAndNil(frmStewadworkexperience);
    end;
  end
 else
  begin
    SysDialogs.ShowError('请先选择需要修改的记录！');
  end;
end;

procedure TfrmSteward.btn6Click(Sender: TObject);
var  msg: String;
  nResult: integer;
  sResult: String;
begin
  inherited;
  if not dsWorkResult.DataSet.Active then
    exit;
  if dsWorkResult.DataSet.RecordCount < 1 then
    exit;
   if not SysDialogs.Confirm('提示','确定要删除该记录吗？') then
    begin
      exit;
    end;
 if (jcdsStewardWork.Active=True) and (jcdsStewardWork.RecNo>=0) then
  begin

    with jcdsDelWork do
    begin
      Params.ParamValues['delid']:=jcdsStewardWork.FieldByName('id').AsString;
      Execute;
      if jcdsDelWork.Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(jcdsDelWork.Params.ParamValues['msg']);
      end;
      if jcdsDelWork.Params.ParamValues['flag']=1 then
      begin
        refreshWork;
      end;
    end;
  end;
end;

procedure TfrmSteward.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  //证件已过期
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 if (jcdsResult.FieldByName('qualificationenddate').AsDateTime<Now)then
  begin
    Background := clRed;
  end;

end;

procedure TfrmSteward.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbGrade.Active := False;
  nvcbbGrade.Active := True;
  jcdsEducation.Active := False;
  jcdsEducation.Active := True;
  jcdsGradename.Active:= False;
  jcdsGradename.Active :=True;
end;

procedure TfrmSteward.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
{if dsResult.DataSet.RecordCount<1 then
  begin
    jcdsStewardWork.Close;
  end;}
end;

procedure TfrmSteward.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
 // refreshWork;
end;

procedure TfrmSteward.refreshWork;
begin
 if jcdsResult.RecordCount <= 0 then
  begin
    jcdsStewardWork.Close;
    exit;
  end;
   with jcdsStewardWork do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_w!stewardid']:= jcdsResult.FieldByName('id').AsString;
  Active:=true;
  end;
end;



procedure TfrmSteward.tbtnDeleteClick(Sender: TObject);
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
    if not SysDialogs.Confirm('提示','确定要删除该乘务员档案吗？') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['stewardid']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' 删除乘务员:'+jcdsResult.FieldByName('name').AsString+'的记录';
      SysLog.WriteLog('乘务员档案管理', '删除', log);
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

procedure TfrmSteward.tbtnEditClick(Sender: TObject);
var did:Integer;HexStr:string;
begin
  inherited;
    //修改
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  frmStewardEdit := TfrmStewardEdit.Create(self);
  with frmStewardEdit do
  begin
    Caption:='修改乘务员信息';
    iseditS := True;
    id :=  jcdsResult.FieldByName('id').AsInteger;
    createbys :=  jcdsResult.FieldByName('createby').AsString;
    createtimes :=  jcdsResult.FieldByName('createtime').AsString;
    nvedtName.Text :=jcdsResult.FieldByName('name').AsString;
    nvedtJianpin.Text := jcdsResult.FieldByName('jianpin').AsString;
    tname:=jcdsResult.FieldByName('name').AsString;
    nvedtCode.Text :=jcdsResult.FieldByName('code').AsString;
    code :=jcdsResult.FieldByName('code').AsString;
    nvedtCarNO.Text :=jcdsResult.FieldByName('cardno').AsString;
    cardno :=jcdsResult.FieldByName('cardno').AsString;
    nvedtIDcard.Text :=jcdsResult.FieldByName('idcard').AsString;
    idcard  :=jcdsResult.FieldByName('idcard').AsString;
    nvedtFamilyPhone.Text:=jcdsResult.FieldByName('familyphone').AsString;
    nvedtMovePhone.Text:=jcdsResult.FieldByName('mobilephone').AsString;
    nvedtNativeplace.Text:=jcdsResult.FieldByName('nativeplace').AsString;
    nativeplace:= jcdsResult.FieldByName('nativeplace').AsString;
    nvedtAdress.Text:=jcdsResult.FieldByName('familyaddress').AsString;
    nvedtSalary.Text:=jcdsResult.FieldByName('salary').AsString;
    salary := jcdsResult.FieldByName('salary').AsString;
    nvedtQualification.Text:=jcdsResult.FieldByName('qualificationno').AsString;
    qualificationno:=jcdsResult.FieldByName('qualificationno').AsString;
    nvedtArchive.Text:=jcdsResult.FieldByName('archiveno').AsString;
    archiveno := jcdsResult.FieldByName('archiveno').AsString;
    dtpBirthdate.Date:=jcdsResult.FieldByName('birthday').AsDateTime;
    dtpQualificationstartdate.Date :=jcdsResult.FieldByName('qualificationstartdate').AsDateTime;
    qualificationnoS:=jcdsResult.FieldByName('qualificationstartdate').AsString;
    dtpQualificationenddate.Date  :=jcdsResult.FieldByName('qualificationenddate').AsDateTime;
    qualificationnoE:=jcdsResult.FieldByName('qualificationenddate').AsString;
    nvcbbEducation.SetItemIndexByCode(self.jcdsResult.FieldByName('education').AsString);
    education := nvcbbEducation.Text;
    nvcbbGrade.SetItemIndexByCode(self.jcdsResult.FieldByName('grade').AsString);
    grade :=nvcbbGrade.Text;
    nvcbbPoliticsstatus.SetItemIndexByCode(self.jcdsResult.FieldByName('politicsstatus').AsString);
    nvhelpUnit.Text := jcdsResult.FieldByName('unitname').AsString;
    nvhelpUnit.Id := jcdsResult.FieldByName('unitid').AsInteger;

    nvhlpVehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    nvhlpVehicleno.Id :=   jcdsResult.FieldByName('vehicleid').AsInteger;

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

    with jcdsFindPicture do
    begin
    Active:=False;
      Params.ParamValues['filter_EQL_s!id']:= jcdsResult.FieldByName('id').AsInteger;
    Active := True;
     if recordcount > 0 then
      begin
        HexStr := FieldByName('picture').AsString;
        if (HexStr <> '') then
          imgImg_Picture1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
      end;
    end;

    nvedtIDcard.Enabled:=false;
    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TfrmSteward.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active:=False;
    if not(((Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id<=0)) then
      Params.ParamValues['filter_EQL_ut!id']:=  nvhelpUnit.Id;

      if nvcbbGrade.ItemIndex < 0 then
      begin
        Params.ParamValues['filter_EQS_s!grade']:= '';
      end
      else
      begin
        Params.ParamValues['filter_EQS_s!grade']:=nvcbbGrade.GetSelectCode;
      end;
     Params.ParamValues['filter_LIKES_s!name']:=  nvedtName.Text;
      Params.ParamValues['filter_LIKES_s!code']:= nvedtCode.Text;
      Params.ParamValues['filter_LIKES_s!qualificationno']:= nvedtQualification.Text;
      Params.ParamValues['filter_LIKES_s!archiveno']:= nvedtArchiceNo.Text;

       if chkNotOver.Checked then           //证件未过期
        begin
          if not( chkOverDate.Checked ) then
          begin
            Params.ParamValues['filter_GED_s!qualificationenddate']:=Now;
            Params.ParamValues['filter_LTD_s!qualificationenddate']:='';
          end
          else
          begin
            Params.ParamValues['filter_LTD_s!qualificationenddate']:='';
            Params.ParamValues['filter_GED_s!qualificationenddate']:='';
          end;
        end
        else
        begin
          if chkOverDate.Checked  then       //证件已过期
          begin
            Params.ParamValues['filter_LTD_s!qualificationenddate']:= Now;
            Params.ParamValues['filter_GED_s!qualificationenddate']:='';
          end
          else
          begin
            Params.ParamValues['filter_LTD_s!qualificationenddate']:= '';
            Params.ParamValues['filter_GED_s!qualificationenddate']:='';
          end;
        end;


      Active := True;
  end;
  refreshWork;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TfrmSteward.tbtnInsertClick(Sender: TObject);
begin
  inherited;
   //添加
   frmStewardEdit := TfrmStewardEdit.Create(self);
  with frmStewardEdit do
  begin
    Caption := '添加乘务员档案信息';
     ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[]);
    end;
  end;
end;

procedure TfrmSteward.tbtnSaveClick(Sender: TObject);
begin
  inherited;
//   if not dsResult.DataSet.Active then
//
//   exit;
//  if dsResult.DataSet.RecordCount < 1 then
//   exit;
   FrmStewardFinger := TFrmStewardFinger.Create(self);
 try
    with FrmStewardFinger do
    begin
      Caption := '采集乘务员指纹信息';
       NovaHelpsteward.id :=  jcdsResult.FieldByName('id').AsInteger;
       NovaHelpsteward.Text :=jcdsResult.FieldByName('name').AsString;
      if SysMainForm.showFormModal(FrmStewardFinger,false) = mrok then
      begin
         //curid:=id;
        // tbtnFilterClick(Sender);
         //jcdsResult.Locate('id',curid,[]);

      end;
    end;
  finally
    FreeAndNil(FrmStewardFinger);
  end;



end;

end.
