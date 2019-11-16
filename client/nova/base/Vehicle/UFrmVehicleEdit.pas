unit UFrmVehicleEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Services, ComCtrls, Buttons, ExtCtrls, USimpleEditForm,
  DB, DBClient, jsonClientDataSet, ExtDlgs, NovaHComboBox, NovaHelp, CardManage,
  NovaComboBox, NovaEdit, ImgList,UICcardRW,jpeg, UDMPublic,ToolWin;

type
  TFrmVehicleEdit = class(TSimpleEditForm,IBaseCardfound)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    lblcontractno: TLabel;
    edtcontractno: TNovaEdit;
    Label18: TLabel;
    dtpcontractstartdate: TDateTimePicker;
    Label19: TLabel;
    dtpcontractenddate: TDateTimePicker;
    lblliabilityinsureno: TLabel;
    Label21: TLabel;
    dtpliabilityinsurestartdate: TDateTimePicker;
    dtpcompulsoryinsureenddate: TDateTimePicker;
    edtliabilityinsureno: TNovaEdit;
    Label23: TLabel;
    Label24: TLabel;
    dtpcompulsoryinsurestartdate: TDateTimePicker;
    dtpliabilityinsureenddate: TDateTimePicker;
    edtcompulsoryinsureno: TNovaEdit;
    Label27: TLabel;
    lblworkno: TLabel;
    NovaEdtroadno: TNovaEdit;
    dtpworkstartdate: TDateTimePicker;
    dtplicenseenddate: TDateTimePicker;
    GroupBox4: TGroupBox;
    lblvehicleno: TLabel;
    Label22: TLabel;
    Label25: TLabel;
    dtplicensestartdate: TDateTimePicker;
    lbl1: TLabel;
    dtpworkenddate: TDateTimePicker;
    lbl2: TLabel;
    lbl3: TLabel;
    dlgOpenPic1: TOpenPictureDialog;
    Img_Picture: TImage;
    jsonCDSVehicleSave: TjsonClientDataSet;
    jcdsQryPic: TjsonClientDataSet;
    grpremarks: TGroupBox;
    Label2: TLabel;
    ilToolBar: TImageList;
    NovaEdtmargin: TNovaEdit;
    NovaEdtstopfee: TNovaEdit;
    NovaEdtcheckfee: TNovaEdit;
    NovaEdtotherfee: TNovaEdit;
    Label6: TLabel;
    Label1: TLabel;
    dtpvehiclenotime: TDateTimePicker;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btn1: TSpeedButton;
    btn2: TSpeedButton;
    Label12: TLabel;
    NovaEdtEnterNo: TNovaEdit;
    dtpMakeDate: TDateTimePicker;
    Label13: TLabel;
    chkTempVehicle: TCheckBox;
    lblunitid: TLabel;
    lblcardno: TLabel;
    lblrationseatnum: TLabel;
    lblseatnum: TLabel;
    lblloadamout: TLabel;
    lbltype: TLabel;
    lbl5: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl13: TLabel;
    lbl6: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    lbl8: TLabel;
    lbl11: TLabel;
    Label15: TLabel;
    edtcardno: TNovaEdit;
    edtrationseatnum: TNovaEdit;
    edtseatnum: TNovaEdit;
    edtloadamout: TNovaEdit;
    cbbType: TNovaComboBox;
    NovaHelpUnit: TNovaHelp;
    dtpCardValidate: TDateTimePicker;
    NovaHelpBalanceUnit: TNovaHelp;
    NHelpRoute: TNovaHelp;
    btnReadCard: TButton;
    cbbstatus: TNovaComboBox;
    lblcolor: TLabel;
    lblcontactperson: TLabel;
    lblcontactphone: TLabel;
    lbl4: TLabel;
    lblgprs: TLabel;
    edtcontactperson: TNovaEdit;
    edtcontactphone: TNovaEdit;
    edtgprs: TNovaEdit;
    cbbcolor: TNovaComboBox;
    Label3: TLabel;
    Label14: TLabel;
    mmoremarks: TMemo;
    NovaEdtAuditroute: TNovaEdit;
    Label16: TLabel;
    NovaEdtdriverlicense: TNovaEdit;
    Label17: TLabel;
    Label20: TLabel;
    edtworkno: TNovaEdit;
    Label26: TLabel;
    Dpmaintainvaliddate: TDateTimePicker;
    Label28: TLabel;
    NEdtNextmaintaindistance: TNovaEdit;
    Label29: TLabel;
    edtvehicleno: TNovaHelp;
    Cbxisneed: TCheckBox;
    Label11: TLabel;
    nvhlpVehiclebrandmodel: TNovaHelp;
    Label30: TLabel;
    lbl7: TLabel;
    vehicleseattype: TNovaComboBox;
    lbl14: TLabel;
    chkisneedcheck: TCheckBox;
    Label31: TLabel;
    edttwono: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtcontractnoChange(Sender: TObject);
    procedure edtliabilityinsurenoChange(Sender: TObject);
    procedure edtcompulsoryinsurenoChange(Sender: TObject);
    procedure NovaEdtroadnoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtcardnoChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure edtcardnoEnter(Sender: TObject);
    procedure btnReadCardClick(Sender: TObject);
    procedure edtvehiclenoChange(Sender: TObject);
    procedure edtvehiclenoExit(Sender: TObject);
    procedure NovaEdtdriverlicenseChange(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure nvhlpVehiclebrandmodelIdChange(Sender: TObject);
    procedure edtworknoChange(Sender: TObject);
  private
    { Private declarations }
    baseCard : TBaseCard;
    mem: TMemoryStream;
    procedure iccardfound(icCard:TBaseCard);
  public
    createby, grantdate,printdate: string;
    id, orgid: int64;
    isaudited, isauditpass,isupdates: boolean;
    isactive, islocaldelete: boolean;
    createtime,synccode: String;
  end;

var
  FrmVehicleEdit: TFrmVehicleEdit;

implementation

uses PubFn, UFrmVehicle;
{$R *.dfm}

procedure TFrmVehicleEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  jpg1: TJpegImage;
  var cansave: Boolean;
begin
  inherited;
  if edtvehicleno.Text = '' then
  begin
    SysDialogs.ShowMessage('车牌不能为空');
    edtvehicleno.SetFocus;
    exit;
  end;
 { if Length(Trim(edtvehicleno.Text))<>7 then
  begin
    SysDialogs.ShowMessage('你输入的车牌位数不对！');
    edtvehicleno.SetFocus;
    exit;
  end; }
  if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
  begin
    SysDialogs.ShowMessage('车属单位不能空！');
    NovaHelpUnit.SetFocus;
    exit;
  end;
  if (trim(NovaHelpBalanceUnit.Text) = '') or (NovaHelpBalanceUnit.id = 0) then
  begin
    SysDialogs.ShowMessage('单位结算不能空！');
    NovaHelpBalanceUnit.SetFocus;
    exit;
  end;
    if nvhlpVehiclebrandmodel.id<=0 then
  begin
    SysDialogs.ShowMessage('请选择品牌型号！');
    nvhlpVehiclebrandmodel.SetFocus;
    exit;
  end;

  if cbbstatus.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择车辆状态！');
    cbbstatus.SetFocus;
    exit;
  end;
  {
  if cbbvehicletype.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择车型！');
    cbbvehicletype.SetFocus;
    exit;
  end;   }



  if cbbType.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择营运类型！');
    cbbType.SetFocus;
    exit;
  end;
  if edtrationseatnum.Text = '' then
  begin
    SysDialogs.ShowMessage('核定座位数不能为空！');
    edtrationseatnum.SetFocus;
    exit;
  end;
  if edtseatnum.Text = '' then
  begin
//    SysDialogs.ShowMessage('乘客座位数不能为空！');
    SysDialogs.ShowMessage('请先选择品牌型号！');
    nvhlpVehiclebrandmodel.SetFocus;
    exit;
  end;
 { if (NovaHCbBrand.Text<>'') and (NovaHCbBrand.Id>0)
    and (NovaHCbBrand.isactive)
    and (NovaHCbBrand.HelpFieldValue['rationseatnum']<>StrToInt(edtseatnum.Text))
    then
  begin
    SysDialogs.ShowMessage('乘客座位数与该厂牌的座位数不一致，请重新输入！');
    edtseatnum.SetFocus;
    exit;
  end; }


  cansave:= True;
  try
    if (strtofloat(edtseatnum.Text) > strtofloat(edtrationseatnum.Text)) then
    begin
      SysDialogs.ShowMessage('乘客坐位数不能大于核定坐位数！');
      cansave:= False;
      edtrationseatnum.SetFocus;
      exit;  //这里只是跳出 try 模块，
    end
    else
    cansave :=True;
  except
    on E: exception do
      SysLog.WriteErr('车辆信息保存失败：' + E.Message);
  end;
  if not cansave then
  begin
    Exit;   //所以这里要再跳出一次，才能真正跳出该方法。
  end;

  if cbbcolor.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择车牌颜色！');
    cbbcolor.SetFocus;
    exit;
  end;

  if vehicleseattype.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择座位类型！');
    vehicleseattype.SetFocus;
    exit;
  end;

  // 合同编号
  if dtpcontractstartdate.Enabled then
  begin
    if (formatdatetime('yyyymmdd', dtpcontractstartdate.Date) > formatdatetime
        ('yyyymmdd', dtpcontractenddate.Date)) then
    begin
      SysDialogs.ShowMessage('合同的有效开始日期不能大于结束日期！');
      dtpcontractstartdate.SetFocus;
      exit;
    end;
  end;
  // 责任险编号
  if dtpliabilityinsurestartdate.Enabled then
  begin
    if (formatdatetime('yyyymmdd',
        dtpliabilityinsurestartdate.Date) > formatdatetime('yyyymmdd',
        dtpliabilityinsureenddate.Date)) then
    begin
      SysDialogs.ShowMessage('责任险的有效开始日期不能大于结束日期！');
      dtpliabilityinsurestartdate.SetFocus;
      exit;
    end;
  end;

  // 营运证编号
  if dtpcompulsoryinsurestartdate.Enabled then
  begin
    if (formatdatetime('yyyymmdd',
        dtpcompulsoryinsurestartdate.Date) > formatdatetime('yyyymmdd',
        dtpcompulsoryinsureenddate.Date)) then
    begin
      SysDialogs.ShowMessage('交强险的有效开始日期不能大于结束日期！');
      dtpcompulsoryinsurestartdate.SetFocus;
      exit;
    end;
  end;
  if dtplicensestartdate.Enabled then
  begin
    if (formatdatetime('yyyymmdd', dtplicensestartdate.Date) > formatdatetime
        ('yyyymmdd', dtplicenseenddate.Date)) then
    begin
      SysDialogs.ShowMessage('车辆行驶证的有效开始日期不能大于结束日期！');
      dtplicensestartdate.SetFocus;
      exit;
    end;
  end;
  if dtpworkstartdate.Enabled then
  begin
    if (formatdatetime('yyyymmdd', dtpworkstartdate.Date) > formatdatetime
        ('yyyymmdd', dtpworkenddate.Date)) then
    begin
      SysDialogs.ShowMessage('营运证的有效开始日期不能大于结束日期！');
      dtpworkstartdate.SetFocus;
      exit;
    end;
  end;

  with jsonCDSVehicleSave do
    try
      begin
        active := false;
        Params.ParamByName('vehicle.istempvehicle').Value:=chkTempVehicle.Checked;
        Params.ParamByName('vehicle.id').Value := id;
        Params.ParamByName('vehicle.vehicleno').Value := edtvehicleno.Text;
        if dtpvehiclenotime.Checked then
          Params.ParamByName('vehicle.vehiclenodate').Value :=FormatDateTime('yyyy-mm-dd',dtpvehiclenotime.Date)
        else
          Params.ParamByName('vehicle.vehiclenodate').Value := null ;
        if dtpMakeDate.Checked then
          Params.ParamByName('vehicle.makedate').Value := FormatDateTime('yyyy-mm-dd',dtpMakeDate.Date)
        else
          Params.ParamByName('vehicle.makedate').Value := null ;
        Params.ParamByName('vehicle.entercardno').Value := NovaEdtEnterNo.Text ;
        Params.ParamByName('vehicle.orgid').Value :=
          Sysinfo.LoginUserInfo.orgid;
        Params.ParamByName('vehicle.type').Value := cbbType.GetSelectCode;
        Params.ParamByName('vehicle.status').Value := cbbstatus.GetSelectCode;
        Params.ParamByName('vehicle.color').Value := cbbcolor.GetSelectCode;
        Params.ParamByName('vehicle.cardno').Value := edtcardno.Text;
        if trim(edtcardno.Text) <> '' then
          Params.ParamByName('vehicle.grantdate').Value := grantdate;
        Params.ParamByName('vehicle.createby').Value := createby;
        Params.ParamByName('vehicle.createtime').Value := createtime;
        if printdate<>'' then
           Params.ParamByName('vehicle.cardnoprintdate').Value := printdate;
        Params.ParamByName('vehicle.rationseatnum').Value :=
          edtrationseatnum.Text;
        Params.ParamByName('vehicle.seatnum').Value := edtseatnum.Text;
        if  edtloadamout.Text='' then
            Params.ParamByName('vehicle.loadamout').Value :=null
        else
            Params.ParamByName('vehicle.loadamout').Value := edtloadamout.Text;

        Params.ParamByName('vehicle.contactperson').Value :=
          edtcontactperson.Text;
        Params.ParamByName('vehicle.contactphone').Value :=
          edtcontactphone.Text;
        // 合同编号
        if (trim(edtcontractno.Text) <> '') then
        begin
          Params.ParamByName('vehicle.contractno').Value := edtcontractno.Text;
          Params.ParamByName('vehicle.contractstartdate').Value :=
            formatdatetime('yyyy-mm-dd', dtpcontractstartdate.Date);
          Params.ParamByName('vehicle.contractenddate').Value := formatdatetime
            ('yyyy-mm-dd', dtpcontractenddate.Date);
        end;
        // 责任险编号
        if (trim(edtliabilityinsureno.Text) <> '') then
        begin
          Params.ParamByName('vehicle.liabilityinsureno').Value :=
            edtliabilityinsureno.Text;
          Params.ParamByName('vehicle.liabilityinsurestartdate').Value :=
            formatdatetime('yyyy-mm-dd', dtpliabilityinsurestartdate.Date);
          Params.ParamByName('vehicle.liabilityinsureenddate').Value :=
            formatdatetime('yyyy-mm-dd', dtpliabilityinsureenddate.Date);
        end;
        // 营运证编号
        if (trim(edtworkno.Text) <> '') then
        begin
          Params.ParamByName('vehicle.workno').Value := edtworkno.Text;
          Params.ParamByName('vehicle.workstartdate').Value := formatdatetime
            ('yyyy-mm-dd', dtpworkstartdate.Date);
          Params.ParamByName('vehicle.workenddate').Value := formatdatetime
            ('yyyy-mm-dd', dtpworkenddate.Date);
        end;

        // 交强险
        if (trim(edtcompulsoryinsureno.Text) <> '') then
        begin
          Params.ParamByName('vehicle.compulsoryinsureno').Value :=
            edtcompulsoryinsureno.Text;
          Params.ParamByName('vehicle.compulsoryinsurestartdate').Value :=
            formatdatetime('yyyy-mm-dd', dtpcompulsoryinsurestartdate.Date);
          Params.ParamByName('vehicle.compulsoryinsureenddate').Value :=
            formatdatetime('yyyy-mm-dd', dtpcompulsoryinsureenddate.Date);
        end;
        // 车辆行驶证有效期
        if (trim(NovaEdtdriverlicense.Text) <> '') then
        begin
          Params.ParamByName('vehicle.driverlicense').Value :=
            NovaEdtdriverlicense.Text;
          Params.ParamByName('vehicle.licensestartdate').Value := formatdatetime
            ('yyyy-mm-dd', dtplicensestartdate.Date);
          Params.ParamByName('vehicle.licenseenddate').Value := formatdatetime
            ('yyyy-mm-dd', dtplicenseenddate.Date);
        end;
        Params.ParamByName('vehicle.remarks').Value := mmoremarks.Text;
        Params.ParamByName('vehicle.roadno').Value := NovaEdtroadno.Text;
        //增加二维证件号
        Params.ParamByName('vehicle.twodimensionno').Value := edttwono.Text;
        if Dpmaintainvaliddate.Checked then
          Params.ParamByName('vehicle.maintainvaliddate').Value :=  formatdatetime
            ('yyyy-mm-dd', Dpmaintainvaliddate.Date)
        else
          Params.ParamByName('vehicle.maintainvaliddate').Value :=null;
        if trim(NEdtNextmaintaindistance.Text)='' then
          Params.ParamByName('vehicle.nextmaintaindistance').Value :='0'
        else
          Params.ParamByName('vehicle.nextmaintaindistance').Value := NEdtNextmaintaindistance.Text;
        Params.ParamByName('vehicle.gprs').Value := edtgprs.Text;
        Params.ParamByName('vehicle.seattype').Value := vehicleseattype.GetSelectCode; //座位类型  李电志 2015年7月27日 15:19:23
        //Params.ParamByName('vehicle.vehicletypeid').Value :=
         // cbbvehicletype.HelpFieldValue['id'];

        Params.ParamByName('vehicle.unitid').Value := NovaHelpUnit.id;
        Params.ParamByName('vehicle.balanceunitid').Value := NovaHelpBalanceUnit.id;
        Params.ParamByName('vehicle.auditroute').Value := NovaEdtAuditroute.text;

        Params.ParamByName('vehicle.vehiclebrandmodelid').Value :=nvhlpVehiclebrandmodel.id;

        if Trim(edtcardno.Text)<>'' then
        begin
          Params.ParamByName('validdate').Value := FormatDateTime('yyyy-mm-dd', dtpCardValidate.Date);
        end;
        Params.ParamByName('vehicle.isaudited').Value := isaudited;
        Params.ParamByName('vehicle.isauditpass').Value := isauditpass;
        Params.ParamByName('vehicle.isactive').Value := true;
        Params.ParamByName('synccode').Value := synccode;
        Params.ParamByName('vehicle.islocaldelete').Value := false;
        if Trim(NovaEdtmargin.Text)<>'' then
          Params.ParamByName('vehicle.margin').Value := Trim(NovaEdtmargin.Text);

        if Trim(NovaEdtotherfee.Text)<>'' then
          Params.ParamByName('vehicle.otherfee').Value := Trim(NovaEdtotherfee.Text);
        if Trim(NovaEdtstopfee.Text)<>'' then
          Params.ParamByName('vehicle.stopfee').Value := Trim(NovaEdtstopfee.Text);
        if Trim(NovaEdtcheckfee.Text)<>'' then
          Params.ParamByName('vehicle.checkfee').Value := Trim(NovaEdtcheckfee.Text);
        if Cbxisneed.Checked then
        begin
          Params.ParamByName('vehicle.isneedfinger').Value := true;
        end
        else
        begin
          Params.ParamByName('vehicle.isneedfinger').Value := false;
        end;
         //是否需要证件核查才允许报班0：不需要 ； 1：需要
        if chkisneedcheck.Checked then
        begin
          Params.ParamByName('vehicle.isneedcheck').Value:=true;
        end
        else
        begin
          Params.ParamByName('vehicle.isneedcheck').Value:=false;
        end;
        Params.ParamByName('vehicle.islocaldelete').Value := false;
        if(NHelpRoute.Text<>'')
         and (NHelpRoute.Id>0) then
             Params.ParamByName('vehicle.route.id').Value := NHelpRoute.Id ;

        if (not(Img_Picture.Picture.Graphic = nil)) and
          (not Img_Picture.Picture.Graphic.Empty) then
        begin
          if not assigned(mem) then
          begin
            mem := TMemoryStream.Create;
          end
          else
            mem.Clear;
          // 转换为JPG格式
          jpg1 := TJpegImage.Create;
          jpg1.Assign(Img_Picture.Picture.Graphic);
          jpg1.SaveToStream(mem);
          jpg1.Free;
          { // 转为BMP格式
            bmp := Tbitmap.Create;
            bmp.Assign(Img_Picture.Picture.Graphic);
            bmp.SaveToStream(mem);
            bmp.Free; }

          if mem.Size > 1204000 then
          begin
            SysDialogs.Warning('图片大小不能超过1M');
            exit;
          end;
          Params.ParamByName('picture').Value := MemoryStreamToHexStr(mem);
        end;
        try
          Execute;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          if (nResult <= 0) then
          begin
            SysDialogs.Warning(sResult);
            if (Pos('车牌号码',sResult)>0)
            and (edtvehicleno.Enabled) then
              edtvehicleno.SetFocus;
            if (Pos('座位数不一致',sResult)>0) then
              edtseatnum.SetFocus;
              Exit;
          end
          else
          begin
            SysDialogs.ShowMessage(sResult);
            id := Params.ParamByName('vehicleid').Value;
            ModalResult := mrok;
          end;
        except
          on E: exception do
          begin
            SysLog.WriteErr('车辆信息失败：' + E.Message);
          end;
        end;
      end;
    finally

    end;

end;

procedure TFrmVehicleEdit.btn1Click(Sender: TObject);
begin
  inherited;
  if dlgOpenPic1.Execute then
  begin
    Img_Picture.Picture.Assign(nil);
    Img_Picture.Picture.LoadFromFile(dlgOpenPic1.FileName);
    Img_Picture.Repaint;
  end;
end;

procedure TFrmVehicleEdit.btn2Click(Sender: TObject);
begin
  inherited;
  Img_Picture.Picture.Assign(nil);
end;

procedure TFrmVehicleEdit.btnReadCardClick(Sender: TObject);
begin
  inherited;
  edtcardno.Clear;
end;

procedure TFrmVehicleEdit.edtcardnoChange(Sender: TObject);
begin
  inherited;

    if Trim(edtcardno.Text)<>'' then
      dtpCardValidate.Checked:=true
    else
      dtpCardValidate.Checked:=false;

end;

procedure TFrmVehicleEdit.edtcardnoEnter(Sender: TObject);
begin
  inherited;
 { if Assigned(SysInfo.cardManage) then
  begin
    SysInfo.cardManage.ReadCardNo(edtcardno);
    SysInfo.cardManage.StartRead;
  end; }
end;

procedure TFrmVehicleEdit.edtcompulsoryinsurenoChange(Sender: TObject);
begin
  inherited;
  if (trim(edtcompulsoryinsureno.Text) <> '') then
  begin
    dtpcompulsoryinsurestartdate.Enabled := true;
    dtpcompulsoryinsureenddate.Enabled := true;
  end
  else
  begin
    dtpcompulsoryinsurestartdate.Enabled := false;
    dtpcompulsoryinsureenddate.Enabled := false;
  end;
end;

procedure TFrmVehicleEdit.edtcontractnoChange(Sender: TObject);
begin
  inherited;
  if (trim(edtcontractno.Text) <> '') then
  begin
    dtpcontractstartdate.Enabled := true;
    dtpcontractenddate.Enabled := true;
  end
  else
  begin
    dtpcontractstartdate.Enabled := false;
    dtpcontractenddate.Enabled := false;
  end;
end;

procedure TFrmVehicleEdit.edtliabilityinsurenoChange(Sender: TObject);
begin
  inherited;
  if (trim(edtliabilityinsureno.Text) <> '') then
  begin
    dtpliabilityinsurestartdate.Enabled := true;
    dtpliabilityinsureenddate.Enabled := true;
  end
  else
  begin
    dtpliabilityinsurestartdate.Enabled := false;
    dtpliabilityinsureenddate.Enabled := false;
  end;
end;

procedure TFrmVehicleEdit.NovaEdtroadnoChange(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmVehicleEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
   try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmVehicleEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbstatus.Active := False;
  cbbstatus.Active := True;
  cbbType.active := false;
  cbbType.active := true;
  cbbcolor.active := false;
  cbbcolor.active := true;
  vehicleseattype.active := false;
  vehicleseattype.active := true;
  //cbbvehicletype.active := false;
  //cbbvehicletype.active := true;
  dtpCardValidate.Date:=now;
  dtpCardValidate.Checked:=false;
 {  if not Assigned(SysInfo.CardManage) then
  begin
    SysInfo.CardManage := TCardManage.Create(nil);
    SysInfo.CardManage.CardType := TCardType.All;
    SysInfo.CardManage.CardLength:=SysInfo.curBillLength.Items['Vehicle'];
    SysInfo.CardManage.SetConfig(2, 1, '111ffffffff');
  end
  else
  begin
    SysInfo.CardManage.CardLength:=SysInfo.curBillLength.Items['Vehicle'];
    SysInfo.CardManage.StopRead;
  end;  }
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

procedure TFrmVehicleEdit.FormDeactivate(Sender: TObject);
begin
  inherited;
  if Assigned(sysInfo.CardManage) then
  begin
    sysInfo.CardManage.StopRead;
  end;
end;

procedure TFrmVehicleEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmVehicleEdit.FormShow(Sender: TObject);
var
  HexStr: wideString;
begin
  inherited;
  if edtcardno.Text <> '' then
  begin
    btnReadCard.Caption := '清除';
  end;
  if edittype = add then
  begin
    edtvehicleno.SetFocus;
  end;
  if id > 0 then
  with jcdsQryPic do
  begin
    active := false;
    Params.ParamValues['vehicleid'] := id;
    active := true;
    if recordcount > 0 then
    begin
      HexStr := FieldByName('picture').AsString;
      if (HexStr <> '') then
        Img_Picture.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
    end;
  end;
  if isupdates then
  begin
    setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
    if FrmVehicle.AddVehicleInfo = false then
    begin
       edtvehicleno.Enabled := false;
       dtpvehiclenotime.Enabled := false;
       chkTempVehicle.Enabled := false;
       NovaHelpUnit.Enabled := false;
       NovaHelpBalanceUnit.Enabled := false;
       //cbbvehicletype.Enabled := false;
       nvhlpVehiclebrandmodel.Enabled := false;
       cbbstatus.Enabled := false;
       edtcardno.Enabled := false;
       btnReadCard.Enabled := false;
       dtpCardValidate.Enabled := false;
       cbbType.Enabled := false;
       NHelpRoute.Enabled := false;
       edtrationseatnum.Enabled := false;
       edtseatnum.Enabled := false;
       edtloadamout.Enabled := false;
       cbbcolor.Enabled := false;
       edtcontactperson.Enabled := false;
       edtcontactphone.Enabled := false;
       edtgprs.Enabled := false;
    end;
    if FrmVehicle.AddOtherInfo = false then
    begin
       edtcontractno.Enabled := false;
       dtpcontractstartdate.Enabled := false;
       dtpcontractenddate.Enabled := false;
       edtliabilityinsureno.Enabled := false;
       dtpliabilityinsurestartdate.Enabled := false;
       dtpliabilityinsureenddate.Enabled := false;
       edtcompulsoryinsureno.Enabled := false;
       dtpcompulsoryinsurestartdate.Enabled := false;
       dtpcompulsoryinsureenddate.Enabled := false;
       NovaEdtdriverlicense.Enabled := false;
       dtplicensestartdate.Enabled := false;
       dtplicenseenddate.Enabled := false;
       edtworkno.Enabled := false;
       dtpworkstartdate.Enabled := false;
       dtpworkenddate.Enabled := false;
       NovaEdtroadno.Enabled := false;
       Dpmaintainvaliddate.Enabled := false;
       NEdtNextmaintaindistance.Enabled := false;
       NovaEdtmargin.Enabled := false;
       NovaEdtstopfee.Enabled := false;
       NovaEdtEnterNo.Enabled := false;
       NovaEdtcheckfee.Enabled := false;
       NovaEdtotherfee.Enabled := false;
       dtpMakeDate.Enabled := false;
    end;
  end;
end;


procedure TFrmVehicleEdit.iccardfound(icCard: TBaseCard);
begin
  edtcardno.Text:= icCard.cardNo;
  baseCard := icCard;
end;

procedure TFrmVehicleEdit.NovaEdtdriverlicenseChange(Sender: TObject);
begin
  inherited;
  if (trim(NovaEdtdriverlicense.Text) <> '') then
  begin
    dtplicensestartdate.Enabled := true;
    dtplicenseenddate.Enabled := true;
  end
  else
  begin
    dtplicensestartdate.Enabled := false;
    dtplicenseenddate.Enabled := false;
  end;
end;

procedure TFrmVehicleEdit.nvhlpVehiclebrandmodelIdChange(Sender: TObject);
begin
  inherited;
  if nvhlpVehiclebrandmodel.isactive and (nvhlpVehiclebrandmodel.id>=0) then
  begin
    edtseatnum.Text:= nvhlpVehiclebrandmodel.HelpFieldValue['rationseatnum'];
  end;
end;

procedure TFrmVehicleEdit.edtvehiclenoChange(Sender: TObject);
begin
  inherited;
    if Length(edtvehicleno.Text) < 2 then
    begin
      //edtvehicleno.SetFocus;
      edtvehicleno.HelpOptions.HelpHeight := 200;
    end else
    begin
      edtvehicleno.HelpOptions.HelpHeight := 0;
//      nvhlpvehiclecode.HelpOptions.HelpType := '';
//      nvhlpvehiclecode.HelpOptions.HQueryAddress := '';
//      nvhlpvehiclecode.HelpOptions.HDataSourceName := '';
    end;
end;

procedure TFrmVehicleEdit.edtvehiclenoExit(Sender: TObject);
begin
  inherited;
  if Length(edtvehicleno.Text) < 2 then
  begin
    edtvehicleno.SetFocus;
    edtvehicleno.SelStart := Length(edtvehicleno.Text);
    edtvehicleno.SelLength := length(edtvehicleno.Text);
  end;

end;

procedure TFrmVehicleEdit.edtworknoChange(Sender: TObject);
begin
  inherited;
  if (trim(edtworkno.Text) <> '') then
  begin
    dtpworkstartdate.Enabled := true;
    dtpworkenddate.Enabled := true;
  end
  else
  begin
    dtpworkstartdate.Enabled := false;
    dtpworkenddate.Enabled := false;
  end;
end;

end.
