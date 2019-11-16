unit UFrmCustomer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
   ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit,Services,NvPrnDbgeh, NvDbgridEh,
  UFrmCustomerEdit, NovaCheckedComboBox;

type
  TfrmCustomer= class(TSimpleCRUDForm)
    nvedtName: TNovaEdit;
    lbl1: TLabel;
    lbl5: TLabel;
    nvedtPhone: TNovaEdit;
    jcdsEducation: TjsonClientDataSet;
    jcdsDelete: TjsonClientDataSet;
    jcdsCertificatetype: TjsonClientDataSet;
    lrgntfldResultid: TLargeintField;
    lrgntfldResultcreateby: TLargeintField;
    wdstrngfldResulteducation: TWideStringField;
    wdstrngfldResultfamilyaddress: TWideStringField;
    wdstrngfldResultfamilyphone: TWideStringField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultname: TWideStringField;
    wdstrngfldResultsex: TWideStringField;
    lrgntfldResultupdateby: TLargeintField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    grp3: TGroupBox;
    grp8: TGroupBox;
    nvdbgrdhTicke: TNvDbgridEh;
    grp1: TGroupBox;
    grp2: TGroupBox;
    tlb2: TToolBar;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    btn11: TToolButton;
    btn12: TToolButton;
    nvdbgrdh1: TNvDbgridEh;
    jcdsInputway: TjsonClientDataSet;
    wdstrngfldResultcertificateno: TWideStringField;
    wdstrngfldResultcertificatetype: TWideStringField;
    wdstrngfldResultinputway: TWideStringField;
    wdstrngfldResultremarks: TWideStringField;
    wdstrngfldResulteducationname: TWideStringField;
    wdstrngfldResultinputwayname: TWideStringField;
    wdstrngfldResultcertificatetypename: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultbirthday: TDateField;
    lrgntfldResultorgid: TLargeintField;
    wdstrngfldResultemail: TWideStringField;
    lbl2: TLabel;
    lbl6: TLabel;
    lbl15: TLabel;
    edtEmail: TNovaEdit;
    nvcbbvipgrade: TNovaCheckedComboBox;
    nvhlpcardno: TNovaHelp;
    chkhascard: TCheckBox;
    jcdsResultmoney: TCurrencyField;
    jcdsResultvipamount: TCurrencyField;
    jcdsResultstatus: TWideStringField;
    jcdsvipstatus: TjsonClientDataSet;
    jcdsResultstatusname: TWideStringField;
    lbl4: TLabel;
    lbl7: TLabel;
    nvcbbOrgid: TNovaCheckedComboBox;
    nvcbbPorg: TNovaCheckedComboBox;
    nvcbbCertificatetypeQuery: TNovaComboBox;
    lbl3: TLabel;
    lbl14: TLabel;
    nvedtCertificateNOQuey: TNovaEdit;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultendstationname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    wdstrngfldResultschcode: TWideStringField;
    jcdsResultdepartdate: TDateField;
    wdstrngfldResultplanvehicleno: TWideStringField;
    wdstrngfldResulttsdeparttime: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure nvcbbPorgCheckClick(Sender: TObject);
    procedure nvedtPhoneKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustomer: TfrmCustomer;

implementation
uses UDMPublic,PubFn;

{$R *.dfm}



procedure TfrmCustomer.FormCreate(Sender: TObject);
begin
  inherited;
//  nvckbOrgid.Active := False;
//  nvckbOrgid.Active := True;
//  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  jcdsEducation.Active:= False;
  jcdsEducation.Active :=True;
  jcdsInputway.Active:= False;
  jcdsInputway.Active :=True;
  jcdsCertificatetype.Active:= False;
  jcdsCertificatetype.Active :=True;
  nvcbbvipgrade.Active := False;
  nvcbbvipgrade.Active := True;
  jcdsvipstatus.Active := true;

   nvcbbPorg.Active:= False;
  nvcbbPorg.Active := True;
  nvcbbCertificatetypeQuery.Active:=False;
  nvcbbCertificatetypeQuery.Active:=True;
  nvcbbPorg.OnCheckClick:=nil;
  nvcbbPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  nvcbbPorg.OnCheckClick:=nvcbbPorgCheckClick;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=nvcbbPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

////查找顾客购票明细
//procedure TfrmCustomer.jcdsResultAfterScroll(DataSet: TDataSet);
//begin
//  inherited;
//      with jcdsTickeDetail do
//  begin
//    Active:=False;
//    Params.ParamValues['filter_EQL_t!customer.id']:= jcdsResult.FieldByName('id').AsString;
//    Active:=true;
//    if recordcount = 0 then
//      jcdsTickeDetail.Close;
//  end;
//end;

procedure TfrmCustomer.nvcbbPorgCheckClick(Sender: TObject);
begin
  inherited;
     if nvcbbPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=nvcbbPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);
  end;
end;

procedure TfrmCustomer.nvedtPhoneKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (key in ['0'..'9',#8,#32]) then
     key:= #0;

end;

procedure TfrmCustomer.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
    // 删除
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该顾客档案吗？') then
    begin
      exit;
    end;
    if jcdsResult.FieldByName('vipcardno').AsString<>'' then
    begin
       SysDialogs.Warning('该顾客档案已经发行会员卡，不允许删除！');
       Exit;
    end;

    with jcdsDelete do
    begin
      Params.ParamValues['delid']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' 删除'+jcdsResult.FieldByName('orgname').AsString+'的顾客档案:'+jcdsResult.FieldByName('name').AsString;
      SysLog.WriteLog('顾客档案管理', '删除', log);
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

procedure TfrmCustomer.tbtnEditClick(Sender: TObject);
begin
  inherited;
    //修改
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0)  then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('请先选择需要修改的记录！');
    end;
    try
      frmCustomerEdit := TfrmCustomerEdit.Create(self);
      with frmCustomerEdit do
      begin
        Caption:='修改顾客档案信息';
        isedit:= True;
        id:=  jcdsResult.FieldByName('id').AsInteger;
        createby:=jcdsResult.FieldByName('createby').AsString;
        createtime:=jcdsResult.FieldByName('createtime').AsString;
        orgid := jcdsResult.FieldByName('orgid').AsString;
        mmoRemark.Text:=jcdsResult.FieldByName('remarks').AsString;
        remarks := jcdsResult.FieldByName('remarks').AsString;
        nvedtFamilyPhone.Text:=jcdsResult.FieldByName('familyphone').AsString;
        familyphone := jcdsResult.FieldByName('familyphone').AsString;
        nvedtMovePhone.Text:=jcdsResult.FieldByName('mobilephone').AsString;
        mobilphone := jcdsResult.FieldByName('mobilephone').AsString;
        nvedtAdress.Text:=jcdsResult.FieldByName('familyaddress').AsString;
        adress:= jcdsResult.FieldByName('familyaddress').AsString;
        nvcbbEducation.SetItemIndexByCode(self.jcdsResult.FieldByName('education').AsString);
        education :=jcdsResult.FieldByName('education').AsString;
        educationname:=jcdsResult.FieldByName('educationname').AsString;
        nvcbbCertificatetype.SetItemIndexByCode(self.jcdsResult.FieldByName('certificatetype').AsString);
        certificatetypename:=jcdsResult.FieldByName('certificatetypename').AsString;
        certificatetype:=nvcbbCertificatetype.Text;
        email := jcdsResult.FieldByName('email').AsString;
        edtEmail.Text := jcdsResult.FieldByName('email').AsString;
        if jcdsResult.FieldByName('birthday').AsString<>'' then
        begin
         dtpBirthdate.Date:=jcdsResult.FieldByName('birthday').AsDateTime;
         birthday:= jcdsResult.FieldByName('birthday').AsString;
        end;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        tname:= jcdsResult.FieldByName('name').AsString;
        nvedtCertificateNO.Text:=jcdsResult.FieldByName('certificateno').AsString;
        certificateno :=jcdsResult.FieldByName('certificateno').AsString;
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
        nvcbbCertificatetype.Enabled:=false;
        nvedtCertificateNO.Enabled:=false;
        if ShowModal = mrok then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id',id,[] );
        end;
      end;
    finally
      FreeAndNil(frmCustomerEdit);
    end;
  end;
end;

procedure TfrmCustomer.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  //查询
//  jcdsResult.AfterScroll := nil;
  if nvcbbOrgid.GetSelectID='' then
  begin
     SysDialogs.Warning('请选择所属机构！');
     Exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_o!id']:=  nvcbbOrgid.GetSelectID;
    Params.ParamValues['filter_LIKES_c!name']:=  nvedtName.Text;
    Params.ParamValues['filter_LIKES_c!familyphone_OR_c!mobilephone']:= nvedtPhone.Text;
    Params.ParamValues['filter_LIKES_c!email'] := edtEmail.Text;
    Params.ParamValues['filter_INS_v!vipgrade'] := nvcbbvipgrade.GetSelectID;
    Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcardno.Text;
    Params.ParamValues['filter_EQS_c!certificatetype'] := nvcbbCertificatetypeQuery.GetSelectCode;
    Params.ParamValues['filter_LIKES_c!certificateno'] := nvedtCertificateNOQuey.Text;
    if chkhascard.Checked then
      Params.ParamValues['filter_GTL_v!id'] := 0
    else
      Params.ParamValues['filter_GTL_v!id'] := null;

    try
    Active := True;
    except
    on e:Exception do
    begin
        SysDialogs.ShowMessage(e.Message);
    end;

    end;
  end;
//  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TfrmCustomer.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  //添加
   frmCustomerEdit := TfrmCustomerEdit.Create(self);
  with frmCustomerEdit do
  begin
    Caption := '旅客档案管理';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
end;

end.
