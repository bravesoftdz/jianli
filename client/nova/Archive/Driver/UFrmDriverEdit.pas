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
    Params.ParamByName('driver.sex').Value := '男';
    if rbGrile.Checked then
    Params.ParamByName('driver.sex').Value := '女';

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
           SysDialogs.Warning('隶属车队不能为空！');
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
       istem :='是';
     end
     else
     begin
      Params.ParamByName('driver.istemporary').Value := False;
      istem :='否';
     end;


    if chkResponsibility.Checked then
    begin
       Params.ParamByName('driver.issignedresponsibility').Value := True;
      isposibit :='是';
    end
    else
    begin
        Params.ParamByName('driver.issignedresponsibility').Value := False;
       isposibit :='否';
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
        // 转换为JPG格式
        jpg1 := TJpegImage.Create;
        jpg1.Assign(imgImg_Picture1.Picture.Graphic);
        jpg1.SaveToStream(mem);
        jpg1.Free;


        if mem.Size > 120400 then
        begin
          SysDialogs.Warning('图片大小不能超过100K');
          exit;
        end;
        Params.ParamByName('pictures').Value := MemoryStreamToHexStr(mem);
      end;
    end;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      idcarname := '身份证';
      ic := 'IC卡号';
      codes :='工号';
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
           optype:='修改';
           log:= '修改内容：';
           if tname <> nvedtName.Text then
           begin
              log := ' 名称由'+tname+'改成'+nvedtName.Text;
           end;
            if codess <> nvedtCode.Text then
           begin
              log := log+', 编码由'+codess+'改成'+nvedtCode.Text;
           end;
            if idcard <> nvedtIDcard.Text then
           begin
              log := log+', 身份证由'+idcard+'改成'+nvedtIDcard.Text;
           end;
            if cardno <> nvedtCarNO.Text then
           begin
              log := log+', IC卡号由'+cardno+'改成'+nvedtCarNO.Text;
           end;
           if education <> nvcbbEducation.Text then
           begin
              log := log+', 教育程度由：'+education+'改成'+nvcbbEducation.Text;
           end;
           if archiveno <> nvedtArchivenos.Text then
           begin
              log := log+', 档案号由：'+archiveno+'改成'+ nvedtArchivenos.Text;
           end;
            if salary <> nvedtSalary.Text then
           begin
              log := log+',工资由：'+salary+'改成'+nvedtSalary.Text;
           end;
           if qualificationno <> nvedtQualification.Text then
           begin
              log := log+',从业资格证号由：'+qualificationno+'改成'+nvedtQualification.Text;
           end;
           if qualificationnoS <> DateToStr(dtpQualificationstartdate.Date)then
           begin
              log := log+', 从业资格证发证日期由'+qualificationnoS
                    +'改成'+DateToStr(dtpQualificationstartdate.Date);
           end;
           if qualificationnoE <> DateToStr(dtpQualificationenddate.Date)then
           begin
              log := log+', 从业资格证有效日期由'+qualificationnoE
                      +'改成'+DateToStr(dtpQualificationenddate.Date);
           end;

           if drivinglicense <> nvedtQualification.Text then
           begin
              log := log+',驾驶证号由：'+qualificationno+'改成'+nvedtQualification.Text;
           end;
           if drivinglicenseS <> DateToStr(dtpDriveingstart.Date) then
           begin
              log := log+', 驾驶证发证日期由'+drivinglicenseS
                    +'改成'+DateToStr(dtpDriveingstart.Date);
           end;
           if drivinglicenseE <> DateToStr(dtpDriveingend.Date) then
           begin
              log := log+', 驾驶证有效日期由'+drivinglicenseE
                      +'改成'+DateToStr(dtpDriveingend.Date);
           end;

           if workno <> nvedtWorkNO.Text then
           begin
              log := log+',准驾证由：'+workno+'改成'+nvedtWorkNO.Text;
           end;
           if worknoS <> DateToStr(dtpWorkstartdate.Date) then
           begin
              log := log+', 准驾发证日期由'+worknoS
                    +'改成'+DateToStr(dtpWorkstartdate.Date);
           end;
           if worknoE <> DateToStr(dtpWorkenddate.Date) then
           begin
              log := log+', 准驾证有效日期由'+worknoE
                      +'改成'+DateToStr(dtpWorkenddate.Date);
           end;
           if movephone<> nvedtMovePhone.Text then
           begin
             log := log+',  移动电话由：'+movephone
                      +'改成'+nvedtMovePhone.Text;
           end;
           if connetphone<> nvedtFamilyPhone.Text  then
           begin
              log := log+', 联系电话由：'+connetphone
                      +'改成'+nvedtFamilyPhone.Text;
           end;
           if submit<>nvedtSubunit.Text  then
           begin
             log := log+', 隶属分队由：'+ submit
                      +'改成'+nvedtSubunit.Text;
           end;
           if vehicle <> nvhlpVehicle.Text then
           begin
              log := log+', 建制车号由：'+vehicle
                      +'改成'+nvhlpVehicle.Text;
           end;
           if workstatus <> nvcbbWorkstatus.Text  then
           begin
               log := log+', 工作状态由'+ workstatus
                      +'改成'+nvcbbWorkstatus.Text;
           end;
           if  politicsstatus <> nvcbbPoliticsstatus.Text then
           begin
              log := log+', 政治面貌由'+ politicsstatus
                      +'改成'+nvcbbPoliticsstatus.Text;
           end;
           if  qualificationtype <> nvcbbQualificationtype.Text  then
           begin
              log := log+', 准驾类型由'+qualificationtype
                      +'改成'+nvcbbQualificationtype.Text;
           end;
           if birthday <> DateToStr(dtpBirthdate.Date) then
           begin
              log := log+', 生日由：'+  birthday
                      +'改成'+DateToStr(dtpBirthdate.Date);
           end;
           if isposibility <>  isposibit then
           begin
              log := log+', 是否签定责任书 由‘ '+isposibility
                      +' ’ 改成'+isposibit;
           end;
           if istemp <> istem then
           begin
              log := log+', 是否临时工 由 ‘'+ istemp
                      +' ’改成 '+istem;
           end;

        end
       else
        begin
           optype:='添加';
            log := ' 名称'+nvedtName.Text+'， 编码；'+nvedtCode.Text
                    +', IC卡号；'+nvedtCarNO.Text
                    +', 身份证'+nvedtIDcard.Text
                    +', 教育程度'+nvcbbEducation.GetSelectCode
                    +', 档案号'+ nvedtArchivenos.Text
                    +', 从业资格证'+nvedtQualification.Text
                    +', 从业资格证发证日期'+DateToStr(dtpQualificationenddate.Date)
                    +', 从业资格证有效日期'+DateToStr(dtpQualificationstartdate.Date)
                    +', 驾驶证号'+nvedtQualification.Text
                    +', 驾驶证发证日期'+DateToStr(dtpDriveingstart.Date)
                    +', 驾驶证有效日期'+DateToStr(dtpDriveingend.Date)
                    +', 准驾证号'+nvedtWorkNO.Text
                    +', 准驾发证日期'+DateToStr(dtpWorkenddate.Date)
                    +', 准驾证有效日期'+DateToStr(dtpWorkstartdate.Date);
        end;
        SysLog.WriteLog('驾驶员档案管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('driverid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('驾驶员档案添加失败：' + E.Message);
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
    msg := '姓名不能为空！';
    nvedtName.SetFocus;
    exit;
  end;
  if trim(nvedtCode.Text) = '' then
  begin
    msg := '工号不能为空！';
    nvedtCode.SetFocus;
    exit;
  end;
 { if trim(nvedtIDcard.Text)='' then
  begin
    msg := '身份证号不能为空！';
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
    msg := '请选择政治面貌！';
    nvcbbPoliticsstatus.SetFocus;
    exit;
  end;
  if nvcbbEducation.GetSelectID < 0 then
  begin
    msg := '请选择文化程度！';
    nvcbbEducation.SetFocus;
    exit;
  end;
  if trim(nvedtNativeplace.Text)='' then
  begin
    msg := '籍贯不能为空！';
    nvedtNativeplace.SetFocus;
    exit;
  end;  }
  if ((Trim(nvhelpUnit.Text) = '')) and (nvhelpUnit.Id<=0) then
  begin
    msg := '请输入隶属车队 ！';
    nvhelpUnit.SetFocus;
    exit;
  end;

      if nvcbbWorkstatus.GetSelectID < 0 then
  begin
    msg := '请选择驾驶员状态！';
    nvcbbWorkstatus.SetFocus;
    exit;
  end;
//    if nvcbbQualificationtype.GetSelectID < 0 then
//  begin
//    msg := '请选择驾驶员准架类型！';
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
  inherited; //清空图片
  imgImg_Picture1.Picture.Assign(nil);
end;

 procedure TfrmDriverEdit.cardfound(idcard: TIDCard);
 var sexbg :string;
begin
  curidcard:=idcard;
  try
    if curidcard<>nil then
    begin
      nvedtName.Text:=curidcard.Name;  //姓名
      sexbg:=curidcard.Sex;    //性别
      if Trim(curidcard.Sex)='男' then
         begin
          rbMan.Checked:=True;
         end
         else
         begin
          rbGrile.Checked :=True;
         end;
//      if sexbg = '女' then
//         begin
//          rbGrile.Checked
//         end;


//      EdtMZ.Text:= curidcard.MZ;     //民族
      dtpBirthdate.DateTime:=curidcard.Bday;   // 出生日期

      nvedtNativeplace.Text:=curidcard.Addr;        //籍贯
      nvedtIDcard.Text:=curidcard.ID;           //身份证号码
//      EdtDep.Text:=curidcard.Dep;                     //     发证机关
//      EdtVld.Text:=DateToStr(curidcard.Vld_S)+'至'+DateToStr(curidcard.Vld_E);  //有效日期
//      EdtNewAddr.Text:=curidcard.NewAddr;         //现住址
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
