unit UFrmEmployeeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, DB, DBClient,Services, jsonClientDataSet, ExtDlgs, Jpeg,
  NovaHComboBox, NovaCheckedComboBox, Menus, NovaHelp, ImgList;

type
  TfrmEmployeeEdt = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl10: TLabel;
    lblSalary: TLabel;
    lbl11: TLabel;
    lbl19: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    lbl26: TLabel;
    lbl28: TLabel;
    nvedtName: TNovaEdit;
    nvedtCode: TNovaEdit;
    nvedtIDcard: TNovaEdit;
    nvedtFamilyPhone: TNovaEdit;
    nvedtAdress: TNovaEdit;
    nvcbbEducation: TNovaComboBox;
    dtpBirthdate: TDateTimePicker;
    nvedtMovePhone: TNovaEdit;
    nvedtSalary: TNovaEdit;
    nvedtNativeplace: TNovaEdit;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    grpPicture: TGroupBox;
    pnl1: TPanel;
    imgImg_Picture1: TImage;
    lbl3: TLabel;
    nvcbbPosition: TNovaComboBox;
    lbl9: TLabel;
    chkTemp: TCheckBox;
    jcdsSave: TjsonClientDataSet;
    dlgOpenPicPictrue: TOpenPictureDialog;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    nvhelpOrg: TNovaHelp;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure imgImg_Picture1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
    iseditS:boolean;
   id:Integer;
   picture:string;
   createby, createtime,code,
   orgname,tname,salary,education,idcard,position,codess: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmEmployeeEdt: TfrmEmployeeEdt;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmEmployeeEdt.bbtnSaveClick(Sender: TObject);
var  msg,log,optype: String;
  nResult: integer;
  sResult: String;
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

    Params.ParamByName('employeer.id').Value := id;
    Params.ParamByName('employeer.createtime').Value := createtime;
    Params.ParamByName('employeer.createby').Value := createby;

    Params.ParamByName('employeer.name').Value := nvedtName.Text;
    Params.ParamByName('employeer.code').Value := nvedtCode.Text;
    Params.ParamByName('employeer.idcard').Value := nvedtIDcard.Text;
    Params.ParamByName('employeer.education').Value := nvcbbEducation.GetSelectCode;
    Params.ParamByName('employeer.position').Value := nvcbbPosition.GetSelectCode;

    Params.ParamByName('employeer.familyaddress').Value := nvedtAdress.Text;
    Params.ParamByName('employeer.familyphone').Value := nvedtFamilyPhone.Text;
    Params.ParamByName('employeer.mobilephone').Value :=  nvedtMovePhone.Text;
    Params.ParamByName('employeer.nativeplace').Value := nvedtNativeplace.Text;
//    Params.ParamByName('steward.picture').Value :=           formatdatetime('c',dtpDriveingstart.Date);
    Params.ParamByName('employeer.birthday').Value :=formatdatetime('c',dtpBirthdate.Date);
    if Trim(nvedtSalary.Text) ='' then
    begin
       Params.ParamByName('employeer.salary').Value := '0'
    end
    else
    begin
      Params.ParamByName('employeer.salary').Value :=  nvedtSalary.Text;
    end;


    Params.ParamByName('employeer.orgid').Value := nvhelpOrg.Id;
    if rbMan.Checked then
    Params.ParamByName('employeer.sex').Value := '男';
    if rbGrile.Checked then
    Params.ParamByName('employeer.sex').Value := '女';

     if chkTemp.Checked then
     Params.ParamByName('employeer.istemporary').Value := True
    else
     Params.ParamByName('employeer.istemporary').Value := False;

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
           if tname <> nvedtName.Text then
           begin
              log := ' 员工名称由'+tname+'改成'+nvedtName.Text;
           end;
            if codess <> nvedtCode.Text then
           begin
              log := log+', 工号由'+codess+'改成'+nvedtCode.Text;
           end;
            if idcard <> nvedtIDcard.Text then
           begin
              log := log+', 身份证由'+idcard+'改成'+nvedtIDcard.Text;
           end;
           if education <> nvcbbEducation.Text then
           begin
              log := log+', 教育程度由'+education+'改成'+nvcbbEducation.Text;
           end;
             if salary <> nvedtSalary.Text then
           begin
              log := log+',工资由'+salary+'改成'+nvedtSalary.Text;
           end;
            if position <> nvcbbPosition.Text then
           begin
              log := log+',职位类型由'+position+'改成'+nvcbbPosition.Text;
           end;
        end
        else
        begin
           optype:='添加';
            log := ' 员工名称'+nvedtName.Text+'， 编码；'+nvedtCode.Text
                    +', 身份证'+nvedtIDcard.Text
                    +', 教育程度'+nvcbbEducation.Text
                    +', 工资'+ nvedtSalary.Text
                    +',职位类型'+nvcbbPosition.Text;
        end;
        SysLog.WriteLog('员工档案管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('employeeid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('员工档案添加失败：' + E.Message);
      end;
    end;
  end;



end;




function TfrmEmployeeEdt.checkSchedule(var msg: String): boolean;
begin
   result := False;
   if ((Trim(nvhelpOrg.Text) = '')) and (nvhelpOrg.Id<=0) then
  begin
    msg := '所属单位不能为空！';
    nvhelpOrg.SetFocus;
    exit;
  end;
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
  if trim(nvedtIDcard.Text)='' then
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
    end;
  if nvcbbEducation.GetSelectID < 0 then
  begin
    msg := '请选择学历！';
    nvcbbEducation.SetFocus;
    exit;
  end;
  if nvcbbPosition.GetSelectID < 0 then
  begin
    msg := '请选择职位类型！';
    nvcbbPosition.SetFocus;
    exit;
  end;
   result := True;
  end;



procedure TfrmEmployeeEdt.FormCreate(Sender: TObject);
begin
  inherited;
   nvcbbEducation.Active := False;
   nvcbbEducation.Active := True;
   nvcbbPosition.Active := False;
   nvcbbPosition.Active :=True;
end;

procedure TfrmEmployeeEdt.FormShow(Sender: TObject);
begin
  inherited;
 if picture<>'' then
    imgImg_Picture1.Picture.Assign(HexStrToJpg(picture));
end;

procedure TfrmEmployeeEdt.btn1Click(Sender: TObject);
begin
  inherited;
  if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;

procedure TfrmEmployeeEdt.btn2Click(Sender: TObject);
begin
  inherited;
   imgImg_Picture1.Picture.Assign(nil);
end;

procedure TfrmEmployeeEdt.imgImg_Picture1DblClick(Sender: TObject);
begin
  inherited;
  if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;


procedure TfrmEmployeeEdt.N2Click(Sender: TObject);
begin
  inherited;          //清空图片
    imgImg_Picture1.Picture.Assign(nil);
end;

end.
