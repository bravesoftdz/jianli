unit UFrmChangeVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet,DateUtils;

type
  TFrmChangeVehicle = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHelpReportVehicle: TNovaHelp;
    lbl17: TLabel;
    nvedtSeatnum: TNovaEdit;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl16: TLabel;
    NvEdtRoute: TNovaEdit;
    nvedtcode: TNovaEdit;
    NvedtDeparttimeL: TNovaEdit;
    Label2: TLabel;
    NovaHelpVehicleno: TNovaHelp;
    Label3: TLabel;
    NovaEdtSeats: TNovaEdit;
    lbl4: TLabel;
    NovaHUnit: TNovaHelp;
    jscdchangeReportVehicle: TjsonClientDataSet;
    jcsdQryVehiclecheck: TjsonClientDataSet;
    cbbCheckResult: TComboBox;
    lbl21: TLabel;
    mmoCheckResult: TMemo;
    jcdsVehicledistance: TjsonClientDataSet;
    procedure NovaHelpVehiclenoIdChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
        // 获取车辆安检信息
    function checkVehicle(vehicleid: Int64; departdate: string): boolean;

  public
    { Public declarations }
    scheduleplanid,vehiclereportid:Int64;
      isMustCheck: boolean; // 是否必须安检
    maintainvaliddate : TDatetime;
    distancemessage,scheduledepartdate: string;
    temp:Integer;
  end;

var
  FrmChangeVehicle: TFrmChangeVehicle;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmChangeVehicle.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (trim(NovaHelpVehicleno.Text)='') or (NovaHelpVehicleno.Id=0)  then
  begin
    SysDialogs.Warning('请输入更换的车号！');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;
  if ((NovaHelpReportVehicle.Text)=(NovaHelpVehicleno.text))
   then
  begin
    SysDialogs.Warning('更换的车辆不能与已报到车辆一样！');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;

  if (isMustCheck) then
  begin
    if cbbCheckResult.ItemIndex = 0 then
    begin
      SysDialogs.Warning('该车辆还未进行安检，不允许报到！');
      NovaHelpVehicleno.SetFocus;
      exit;
    end
    else if cbbCheckResult.ItemIndex = 2 then
    begin
      SysDialogs.Warning('该车辆安检不合格，不允许报到！');
      NovaHelpVehicleno.SetFocus;
      exit;
    end
  end;
  //是否开启车辆里程限制
  if getParametervalue('0143', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    //  查询车辆里程激活管理，取出发班里程数和限制的里程数
    with jcdsVehicledistance do
    begin
      Close;
      Params.ParamValues['vehicleid'] := NovaHelpVehicleno.Id;
      Params.ParamValues['iscomparedate'] := 'false';
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if (nResult <= 0) then
      begin
        sResult := Params.ParamByName('msg').Value;
        temp := Pos('该车辆还有',sResult) ;
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
   //是否开启车辆二期维护有效期
  if getParametervalue('6006', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    //  查询车辆里程激活管理，取出二维有效期
    with jcdsVehicledistance do
    begin
       Close;
      Params.ParamValues['vehicleid'] := NovaHelpVehicleno.Id;
      Params.ParamValues['iscomparedate'] := 'true';
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if (nResult <= 0) then
      begin
        sResult := Params.ParamByName('msg').Value;
        temp := Pos('该车辆还有',sResult) ;
        if temp > 0 then
        begin
          if distancemessage<>'' then
          begin
            sResult := Copy(sResult,4);
            distancemessage := distancemessage+','+sResult;
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
  if distancemessage  <> ''then
  SysDialogs.ShowInfo(distancemessage+',达到二维期限！');
  distancemessage:='';

  with jscdchangeReportVehicle do
  begin
    Active := false;
    Params.ParamValues['vehiclereport.scheduleplanid'] := scheduleplanid;
    Params.ParamValues['vehiclereport.id'] := vehiclereportid;
    Params.ParamValues['vehiclereport.vehicleid'] :=NovaHelpVehicleno.Id ;
    Params.ParamValues['vehiclereport.createby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['vehiclereport.departdate'] :=  scheduledepartdate;
    Params.ParamValues['departstationid'] := SysInfo.LoginUserInfo.StationID;
    Params.ParamValues['ip'] := SysInfo.LocalHostAddress;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('换车报到操作失败：' + E.Message);
      end;
    end;
  end;

end;

function TFrmChangeVehicle.checkVehicle(vehicleid: Int64;
  departdate: string): boolean;
var
  nResult: integer;
  sResult,ischeckwithout: string;
begin
  with jcsdQryVehiclecheck do
  begin
    active := false;
    Params.ParamValues['vehiclereport.vehicleid'] := vehicleid;
    Params.ParamValues['vehiclereport.departdate'] := departdate;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      mmoCheckResult.Text := sResult;
      ischeckwithout :=  getParametervalue('6008', sysInfo.LoginUserInfo.OrgID);
      // -1未检 1合格 0不合格 2是无安检计划无需校验安检 3:24小时内安检合格，
              //- 2,已发班里程大于设置需要重复安检里程，提示需要再次安检
      if (isMustCheck) then
      begin
        cbbCheckResult.Enabled := false;
//        if (nResult = -3) then  //有安检计划，必须安检
//        begin
//            cbbCheckResult.ItemIndex := 0;
//            result := false;
//            cbbCheckResult.Enabled := false;
//            exit;
//        end;
        if (nResult = -1) then     //该车辆当日还没例检！
        begin
          if ischeckwithout = '1' then
          begin
            cbbCheckResult.ItemIndex := 0;
            result := false;
            cbbCheckResult.Enabled := false;
            exit;
          end
          else
          begin
            cbbCheckResult.ItemIndex := 0;
            result := true;
            cbbCheckResult.Enabled := true;
            exit;
          end;
        end
        else if (nResult = 1) then    //该车辆当日例检合格!
        begin
          if sResult='该车辆还没例检！' then
            begin
                cbbCheckResult.ItemIndex := 0;
                cbbCheckResult.Enabled := false;
            end
            else
                cbbCheckResult.ItemIndex := 1;
          result := true;
          exit;
        end
         else if (nResult = 2) then  //当前车辆无安检计划!
        begin
          //是否需要安检合格才允许报到
          if isMustCheck then
          begin
            if  ischeckwithout = '1' then
            begin
                sResult := '安检合格才允许报到！';
                cbbCheckResult.ItemIndex := 0;
                mmoCheckResult.Text := sResult;
                cbbCheckResult.Enabled := false;
                result := false;
                exit;
            end
            else
            begin
                cbbCheckResult.Enabled := true;
                cbbCheckResult.ItemIndex := 0;
                mmoCheckResult.Text := sResult;
                result := true;;
//                exit;
            end;
          end
          else
          begin
            cbbCheckResult.ItemIndex := 1;
            result := true;
            exit;
          end;
        end
        else if (nResult = 3) then //该车辆24小时内例检合格!
        begin
          cbbCheckResult.ItemIndex := 1;
          cbbCheckResult.Enabled := false;
          result := true;
          exit;
        end
        else if (nResult = 0) then  //该车辆当日例检不合格！
        begin
          cbbCheckResult.ItemIndex := 2;
          cbbCheckResult.Enabled := false;
          result := false;
          exit;
        end
        else if (nResult = -2) or (nResult = -3) then //提示需要再次安检
        begin
          cbbCheckResult.ItemIndex := 0;
          cbbCheckResult.Enabled := false;
          result := false;
          exit;
        end
        else
        begin
          cbbCheckResult.Enabled := true;
          cbbCheckResult.ItemIndex := 0;
          result := true;
        end;
      end
      else
      begin
        mmoCheckResult.Text := '系统未设置车辆需要安检！';
        cbbCheckResult.Enabled := true;
        if (nResult = -1) then
        begin
          cbbCheckResult.ItemIndex := 0;
          result := false;
          exit;
        end
        else if (nResult = 1) then
        begin
          cbbCheckResult.ItemIndex := 1;
          result := true;
          exit;
        end
        else if (nResult = 0) then
        begin
          cbbCheckResult.ItemIndex := 2;
          result := false;
          exit;
        end
        else
        begin
          cbbCheckResult.ItemIndex := 0;
          result := true;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('获取车辆安检信息失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmChangeVehicle.NovaHelpVehiclenoIdChange(Sender: TObject);
begin
  inherited;
    if (NovaHelpVehicleno.isactive) and (NovaHelpVehicleno.Id > 0) and
    (trim(NovaHelpVehicleno.Text) <> '') then
  begin
    NovaHUnit.Text := NovaHelpVehicleno.HelpFieldValue['unitname'];
    NovaEdtSeats.Text := NovaHelpVehicleno.HelpFieldValue['seatnum'];
    checkVehicle(NovaHelpVehicleno.Id, scheduledepartdate);
  end;
end;

end.
