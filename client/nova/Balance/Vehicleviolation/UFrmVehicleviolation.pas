unit UFrmVehicleviolation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, UFrmVehicleviolationEdit,
  UFrmVehicleviolationProcess, Generics.Collections, NovaPrint, NovaEdit,
  NovaHelp, NovaComboBox;

type
  TFrmVehicleviolation = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbldate: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    jcdsDelVehicleviolation: TjsonClientDataSet;
    jcdsResultPrint: TjsonClientDataSet;
    jcdshandleret: TjsonClientDataSet;
    lbl4: TLabel;
    nvhlphandle: TNovaHelp;
    lbl3: TLabel;
    Label1: TLabel;
    edtnotenum: TNovaEdit;
    NHelpRoute: TNovaHelp;
    lbl5: TLabel;
    nvhelpvehicleno: TNovaHelp;
    chkhandle: TCheckBox;
    chkishandle: TCheckBox;
    jcdsstatus: TjsonClientDataSet;
    jcdsbalancetype: TjsonClientDataSet;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultnotenum: TWideStringField;
    wdstrngfldResultvehicleno: TWideStringField;
    n: TWideStringField;
    dtfldResultviolationdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultremark: TWideStringField;
    wdstrngfldResultbillorname: TWideStringField;
    wdstrngfldResulthandleret: TWideStringField;
    fltfldResultbreachfee: TFloatField;
    blnfldResultishandle: TBooleanField;
    wdstrngfldResulthandlorname: TWideStringField;
    wdstrngfldResultbalancetype: TWideStringField;
    wdstrngfldResultstatus: TWideStringField;
    wdstrngfldResultcreatename: TWideStringField;
    wdstrngfldResultupdatename: TWideStringField;
    wdstrngfldResulthandleretname: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    wdstrngfldResultstatusname: TWideStringField;
    fltfldResultdebit: TFloatField;
    dtmfldResultbilldate: TDateTimeField;
    dtmfldResulthandledate: TDateTimeField;
    dtmfldResultcreatetime: TDateTimeField;
    dtmfldResultupdatetime: TDateTimeField;
    lrgntfldResultid: TLargeintField;
    lrgntfldResultvehicleid: TLargeintField;
    lrgntfldResultorgid: TLargeintField;
    lrgntfldResultcreateby: TLargeintField;
    lrgntfldResultbillor: TLargeintField;
    cbbstatus: TNovaComboBox;
    lbl6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    vehicleviolationPrint: TNovaPrint;
    notprintValue: TList<string>; // 不打印项目
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
  public
    { Public declarations }
    log, templtename, parameter : string;
    balance : Int64;
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;

  end;

var
  FrmVehicleviolation: TFrmVehicleviolation;

implementation

uses Services, PubFn, DateUtils;
{$R *.dfm}

procedure TFrmVehicleviolation.FormShow(Sender: TObject);
var i : Int64;
begin
  inherited;
  cbbstatus.Active := False;
  cbbstatus.Active := True;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,Sysinfo.LoginUserInfo.OrgID);
  i := StrToInt(getParametervalue('4008', Sysinfo.LoginUserInfo.OrgID));
  if i = 0 then
  begin
    tbtnCancel.Visible := False;
    tbtnSave.Visible := False;
    balance := 0;
    dbgrdhResult.Columns[10].Visible :=False;
    dbgrdhResult.Columns[11].Visible :=False;
    dbgrdhResult.Columns[12].Visible :=False;
    dbgrdhResult.Columns[13].Visible :=False;
    dbgrdhResult.Columns[14].Visible :=False;
    dbgrdhResult.Columns[6].Title.Caption := '罚金';
    lbl4.Visible := False;
    chkhandle.Visible := False;
    chkishandle.Visible := False;
    nvhlphandle.Visible := False;
  end else
  begin
    balance := 1;
    dbgrdhResult.Columns[6].Title.Caption := '暂扣款';
  end;
end;


procedure TFrmVehicleviolation.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  //处理
  if GUIDToString(key)='{B587536B-8BC7-4EF0-8845-46914E7821A5}' then
  begin
    tbtnSave.Visible:=aEnable;
  end ;
  //添加
  if GUIDToString(key)='{27D0BD48-9B75-4459-B361-4DD899360A53}' then
  begin
    tbtnInsert.Visible:=aEnable;
  end ;
  //删除
  if GUIDToString(key)='{83E9210E-EC4A-4452-8C34-26D93674570B}' then
  begin
    tbtnDelete.Visible:=aEnable;
  end ;
  //修改
  if GUIDToString(key)='{80967894-E79E-43A4-B208-2D5F1A09C074}' then
  begin
    tbtnEdit.Visible:=aEnable;
  end ;
  //已处理
  if GUIDToString(key)='{ACC2BFA3-D2CA-4445-89D9-B05D19039DAF}' then
  begin
    chkhandle.Enabled := aEnable;
  end ;
  //未处理
  if GUIDToString(key)='{321CA664-B649-4B75-86D6-1EFFFD3744B8}' then
  begin
    chkishandle.Enabled := aEnable;
  end ;

end;

procedure TFrmVehicleviolation.tbtnCancelClick(Sender: TObject);
var multipleValueValue: TDictionary<String, String>;
    isbalance, ishandle : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with jcdsResultPrint do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_t!id'] := jcdsResult.FieldByName('id').AsString;
    Active := True;
    templtename := TNovaPrint.GetTicketModelName('处理通知单', '车辆违规通知单');
    if not Assigned(vehicleviolationPrint) then
      vehicleviolationPrint := TNovaPrint.Create(self, templtename);
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
    printValue.Clear;
    printValue.Add('notenum',FieldByName('notenum').AsString);
    printValue.Add('billdate',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('billdate').AsDateTime));
    printValue.Add('billorname',FieldByName('billorname').AsString);
    printValue.Add('breachfee',FloatToStr(FieldByName('breachfee').AsFloat));
    printValue.Add('debit',FloatToStr(FieldByName('debit').AsFloat));
    printValue.Add('departtime',FieldByName('departtime').AsString);
    printValue.Add('handledate',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('handledate').AsDateTime));
    printValue.Add('handleret',jcdsResult.FieldByName('handleretname').AsString);
    printValue.Add('handlorname',FieldByName('handlorname').AsString);
   
    printValue.Add('isbalance', jcdsResult.FieldByName('statusname').AsString);
    if FieldByName('ishandle').AsBoolean = True then
      ishandle := '已处理'
    else
      ishandle := '未处理';
    printValue.Add('ishandle', ishandle);
    printValue.Add('orgname',FieldByName('orgname').AsString);
    printValue.Add('remark',FieldByName('remark').AsString);
    printValue.Add('routename',FieldByName('routename').AsString);
    printValue.Add('vehicleno',FieldByName('vehicleno').AsString);
    printValue.Add('violationdate',FormatDateTime('yyyy-mm-dd', FieldByName('violationdate').AsDateTime));
    printValue.Add('createname',FieldByName('createname').AsString);
    printValue.Add('updatename',FieldByName('updatename').AsString);
    printValue.Add('createtime',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('createtime').AsDateTime));
    printValue.Add('updatetime',FormatDateTime('yyyy-mm-dd hh:mm', FieldByName('updatetime').AsDateTime));

    vehicleviolationPrint.SingleValue := printValue;
    vehicleviolationPrint.Print;
  end;
end;

procedure TFrmVehicleviolation.tbtnDeleteClick(Sender: TObject);
var nResult : Int64;
    sResult : String;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if StrToInt(getParametervalue('4007', Sysinfo.LoginUserInfo.OrgID))
      < (MilliSecondsBetween(Now,jcdsResult.FieldByName('createtime').AsDateTime) div 60000) then
  begin
    SysDialogs.ShowMessage('该记录已经超过参数设置的时间，不能删除！');
    Exit;
  end;
  if jcdsResult.FieldByName('ishandle').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('该违规车辆已经处理，不能删除!');
    Exit;
  end;
  if jcdsResult.FieldByName('status').AsString <> '0' then
  begin
    SysDialogs.ShowMessage('该违规车辆已经结算，不能删除!');
    Exit;
  end;
  with jcdsDelVehicleviolation do
  try
    if not SysDialogs.Confirm('提示','确定要删除该营运车辆违规处理？') then
    begin
      exit;
    end;
    Params.ParamByName('vehicleviolation.id').Value :=jcdsResult.FieldByName('id').AsString ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      log := '删除车辆违规情况：通知单号='+jcdsResult.FieldByName('notenum').AsString+
      ',线路='+jcdsResult.FieldByName('routename').AsString+',车牌号='+
      jcdsResult.FieldByName('vehicleno').AsString+',发车时间='+jcdsResult.FieldByName('departtime').AsString+
      ',操作人='+SysInfo.LoginUserInfo.UserName;
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('营运车辆违规处理删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmVehicleviolation.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if StrToInt(getParametervalue('4007', Sysinfo.LoginUserInfo.OrgID))
      < (MilliSecondsBetween(Now,jcdsResult.FieldByName('createtime').AsDateTime) div 60000) then
  begin
    SysDialogs.ShowMessage('该记录已经超过参数设置的时间，不能修改！');
    Exit;
  end;
  if jcdsResult.FieldByName('ishandle').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('该违规车辆已经处理，不能修改!');
    Exit;
  end;
  if Trim(jcdsResult.FieldByName('status').AsString) <> '0' then
  begin
    SysDialogs.ShowMessage('该违规车辆已经结算，不能修改!');
    Exit;
  end;
  with FrmVehicleviolationEdit do
  begin
    FrmVehicleviolationEdit := TFrmVehicleviolationEdit.Create(Self);
    Caption := '修改车辆违规处理通知单';
    flag := true;
    if balance = 0 then
      lbl5.Caption := '罚金'
    else
      lbl5.Caption := '暂扣款';
    id := jcdsResult.FieldByName('id').AsInteger;
    balancetype := balance;
    dtpdepartdate.DateTime := jcdsResult.FieldByName('violationdate').AsDateTime;
    nvhelpvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    edtdeparttime.DateTime := jcdsResult.FieldByName('departtime').AsDateTime;
    mmoremark.Text := jcdsResult.FieldByName('remark').AsString;
    edtdebit.Text := jcdsResult.FieldByName('debit').AsString;
    vehicleid := jcdsResult.FieldByName('vehicleid').AsString;
    nvhelpvehicleno.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    createby := jcdsResult.FieldByName('createby').AsInteger;
    billor := jcdsResult.FieldByName('billor').AsInteger;
    billdate := jcdsResult.FieldByName('billdate').AsDateTime;
    notenum := jcdsResult.FieldByName('notenum').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmVehicleviolation.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
      if nvckbOrgid.CheckedCount = 0 then
        Params.ParamValues['filter_INS_t!orgid'] := SysInfo.LoginUserInfo.OrgIDs
      else
        Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
      Params.ParamValues['filter_GED_t!violationdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
      Params.ParamValues['filter_LED_t!violationdate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
      if Trim(edtnotenum.Text) = '' then
        params.ParamValues['filter_LIKES_t!notenum'] := ''
      else
        params.ParamValues['filter_LIKES_t!notenum'] := edtnotenum.Text;
      if Trim(NHelpRoute.Text) = '' then
        params.ParamValues['filter_LIKES_t!routename'] := ''
      else
        params.ParamValues['filter_LIKES_t!routename'] := NHelpRoute.Text;
      if Trim(nvhelpvehicleno.Text) = '' then
        params.ParamValues['filter_EQL_t!vehicleid'] := ''
      else
        params.ParamValues['filter_EQL_t!vehicleid'] := nvhelpvehicleno.Id;
      if Trim(nvhlphandle.Text) = '' then
        params.ParamValues['filter_EQL_t!handlor'] := ''
      else
        params.ParamValues['filter_EQL_t!handlor'] := nvhlphandle.Id;
      if ((chkhandle.Checked) and (chkishandle.Checked = false)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := 'true';
      end
      else if ((chkhandle.Checked = false) and (chkishandle.Checked)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := 'false';
      end
      else if ((chkhandle.Checked) and (chkishandle.Checked)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := null;
      end
      else if ((chkhandle.Checked = false) and (chkishandle.Checked = false)) then
      begin
        Params.ParamValues['filter_EQB_t!ishandle'] := null;
      end;
      Params.ParamValues['filter_EQS_t!balancetype'] := balance;
      if Trim(cbbstatus.Text) = '' then
        Params.ParamValues['filter_EQS_t!status'] := ''
      else
        params.ParamValues['filter_EQS_t!status'] := TCommInfo(cbbstatus.Items.Objects[cbbstatus.ItemIndex]).Value;
    Active := True;

    log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.GetSelectID) <>'' then
      log := log +',[班次机构]：'+nvckbOrgid.Text;
    if Trim(cbbstatus.Text) <> '' then
      log  := log +',[状态]:'+cbbstatus.Text;
    if NHelpRoute.Id <> 0 then
      log := log +'[线路]：'+NHelpRoute.Text;
    if nvhelpvehicleno.Id <> 0 then
      log:= log+',[车辆]:'+nvhelpvehicleno.Text;
    if edtnotenum.Text <>'' then
      log := log +',[通知单号]:'+edtnotenum.Text;
    if chkhandle.Checked then
      log := log +',[已处理]';
    if chkishandle.Checked then
      log := log+',[未处理]';
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->营运车辆违规处理','查询',log);
  end;
end;

procedure TFrmVehicleviolation.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmVehicleviolationEdit do
  begin
    FrmVehicleviolationEdit := TFrmVehicleviolationEdit.Create(Self);
    Caption := '添加车辆违规处理通知单';
    flag := true;
    dtpdepartdate.DateTime := Now;
    balancetype := balance;
    if balance = 0 then
      lbl5.Caption := '罚金'
    else
      lbl5.Caption := '暂扣款';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

procedure TFrmVehicleviolation.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('ishandle').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('该车辆违规通知单已经处理，请选择其它车辆!');
    Exit;
  end;
  with FrmVehicleviolationProcess do
  begin
    FrmVehicleviolationProcess := TFrmVehicleviolationProcess.Create(Self);
    Caption := '处理车辆违规通知单';
    flag := true;
    id := jcdsResult.FieldByName('id').AsInteger;
    dtpdepartdate.DateTime := jcdsResult.FieldByName('violationdate').AsDateTime;
    nvhelpvehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    edtdeparttime.DateTime := jcdsResult.FieldByName('departtime').AsDateTime;
    nvhelpvehicleno.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
