{ ------------------------------------
  功能说明：onecard.bpl功能对象
  创建日期：2012/12/06
  作者：ice
  版权：nova
  ------------------------------------- }
unit onecardPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections,Forms;

Type

{------------------------------------
  功能说明：一卡通功能
-------------------------------------}
  TOneCardFunction=class(TInterfacedObject,IFunctionItem)
  private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;

{------------------------------------
  功能说明：一卡通退检退票功能
-------------------------------------}
  TOneCardFunctionReturn=class(TInterfacedObject,IFunctionItem)
  private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;

implementation

uses Services,MainFormIntf, UFrmOneCard, UFrmOneCardReturn;

{ TOneCardFunction }

procedure TOneCardFunction.ChangeTheme;
begin

end;

constructor TOneCardFunction.Create;
begin

end;

procedure TOneCardFunction.Enter(const parameters: TFunctionItemParameters);
var _scheduleplanid,_vehiclereportid:int64;
    _ticketentrance:String;
    FrmOneCard:TFrmOneCard;
begin
  if (parameters=nil) or (parameters.Count<1) then
  begin
    raise Exception.Create('“刷卡上车功能”需要指定班次计划ID');
  end
  else if (parameters.Count<2) then
  begin
    raise Exception.Create('“刷卡上车功能”需要指定车辆报到ID');
  end
  else if (parameters.Count<3) then
  begin
    raise Exception.Create('“刷卡上车功能”需要指定检票口');
  end;
  _scheduleplanid:=StrToInt64Def(parameters.Strings[0],0);
  _vehiclereportid:=StrToInt64Def(parameters.Strings[1],0);
  _ticketentrance:=parameters.Strings[2];
  if _scheduleplanid<=0 then
  begin
    raise Exception.Create('传入班次计划ID参数错误');
  end;
  if _vehiclereportid<=0 then
  begin
    raise Exception.Create('传入车辆报到ID参数错误');
  end;
  FrmOneCard:=TFrmOneCard.Create(Application,Self,parameters,False);
  try
    with FrmOneCard do
    begin
      scheduleplanid:=_scheduleplanid;
      vehiclereportid:=_vehiclereportid;
      ticketentrance:=_ticketentrance;
      jcdsschedule.Params.ParamValues['scheduleplanid']:=scheduleplanid;
      jcdsschedule.Params.ParamValues['vehiclereportid']:=vehiclereportid;
      jcdsschedule.Params.ParamValues['checkstationid']:=SysInfo.LoginUserInfo.StationID;
      jcdsschedule.Active:=True;
      lblDepartdate.Caption:=jcdsschedule.FieldByName('departdate').AsString;
      lblEntrance.Caption:=jcdsschedule.FieldByName('ticketentrance').AsString;
      lblvehicleno.Caption:=jcdsschedule.FieldByName('vehicleno').AsString;
      lblEndStation.Caption:=jcdsschedule.FieldByName('endstationname').AsString;
      lblScheduleCode.Caption:=jcdsschedule.FieldByName('schedulecode').AsString;
      lblresidueseatnum.Caption:=jcdsschedule.FieldByName('residueseatnum').AsString;
      if jcdsschedule.FieldByName('islinework').AsBoolean then
        lblDepartTime.Caption:='流水班'
      else
        lblDepartTime.Caption:=jcdsschedule.FieldByName('departtime').AsString;
      lblfullprice.Caption:=jcdsschedule.FieldByName('fullpfice').AsString;

      if (jcdsschedule.RecordCount=0) then
      begin
        SysDialogs.Warning('该班次还未报到');
        FrmOneCard.Free;
      end
      else
      begin
        if (jcdsschedule.FieldByName('isdeparted').AsBoolean) then
        begin
          SysDialogs.Warning('该班次已发班，不允许刷卡上车');
          FrmOneCard.Free;
        end
        else if (not jcdsschedule.FieldByName('isbegincheck').AsBoolean) then
        begin
          SysDialogs.Warning('该班次还未开始检票，不允许刷卡上车');
          FrmOneCard.Free;
        end
        else if (jcdsschedule.FieldByName('status').AsString<>'0')
          and (FrmOneCard.jcdsschedule.FieldByName('status').AsString<>'2') then
        begin
          SysDialogs.Warning('该班次已停班，不允许刷卡上车');
          FrmOneCard.Free;
        end
        else
        begin
          SysMainForm.showFormModal(FrmOneCard,True);
        end;
      end;
    end;
  except
    SysDialogs.Warning('该班次还未报到');
    FrmOneCard.Free;
    Exit;
  end;
end;

function TOneCardFunction.getDescribe: String;
begin
  result:='一卡通刷卡上车';
end;

function TOneCardFunction.getKey: TGUID;
begin
  Result:=StringToGUID('{51F3A99E-2748-4FE6-B0AD-B498EF283063}');
end;

function TOneCardFunction.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TOneCardFunction.IsWorkState: Boolean;
begin

end;

procedure TOneCardFunction.Leave;
begin

end;

procedure TOneCardFunction.refresh(
  const parameters: TFunctionItemParameters);
begin

end;


{ TOneCardFunctionReturn }

procedure TOneCardFunctionReturn.ChangeTheme;
begin

end;

constructor TOneCardFunctionReturn.Create;
begin

end;

procedure TOneCardFunctionReturn.Enter(const parameters: TFunctionItemParameters);
var FrmOneCardReturn:TFrmOneCardReturn;
begin
  FrmOneCardReturn:=TFrmOneCardReturn.Create(Application,Self,parameters,False);
  SysMainForm.showFormModal(FrmOneCardReturn,True);
end;

function TOneCardFunctionReturn.getDescribe: String;
begin
  result:='一卡通退检退票';
end;

function TOneCardFunctionReturn.getKey: TGUID;
begin
  Result:=StringToGUID('{02A6C5E1-4100-4B1B-9BB8-475D517DA0F3}');
end;

function TOneCardFunctionReturn.getSubFunctionList: TList<TSubfunction>;
begin

end;

function TOneCardFunctionReturn.IsWorkState: Boolean;
begin

end;

procedure TOneCardFunctionReturn.Leave;
begin

end;

procedure TOneCardFunctionReturn.refresh(
  const parameters: TFunctionItemParameters);
begin

end;

end.
