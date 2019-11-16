unit UFrmStewardEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ExtDlgs, Jpeg, Menus, ImgList;

type
  TfrmStewardEdit = class(TSimpleEditForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    grpPicture: TGroupBox;
    nvedtName: TNovaEdit;
    nvedtCode: TNovaEdit;
    nvedtCarNO: TNovaEdit;
    nvedtIDcard: TNovaEdit;
    nvedtFamilyPhone: TNovaEdit;
    nvedtAdress: TNovaEdit;
    nvcbbEducation: TNovaComboBox;
    dtpBirthdate: TDateTimePicker;
    nvcbbPoliticsstatus: TNovaComboBox;
    lbl10: TLabel;
    nvedtMovePhone: TNovaEdit;
    lblSalary: TLabel;
    nvedtSalary: TNovaEdit;
    nvedtNativeplace: TNovaEdit;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    jcdsSave: TjsonClientDataSet;
    grp2: TGroupBox;
    lbl18: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    dtpQualificationstartdate: TDateTimePicker;
    dtpQualificationenddate: TDateTimePicker;
    nvedtQualification: TNovaEdit;
    lbl9: TLabel;
    nvcbbGrade: TNovaComboBox;
    lbl11: TLabel;
    nvedtArchive: TNovaEdit;
    lblArchiveno: TLabel;
    chkTemp: TCheckBox;
    dlgOpenPicPictrue: TOpenPictureDialog;
    pnl2: TPanel;
    imgImg_Picture1: TImage;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    nvhelpUnit: TNovaHelp;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    Label1: TLabel;
    nvedtJianpin: TNovaEdit;
    nvhlpVehicleno: TNovaHelp;
    lbl25: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgImg_Picture1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    mem: TMemoryStream;
    memstr: TStringStream;
    function checkSchedule(var msg: String): boolean;
  public
    { Public declarations }
   id:Integer;
    iseditS:boolean;
   createbys, createtimes,code,tname, idcard,cardno,education,grade,
   salary,archiveno,qualificationno,qualificationnoS,qualificationnoE,
   nativeplace: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmStewardEdit: TfrmStewardEdit;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmStewardEdit.bbtnSaveClick(Sender: TObject);
 var  msg,log,optype: String;
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

  with jcdsSave do
  begin
    close;
//    if iseditS then
//    begin
     Params.ParamByName('steward.id').Value := id;
//     Params.ParamByName('steward.createtime').Value := createtimes;
//     Params.ParamByName('steward.createby').Value := createbys
//    end;
    Params.ParamByName('steward.vehicleid').Value := nvhlpVehicleno.Id;
    Params.ParamByName('steward.vehicleno').Value := nvhlpVehicleno.text;

    Params.ParamByName('steward.name').Value := nvedtName.Text;
    Params.ParamByName('steward.jianpin').Value := nvedtJianpin.Text;
    Params.ParamByName('steward.archiveno').Value := nvedtArchive.Text;
    Params.ParamByName('steward.code').Value := nvedtCode.Text;
    Params.ParamByName('steward.cardno').Value := nvedtCarNO.Text;
    Params.ParamByName('steward.idcard').Value := nvedtIDcard.Text;
    Params.ParamByName('steward.education').Value := nvcbbEducation.GetSelectCode;
    Params.ParamByName('steward.politicsstatus').Value := nvcbbPoliticsstatus.GetSelectCode;
    Params.ParamByName('steward.grade').Value := nvcbbGrade.GetSelectCode;
    Params.ParamByName('steward.unitid').Value := nvhelpUnit.Id;
    Params.ParamByName('steward.familyaddress').Value := nvedtAdress.Text;
    Params.ParamByName('steward.familyphone').Value := nvedtFamilyPhone.Text;
    Params.ParamByName('steward.mobilephone').Value :=  nvedtMovePhone.Text;
    Params.ParamByName('steward.nativeplace').Value := nvedtNativeplace.Text;
//    Params.ParamByName('steward.picture').Value :=           formatdatetime('c',dtpDriveingstart.Date);
    Params.ParamByName('steward.birthday').Value :=formatdatetime('yyyy-mm-dd',dtpBirthdate.Date);
    Params.ParamByName('steward.qualificationenddate').Value := formatdatetime('yyyy-mm-dd',dtpQualificationenddate.Date);
    Params.ParamByName('steward.qualificationstartdate').Value :=formatdatetime('yyyy-mm-dd',dtpQualificationstartdate.Date);
    Params.ParamByName('steward.qualificationno').Value := nvedtQualification.Text;



    if Trim(nvedtSalary.Text) ='' then
    begin
       Params.ParamByName('steward.salary').Value := '0'
    end
    else
    begin
      Params.ParamByName('steward.salary').Value :=  nvedtSalary.Text;
    end;


    Params.ParamByName('steward.orgid').Value :=  SysInfo.LoginUserInfo.OrgID;
    if rbMan.Checked then
    Params.ParamByName('steward.sex').Value := '��';
    if rbGrile.Checked then
    Params.ParamByName('steward.sex').Value := 'Ů';

     if chkTemp.Checked then
     Params.ParamByName('steward.istemporary').Value := True
    else
     Params.ParamByName('steward.istemporary').Value := False;

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
      if (nResult <= 0) then
      begin
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
      end
      else
      begin
       if id>0 then
        begin
           optype:='�޸�';
           log := '�޸������У�';
           if tname <> nvedtName.Text then
           begin
              log := ' ������'+tname+'�ĳ�'+nvedtName.Text;
           end;
            if code <> nvedtCode.Text then
           begin
              log := log+', ������'+code+'�ĳ�'+nvedtCode.Text;
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
              log := log+', �����̶���'+education+'�ĳ�'+nvcbbEducation.GetSelectCode;
           end;
           if archiveno <> nvedtArchive.Text then
           begin
              log := log+', ��������'+archiveno+'�ĳ�'+ nvedtArchive.Text;
           end;
            if salary <> nvedtSalary.Text then
           begin
              log := log+',������'+salary+'�ĳ�'+nvedtSalary.Text;
           end;
           if qualificationno <> nvedtQualification.Text then
           begin
              log := log+',��ҵ�ʸ�֤����'+qualificationno+'�ĳ�'+nvedtQualification.Text;
           end;
           if qualificationnoS <> DateToStr(dtpQualificationstartdate.Date) then
           begin
              log := log+', ��ҵ�ʸ�֤��֤������'+qualificationnoS
                    +'�ĳ�'+DateToStr(dtpQualificationstartdate.Date);
           end;
           if qualificationnoE <> DateToStr(dtpQualificationenddate.Date) then
           begin
              log := log+', ��ҵ�ʸ�֤��Ч������'+qualificationnoE
                      +'�ĳ�'+DateToStr(dtpQualificationenddate.Date);
           end;
            if nativeplace <> nvedtNativeplace.Text then
           begin
              log := log+', ������'+nativeplace
                      +'�ĳ�'+nvedtNativeplace.Text;
           end;
        end
       else
        begin
           optype:='���';
            log := ' ����Ա����'+nvedtName.Text+'�� ���룻'+nvedtCode.Text
                    +', IC���ţ�'+nvedtCarNO.Text
                    +', ���֤:'+nvedtIDcard.Text
                    +', �����̶�:'+nvcbbEducation.Text
                    +', ������:'+ nvedtArchive.Text
                    +',��ҵ�ʸ�֤��:'+nvedtQualification.Text
                    +', ��ҵ�ʸ�֤��֤����:'+DateToStr(dtpQualificationstartdate.Date)
                    +', ��ҵ�ʸ�֤��Ч����:'+DateToStr(dtpQualificationenddate.Date);
        end;
        SysLog.WriteLog('����Ա��������', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('stewadid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����Ա�������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;



end;



function TfrmStewardEdit.checkSchedule(var msg: String): boolean;
begin
   result := False;
   if ((Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id<=0) then
  begin
    msg := '��ѡ������λ ��';
    nvhelpUnit.SetFocus;
    exit;
  end;
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
  if trim(nvedtIDcard.Text)='' then
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
  end;
  if nvcbbEducation.GetSelectID < 0 then
  begin
    msg := '��ѡ���Ļ��̶ȣ�';
    nvcbbEducation.SetFocus;
    exit;
  end;
  if nvcbbPoliticsstatus.GetSelectID < 0 then
  begin
    msg := '��ѡ��������ò��';
    nvcbbPoliticsstatus.SetFocus;
    exit;
  end;
   if nvcbbGrade.ItemIndex < 0 then
  begin
    msg := '��ѡ�����Ա�Ǽ� ��';
    nvcbbGrade.SetFocus;
    exit;
  end;

   

   result := True;
end;


procedure TfrmStewardEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBirthdate.Date := Now;
  dtpQualificationstartdate.Date := Now;
  dtpQualificationenddate.Date := Now;
  nvcbbEducation.Active :=False;
  nvcbbEducation.Active:=True;
  nvcbbPoliticsstatus.Active :=False;
  nvcbbPoliticsstatus.Active:=True;
  nvcbbGrade.Active :=False;
  nvcbbGrade.Active:=True;
end;

procedure TfrmStewardEdit.imgImg_Picture1DblClick(Sender: TObject);
begin
  inherited;
   if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;
procedure TfrmStewardEdit.btn1Click(Sender: TObject);
begin
  inherited;
   if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;

procedure TfrmStewardEdit.btn2Click(Sender: TObject);
begin
  inherited;
  imgImg_Picture1.Picture.Assign(nil);
end;

procedure TfrmStewardEdit.N2Click(Sender: TObject);
begin
  inherited;
   imgImg_Picture1.Picture.Assign(nil);
end;

end.


