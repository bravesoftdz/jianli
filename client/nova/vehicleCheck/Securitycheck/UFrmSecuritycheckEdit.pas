unit UFrmSecuritycheckEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaCheckedComboBox,
  NovaEdit, ComCtrls, NovaComboBox, DB, DBClient, jsonClientDataSet, NovaHelp,
  ImgList, NovaPrint, Generics.Collections, UICcardRW, DateUtils,OleCtrls,
  ZKFPEngXControl_TLB;

type
  TFrmSecuritycheckEdit = class(TSimpleEditForm, IBaseCardfound)
    Label22: TLabel;
    Shape1: TShape;
    Lbnvhelpvehicleno: TLabel;
    Labenvedtunitname: TLabel;
    Label5: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    Label9: TLabel;
    Shape5: TShape;
    Label23: TLabel;
    Shape6: TShape;
    Shape7: TShape;
    Label24: TLabel;
    Labelnvedtvehicletype: TLabel;
    Label27: TLabel;
    Labelnvhelpcheckname: TLabel;
    Label13: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label42: TLabel;
    light: TCheckBox;
    mirror: TCheckBox;
    drive: TCheckBox;
    brake: TCheckBox;
    turn: TCheckBox;
    wheel: TCheckBox;
    hang: TCheckBox;
    safety: TCheckBox;
    nvccblight: TNovaCheckedComboBox;
    nvcbbmirror: TNovaCheckedComboBox;
    nvcbbdrive: TNovaCheckedComboBox;
    nvcbbbrake: TNovaCheckedComboBox;
    nvcbbturn: TNovaCheckedComboBox;
    nvcbbwheel: TNovaCheckedComboBox;
    nvcbbhang: TNovaCheckedComboBox;
    nvcbbsafety: TNovaCheckedComboBox;
    nvedtunitname: TNovaEdit;
    nvedtvehicletype: TNovaEdit;
    jsonCDSCheckSave: TjsonClientDataSet;
    nvhelpcheckname: TNovaHelp;
    allcheck: TCheckBox;
    jsonVehicleResult: TjsonClientDataSet;
    jsonVehicleResultid: TLargeintField;
    jsonVehicleResultunitname: TWideStringField;
    jsonVehicleResultvehicletypename: TWideStringField;
    dsVehicleResult: TDataSource;
    jcdsSecurityVehicle: TjsonClientDataSet;
    dsSecurityResult: TDataSource;
    Label1: TLabel;
    lbl1: TLabel;
    cbbperiodtype: TNovaComboBox;
    Label7: TLabel;
    lblLabedriver :TLabel;
    edtcard: TNovaEdit;
    nvhelpvehicleno: TNovaHelp;
    wdstrngfldVehicleResultcardno: TWideStringField;
    wdstrngfldVehicleResultvehicleno: TWideStringField;
    jcdsChickinfo: TjsonClientDataSet;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    shp1: TShape;
    Shape8: TShape;
    Shape3: TShape;
    Label17: TLabel;
    Label41: TLabel;
    Shape4: TShape;
    window: TCheckBox;
    nvcbbwindow: TNovaCheckedComboBox;
    leak: TCheckBox;
    nvcbbleak: TNovaCheckedComboBox;
    chkcamera: TCheckBox;
    nvcbbcamera: TNovaCheckedComboBox;
    chkreturncheck: TCheckBox;
    nvcbbreturncheck: TNovaCheckedComboBox;
    Label4: TLabel;
    Label11: TLabel;
    mmoremarks: TMemo;
    jcdsVehicledistance: TjsonClientDataSet;
    EdtUserCard: TEdit;
    jscdqrycheckinfobycard: TjsonClientDataSet;
    jsonShowValidate: TjsonClientDataSet;
    Label14: TLabel;
    NvedtNO: TNovaEdit;
    Label16: TLabel;
    Label12: TLabel;
    Label19: TLabel;
    Label3: TLabel;
    Label21: TLabel;
    ChkIsnextday: TCheckBox;
    lblrechecktime: TLabel;
    dtprechecktime: TDateTimePicker;
    ncbbresult: TNovaComboBox;
    lblresult: TLabel;
    Label6: TLabel;
    Label18: TLabel;
    Label25: TLabel;
    nvedtroadno: TNovaEdit;
    nvedtliabilityinsureno: TNovaEdit;
    Label26: TLabel;
    nvedtdriverlicense: TNovaEdit;
    jcdsvaliateCardOverDue: TjsonClientDataSet;
    lrgntfld1: TLargeintField;
    wdstrngfld1: TWideStringField;
    wdstrngfld2: TWideStringField;
    wdstrngfld3: TWideStringField;
    wdstrngfld4: TWideStringField;
    lbl3: TLabel;
    nvhlpdriver: TNovaHelp;
    jcdsoutdateShowValidate: TjsonClientDataSet;
    lbl7: TLabel;
    edtsecurityfee: TEdit;
    LabInfo: TLabel;
    jsonSpcQry: TjsonClientDataSet;
    nvedtroutename: TNovaHelp;

    jsnclntdtstSpcQry: TjsonClientDataSet;
    jsonClientQryDriverName: TjsonClientDataSet;
    jsnclvehiclenobydriverQry: TjsonClientDataSet;

    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lightClick(Sender: TObject);
    procedure allcheckClick(Sender: TObject);
    procedure mirrorClick(Sender: TObject);
    procedure driveClick(Sender: TObject);
    procedure brakeClick(Sender: TObject);
    procedure turnClick(Sender: TObject);
    procedure wheelClick(Sender: TObject);
    procedure hangClick(Sender: TObject);
    procedure leakClick(Sender: TObject);
    procedure windowClick(Sender: TObject);
    procedure safetyClick(Sender: TObject);
    procedure nvccblightCheckClick(Sender: TObject);
    procedure nvcbbwindowCheckClick(Sender: TObject);
    procedure nvcbbsafetyCheckClick(Sender: TObject);
    procedure nvcbbleakCheckClick(Sender: TObject);
    procedure nvcbbhangCheckClick(Sender: TObject);
    procedure nvcbbwheelCheckClick(Sender: TObject);
    procedure nvcbbturnCheckClick(Sender: TObject);
    procedure nvcbbbrakeCheckClick(Sender: TObject);
    procedure nvcbbdriveCheckClick(Sender: TObject);
    procedure nvcbbmirrorCheckClick(Sender: TObject);
    procedure checkall(Sender: TObject);
    procedure nvhelpvehiclenoIdChange(Sender: TObject);
    procedure edtcardChange(Sender: TObject);
    procedure chkcameraClick(Sender: TObject);
    procedure chkreturncheckClick(Sender: TObject);
    procedure nvcbbcameraCheckClick(Sender: TObject);
    procedure nvcbbreturncheckCheckClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtUserCardChange(Sender: TObject);
    procedure edtcardKeyPress(Sender: TObject; var Key: Char);
    procedure nvhlpdriverIdChange(Sender: TObject);
    procedure zkfpngx1Capture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure driver1Enter(Sender: TObject);
    procedure driver1Exit(Sender: TObject);

  private
    { Private declarations }
    zkfpngx1: TZKFPEngX;
    isusercard:boolean;
    checkprint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    uncheckprint: TNovaPrint;
    unprintValue: TDictionary<String, String>; // 输出单变量
    checktitle: TNovaPrint;
    titleValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    maintenance,drivername : string;
    sRegTemplate1: WideString;
    sRegTemplate:WideString;
    checkallflag,checklight,checkreturn,checkcamera,checkhang,checkbrake
    ,checkdrive,checkbleak,checkmirror,checksafety,checkturn,checkwheel,checkwindow:boolean;//用来判断勾选安检项目的普通项目为不合格时候全部合格项目变为不选中
    //curisfinger:boolean;
    procedure qryVehicleinfo(vehicleid: int64);
    // 根据车牌或者卡号，获取要安检的车辆信息
    procedure getScurityVehilce(cardNO: string; curvehicleid: int64);
    procedure printer(scurityedid: int64); // 打印
    procedure iccardfound(icCard: TBaseCard);
  public
    { Public declarations }
    id, vid, createby: LongWord;
    isprintcheck, isprinttitle, isall,ischeckplan,driverflag,initsuccess: boolean;
    driverid,vehicleid, checkid, checkerid,fpcHandle,driver1id: int64;
    createtime, maintainvaliddate: TDatetime;
    cardNO, checkercode, checker, distancemessage,info,param_2033: String;
    temp: Integer;
  end;

var
  FrmSecuritycheckEdit: TFrmSecuritycheckEdit;

implementation

uses Services, UDMPublic, PubFn;
{$R *.dfm}


procedure TFrmSecuritycheckEdit.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,
    SysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, SysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    SysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, SysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, SysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    SysInfo.curBillLength.Items['Unit']);

  checkallflag:=True;
  param_2033 := getParametervalue('2033', Sysinfo.LoginUserInfo.OrgID);
  if param_2033='1' then
  begin
      zkfpngx1:=TZKFPEngX.Create(self);
      fpcHandle := zkfpngx1.CreateFPCacheDB;
  end;
end;



procedure TFrmSecuritycheckEdit.checkall(Sender: TObject);
begin
  if ((light.Checked) and (mirror.Checked) and (drive.Checked) and
      (brake.Checked) and (turn.Checked) and (wheel.Checked) and
      (hang.Checked) and (leak.Checked) and (window.Checked) and
      (safety.Checked) and (chkcamera.Checked) and (chkreturncheck.Checked))
    then
  begin
    if (id > 0) then
    begin
      //复检合格
      ncbbresult.ItemIndex := 2;
    end
    else
    begin
      //合格
      ncbbresult.ItemIndex := 0;
    end;
    dtprechecktime.Visible:=false;
    lblrechecktime.Visible:=false;
  end
  else
  begin
    //不合格
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.chkcameraClick(Sender: TObject);
begin
  inherited;
  if (chkcamera.Checked) then
  begin
    nvcbbcamera.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkcamera:=true;
    nvcbbcamera.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.chkreturncheckClick(Sender: TObject);
begin
  inherited;
  if (chkreturncheck.Checked) then
  begin
    nvcbbreturncheck.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkreturn:=true;
    nvcbbreturncheck.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult,sResult1: string;
  multipleValue: TDictionary<String, String>;
begin
  inherited;
  maintenance:='';

  if not Assigned(multiplelist) then
        multiplelist := TList < TDictionary < String, String >> .Create
  else
        multiplelist.Clear;

  multipleValue := TDictionary<String, String>.Create;
  if ischeckplan then
  begin
    SysDialogs.ShowMessage('该车辆无安检计划，不允许安检！');
    nvhelpvehicleno.SetFocus;
    Exit;
  end;

  if Trim(nvhelpvehicleno.Text) = '' then
  begin
    SysDialogs.ShowMessage('请填写车辆信息！');
    nvhelpvehicleno.SetFocus;
    Exit;
  end;
  if Trim(cbbperiodtype.Text) = '' then
  begin
    SysDialogs.Warning('请填写安检周期类型！');
    cbbperiodtype.SetFocus;
    Exit;
  end;
  with jsonCDSCheckSave do
  begin
    Close;
    if (light.Checked) then
    begin
      Params.ParamByName('securitycheck.light').Value := '合格';
    end
    else
    begin
      if (Trim(nvccblight.Text) = '') then
      begin
        SysDialogs.Warning('请填写“外观”的信息');
        nvccblight.SetFocus;
        Exit;
      end
      else
      begin
        Params.ParamByName('securitycheck.light').Value := nvccblight.Text;
        maintenance := maintenance+ nvccblight.Text+'。'+#13;
        multipleValue.Add('needmaintenance',nvccblight.Text);
        multiplelist.Add(multipleValue);
      end;
    end;
    if (turn.Checked) then
    begin
      Params.ParamByName('securitycheck.turn').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.turn').Value := nvcbbturn.Text;
        maintenance := maintenance+ nvcbbturn.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbturn.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbturn.Text) = '') then
      begin
        SysDialogs.Warning('请填写“转向系”的信息');
        nvcbbturn.SetFocus;
        Exit;
      end;
    end;
    if (brake.Checked) then
    begin
      Params.ParamByName('securitycheck.brake').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.brake').Value := nvcbbbrake.Text;
        maintenance := maintenance+ nvcbbbrake.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbbrake.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbbrake.Text) = '') then
      begin
        SysDialogs.Warning('请填写“制动系”的信息');
        nvcbbbrake.SetFocus;
        Exit;
      end;
    end;
    if (drive.Checked) then
    begin
      Params.ParamByName('securitycheck.drive').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.drive').Value := nvcbbdrive.Text;
        maintenance := maintenance+ nvcbbdrive.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbdrive.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbdrive.Text) = '') then
      begin
        SysDialogs.Warning('请填写“传动系”的信息');
        nvcbbdrive.SetFocus;
        Exit;
      end;
    end;
    if (hang.Checked) then
    begin
      Params.ParamByName('securitycheck.hang').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.hang').Value := nvcbbhang.Text;
        maintenance := maintenance+ nvcbbhang.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbhang.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbhang.Text) = '') then
      begin
        SysDialogs.Warning('请填写“车架,悬架和车桥”的信息');
        nvcbbhang.SetFocus;
        Exit;
      end;
    end;

    if (wheel.Checked) then
    begin
      Params.ParamByName('securitycheck.wheel').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.wheel').Value := nvcbbwheel.Text;
        maintenance := maintenance+ nvcbbwheel.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbwheel.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbwheel.Text) = '') then
      begin
        SysDialogs.Warning('请填写“轮胎”的信息');
        nvcbbwheel.SetFocus;
        Exit;
      end;
    end;
    if (mirror.Checked) then
    begin
      Params.ParamByName('securitycheck.mirror').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.mirror').Value := nvcbbmirror.Text;
        maintenance := maintenance+ nvcbbmirror.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbmirror.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbmirror.Text) = '') then
      begin
        SysDialogs.Warning('请填写“照明、信号指示灯”的信息');
        nvcbbmirror.SetFocus;
        Exit;
      end;
    end;

    if (safety.Checked) then
    begin
      Params.ParamByName('securitycheck.safety').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.safety').Value := nvcbbsafety.Text;
        maintenance := maintenance+ nvcbbsafety.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbsafety.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbsafety.Text) = '') then
      begin
        SysDialogs.Warning('请填写“安全设施“的信息');
        nvcbbsafety.SetFocus;
        Exit;
      end;
    end;
    if (window.Checked) then
    begin
      Params.ParamByName('securitycheck.window').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.window').Value := nvcbbwindow.Text;
        maintenance := maintenance+ nvcbbwindow.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbwindow.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbwindow.Text) = '') then
      begin
        SysDialogs.Warning('请填写“其他部分”的信息');
        nvcbbwindow.SetFocus;
        Exit;
      end;
    end;
    if (leak.Checked) then
    begin
      Params.ParamByName('securitycheck.leak').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.leak').Value := nvcbbleak.Text;
        maintenance := maintenance+ nvcbbleak.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbleak.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbleak.Text) = '') then
      begin
        SysDialogs.Warning('请填写“证件”的信息');
        nvcbbleak.SetFocus;
        Exit;
      end;
    end;
    if (chkcamera.Checked) then
    begin
      Params.ParamByName('securitycheck.camera').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.camera').Value := nvcbbcamera.Text;
        maintenance := maintenance+ nvcbbcamera.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbcamera.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbcamera.Text) = '') then
      begin
        SysDialogs.Warning('请填写“摄像头”的信息');
        nvcbbcamera.SetFocus;
        Exit;
      end;
    end;
    if (chkreturncheck.Checked) then
    begin
      Params.ParamByName('securitycheck.returncheck').Value := '合格';
    end
    else
    begin
      Params.ParamByName('securitycheck.returncheck').Value :=
        nvcbbreturncheck.Text;
        maintenance := maintenance+ nvcbbreturncheck.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance',nvcbbreturncheck.Text);
        multiplelist.Add(multipleValue);
      if (Trim(nvcbbreturncheck.Text) = '') then
      begin
        SysDialogs.Warning('请填写“回程检查”的信息');
        nvcbbreturncheck.SetFocus;
        Exit;
      end;
    end;
    if cbbperiodtype.ItemIndex >= 0 then
    begin
      Params.ParamByName('securitycheck.periodtype').Value := TCommInfo
        (cbbperiodtype.Items.Objects[cbbperiodtype.ItemIndex]).Value;
    end;
    Params.ParamByName('securitycheck.result').Value := IntToStr
      (ncbbresult.ItemIndex);
    if ncbbresult.ItemIndex=1 then
    begin
        Params.ParamByName('securitycheck.rechecktime').Value := formatdatetime('yyyy-mm-dd', dtprechecktime.DateTime);
    end
    else
    begin
        Params.ParamByName('securitycheck.rechecktime').Value := '';
    end;
    // Params.ParamByName('securitycheck.id').Value := id;

    if vehicleid = 0 then
    begin
      SysDialogs.ShowMessage('请填写正确的车辆信息');
      nvhelpvehicleno.SetFocus;
      Exit;
    end;
    if (nvhelpcheckname.id = 0) or (nvhelpcheckname.Text = '') then
    begin
      SysDialogs.ShowMessage('请填写安检员信息');
     // nvhelpcheckname.SetFocus;
      Exit;
    end
    else if not(nvhelpcheckname.id = checkerid) then
    begin
      Params.ParamByName('securitycheck.checkby').Value := nvhelpcheckname.id;
    end
    else
    begin
      Params.ParamByName('securitycheck.checkby').Value := checkerid;
    end;
    //新增安检费
    Params.ParamByName('securitycheck.securityfee').Value := edtsecurityfee.Text;


    Params.ParamByName('securitycheck.vehicleid').Value := IntToStr(vehicleid);
    Params.ParamByName('securitycheck.createby').Value :=
      SysInfo.LoginUserInfo.UserID;
    Params.ParamByName('securitycheck.remarks').Value := mmoremarks.Text;
        maintenance := maintenance+'备注:'+ mmoremarks.Text+'。'+#13;
        multipleValue := TDictionary<String, String>.Create;
        multipleValue.Add('needmaintenance','备注:'+ mmoremarks.Text);
        multiplelist.Add(multipleValue);

    // 是否开启车辆里程限制
    if getParametervalue('0143', SysInfo.LoginUserInfo.OrgID) = '1' then
    begin
      // 查询车辆里程激活管理，取出发班里程数和限制的里程数
      with jcdsVehicledistance do
      begin
        Close;
        Params.ParamValues['vehicleid'] := vehicleid;
        Params.ParamValues['iscomparedate'] := 'false';
        Execute;
        nResult := Params.ParamByName('flag').Value;
        if (nResult <= 0) then
        begin
          sResult := Params.ParamByName('msg').Value;
          temp := Pos('该车辆还有', sResult);
          if temp > 0 then
            distancemessage := sResult
          else
          begin
            SysDialogs.Warning(sResult);
            Exit;
          end;
        end;
      end;
    end;
    // 是否开启车辆二期维护有效期
    if getParametervalue('6006', SysInfo.LoginUserInfo.OrgID) = '1' then
    begin
      // 查询车辆里程激活管理，取出二维有效期
      with jcdsVehicledistance do
      begin
        Close;
        Params.ParamValues['vehicleid'] := vehicleid;
        Params.ParamValues['iscomparedate'] := 'true';
        Execute;
        nResult := Params.ParamByName('flag').Value;
        if (nResult <= 0) then
        begin
          sResult := Params.ParamByName('msg').Value;
          temp := Pos('该车辆还有', sResult);
          if temp > 0 then
          begin
            if distancemessage <> '' then
            begin
              sResult := Copy(sResult, 4);
              distancemessage := distancemessage + ',' + sResult;
            end
            else
              distancemessage := sResult;
          end
          else
          begin
            SysDialogs.Warning(sResult);
            Exit;
          end;
        end;

      end;
    end;
    if distancemessage <> '' then
      SysDialogs.ShowInfo(distancemessage + ',达到二维期限！');
    //distancemessage := '';
     maintenance := maintenance+distancemessage+#13;

     // 是否进行证件判断
    if getParametervalue('6002', SysInfo.LoginUserInfo.OrgID) = '1' then
     begin
      //
      if leak.Checked then
      begin

        with jsonShowValidate do
        begin
          Close;
          Params.ParamValues['vehicleid'] := vehicleid;
          Params.ParamValues['orgid'] := SysInfo.LoginUserInfo.OrgID;
          Params.ParamValues['driverid']:= driverid;
          Execute;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          if nResult < 0 then
          begin

          SysDialogs.Warning(sResult);
          maintenance := maintenance+sResult+#13;
          Exit;
          end
          else
          begin
             sResult:='';
          end;
        end;
      end;
      if getParametervalue('6022', SysInfo.LoginUserInfo.OrgID) = '0' then
        begin
         with jcdsoutdateShowValidate do
         begin
           Close;
           Params.ParamValues['vehicleid'] := vehicleid;
           Params.ParamValues['orgid'] := SysInfo.LoginUserInfo.OrgID;
           Params.ParamValues['driverid']:= driverid;
           Execute;
           nResult := Params.ParamByName('flag').Value;
            if nResult < 0 then
            begin
              if sResult='' then
              begin
                sResult:='   证件名称                证件号              有效期            剩余天数'#13;
              end;
              sResult1 := Params.ParamByName('msg').Value;
              sResult:=sResult+sResult1;
              SysDialogs.Warning(sResult);
              maintenance := maintenance+sResult+#13;
              exit;
            end;
            end;
         end;
//      else
//          begin
//            SysDialogs.Warning(sResult);
//          end;


    end;

  //  新增四证过期提示信息，通过参数进行判断



    //是否安检明天车辆
    if ChkIsnextday.Checked then
    begin
      Params.ParamByName('ischeckenextday').Value := 'true';
    end
    else
    begin
       Params.ParamByName('ischeckenextday').Value := 'false';
    end;
    //线路id: routeid 李电志  2015年7月9日 11:15:36
    Params.ParamByName('routeid').Value := nvedtroutename.Id;
    //驾驶员id 李电志  2015年7月9日 11:15:43
    Params.ParamByName('securitycheck.driverid').Value := nvhlpdriver.Id;

   //驾驶员与车辆关联与否，0 不允许，1 为允许。默认为1，林东为0
   if getParametervalue('6027', SysInfo.LoginUserInfo.OrgID) = '0' then
    begin
     with jsnclvehiclenobydriverQry do
     begin
      // Close;
        Active := False;
        Params.ParamValues['driverid']:= driverid;
        Active := True;

      // Execute;

        if jsnclvehiclenobydriverQry.RecordCount > 0 then
        begin
             driver1id := jsnclvehiclenobydriverQry.FieldByName('vehicleid').AsLargeInt;
          if driver1id <> nvhelpvehicleno.id then
           begin
             SysDialogs.ShowMessage('驾驶员非本车辆驾驶员，安检不通过！');
             exit;
           end;

        end;
        end;
     end;



    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
//      if not isusercard then
 //       SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvccblight.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        try
           bbtnSave.Enabled:=False;
           printer(id); //打印
        finally
          bbtnSave.Enabled:=True;
          ModalResult := mrok;
        end;

      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车辆安检失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSecuritycheckEdit.printer(scurityedid: int64);
var
  checkername, checkcode,routename,endstation: string;

begin
  inherited;
  with jcdsChickinfo do
  begin
    Active := False;
    Params.ParamByName('checkid').Value := scurityedid;
    Active := True;
    if jcdsChickinfo.RecordCount > 0 then
    begin
      if Self.isprintcheck then
      begin
        //合格，复检合格打印
        if (ncbbresult.ItemIndex = 0) or (ncbbresult.ItemIndex = 2) then
        begin
            if not Assigned(checkprint) then
              checkprint := TNovaPrint.Create(Self,
                TNovaPrint.GetTicketModelName('安检合格通知单', '安检合格通知单'));
            if not Assigned(printValue) then
              printValue := TDictionary<String, String>.Create
            else
              printValue.Clear;
            printValue.Add('checkorg', FieldByName('checkorg').AsString);
            printValue.Add('checker', FieldByName('checker').AsString);
            printValue.Add('checkercode', FieldByName('checkercode').AsString);
            printValue.Add('checktime', FieldByName('checktime').AsString);
            printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
            printValue.Add('color', FieldByName('color').AsString);
            printValue.Add('notenum', FieldByName('notenum').AsString);
            printValue.Add('routename', FieldByName('routename').AsString);
            routename := FieldByName('routename').AsString;
            endstation := copy(routename,pos('-',routename)+1,Length(routename));
            printValue.Add('endstation',endstation);
            printValue.Add('idcard', FieldByName('idcard').AsString);
            //新增数据源，营运证好，驾驶证
            printValue.Add('workno', FieldByName('workno').AsString);
            printValue.Add('driverlicense', FieldByName('driverlicense').AsString);


            printValue.Add('vehicletypename',
                     jcdsSecurityVehicle.FieldByName('vehicletypename').Value);
            // 如果二维有效期及里程有开启限制，且有内容需要提醒，则添加打印
            if distancemessage <> '' then
              printValue.Add('maintainmessage', distancemessage + '达到二维期限！');
                    checkprint.SingleValue := printValue;
                    checkprint.Print;
         end
         else
         begin
         // 6012 是否打印安检不合格通知单：1打印，0不打印
           if getParametervalue('6012', SysInfo.LoginUserInfo.OrgID) = '1' then
           begin
               if not Assigned(uncheckprint) then
                  uncheckprint := TNovaPrint.Create(Self,
                          TNovaPrint.GetTicketModelName('安检不合格通知单', '安检不合格通知单'));
               if not Assigned(unprintValue) then
                          unprintValue := TDictionary<String, String>.Create
               else
                  unprintValue.Clear;
              unprintValue.Add('checkorg', FieldByName('checkorg').AsString);
              unprintValue.Add('checker', FieldByName('checker').AsString);
              unprintValue.Add('checkercode', FieldByName('checkercode').AsString);
              unprintValue.Add('checktime', FieldByName('checktime').AsString);
              unprintValue.Add('vehicleno', FieldByName('vehicleno').AsString);
              unprintValue.Add('notenum', FieldByName('notenum').AsString);
              unprintValue.Add('drivername', drivername);
              unprintValue.Add('routename', FieldByName('routename').AsString);
              routename := FieldByName('routename').AsString;
              endstation := copy(routename,pos('-',routename)+1,Length(routename));
              unprintValue.Add('endstation',endstation);
              unprintValue.Add('idcard', FieldByName('idcard').AsString);
              unprintValue.Add('rechecktime', FieldByName('rechecktime').AsString);
              uncheckprint.SingleValue := unprintValue;
              uncheckprint.MultipleValue := multiplelist;
              uncheckprint.Print;
           end;
         end;
      end;
      if Self.isprinttitle then
      begin
        if not Assigned(checktitle) then
          checktitle := TNovaPrint.Create(Self,
            TNovaPrint.GetTicketModelName('安检合格标签', '安检合格标签'));
        if not Assigned(titleValue) then
          titleValue := TDictionary<String, String>.Create
        else
          titleValue.Clear;
        titleValue.Add('checkorg', FieldByName('checkorg').AsString);
        titleValue.Add('checker', FieldByName('checker').AsString);
        titleValue.Add('checkercode', FieldByName('checkercode').AsString);
        titleValue.Add('checktime', FieldByName('checktime').AsString);
        titleValue.Add('vehicleno', FieldByName('vehicleno').AsString);
        titleValue.Add('color', FieldByName('color').AsString);
        titleValue.Add('idcard', FieldByName('idcard').AsString);
        titleValue.Add('notenum', FieldByName('notenum').AsString);
        titleValue.Add('routename', FieldByName('routename').AsString);
        checktitle.SingleValue := titleValue;
        checktitle.Print;
      end;

      { if not Assigned(checkprint) then
        checkprint := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('安检合格通知单', '安检合格通知单'));
        if not Assigned(printValue) then
        printValue := TDictionary<String, String>.Create
        else
        printValue.Clear;

        printValue.Add('checkorg', FieldByName('checkorg').AsString);
        printValue.Add('checker', FieldByName('checker').AsString);
        printValue.Add('checkercode', FieldByName('checkercode').AsString);
        printValue.Add('checktime', FieldByName('checktime').AsString);
        printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
        printValue.Add('color', FieldByName('color').AsString);
        printValue.Add('notenum', FieldByName('notenum').AsString);
        printValue.Add('routename', FieldByName('routename').AsString); }
    end;
  end;
end;

procedure TFrmSecuritycheckEdit.FormShow(Sender: TObject);
var
  sTemp:WideString;
begin
 // inherited;

 jsnclntdtstSpcQry.Active := False;
  jsnclntdtstSpcQry.Active := True;
if param_2033='1' then
   begin
      if zkfpngx1.InitEngine = 0 then
      begin
       // mmoReportInfo.Lines.Insert(0, '指纹设备初始化成功！');
       lblLabedriver.Caption :='指纹设备初始化成功！' ;
        initsuccess:=true;


        with jsnclntdtstSpcQry do
        begin
           if active then
           begin
             first;
             while(not eof) do
             begin
               sTemp:= FieldByName('fingerstr').AsString;
               SysLog.WriteErr('sTemp='+sTemp);
               id:=FieldByName('id').AsInteger;
               try
                  zkfpngx1.AddRegTemplateStrToFPCacheDB(fpcHandle,id,sTemp);
               except
                  SysLog.WriteErr('id='+inttostr(id)+'指纹注册失败！');
               end;
               next;
             end;
           end;
        end ;

        zkfpngx1.BeginCapture;
        zkfpngx1.EnrollCount:=1;
        if zkfpngx1.IsRegister then zkfpngx1.CancelEnroll;
        zkfpngx1.SetAutoIdentifyPara(true, fpcHandle, 8);
      end
      else
      begin
       //  mmoReportInfo.Lines.Insert(0, '指纹设备初始化失败！');
        lblLabedriver.Caption :='指纹设备初始化失败!' ;
         initsuccess:=false;

      end;
   end;
   driverflag :=false;
  isusercard:=false;
  //6009 安检时，安检员是否允许修改
  if getParametervalue('6009', SysInfo.LoginUserInfo.OrgID) = '0' then
  begin
    nvhelpcheckname.Enabled := False;
    nvhelpcheckname.Text:=sysInfo.LoginUserInfo.UserName;
    nvhelpcheckname.id:=sysInfo.LoginUserInfo.UserID;
  end
  else
  begin
    nvhelpcheckname.Enabled := true;;
    nvhelpcheckname.Text:=sysInfo.LoginUserInfo.UserName;
    nvhelpcheckname.id:=sysInfo.LoginUserInfo.UserID;
  end;
  //6016 是否必须刷安检员卡
  if getParametervalue('6016', SysInfo.LoginUserInfo.OrgID) = '1' then
  begin
    isusercard:=true;
    nvhelpcheckname.Enabled := False;
    nvhelpcheckname.Text:='';
    nvhelpcheckname.id:=0;
  end;

  nvccblight.Active := False;
  nvccblight.Active := True;

  nvcbbmirror.Active := False;
  nvcbbmirror.Active := True;

  nvcbbdrive.Active := False;
  nvcbbdrive.Active := True;

  nvcbbbrake.Active := False;
  nvcbbbrake.Active := True;

  nvcbbturn.Active := False;
  nvcbbturn.Active := True;

  nvcbbwheel.Active := False;
  nvcbbwheel.Active := True;

  nvcbbhang.Active := False;
  nvcbbhang.Active := True;

  nvcbbleak.Active := False;
  nvcbbleak.Active := True;

  nvcbbwindow.Active := False;
  nvcbbwindow.Active := True;

  nvcbbsafety.Active := False;
  nvcbbsafety.Active := True;

  cbbperiodtype.Active := False;
  cbbperiodtype.Active := True;

  nvcbbcamera.Active := False;
  nvcbbcamera.Active := True;

  nvcbbreturncheck.Active := False;
  nvcbbreturncheck.Active := True;
  allcheck.Checked := True;
  cbbperiodtype.ItemIndex := 0;
  ncbbresult.ItemIndex := 0;
  ncbbresult.Enabled := false;
  if vehicleid > 0 then
  begin
    getScurityVehilce('', vehicleid);
    bbtnSave.SetFocus;
  end;
  if allcheck.Checked then
  isall := true;
  // cbbperiodtype.Items.Objects[cbbperiodtype]
  // allcheck.Checked:=true;
  { if not Assigned(SysInfo.cardManage) then
    begin
    SysInfo.cardManage:=TCardManage.Create(nil);
    SysInfo.CardManage.CardLength:=SysInfo.curBillLength.Items['Vehicle'];
    SysInfo.cardManage.CardType:=TCardType.All;
    SysInfo.cardManage.ReadCardNo(nvhelpcardno);
    SysInfo.cardManage.SetConfig(2,1,'111fffffffff');
    SysInfo.cardManage.StartRead;
    end
    else
    begin
    SysInfo.cardManage.StopRead;
    SysInfo.CardManage.CardLength:=SysInfo.curBillLength.Items['Vehicle'];
    SysInfo.cardManage.CardType:=TCardType.All;
    SysInfo.cardManage.ReadCardNo(nvhelpcardno);
    SysInfo.cardManage.StartRead;
    end; }
end;

procedure TFrmSecuritycheckEdit.edtcardChange(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  inherited;
//  if Length(edtcard.Text) = SysInfo.curBillLength.Items['Vehicle'] then
//  begin
//    nvhelpvehicleno.Text := '';
//    nvedtvehicletype.Text := '';
//    nvedtunitname.Text := '';
//    bbtnSave.SetFocus;
//    getScurityVehilce(edtcard.Text, 0);
//    Self.nvhelpvehiclenoIdChange(Sender);
//  end;
end;

procedure TFrmSecuritycheckEdit.edtcardKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    nvhelpvehicleno.Text := '';
    nvedtvehicletype.Text := '';
    nvedtunitname.Text := '';
    bbtnSave.SetFocus;
    getScurityVehilce(edtcard.Text, 0);
    Self.nvhelpvehiclenoIdChange(Sender);
  end;
end;

procedure TFrmSecuritycheckEdit.EdtUserCardChange(Sender: TObject);
begin
  inherited;
  if Length(EdtUserCard.Text) = SysInfo.curBillLength.Items['Userinfo'] then
  begin
    with jscdqrycheckinfobycard do
    begin
      Active := False;
      Params.ParamByName('cardno').Value := EdtUserCard.Text;
      Execute;
      if Params.ParamByName('userid').Value > 0 then
      begin
        nvhelpcheckname.id := Params.ParamByName('userid').Value;
        nvhelpcheckname.Text := Params.ParamByName('name').Value;
        EdtUserCard.Clear;
        isusercard:=true;
        bbtnSaveClick(sender);
      end;

    end;
  end;
end;

procedure TFrmSecuritycheckEdit.nvhelpvehiclenoIdChange(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
  curid: int64;
begin
  // inherited;
  if nvhelpvehicleno.id = 0 then
  begin
    Exit;
  end;
  edtcard.Text := '';
  nvedtvehicletype.Text := '';
  nvedtunitname.Text := '';
  bbtnSave.SetFocus;
  vehicleid:=nvhelpvehicleno.id;
  getScurityVehilce('', nvhelpvehicleno.id);
  // self.edtcardChange(Sender);
end;

procedure TFrmSecuritycheckEdit.nvhlpdriverIdChange(Sender: TObject);
begin
  inherited;
  driverid :=  nvhlpdriver.Id;
end;

procedure TFrmSecuritycheckEdit.getScurityVehilce(cardNO: string;
  curvehicleid: int64);
var
  flag: Integer;
  msg : string;
begin
  with jcdsSecurityVehicle do
  begin
    Active := False;
    Params.ParamByName('cardno').Value := cardNO;
    Params.ParamByName('vehicleid').Value := curvehicleid;
    Params.ParamByName('orgid').Value := SysInfo.LoginUserInfo.OrgID;
    Active := True;
    // if not dsVehicleResult.DataSet.Active then
    // exit;
    // if dsVehicleResult.DataSet.RecordCount >= 1 then
    // begin
    flag := Params.ParamValues['flag'];
    msg:= Params.ParamValues['msg'];
    if flag < 1 then
    begin
     // if flag=-2 then
     // begin
        SysDialogs.ShowMessage(msg);
        nvhelpvehicleno.SetFocus;
        ischeckplan := True;
        Exit;
      //end;
      {SysDialogs.ShowMessage('系统不存在对应车辆！');
      nvhelpvehicleno.SetFocus;
      Exit; }
    end;
    //安检计划校验
    if Pos('无安检计划',msg)>0 then
      ischeckplan := True
    else
      ischeckplan := False;

    if (not(jcdsSecurityVehicle.FieldByName('result').AsString = '')) and
      ((jcdsSecurityVehicle.FieldByName('result').Value = '0') or
        (jcdsSecurityVehicle.FieldByName('result').Value = '2')) then
    begin
      //  --安检时，是否进行安检有效期判断，0：不判断，1：要判断
      if  getParametervalue('6019', SysInfo.LoginUserInfo.OrgID) = '1' then
      begin
        //车辆安检有效时间类型：0:当日内有效，1:24小时内有效
        if (getParametervalue('6010', SysInfo.LoginUserInfo.OrgID) = '0') and (not ChkIsnextday.checked) then
        begin
          SysDialogs.ShowMessage('该车辆当天已安检合格，不需要再检') ;
          nvhelpvehicleno.Text := '';
          edtcard.Text := '';
          bbtnClose.SetFocus;
          Exit;
        end;
      end;
    end;
//      else
//      begin                   //24小时有效的，可以再次安检
//        SysDialogs.ShowMessage('该车辆24小时内已安检合格，不需要再检') ;
//      end;



    Self.vehicleid := jcdsSecurityVehicle.FieldByName('vehicleid').Value;
    if not(jcdsSecurityVehicle.FieldByName('Securitycheckid').AsString = '')
      then
    begin
      id := jcdsSecurityVehicle.FieldByName('Securitycheckid').Value;
      //如果已有安检合格的记录，则再次安检时，依然是安检合格
      if jcdsSecurityVehicle.FieldByName('result').Value = '0' then
         ncbbresult.ItemIndex := 0 // 合格
      else
         ncbbresult.ItemIndex := 2; // 复检合格
    end
    else
    begin
         ncbbresult.ItemIndex := 0; // 合格
         mmoremarks.Text:='';
    end;
    nvedtunitname.Text := jcdsSecurityVehicle.FieldByName('unitname').Value;
    nvedtvehicletype.Text := jcdsSecurityVehicle.FieldByName('vehicletypename')
      .Value;
    NvedtNO.Text := jcdsSecurityVehicle.FieldByName('workno').AsString;
    nvedtroadno.Text := jcdsSecurityVehicle.FieldByName('roadno').AsString;
    nvedtroutename.Text := jcdsSecurityVehicle.FieldByName('routename').AsString;
    nvedtliabilityinsureno.Text := jcdsSecurityVehicle.FieldByName('liabilityinsureno').AsString;
    nvedtdriverlicense.Text:=jcdsSecurityVehicle.FieldByName('driverlicense').AsString;
    drivername := jcdsSecurityVehicle.FieldByName('driver1name').AsString;
    nvhelpvehicleno.OnChange := nil;
    if not(jcdsSecurityVehicle.FieldByName('vehicleno').AsString = '') then
      nvhelpvehicleno.Text := jcdsSecurityVehicle.FieldByName('vehicleno')
        .Value;

    edtcard.OnChange := nil;
    if not(jcdsSecurityVehicle.FieldByName('cardno').AsString = '') then
      edtcard.Text := jcdsSecurityVehicle.FieldByName('cardno').Value;

    nvedtunitname.Text := jcdsSecurityVehicle.FieldByName('unitname').Value;

    if not(jcdsSecurityVehicle.FieldByName('remarks').AsString = '') then
      mmoremarks.Text := jcdsSecurityVehicle.FieldByName('remarks').Value;
    if not(jcdsSecurityVehicle.FieldByName('checkfee').AsString = '') then
      edtsecurityfee.Text := jcdsSecurityVehicle.FieldByName('checkfee').Value;

//    if not(jcdsSecurityVehicle.FieldByName('checker').AsString = '') then
//    begin
//      checker := jcdsSecurityVehicle.FieldByName('checker').Value;
//      checkerid := jcdsSecurityVehicle.FieldByName('checkerid').Value;
//      checkercode := jcdsSecurityVehicle.FieldByName('checkercode').Value;
//      nvhelpcheckname.Text := checker;
//      nvhelpcheckname.id := checkerid;
//    end
//    else
//    begin
//
//    end;

  end;
end;

procedure TFrmSecuritycheckEdit.qryVehicleinfo(vehicleid: int64);
begin
  with jsonVehicleResult do
  begin
    Active := False;
    Params.ParamByName('filter_EQL_v!id').Value := vehicleid;
    Params.ParamByName('filter_EQS_v!cardno').Value := null;
    Active := True;
  end;
  if not dsVehicleResult.DataSet.Active then
    Exit;
  if dsVehicleResult.DataSet.RecordCount >= 1 then
  begin
    Self.vehicleid := jsonVehicleResult.FieldByName('id').AsInteger;
    nvhelpvehicleno.Text := jsonVehicleResult.FieldByName('vehicleno').AsString;
    nvedtunitname.Text := jsonVehicleResult.FieldByName('unitname').AsString;
    nvedtvehicletype.Text := jsonVehicleResult.FieldByName('vehicletypename')
      .AsString;
    edtcard.Text := jsonVehicleResult.FieldByName('cardno').AsString;
  end;
end;

procedure TFrmSecuritycheckEdit.allcheckClick(Sender: TObject);
begin
  inherited;

  if allcheck.Checked   then
  begin
    checkallflag:=True;
    isall:=true;
    light.Checked := True;
    mirror.Checked := True;
    drive.Checked := True;
    brake.Checked := True;
    turn.Checked := True;
    wheel.Checked := True;
    hang.Checked := True;
    leak.Checked := True;
    window.Checked := True;
    safety.Checked := True;
    chkcamera.Checked := True;
    chkreturncheck.Checked := True;
    light.Enabled := True;
    mirror.Enabled := True;
    drive.Enabled := True;
    brake.Enabled := True;
    turn.Enabled := True;
    wheel.Enabled := True;
    hang.Enabled := True;
    leak.Enabled := True;
    window.Enabled := True;
    safety.Enabled := True;
    // if((light.Checked) and (mirror.Checked) and (drive.Checked) and (brake.Checked) and (turn.Checked) and
    // (wheel.Checked) and (hang.Checked) and (leak.Checked) and (window.Checked) and (safety.Checked))then
    // begin
    if (id = 0) then
    begin
      ncbbresult.ItemIndex := 0; // 合格
    end
    else
    begin
      ncbbresult.ItemIndex := 2; // 复检合格
    end;
    // end;
    nvccblight.checkall(False);
    nvcbbmirror.checkall(False);
    nvcbbdrive.checkall(False);
    nvcbbbrake.checkall(False);
    nvcbbturn.checkall(False);
    nvcbbwheel.checkall(False);
    nvcbbhang.checkall(False);
    nvcbbleak.checkall(False);
    nvcbbwindow.checkall(False);
    nvcbbsafety.checkall(False);
    nvcbbcamera.checkall(False);
    nvcbbreturncheck.checkall(False);
    dtprechecktime.Visible:=false;
    lblrechecktime.Visible:=false;
  end
   else if checklight then
      begin
        allcheck.Checked:=False;
      end
   else if checkreturn then
      begin
      allcheck.Checked:=False;
      end
     else if checkcamera then
      begin
      allcheck.Checked:=False;
      end
         else if checkbrake then
      begin
      allcheck.Checked:=False;
      end
         else if checkdrive then
      begin
      allcheck.Checked:=False;
      end
         else if checkbleak then
      begin
      allcheck.Checked:=False;
      end
         else if checkmirror then
      begin
      allcheck.Checked:=False;
      end
         else if checksafety then
      begin
      allcheck.Checked:=False;
      end
        else if checkturn then
      begin
      allcheck.Checked:=False;
      end
        else if checkwheel then
      begin
      allcheck.Checked:=False;
      end
        else if checkwindow then
      begin
      allcheck.Checked:=False;
      end
  else
     begin
          allcheck.Checked:=False;
         //xit;
     end;
     if not(allcheck.Checked) and isall then
     begin

          light.Checked := False;
          mirror.Checked := False;
          drive.Checked := False;
          brake.Checked := False;
          turn.Checked := False;
          wheel.Checked := False;
          hang.Checked := False;
          leak.Checked := False;
          window.Checked := False;
          safety.Checked := False;
          chkcamera.Checked := False;
          chkreturncheck.Checked := False;
          ncbbresult.ItemIndex := 1; // 不合格
          dtprechecktime.Visible:=true;
          dtprechecktime.DateTime:=now+1;
          lblrechecktime.Visible:=true;
     end;


end;

procedure TFrmSecuritycheckEdit.hangClick(Sender: TObject);
begin
  inherited;
  if (hang.Checked) then
  begin
    nvcbbhang.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkhang:=true;
    nvcbbhang.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.iccardfound(icCard: TBaseCard);
begin
  edtcard.SetFocus;
  if icCard.cardtype = USER then
  begin
    EdtUserCard.Text := icCard.cardNO;
  end
  else if icCard.cardtype = VEHICLEREPORT then
  begin
    edtcard.Text := icCard.cardNO;
    if Length(edtcard.Text) = SysInfo.curBillLength.Items['Vehicle'] then
    begin
      nvhelpvehicleno.Text := '';
      nvedtvehicletype.Text := '';
      nvedtunitname.Text := '';
      bbtnSave.SetFocus;
      getScurityVehilce(edtcard.Text, 0);
//      Self.nvhelpvehiclenoIdChange(Sender);
    end;
  end;
end;

procedure TFrmSecuritycheckEdit.brakeClick(Sender: TObject);
begin
  inherited;
  if (brake.Checked) then
  begin
    nvcbbbrake.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
    allcheck.Checked:=False;
    checkbrake:=true;
    nvcbbbrake.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.driveClick(Sender: TObject);
begin
  inherited;
  if (drive.Checked) then
  begin
    nvcbbdrive.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
    allcheck.Checked:=False;
    checkdrive:=true;
    nvcbbdrive.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.driver1Enter(Sender: TObject);
begin
  inherited;
  driverflag := True;
end;

procedure TFrmSecuritycheckEdit.driver1Exit(Sender: TObject);
begin
  inherited;
    driverflag := False;
end;

procedure TFrmSecuritycheckEdit.leakClick(Sender: TObject);
begin
  inherited;
  if (leak.Checked) then
  begin
    nvcbbleak.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkbleak:=true;
    nvcbbleak.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.lightClick(Sender: TObject);
begin
  inherited;
  if (light.Checked) then
  begin
    nvccblight.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    nvccblight.Enabled := True;
    isall := false;
    allcheck.Checked:=False;
    checklight:=true;
    checkallflag:=false;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.mirrorClick(Sender: TObject);
begin
  inherited;
  if (mirror.Checked) then
  begin
    nvcbbmirror.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkmirror:=true;
    nvcbbmirror.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbbrakeCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbbrake.Text = '') then
  begin
    brake.Enabled := True;
  end
  else
  begin
    brake.Enabled := False;
    ncbbresult.ItemIndex := 1;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbcameraCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbcamera.Text = '') then
  begin
    chkcamera.Enabled := True;
  end
  else
  begin
    chkcamera.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbdriveCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbdrive.Text = '') then
  begin
    drive.Enabled := True;
  end
  else
  begin
    drive.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbhangCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbhang.Text = '') then
  begin
    hang.Enabled := True;
  end
  else
  begin
    hang.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbleakCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbleak.Text = '') then
  begin
    leak.Enabled := True;
  end
  else
  begin
    leak.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbmirrorCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbmirror.Text = '') then
  begin
    mirror.Enabled := True;
  end
  else
  begin
    mirror.Enabled := False;
  end;

end;

procedure TFrmSecuritycheckEdit.nvcbbreturncheckCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbreturncheck.Text = '') then
  begin
    chkreturncheck.Enabled := True;
  end
  else
  begin
    chkreturncheck.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbsafetyCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbsafety.Text = '') then
  begin
    safety.Enabled := True;
  end
  else
  begin
    safety.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbturnCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbturn.Text = '') then
  begin
    turn.Enabled := True;
  end
  else
  begin
    turn.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbwheelCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbwheel.Text = '') then
  begin
    wheel.Enabled := True;
  end
  else
  begin
    wheel.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvcbbwindowCheckClick(Sender: TObject);
begin
  inherited;
  if (nvcbbwindow.Text = '') then
  begin
    window.Enabled := True;
  end
  else
  begin
    window.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.nvccblightCheckClick(Sender: TObject);
begin
  inherited;
  if (nvccblight.Text = '') then
  begin
    light.Enabled := True;
  end
  else
  begin
    light.Enabled := False;
  end;
end;

procedure TFrmSecuritycheckEdit.safetyClick(Sender: TObject);
begin
  inherited;
  if (safety.Checked) then
  begin
    nvcbbsafety.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checksafety:=true;
    nvcbbsafety.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.turnClick(Sender: TObject);
begin
  inherited;
  if (turn.Checked) then
  begin
    nvcbbturn.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkturn:=true;
    nvcbbturn.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.wheelClick(Sender: TObject);
begin
  inherited;
  if (wheel.Checked) then
  begin
    nvcbbwheel.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkwheel:=true;
    nvcbbwheel.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.windowClick(Sender: TObject);
begin
  inherited;
  if (window.Checked) then
  begin
    nvcbbwindow.Enabled := False;
    checkall(Sender);
  end
  else
  begin
    isall := false;
  allcheck.Checked:=False;
    checkwindow:=true;
    nvcbbwindow.Enabled := True;
    ncbbresult.ItemIndex := 1;
    dtprechecktime.Visible:=true;
    dtprechecktime.DateTime:=now+1;
    lblrechecktime.Visible:=true;
  end;
end;

procedure TFrmSecuritycheckEdit.zkfpngx1Capture(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
  var
  ID: Integer;
  isexist:boolean;
  begin
      ID:= ATemplate[0];
      if ID = -1 then
      begin
           if sRegTemplate1='' then
           begin
             sRegTemplate:='';
//             mmoReportInfo.Lines.Insert(1, '系统中不存在该指纹信息！');
//             mmoReportInfo.Lines.Insert(2, '请按指纹识别器……');
                 lblLabedriver.Caption :=  '' ;
               lblLabedriver.Caption :=  '系统中不存在该指纹信息！' ;
               lblLabedriver.Caption := '请按指纹识别器……';

           end ;
      end
      else
      begin
         with self.jsnclntdtstSpcQry do
         begin
           if Active and (recordcount>0) then
           begin
              isexist:=false;
              first;
              while not eof do
              begin
                if FieldByName('id').AsLargeInt = ID then
                begin

                  if driverflag then
                    begin
                          //根据指纹查询驾驶员姓名
                           with jsonClientQryDriverName do
                          begin
                            Active := False;
                            Params.ParamByName('driverid').Value := id;
                            Active := True;

                            if jsonClientQryDriverName.RecordCount>0 then
                            begin
                                lblLabedriver.Caption :=  '' ;
                                lblLabedriver.Caption :=  '指纹识别成功！' ;
                                info := jsonClientQryDriverName.FieldByName('name').AsString;
                             //   SysDialogs.ShowMessage(info);
                              //  lblLabedriver.Caption :=info;
                              nvhlpdriver.Text :=info;
                              nvhlpdriver.Id := id;

                            end;

                          end;

                    end;

                  isexist:=true;
                  exit;
                end;
                next;
              end;
              if not isexist then
              begin
//                mmoReportInfo.Lines.Insert(3, '没有该指纹信息……');
                     lblLabedriver.Caption := '没有该指纹信息……';
              end;
           end;
         end;
      end;
  end;


// 关闭时，注销刷卡器
procedure TFrmSecuritycheckEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

end.
