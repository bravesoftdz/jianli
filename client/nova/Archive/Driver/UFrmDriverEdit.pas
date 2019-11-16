unit UFrmDriverEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,
  NovaHComboBox, ExtDlgs, Jpeg, Menus, ImgList,UIDCardReader;

type
  TfrmDriverEdit = class(TSimpleEditForm,IIDCardfound)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    grp2: TGroupBox;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lblworkenddate: TLabel;
    lbl20: TLabel;
    lblQualificationtype: TLabel;
    lblWorkn: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbl25: TLabel;
    dtpDriveingstart: TDateTimePicker;
    dtpDrivinglicensefirstdate: TDateTimePicker;
    dtpQualificationstartdate: TDateTimePicker;
    dtpDriveingend: TDateTimePicker;
    dtpWorkstartdate: TDateTimePicker;
    dtpQualificationenddate: TDateTimePicker;
    dtpWorkenddate: TDateTimePicker;
    grp3: TGroupBox;
    lblWorkstatus: TLabel;
    lbvehicleid: TLabel;
    lblInitialkm: TLabel;
    lblSubunit: TLabel;
    grpPicture: TGroupBox;
    nvedtName: TNovaEdit;
    nvedtCode: TNovaEdit;
    nvedtCarNO: TNovaEdit;
    nvedtIDcard: TNovaEdit;
    nvedtFamilyPhone: TNovaEdit;
    nvedtAdress: TNovaEdit;
    nvedtDrivinglicense: TNovaEdit;
    nvedtQualification: TNovaEdit;
    nvcbbEducation: TNovaComboBox;
    dtpBirthdate: TDateTimePicker;
    dtpRecruitmentdate: TDateTimePicker;
    nvcbbWorkstatus: TNovaComboBox;
    nvedtInitialkm: TNovaEdit;
    nvedtWorkNO: TNovaEdit;
    nvcbbQualificationtype: TNovaComboBox;
    nvcbbPoliticsstatus: TNovaComboBox;
    lbl10: TLabel;
    nvedtMovePhone: TNovaEdit;
    lblSalary: TLabel;
    nvedtSalary: TNovaEdit;
    lblUnit: TLabel;
    nvedtSubunit: TNovaEdit;
    nvedtNativeplace: TNovaEdit;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    jcdsSave: TjsonClientDataSet;
    pnl1: TPanel;
    imgImg_Picture1: TImage;
    dlgOpenPicPictrue: TOpenPictureDialog;
    lbl11: TLabel;
    lbl19: TLabel;
    lbl22: TLabel;
    lbl33: TLabel;
    lbl34: TLabel;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    lbl29: TLabel;
    nvedtArchivenos: TNovaEdit;
    chkResponsibility: TCheckBox;
    chkTemp: TCheckBox;
    nvhelpUnit: TNovaHelp;
    btn2: TSpeedButton;
    btn1: TSpeedButton;
    nvhlpVehicle: TNovaHelp;
    lbl30: TLabel;
    edtVehicletype: TNovaEdit;
    NHelpRoute: TNovaHelp;
    Label10: TLabel;
    Label1: TLabel;
    nvedtJianpin: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    {procedure rbGrileClick(Sender: TObject);
    procedure rbManClick(Sender: TObject);    }
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
    procedure imgImg_Picture1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    mem: TMemoryStream;
    memstr: TStringStream;
     curidcard: TIDCard;
    function checkSchedule(var msg: String): boolean;
  public
    { Public declarations }
    createby,id:integer;
    isedit:boolean;
    createtime,codetname,tname,codess,idcard,cardno,education,grade,
   salary,archiveno,qualificationno,qualificationnoS,qualificationnoE,
   drivinglicense,drivinglicenseS,drivinglicenseE,movephone,connetphone,
   submit,vehicle,workstatus,isposibility,istemp,workno,worknoS,worknoE,
   qualificationtype,politicsstatus,birthday,vehicleid: string;
   procedure cardfound(idcard:TIDCard);
  end;

var
  frmDriverEdit: TfrmDriverEdit;

implementation
  uses Services,UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmDriverEdit.bbtnSaveClick(Sender: TObject);
var  msg,log,optype,istem,isposibit: String;
  nResult: integer;
  sResult,idcarname,ic,codes: String;
  jpg1: TJpegImage;

begin
  inherited;

  if (not checkSchedule(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  if not (ValidatePID(nvedtIDcard.Text) ='') then
  begin
    SysDialogs.Warning(ValidatePID(nvedtIDcard.Text));
    nvedtIDcard.SetFocus;
    exit;
  end;

  with jcdsSave do
  begin
    close;
    Params.ParamByName('driver.id').Value := id;
    Params.ParamByName('driver.code').Value := nvedtCode.Text;
    Params.ParamByName('driver.name').Value := nvedtName.Text;
    Params.ParamByName('driver.jianpin').Value := nvedtJianpin.Text;
    Params.ParamByName('driver.cardno').Value := nvedtCarNO.Text;
    Params.ParamByName('driver.idcard').Value := nvedtIDcard.Text;
    Params.ParamByName('driver.orgid').Value := SysInfo.LoginUserInfo.OrgID;
    Params.ParamByName('driver.createby').Value :=createby;
    Params.ParamByName('driver.createtime').Value :=createtime;
    if rbMan.Checked then
    Params.ParamByName('driver.sex').Value := '��';
    if rbGrile.Checked then
    Params.ParamByName('driver.sex').Value := 'Ů';

    Params.ParamByName('driver.birthday').Value := formatdatetime('yyyy-mm-dd',dtpBirthdate.Date);


    Params.ParamByName('driver.politicsstatus').Value := nvcbbPoliticsstatus.GetSelectCode;
    Params.ParamByName('driver.education').Value := nvcbbEducation.GetSelectCode;
    Params.ParamByName('driver.nativeplace').Value := nvedtNativeplace.Text;
    Params.ParamByName('driver.recruitmentdate').Value := formatdatetime('yyyy-mm-dd',dtpRecruitmentdate.Date);

    Params.ParamByName('driver.archiveno').Value := nvedtArchivenos.Text;
    Params.ParamByName('driver.workstatus').Value := nvcbbWorkstatus.GetSelectCode;

    Params.ParamByName('driver.subunit').Value := nvedtSubunit.Text;

    if (nvhelpUnit.Id=0) or (nvhelpUnit.Text='') then
    begin
           SysDialogs.Warning('�������Ӳ���Ϊ�գ�');
           Exit;

    end;
    Params.ParamByName('driver.unitid').Value := nvhelpUnit.Id;

   if (not (Trim(nvhlpVehicle.Text) = '')) and (nvhlpVehicle.Id>0)then
    begin
     Params.ParamByName('driver.vehicle.id').Value :=nvhlpVehicle.id;
    end
   else ;

    Params.ParamByName('driver.familyaddress').Value := nvedtAdress.Text;
    Params.ParamByName('driver.familyphone').Value := nvedtFamilyPhone.Text;
    Params.ParamByName('driver.mobilephone').Value := nvedtMovePhone.Text;
    Params.ParamByName('driver.initialkm').Value := nvedtInitialkm.Text;

     if chkTemp.Checked then
     begin
       Params.ParamByName('driver.istemporary').Value := True;
       istem :='��';
     end
     else
     begin
      Params.ParamByName('driver.istemporary').Value := False;
      istem :='��';
     end;


    if chkResponsibility.Checked then
    begin
       Params.ParamByName('driver.issignedresponsibility').Value := True;
      isposibit :='��';
    end
    else
    begin
        Params.ParamByName('driver.issignedresponsibility').Value := False;
       isposibit :='��';
    end;




    Params.ParamByName('driver.drivinglicense').Value := nvedtDrivinglicense.Text;
//    if  not (Trim(nvedtDrivinglicense.Text)='') then
//    begin
      Params.ParamByName('driver.drivinglicensefirstdate').Value := formatdatetime('yyyy-mm-dd',dtpDrivinglicensefirstdate.Date);
      Params.ParamByName('driver.drivinglicensestartdate').Value := formatdatetime('yyyy-mm-dd',dtpDriveingstart.Date);
//    end;
    Params.ParamByName('driver.drivinglicenseenddate').Value := formatdatetime('yyyy-mm-dd',dtpDriveingend.Date);


    Params.ParamByName('driver.qualification').Value := nvedtQualification.Text;
//    if not (Trim(nvedtQualification.Text)='') then
//    begin
    Params.ParamByName('driver.qualificationstartdate').Value := formatdatetime('yyyy-mm-dd',dtpQualificationstartdate.Date);
    Params.ParamByName('driver.qualificationenddate').Value := formatdatetime('yyyy-mm-dd',dtpQualificationenddate.Date);
//    end;
    if nvcbbQualificationtype.GetSelectID>0 then
       Params.ParamByName('driver.qualificationtype').Value := nvcbbQualificationtype.GetSelectCode
    else
       Params.ParamByName('driver.qualificationtype').Value := '';


    Params.ParamByName('driver.workno').Value := nvedtWorkNO.Text;
    Params.ParamByName('driver.qualifyvehicletype').Value := edtVehicletype.Text;
    Params.ParamByName('driver.workenddate').Value := formatdatetime('yyyy-mm-dd',dtpWorkenddate.Date);
    Params.ParamByName('driver.workstartdate').Value := formatdatetime('yyyy-mm-dd',dtpWorkstartdate.Date);
    if Trim(nvedtSalary.Text)='' then
     Params.ParamByName('driver.salary').Value :='0'
    else
    Params.ParamByName('driver.salary').Value := nvedtSalary.Text;

    if(NHelpRoute.Text<>'')
         and (NHelpRoute.Id>0) then
             Params.ParamByName('driver.route.id').Value := NHelpRoute.Id ;

    if imgImg_Picture1.Picture.Graphic = nil then
    begin
      Params.ParamByName('pictures').Value := '';
    end
    else
    begin
      if (not imgImg_Picture1.Picture.Graphic.Empty) then
      begin
        if not assigned(mem) then
        begin
          mem := TMemoryStream.Create;
        end
        else
          mem.Clear;
        // ת��ΪJPG��ʽ
        jpg1 := TJpegImage.Create;
        jpg1.Assign(imgImg_Picture1.Picture.Graphic);
        jpg1.SaveToStream(mem);
        jpg1.Free;


        if mem.Size > 120400 then
        begin
          SysDialogs.Warning('ͼƬ��С���ܳ���100K');
          exit;
        end;
        Params.ParamByName('pictures').Value := MemoryStreamToHexStr(mem);
      end;
    end;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      idcarname := '���֤';
      ic := 'IC����';
      codes :='����';
      SysDialogs.ShowMessage(sResult);
      if Pos(idcarname,sResult)>0 then
      begin
        nvedtIDcard.SetFocus;
      end
      else if Pos(codes,sResult)>0 then
      begin
        nvedtCode.SetFocus;
      end
      else if  pos(ic,sResult)>0 then
      begin
        nvedtCarNO.SetFocus;
      end
      else
      begin
      if id>0 then
        begin
           optype:='�޸�';
           log:= '�޸����ݣ�';
           if tname <> nvedtName.Text then
           begin
              log := ' ������'+tname+'�ĳ�'+nvedtName.Text;
           end;
            if codess <> nvedtCode.Text then
           begin
              log := log+', ������'+codess+'�ĳ�'+nvedtCode.Text;
           end;
            if idcard <> nvedtIDcard.Text then
           begin
              log := log+', ���֤��'+idcard+'�ĳ�'+nvedtIDcard.Text;
           end;
            if cardno <> nvedtCarNO.Text then
           begin
              log := log+', IC������'+cardno+'�ĳ�'+nvedtCarNO.Text;
           end;
           if education <> nvcbbEducation.Text then
           begin
              log := log+', �����̶��ɣ�'+education+'�ĳ�'+nvcbbEducation.Text;
           end;
           if archiveno <> nvedtArchivenos.Text then
           begin
              log := log+', �������ɣ�'+archiveno+'�ĳ�'+ nvedtArchivenos.Text;
           end;
            if salary <> nvedtSalary.Text then
           begin
              log := log+',�����ɣ�'+salary+'�ĳ�'+nvedtSalary.Text;
           end;
           if qualificationno <> nvedtQualification.Text then
           begin
              log := log+',��ҵ�ʸ�֤���ɣ�'+qualificationno+'�ĳ�'+nvedtQualification.Text;
           end;
           if qualificationnoS <> DateToStr(dtpQualificationstartdate.Date)then
           begin
              log := log+', ��ҵ�ʸ�֤��֤������'+qualificationnoS
                    +'�ĳ�'+DateToStr(dtpQualificationstartdate.Date);
           end;
           if qualificationnoE <> DateToStr(dtpQualificationenddate.Date)then
           begin
              log := log+', ��ҵ�ʸ�֤��Ч������'+qualificationnoE
                      +'�ĳ�'+DateToStr(dtpQualificationenddate.Date);
           end;

           if drivinglicense <> nvedtQualification.Text then
           begin
              log := log+',��ʻ֤���ɣ�'+qualificationno+'�ĳ�'+nvedtQualification.Text;
           end;
           if drivinglicenseS <> DateToStr(dtpDriveingstart.Date) then
           begin
              log := log+', ��ʻ֤��֤������'+drivinglicenseS
                    +'�ĳ�'+DateToStr(dtpDriveingstart.Date);
           end;
           if drivinglicenseE <> DateToStr(dtpDriveingend.Date) then
           begin
              log := log+', ��ʻ֤��Ч������'+drivinglicenseE
                      +'�ĳ�'+DateToStr(dtpDriveingend.Date);
           end;

           if workno <> nvedtWorkNO.Text then
           begin
              log := log+',׼��֤�ɣ�'+workno+'�ĳ�'+nvedtWorkNO.Text;
           end;
           if worknoS <> DateToStr(dtpWorkstartdate.Date) then
           begin
              log := log+', ׼�ݷ�֤������'+worknoS
                    +'�ĳ�'+DateToStr(dtpWorkstartdate.Date);
           end;
           if worknoE <> DateToStr(dtpWorkenddate.Date) then
           begin
              log := log+', ׼��֤��Ч������'+worknoE
                      +'�ĳ�'+DateToStr(dtpWorkenddate.Date);
           end;
           if movephone<> nvedtMovePhone.Text then
           begin
             log := log+',  �ƶ��绰�ɣ�'+movephone
                      +'�ĳ�'+nvedtMovePhone.Text;
           end;
           if connetphone<> nvedtFamilyPhone.Text  then
           begin
              log := log+', ��ϵ�绰�ɣ�'+connetphone
                      +'�ĳ�'+nvedtFamilyPhone.Text;
           end;
           if submit<>nvedtSubunit.Text  then
           begin
             log := log+', �����ֶ��ɣ�'+ submit
                      +'�ĳ�'+nvedtSubunit.Text;
           end;
           if vehicle <> nvhlpVehicle.Text then
           begin
              log := log+', ���Ƴ����ɣ�'+vehicle
                      +'�ĳ�'+nvhlpVehicle.Text;
           end;
           if workstatus <> nvcbbWorkstatus.Text  then
           begin
               log := log+', ����״̬��'+ workstatus
                      +'�ĳ�'+nvcbbWorkstatus.Text;
           end;
           if  politicsstatus <> nvcbbPoliticsstatus.Text then
           begin
              log := log+', ������ò��'+ politicsstatus
                      +'�ĳ�'+nvcbbPoliticsstatus.Text;
           end;
           if  qualificationtype <> nvcbbQualificationtype.Text  then
           begin
              log := log+', ׼��������'+qualificationtype
                      +'�ĳ�'+nvcbbQualificationtype.Text;
           end;
           if birthday <> DateToStr(dtpBirthdate.Date) then
           begin
              log := log+', �����ɣ�'+  birthday
                      +'�ĳ�'+DateToStr(dtpBirthdate.Date);
           end;
           if isposibility <>  isposibit then
           begin
              log := log+', �Ƿ�ǩ�������� �ɡ� '+isposibility
                      +' �� �ĳ�'+isposibit;
           end;
           if istemp <> istem then
           begin
              log := log+', �Ƿ���ʱ�� �� ��'+ istemp
                      +' ���ĳ� '+istem;
           end;

        end
       else
        begin
           optype:='���';
            log := ' ����'+nvedtName.Text+'�� ���룻'+nvedtCode.Text
                    +', IC���ţ�'+nvedtCarNO.Text
                    +', ���֤'+nvedtIDcard.Text
                    +', �����̶�'+nvcbbEducation.GetSelectCode
                    +', ������'+ nvedtArchivenos.Text
                    +', ��ҵ�ʸ�֤'+nvedtQualification.Text
                    +', ��ҵ�ʸ�֤��֤����'+DateToStr(dtpQualificationenddate.Date)
                    +', ��ҵ�ʸ�֤��Ч����'+DateToStr(dtpQualificationstartdate.Date)
                    +', ��ʻ֤��'+nvedtQualification.Text
                    +', ��ʻ֤��֤����'+DateToStr(dtpDriveingstart.Date)
                    +', ��ʻ֤��Ч����'+DateToStr(dtpDriveingend.Date)
                    +', ׼��֤��'+nvedtWorkNO.Text
                    +', ׼�ݷ�֤����'+DateToStr(dtpWorkenddate.Date)
                    +', ׼��֤��Ч����'+DateToStr(dtpWorkstartdate.Date);
        end;
        SysLog.WriteLog('��ʻԱ��������', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('driverid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��ʻԱ�������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

procedure TfrmDriverEdit.btn1Click(Sender: TObject);
begin
  inherited;
 if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;

procedure TfrmDriverEdit.btn2Click(Sender: TObject);
begin
  inherited;
    imgImg_Picture1.Picture.Assign(nil);
end;

function TfrmDriverEdit.checkSchedule(var msg: String): boolean;
begin
   result := False;
  if Trim(nvedtName.Text) ='' then
  begin
    msg := '��������Ϊ�գ�';
    nvedtName.SetFocus;
    exit;
  end;
  if trim(nvedtCode.Text) = '' then
  begin
    msg := '���Ų���Ϊ�գ�';
    nvedtCode.SetFocus;
    exit;
  end;
 { if trim(nvedtIDcard.Text)='' then
  begin
    msg := '���֤�Ų���Ϊ�գ�';
    nvedtIDcard.SetFocus;
    exit;
  end;
  if not (ValidatePID(nvedtIDcard.Text) ='') then
  begin
    msg := ValidatePID(nvedtIDcard.Text);
    nvedtIDcard.SetFocus;
    exit;
  end;  }
{  if nvcbbPoliticsstatus.GetSelectID < 0 then
  begin
    msg := '��ѡ��������ò��';
    nvcbbPoliticsstatus.SetFocus;
    exit;
  end;
  if nvcbbEducation.GetSelectID < 0 then
  begin
    msg := '��ѡ���Ļ��̶ȣ�';
    nvcbbEducation.SetFocus;
    exit;
  end;
  if trim(nvedtNativeplace.Text)='' then
  begin
    msg := '���᲻��Ϊ�գ�';
    nvedtNativeplace.SetFocus;
    exit;
  end;  }
  if ((Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id<=0) then
  begin
    msg := '�������������� ��';
    nvhelpUnit.SetFocus;
    exit;
  end;

      if nvcbbWorkstatus.GetSelectID < 0 then
  begin
    msg := '��ѡ���ʻԱ״̬��';
    nvcbbWorkstatus.SetFocus;
    exit;
  end;
//    if nvcbbQualificationtype.GetSelectID < 0 then
//  begin
//    msg := '��ѡ���ʻԱ׼�����ͣ�';
//    nvcbbQualificationtype.SetFocus;
//    exit;
//  end;

   result := True;
end;




procedure TfrmDriverEdit.FormCreate(Sender: TObject);
begin
  inherited;
 nvcbbEducation.Active :=  False;
  nvcbbEducation.Active := True;

  nvcbbWorkstatus.Active :=  False;
  nvcbbWorkstatus.Active := True;

  nvcbbQualificationtype.Active :=  False;
  nvcbbQualificationtype.Active := True;

  nvcbbPoliticsstatus.Active :=  False;
  nvcbbPoliticsstatus.Active := True;
  rbMan.Checked := true;

  dtpDriveingstart.Date := Now;
  dtpDrivinglicensefirstdate.Date := Now;
  dtpQualificationstartdate.Date := Now;
  dtpDriveingend.Date := Now;
  dtpWorkstartdate.Date := Now;
  dtpQualificationenddate.Date := Now;
  dtpWorkenddate.Date := Now;
  dtpBirthdate.Date := Now;
  dtpRecruitmentdate.Date := Now;
   TIDCardReader.GetInstance.addObserver(Self,False,True);
end;

   procedure TfrmDriverEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TIDCardReader.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TfrmDriverEdit.imgImg_Picture1DblClick(Sender: TObject);
begin
  inherited;
     if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;

procedure TfrmDriverEdit.N2Click(Sender: TObject);
begin
  inherited; //���ͼƬ
  imgImg_Picture1.Picture.Assign(nil);
end;

 procedure TfrmDriverEdit.cardfound(idcard: TIDCard);
 var sexbg :string;
begin
  curidcard:=idcard;
  try
    if curidcard<>nil then
    begin
      nvedtName.Text:=curidcard.Name;  //����
      sexbg:=curidcard.Sex;    //�Ա�
      if Trim(curidcard.Sex)='��' then
         begin
          rbMan.Checked:=True;
         end
         else
         begin
          rbGrile.Checked :=True;
         end;
//      if sexbg = 'Ů' then
//         begin
//          rbGrile.Checked
//         end;


//      EdtMZ.Text:= curidcard.MZ;     //����
      dtpBirthdate.DateTime:=curidcard.Bday;   // ��������

      nvedtNativeplace.Text:=curidcard.Addr;        //����
      nvedtIDcard.Text:=curidcard.ID;           //���֤����
//      EdtDep.Text:=curidcard.Dep;                     //     ��֤����
//      EdtVld.Text:=DateToStr(curidcard.Vld_S)+'��'+DateToStr(curidcard.Vld_E);  //��Ч����
//      EdtNewAddr.Text:=curidcard.NewAddr;         //��סַ
      imgImg_Picture1.Picture.Assign(curidcard.photo);
//
//      imgImg_Picture1.Visible := TRUE;

//      windows.Beep(2800,200);
//      query(TQueryBy.IDCARDNO,edtID.Text);
    end;
  except
//    on e:Exception do
//    SysDialogs.ShowMessage(e.Message);
  end;
end;


{
procedure TfrmDriverEdit.rbGrileClick(Sender: TObject);
begin
  inherited;
  rbMan.Checked :=False;
  rbGrile.Checked :=True;
end;

procedure TfrmDriverEdit.rbManClick(Sender: TObject);
begin
  inherited;

  rbMan.Checked :=True;
  rbGrile.Checked :=False;
end;            }

end.
