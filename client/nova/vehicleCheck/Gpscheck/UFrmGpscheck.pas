unit UFrmGpscheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, NovaHComboBox,
  Buttons,FunctionItemIntf,NovaPrint,Generics.Collections,PubFn, Spin;

type
  TFrmGpscheck = class(TSimpleCRUDForm)//,IBaseCardfound)
    jcdsDelGpscheck: TjsonClientDataSet;
    jsonDelDepartinvoicesotherdetail: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpvehicle: TNovaHelp;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    pnl1: TPanel;
    grpdetail: TGroupBox;
    pnl2: TPanel;
    Label2: TLabel;
    nvhlpvehicleid: TNovaHelp;
    lbl4: TLabel;
    lbl7: TLabel;
    bbtnSave: TBitBtn;
    btn2: TBitBtn;
    jcdsSaveGpscheck: TjsonClientDataSet;
    lbl10: TLabel;
    lbl11: TLabel;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    chkIsnuqual: TCheckBox;
    Label6: TLabel;
    nvhlpCreateby: TNovaHelp;
    Label8: TLabel;
    Label3: TLabel;
    chkunqualify: TCheckBox;
    RoBunquality: TRadioButton;
    RoBquality: TRadioButton;
    NvhelpVehicleids: TNovaHelp;
    BitBtn1: TBitBtn;
    jcsdQryVehiclecheck: TjsonClientDataSet;
    mmoRemarks: TMemo;
    CheckBox1: TCheckBox;
    chkIsqualify: TCheckBox;
    tmrFlash: TTimer;
    flashtime: TSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtnumKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure NvhelpVehicleidsIdChange(Sender: TObject);
    procedure chkIsqualifyClick(Sender: TObject);
    procedure chkunqualifyClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure dbgrdhResultDblClick(Sender: TObject);
    procedure dbgrdhResultCellClick(Column: TColumnEh);
    procedure tmrFlashTimer(Sender: TObject);
    procedure flashtimeChange(Sender: TObject);
//    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    functiontype,log,templtename,mustcheck :string;
    id : Int64;
    cbbtickettypeid : string;
    isprint :boolean;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    procedure savecheck(vehicleno,vehicleid,results,remark:string);
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); override;

  end;


var
  frmGpscheck: TfrmGpscheck;

implementation

uses Services ;
{$R *.dfm}

constructor TFrmGpscheck.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;checkpermission:boolean);
begin
  inherited;
  //功能类型  0车辆安检管理  1 车辆安检统计
  functiontype:=parameter.strings[0];
  if functiontype='0' then
  begin
//     dbgrdhResult.Columns[5].Visible:=false;
     dbgrdhResult.Columns[7].Visible:=false;
     dbgrdhResult.Columns[8].Visible:=false;
     dbgrdhResult.Columns[9].Visible:=false;
     // 6014 车辆是否必须先安检，才能进行GPS检查：0否，1是
    mustcheck := getParametervalue('6014', SysInfo.LoginUserInfo.OrgID);
    Label4.visible := true;
    flashtime.visible := true;
    Label5.visible := true;
    tmrFlash.interval := 10 * 1000 ; //窗体打开默认10秒自动刷新
    tmrFlash.Enabled := true;
  end
  else
  begin
     tbtnEdit.Visible := false;
     tbtnDelete.Visible := false;
     tbtn1.Visible := false;
     CheckBox1.Visible := false;
     CheckBox1.Checked := true;
     chkIsqualify.Checked := true;
     chkunqualify.Checked := true;
     chkIsqualify.Visible := false;
     chkunqualify.Visible := false;
     nvhlpCreateby.Visible :=false;
     Label6.Visible := false;
     grpdetail.Visible := false;
     dbgrdhResult.Columns[2].Visible:=false;
     dbgrdhResult.Columns[3].Visible:=false;
     dbgrdhResult.Columns[6].Visible:=false;
     dbgrdhResult.Columns[10].Visible:=false;
     dbgrdhResult.Columns[11].Visible:=false;
     dbgrdhResult.Columns[12].Visible:=false;
     dbgrdhResult.Columns[13].Visible:=false;
     dbgrdhResult.Columns[14].Visible:=false;
     Label4.visible := false;
     flashtime.visible := false;
     Label5.visible := false;
  end;

end;

procedure TFrmGpscheck.tbtnFilterClick(Sender: TObject);
var begindatetime,enddatetime:string;
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    begindatetime := formatdatetime('yyyy-mm-dd',dtpstartdate.Date)+' 00:00:00';
    enddatetime := formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' 23:59:59';

    if Trim(nvhlpvehicle.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_gp!vehicleid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_gp!vehicleid'] := nvhlpvehicle.Id;
    end;
    if cbborg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_gp!orgid'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_gp!orgid'] := cbborg.GetSelectID;

    if (trim(NovaHelpUnit.Text)<>'') and (NovaHelpUnit.Id >0) then
      Params.ParamValues['filter_EQL_v!unitid'] := NovaHelpUnit.HelpFieldValue['id']
    else
      Params.ParamValues['filter_EQL_v!unitid'] :='';



    if ( CheckBox1.checked) or
        (not(chkunqualify.Checked) and not(chkIsqualify.Checked)) then
    begin
      Params.ParamValues['filter_NOEQS_gp!result']:=1;
      Params.ParamValues['filter_GED_gp!checktime'] := begindatetime;
      Params.ParamValues['filter_LED_gp!checktime'] := enddatetime;
      Params.ParamValues['filter_GED_gp!checkdate'] := null;
      Params.ParamValues['filter_LED_gp!checkdate'] := null;
      Params.ParamValues['filter_EQL_gp!operater']:= '';
      Params.ParamValues['filter_EQS_gp!checkresult']:=null;
    end
    else
    begin
      if  (not (Trim(nvhlpCreateby.Text) = '')) and  (nvhlpCreateby.Id>=0) then
          Params.ParamValues['filter_EQL_gp!operater']:= nvhlpCreateby.HelpFieldValue['id']
      else
          Params.ParamValues['filter_EQL_gp!operater']:= '';

      Params.ParamValues['filter_GED_gp!checkdate'] := begindatetime;
      Params.ParamValues['filter_LED_gp!checkdate'] := enddatetime;
      Params.ParamValues['filter_GED_gp!checktime'] := null;
      Params.ParamValues['filter_LED_gp!checktime'] := null;

      if not chkIsqualify.Checked  and chkunqualify.Checked  then    //不合格
      begin
         Params.ParamValues['filter_NOEQS_gp!result']:=null;
         Params.ParamValues['filter_EQS_gp!checkresult']:=1;
      end
      else if not chkunqualify.Checked  and chkIsqualify.Checked then   //合格
      begin
         Params.ParamValues['filter_NOEQS_gp!result']:=null;
         Params.ParamValues['filter_EQS_gp!checkresult']:=0;
      end
      else if chkunqualify.Checked  and chkIsqualify.Checked then
      begin
         Params.ParamValues['filter_NOEQS_gp!result']:=null;
         Params.ParamValues['filter_EQS_gp!checkresult']:=null;
      end;
    end;

    if functiontype='1' then
         Params.ParamValues['issummary']:='true'   //GPS统计查询
    else
         Params.ParamValues['issummary']:='false'; //GPS安检管理

    Active := True;
  end;
end;


procedure TFrmGpscheck.tmrFlashTimer(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

//保存并打印
procedure TFrmGpscheck.BitBtn1Click(Sender: TObject);
begin
  inherited;
  isprint := true;
  bbtnSaveClick(Sender);
end;

//单击记录获取车牌信息到右边框
procedure TFrmGpscheck.dbgrdhResultCellClick(Column: TColumnEh);
begin
  inherited;
  if functiontype<>'0' then
    exit;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('resultname').AsString<>'' then
    exit;
  NvhelpVehicleids.text := jcdsResult.FieldByName('vehicleno').AsString;
  NvhelpVehicleids.id := jcdsResult.FieldByName('vehicleid').asinteger;
end;

//双击进行保存
procedure TFrmGpscheck.dbgrdhResultDblClick(Sender: TObject);
begin
  inherited;
   if functiontype<>'0' then
    exit;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('resultname').AsString<>'' then
    exit;
  if not SysDialogs.Confirm('提示','是否确认车辆('
              +jcdsResult.FieldByName('vehicleno').AsString+')GPS检查合格？') then
    begin
      exit;
    end;
  savecheck(jcdsResult.FieldByName('vehicleno').AsString,
  jcdsResult.FieldByName('vehicleid').AsString,'0','');
end;

//保存 按钮
procedure TFrmGpscheck.bbtnSaveClick(Sender: TObject);
var nResult : Int64;
    sResult,results:string;
begin
  inherited;
  log :='';
  if (Trim(NvhelpVehicleids.Text) = '' ) then
  begin
    SysDialogs.Warning('请填写安检车辆！');
    isprint := false;
    NvhelpVehicleids.SetFocus;
    Exit;
  end;
  //  车辆必须安检合格
  if mustcheck ='1' then
  begin
    with jcsdQryVehiclecheck do
    begin
      active := false;
      Params.ParamValues['vehiclereport.vehicleid'] := NvhelpVehicleids.Id;
      Params.ParamValues['vehiclereport.departdate'] := formatdatetime('yyyy-mm-dd',now);
      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        // 返回的-1未检 1合格 0不合格
        //2是无安检计划无需校验安检,3:24小时内安检合格
        if (nResult=-1) or (nResult =0) or (nResult =2)then
        begin
            SysDialogs.Warning('车辆必须安检合格,才允许GPS检查！');
            NvhelpVehicleids.SetFocus;
            Exit;
        end;
      except
      on E: Exception do
      begin
        SysLog.WriteErr('获取车辆安检信息失败：' + E.Message);
      end;
    end;
    end;
  end;
  if RoBquality.Checked then
    results := '0'
  else
    results :='1';
  savecheck(NvhelpVehicleids.Text,inttostr(NvhelpVehicleids.Id),
    results,mmoRemarks.Text);
end;

//保存事件
 procedure TFrmGpscheck.savecheck(vehicleno,vehicleid,results,remark:string);
 var nResult : Int64;
    sResult,checkresult : string;
begin
  with jcdsSaveGpscheck do
  begin
    Close;
    Params.ParamValues['gpscheck.vehicleid'] := vehicleid;//.HelpFieldValue['id'];
     Params.ParamValues['gpscheck.checkresult'] := results ;
    if results ='1' then
    begin
        checkresult :='不合格';
    end
    else
    begin
        checkresult := '合格';
    end;

    Params.ParamValues['gpscheck.operater'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['gpscheck.orgid'] := SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['gpscheck.updateby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['gpscheck.createby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['gpscheck.checkdate'] := formatdatetime('yyyy-mm-dd',now);
    Params.ParamValues['gpscheck.remark'] := remark;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NvhelpVehicleids.SetFocus;
      end
      else
      begin
        NvhelpVehicleids.SetFocus;
        log := '[安检机构]'+SysInfo.LoginUserInfo.OrgName
                 +'，[安检日期]'+formatdatetime('yyyy-mm-dd',now)
                 +'，[安检编号]'+Params.ParamValues['notenum']
                +'，[车号]:'+vehicleno
                +'，[安检结果]:'+checkresult
                +'，[操作员]:'+SysInfo.LoginUserInfo.UserName;
        SysLog.WriteLog('安检管理——>GPS安检管理','添加GPS安检信息',log);
        if isprint then
        begin
          templtename := TNovaPrint.GetTicketModelName('车辆GPS检查', '车辆GPS检查');
          if not Assigned(billPrint) then
            billPrint := TNovaPrint.Create(self, templtename);
          if not Assigned(printValue) then
            printValue := TDictionary<String, String>.Create
          else
              printValue.Clear;
          printValue.Add('orgname',SysInfo.LoginUserInfo.OrgName);
          printValue.Add('checkdate',formatdatetime('yyyy-mm-dd',now));
          printValue.Add('checktime',formatdatetime('yyyy-mm-dd hh:mm:ss',now));
          printValue.Add('operatername',SysInfo.LoginUserInfo.UserName);
          printValue.Add('checkresult', checkresult);
          printValue.Add('vehicleno', NvhelpVehicleids.Text);
          printValue.Add('checkno', Params.ParamValues['notenum']);
          printValue.Add('printtime', formatdatetime('yyyy-mm-dd hh:mm:ss',now));
          printValue.Add('remarks', mmoRemarks.Text);
          billPrint.SingleValue := printValue;
          billPrint.Print;
          isprint := false;
        end;
          mmoRemarks.Text := '';
          NvhelpVehicleids.Text := '';
          RoBquality.Checked := true;
          tbtnFilterClick(Self);
          jcdsResult.Locate('id', id,[]);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车辆GPS检查失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmGpscheck.btn2Click(Sender: TObject);
begin
  inherited;
  NvhelpVehicleids.Text := '';
  mmoRemarks.Text :='';
end;



procedure TFrmGpscheck.CheckBox1Click(Sender: TObject);
begin
  inherited;
  if not(chkIsqualify.checked) and not(chkunqualify.checked) then
  begin
     CheckBox1.checked := true;
  end;
  if CheckBox1.checked then
  begin
     chkIsqualify.checked:=false;
     chkunqualify.checked:=false;
  end;

end;

procedure TFrmGpscheck.chkIsqualifyClick(Sender: TObject);
begin
  inherited;
  if chkIsqualify.checked then
  begin
    CheckBox1.checked := false;
  end
  else if not(chkunqualify.checked) then
  begin
     CheckBox1.checked := true;
  end;


end;

procedure TFrmGpscheck.chkunqualifyClick(Sender: TObject);
begin
  inherited;
   if chkunqualify.checked then
  begin
    CheckBox1.checked := false;
  end
  else if not(chkIsqualify.checked) then
  begin
     CheckBox1.checked := true;
  end;;
end;

procedure TFrmGpscheck.edtnumKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
//  case Key of
//    '0'..'9', #8, #13, #27 : ;
//  else
//    begin
//      MessageBox(Handle, '请输入数字', PChar('输入错误'), MB_OK + MB_ICONINFORMATION);
//      Key := #0;
//    end;
//  end;
end;

//修改自动刷新的值
procedure TFrmGpscheck.flashtimeChange(Sender: TObject);
var
  interval: String;
  intervaltime: Integer;
begin
  inherited;
    interval := flashtime.text;
    try
      intervaltime := StrToInt(interval);
    except
      intervaltime := 10;
    end;
    tmrFlash.interval := intervaltime * 1000;
    tmrFlash.Enabled := true;
end;

procedure TFrmGpscheck.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 // inherited;

  if (Key = vk_return) then
    Key := 0;
  if (Key = vk_F2) then
  begin
    Key := 0;
    NvhelpVehicleids.SetFocus;
  end
  else if Key = VK_F1 then
  begin
//    tbtnInsertClick(Self);
  end;
end;

procedure TFrmGpscheck.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  cbborg.Active := False;
  cbborg.Active := True;
  lbl7.Caption := SysInfo.LoginUserInfo.UserName;

end;

procedure TFrmGpscheck.NvhelpVehicleidsIdChange(Sender: TObject);
begin
  inherited;
  if NvhelpVehicleids.Id >0 then
    bbtnSave.SetFocus;
end;

procedure TFrmGpscheck.tbtnDeleteClick(Sender: TObject);
var nResult : LongWord;
    sResult : string;
begin
  inherited;
   log :='';
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('resultname').AsString='' then
  begin
    SysDialogs.ShowMessage('未检查状态不能删除！');
    exit;
  end;
  with jcdsDelGpscheck do
  try
    close;
    Params.ParamByName('id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
          log := '[安检机构]'+jcdsResult.FieldByName('orgname').AsString
                 +'，[安检日期]'+jcdsResult.FieldByName('checkdate').AsString
                 +'，[安检编号]'+jcdsResult.FieldByName('checkno').AsString
                +'，[车票号]:'+jcdsResult.FieldByName('vehicleno').AsString
                +'，[安检结果]:'+jcdsResult.FieldByName('resultname').AsString
                +'，[操作员]:'+jcdsResult.FieldByName('operatername').AsString
                +'，[安检时间]:'+jcdsResult.FieldByName('createtime').AsString
                +'，[备注]:'+jcdsResult.FieldByName('remark').AsString;
        SysLog.WriteLog('安检管理——>GPS安检管理','删除车辆GPS安检信息',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('车辆GPS安检信息删除失败：' + E.Message);
    end;
  end;

end;

 //重新打印
procedure TFrmGpscheck.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('resultname').AsString = '' then
    exit;
 templtename := TNovaPrint.GetTicketModelName('车辆GPS检查', '车辆GPS检查');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
      printValue.Clear;
  printValue.Add('orgname',jcdsResult.FieldByName('orgname').AsString);
  printValue.Add('checkdate',jcdsResult.FieldByName('checkdate').AsString);
  printValue.Add('checktime',jcdsResult.FieldByName('createtime').AsString);
  printValue.Add('operatername',jcdsResult.FieldByName('operatername').AsString);
  printValue.Add('checkresult', jcdsResult.FieldByName('resultname').AsString);
  printValue.Add('vehicleno', jcdsResult.FieldByName('vehicleno').AsString);
  printValue.Add('checkno', jcdsResult.FieldByName('checkno').AsString);
  printValue.Add('printtime', formatdatetime('yyyy-mm-dd hh:mm:ss',now));
  printValue.Add('remarks', jcdsResult.FieldByName('remark').AsString);
  billPrint.SingleValue := printValue;
  billPrint.Print;
end;


end.
