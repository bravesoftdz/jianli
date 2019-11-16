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
        // ��ȡ����������Ϣ
    function checkVehicle(vehicleid: Int64; departdate: string): boolean;

  public
    { Public declarations }
    scheduleplanid,vehiclereportid:Int64;
      isMustCheck: boolean; // �Ƿ���밲��
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
    SysDialogs.Warning('����������ĳ��ţ�');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;
  if ((NovaHelpReportVehicle.Text)=(NovaHelpVehicleno.text))
   then
  begin
    SysDialogs.Warning('�����ĳ����������ѱ�������һ����');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;

  if (isMustCheck) then
  begin
    if cbbCheckResult.ItemIndex = 0 then
    begin
      SysDialogs.Warning('�ó�����δ���а��죬����������');
      NovaHelpVehicleno.SetFocus;
      exit;
    end
    else if cbbCheckResult.ItemIndex = 2 then
    begin
      SysDialogs.Warning('�ó������첻�ϸ񣬲���������');
      NovaHelpVehicleno.SetFocus;
      exit;
    end
  end;
  //�Ƿ��������������
  if getParametervalue('0143', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    //  ��ѯ������̼������ȡ����������������Ƶ������
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
        temp := Pos('�ó�������',sResult) ;
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
   //�Ƿ�����������ά����Ч��
  if getParametervalue('6006', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    //  ��ѯ������̼������ȡ����ά��Ч��
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
        temp := Pos('�ó�������',sResult) ;
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
  SysDialogs.ShowInfo(distancemessage+',�ﵽ��ά���ޣ�');
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
        SysLog.WriteErr('������������ʧ�ܣ�' + E.Message);
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
      // -1δ�� 1�ϸ� 0���ϸ� 2���ް���ƻ�����У�鰲�� 3:24Сʱ�ڰ���ϸ�
              //- 2,�ѷ�����̴���������Ҫ�ظ�������̣���ʾ��Ҫ�ٴΰ���
      if (isMustCheck) then
      begin
        cbbCheckResult.Enabled := false;
//        if (nResult = -3) then  //�а���ƻ������밲��
//        begin
//            cbbCheckResult.ItemIndex := 0;
//            result := false;
//            cbbCheckResult.Enabled := false;
//            exit;
//        end;
        if (nResult = -1) then     //�ó������ջ�û���죡
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
        else if (nResult = 1) then    //�ó�����������ϸ�!
        begin
          if sResult='�ó�����û���죡' then
            begin
                cbbCheckResult.ItemIndex := 0;
                cbbCheckResult.Enabled := false;
            end
            else
                cbbCheckResult.ItemIndex := 1;
          result := true;
          exit;
        end
         else if (nResult = 2) then  //��ǰ�����ް���ƻ�!
        begin
          //�Ƿ���Ҫ����ϸ��������
          if isMustCheck then
          begin
            if  ischeckwithout = '1' then
            begin
                sResult := '����ϸ����������';
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
        else if (nResult = 3) then //�ó���24Сʱ������ϸ�!
        begin
          cbbCheckResult.ItemIndex := 1;
          cbbCheckResult.Enabled := false;
          result := true;
          exit;
        end
        else if (nResult = 0) then  //�ó����������첻�ϸ�
        begin
          cbbCheckResult.ItemIndex := 2;
          cbbCheckResult.Enabled := false;
          result := false;
          exit;
        end
        else if (nResult = -2) or (nResult = -3) then //��ʾ��Ҫ�ٴΰ���
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
        mmoCheckResult.Text := 'ϵͳδ���ó�����Ҫ���죡';
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
        SysLog.WriteErr('��ȡ����������Ϣʧ�ܣ�' + E.Message);
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
