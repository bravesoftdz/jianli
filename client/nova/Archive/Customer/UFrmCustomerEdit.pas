unit UFrmCustomerEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList;

type
  TfrmCustomerEdit = class(TSimpleEditForm)
    jcdsSave: TjsonClientDataSet;
    lbl1: TLabel;
    nvedtName: TNovaEdit;
    lbl14: TLabel;
    nvedtCertificateNO: TNovaEdit;
    lbl7: TLabel;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    lbl4: TLabel;
    dtpBirthdate: TDateTimePicker;
    lbl6: TLabel;
    nvcbbEducation: TNovaComboBox;
    lbl10: TLabel;
    nvedtFamilyPhone: TNovaEdit;
    lbl12: TLabel;
    nvedtMovePhone: TNovaEdit;
    lbl13: TLabel;
    nvedtAdress: TNovaEdit;
    nvcbbCertificatetype: TNovaComboBox;
    lbl3: TLabel;
    lbl5: TLabel;
    mmoRemark: TMemo;
    lbl2: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    edtEmail: TNovaEdit;
    lbl15: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    function checkSchedule(var msg: String): boolean;
  public
    { Public declarations }
   isedit:boolean;
   id:integer;
   createby, orgid,createtime,code,idcard,tname,certificateno,birthday,
   certificatetype,education,adress,mobilphone,familyphone,remarks,email,
   educationname,certificatetypename: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmCustomerEdit: TfrmCustomerEdit;
implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmCustomerEdit.bbtnSaveClick(Sender: TObject);
 var  msg: String;
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
   if (not checkSchedule(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  with jcdsSave do
  begin
    close;
     Params.ParamByName('customer.id').Value := id;
     Params.ParamByName('customer.createtime').Value := createtime;
     Params.ParamByName('customer.createby').Value := createby;
     Params.ParamByName('customer.birthday').Value
        := FormatDateTime('yyyy-mm-dd',dtpBirthdate.Date);
     Params.ParamByName('customer.email').Value := edtEmail.Text;
     if isedit then
     begin
       Params.ParamByName('customer.orgid').Value := orgid;
     end
     else
     begin
       Params.ParamByName('customer.orgid').Value :=  SysInfo.LoginUserInfo.OrgID;
     end;

    if rbMan.Checked then
    Params.ParamByName('customer.sex').Value := '男';
    if rbGrile.Checked then
    Params.ParamByName('customer.sex').Value := '女';
    Params.ParamByName('customer.name').Value := nvedtName.Text;


    Params.ParamByName('customer.familyaddress').Value := nvedtAdress.Text;
    Params.ParamByName('customer.familyphone').Value := nvedtFamilyPhone.Text;
    Params.ParamByName('customer.mobilephone').Value :=  nvedtMovePhone.Text;
    Params.ParamByName('customer.certificateno').Value := nvedtCertificateNO.Text;
    Params.ParamByName('customer.certificatetype').Value := nvcbbCertificatetype.GetSelectCode;
    if nvcbbEducation.GetSelectID > 0 then
    begin
      Params.ParamByName('customer.education').Value :=nvcbbEducation.GetSelectCode;
    end;

    Params.ParamByName('customer.inputway').Value :='2';
//    Params.ParamByName('customer.lastbuytickettime').Value := Now;
//    Params.ParamByName('customer.ticketoutletsid').Value :=
    Params.ParamByName('customer.remarks').Value :=  mmoRemark.Text;
    Params.ParamByName('customer.isactive').Value := 'true';  //是否激活
    Params.ParamByName('customer.islocaldelete').Value := 'false';
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvedtName.SetFocus;
      end
      else
      begin
       if id>0 then
        begin
           optype:='修改';
           log:='顾客姓名：'+tname+',';
            if tname <> nvedtname.Text then
           begin
              log := log+' 顾客名称 由'+tname+'改成'+nvedtname.Text+',';
           end;
           if birthday <> DateToStr(dtpBirthdate.Date) then
           begin
              log := log+' 生日 由'+birthday+'改成'+DateToStr(dtpBirthdate.Date)+',';
           end;
           if certificatetypename<>nvcbbCertificatetype.Text then
           begin
              log := log+' 证件类型 由'+certificatetypename+'改成'+nvcbbCertificatetype.Text+',';
           end;
           if certificateno <> nvedtCertificateNO.Text  then
           begin
              log := log+' 证件号由'+certificateno+'改成'+nvedtCertificateNO.Text+',';
           end;
           if educationname <> nvcbbEducation.Text then
           begin
              log := log+' 学历 由'+educationname+'改成'+nvcbbEducation.Text+',';
           end;
           if adress <> nvedtAdress.Text then
           begin
              log := log+' 地址 由'+adress+'改成'+nvedtAdress.Text+',';
           end;
           if mobilphone <> nvedtMovePhone.Text then
           begin
              log := log+' 移动电话 由'+mobilphone+'改成'+nvedtMovePhone.Text+',';
           end;
           if  familyphone <> nvedtFamilyPhone.Text then
           begin
              log := log+' 家庭电话 由'+familyphone+'改成'+nvedtFamilyPhone.Text+',';
           end;
           if  remarks <> mmoRemark.Text then
           begin
              log := log+' 从事的活动 由'+remarks+'改成'+mmoRemark.Text+',';
           end;
           if  email <> edtEmail.Text then
           begin
              log := log+' 电子邮件 由'+email+'改成'+edtEmail.Text+',';
           end;

        end
        else
        begin
           optype:='添加';
            log := ' 顾客名称:'+nvedtname.Text+', 生日:'+
                DateToStr(dtpBirthdate.Date)+', 描述:'+mmoRemark.Text
                +'证件类型;'+nvcbbCertificatetype.Text
                +' 证件号;'+nvedtCertificateNO.Text
                +' 教育程度;'+nvcbbEducation.Text +'地址;'+nvedtAdress.Text
                +' 移动电话'+nvedtMovePhone.Text
                +' 家庭电话'+nvedtFamilyPhone.Text;
        end;
        SysLog.WriteLog('顾客档案管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('customerid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('添加失败：' + E.Message);
      end;
    end;
  end;



end;

function TfrmCustomerEdit.checkSchedule(var msg: String): boolean;
var
   ECode :string;
begin
   result := False;
  if Trim(nvedtName.Text) ='' then
  begin
    msg := '姓名不能为空！';
    nvedtName.SetFocus;
    exit;
  end;

  if nvcbbCertificatetype.GetSelectID < 0 then
  begin
    msg := '请选择证件类型！';
    nvcbbCertificatetype.SetFocus;
    exit;
  end;

  if trim(nvedtCertificateNO.Text) = '' then
  begin
    msg := '证件号码不能为空！';
    nvedtCertificateNO.SetFocus;
    exit;
  end;
  idcard :='身份证';
  if Pos(idcard,nvcbbCertificatetype.Text)>0then
  begin
   if not (ValidatePID(nvedtCertificateNO.Text) ='') then
    begin
      msg := ValidatePID(nvedtCertificateNO.Text);
      nvedtCertificateNO.SetFocus;
      exit;
    end;
   end;
   result := True;
end;



procedure TfrmCustomerEdit.FormCreate(Sender: TObject);
begin
  inherited;
   nvcbbEducation.Active :=False;
   nvcbbEducation.Active :=True;
   nvcbbCertificatetype.Active :=False;
   nvcbbCertificatetype.Active:= True;
   dtpBirthdate.Date := Now;

end;

end.
