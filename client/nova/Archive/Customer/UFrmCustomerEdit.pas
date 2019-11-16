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
    Params.ParamByName('customer.sex').Value := '��';
    if rbGrile.Checked then
    Params.ParamByName('customer.sex').Value := 'Ů';
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
    Params.ParamByName('customer.isactive').Value := 'true';  //�Ƿ񼤻�
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
           optype:='�޸�';
           log:='�˿�������'+tname+',';
            if tname <> nvedtname.Text then
           begin
              log := log+' �˿����� ��'+tname+'�ĳ�'+nvedtname.Text+',';
           end;
           if birthday <> DateToStr(dtpBirthdate.Date) then
           begin
              log := log+' ���� ��'+birthday+'�ĳ�'+DateToStr(dtpBirthdate.Date)+',';
           end;
           if certificatetypename<>nvcbbCertificatetype.Text then
           begin
              log := log+' ֤������ ��'+certificatetypename+'�ĳ�'+nvcbbCertificatetype.Text+',';
           end;
           if certificateno <> nvedtCertificateNO.Text  then
           begin
              log := log+' ֤������'+certificateno+'�ĳ�'+nvedtCertificateNO.Text+',';
           end;
           if educationname <> nvcbbEducation.Text then
           begin
              log := log+' ѧ�� ��'+educationname+'�ĳ�'+nvcbbEducation.Text+',';
           end;
           if adress <> nvedtAdress.Text then
           begin
              log := log+' ��ַ ��'+adress+'�ĳ�'+nvedtAdress.Text+',';
           end;
           if mobilphone <> nvedtMovePhone.Text then
           begin
              log := log+' �ƶ��绰 ��'+mobilphone+'�ĳ�'+nvedtMovePhone.Text+',';
           end;
           if  familyphone <> nvedtFamilyPhone.Text then
           begin
              log := log+' ��ͥ�绰 ��'+familyphone+'�ĳ�'+nvedtFamilyPhone.Text+',';
           end;
           if  remarks <> mmoRemark.Text then
           begin
              log := log+' ���µĻ ��'+remarks+'�ĳ�'+mmoRemark.Text+',';
           end;
           if  email <> edtEmail.Text then
           begin
              log := log+' �����ʼ� ��'+email+'�ĳ�'+edtEmail.Text+',';
           end;

        end
        else
        begin
           optype:='���';
            log := ' �˿�����:'+nvedtname.Text+', ����:'+
                DateToStr(dtpBirthdate.Date)+', ����:'+mmoRemark.Text
                +'֤������;'+nvcbbCertificatetype.Text
                +' ֤����;'+nvedtCertificateNO.Text
                +' �����̶�;'+nvcbbEducation.Text +'��ַ;'+nvedtAdress.Text
                +' �ƶ��绰'+nvedtMovePhone.Text
                +' ��ͥ�绰'+nvedtFamilyPhone.Text;
        end;
        SysLog.WriteLog('�˿͵�������', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('customerid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���ʧ�ܣ�' + E.Message);
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
    msg := '��������Ϊ�գ�';
    nvedtName.SetFocus;
    exit;
  end;

  if nvcbbCertificatetype.GetSelectID < 0 then
  begin
    msg := '��ѡ��֤�����ͣ�';
    nvcbbCertificatetype.SetFocus;
    exit;
  end;

  if trim(nvedtCertificateNO.Text) = '' then
  begin
    msg := '֤�����벻��Ϊ�գ�';
    nvedtCertificateNO.SetFocus;
    exit;
  end;
  idcard :='���֤';
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
