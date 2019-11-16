unit UFinger;

interface

uses
  ZKFPEngXControl_TLB, Graphics, jpeg, Classes, ExtCtrls, SysUtils, StdCtrls,
  mmsystem, jsonClientDataSet, Services, NovaHelp;

type
  TOnEnrollEvent = procedure(fingercode: WideString) of object;

type
  TOnCaptureEvent = procedure(driverid1: int64; driverid2: int64;
    ovnresult: integer; ovsresult: string) of object;

type
  TFinger = class(TObject)

  private
    Femployeeid1: int64;
    Femployeeid2: int64;
    Femployees: integer;
    FReceived: boolean;
    sRegTemplate: WideString;
    Finitsuccess: boolean;
    FIsRegister: boolean;
    FImage1: TImage;
    FImage2: TImage;
    FID: integer;
    // FisOnlyName: boolean; // 是否只获取驾驶员姓名
    FLabInfo: TLabel;
    fpcHandle: integer;
    ZKFPEngX1: TZKFPEngX;
    // Ffingercode: String; // 特征码
    // FLabDriver1: TLabel;
    // FLabDriver2: TLabel;
    // Ffingerinfo: TBitmap;
    Fnvdriver1: TNovaHelp;
    Fnvdriver2: TNovaHelp;
    Fnvdriver3: TNovaHelp;
    Fnvsteward: TNovaHelp;
    // Ffinger: TBitmap; // 指纹
    FSpcQry: TjsonClientDataSet;
    FStwedQry: TjsonClientDataSet;
    isexist: boolean;
    FOnCapture: TOnCaptureEvent;
    Frouteid: int64;
    FOnEnroll: TOnEnrollEvent;
    procedure ZKFPEngX1FeatureInfo(ASender: TObject; AQuality: integer);
    procedure ZKFPEngX1Enroll(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure ZKFPEngX1ImageReceived(ASender: TObject;
      var AImageValid: WordBool);
    procedure ZKFPEngX1Capture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure SetRegister(const Value: boolean);
    procedure setEmployees(const Value: integer);
    procedure setRouteid(const Value: int64);

  public
    Drivername: String; // 驾驶员姓名
    Driverid: int64;
    property IsRegister
      : boolean read FIsRegister write SetRegister stored False;
    constructor Create(ASender: TComponent);
    destructor Destroy;
    property initsuccess: boolean read Finitsuccess;
    procedure init;
    procedure CancelCapture;
    procedure PlayPressSound;
    procedure benginreg;
    procedure setLabInfo1(var LabInfo: TLabel);
    procedure setDriverDataSet(var spcQry: TjsonClientDataSet);
    procedure setStewardDataSet(var spcQry: TjsonClientDataSet);
    procedure setDriver1Compent(var nvdriver1: TNovaHelp);
    procedure setDriver2Compent(var nvdriver2: TNovaHelp);
    procedure setDriver3Compent(var nvdriver3: TNovaHelp);
    procedure setStewardCompent(var nvsteward: TNovaHelp);
    procedure setImage1Compent(var Image1: TImage);
    procedure setImage2Compent(var Image2: TImage);
    procedure setHintCompent(var LabInfo: TLabel);

    property OnEnroll: TOnEnrollEvent read FOnEnroll write FOnEnroll;
    property employees: integer read Femployees write setEmployees;
    property routeid: int64 read Frouteid write setRouteid;
    property OnCapture: TOnCaptureEvent read FOnCapture write FOnCapture;
  end;

var
  finger: TFinger;

implementation

{ TFinger }

procedure TFinger.benginreg;
begin
  if Finitsuccess then // and FIsRegister
  begin
    PlaySound('pressfinger.wav', 0, snd_async);
    FLabInfo.Caption := '请按指纹识别器';
    FLabInfo.Font.Color := clred;
    FLabInfo.Refresh;

    if IsRegister then
    begin
      ZKFPEngX1.CancelEnroll;
      ZKFPEngX1.CancelCapture;
      ZKFPEngX1.EnrollCount := 3;
      ZKFPEngX1.BeginEnroll;
      ZKFPEngX1.BeginCapture;
    end
    else
    begin
      ZKFPEngX1.CancelEnroll;
      ZKFPEngX1.CancelCapture;
      ZKFPEngX1.EnrollCount := 1;
      ZKFPEngX1.BeginEnroll;
      ZKFPEngX1.BeginCapture;
    end;
  end;
end;

procedure TFinger.CancelCapture;
begin
  ZKFPEngX1.CancelEnroll;
  ZKFPEngX1.CancelCapture;
end;

constructor TFinger.Create(ASender: TComponent);
begin
  ZKFPEngX1 := TZKFPEngX.Create(ASender);
  fpcHandle := ZKFPEngX1.CreateFPCacheDB;
  ZKFPEngX1.OnFeatureInfo := ZKFPEngX1FeatureInfo;
  ZKFPEngX1.OnEnroll := ZKFPEngX1Enroll;
  ZKFPEngX1.OnImageReceived := ZKFPEngX1ImageReceived;
  ZKFPEngX1.OnCapture := ZKFPEngX1Capture;
  FSpcQry := TjsonClientDataSet.Create(ASender);
  FStwedQry := TjsonClientDataSet.Create(ASender);
  FLabInfo := TLabel.Create(ASender);
end;

destructor TFinger.Destroy;
begin
  ZKFPEngX1.EndEngine;
  ZKFPEngX1.FreeFPCacheDB(fpcHandle);
  ZKFPEngX1.Free;
  inherited;
end;

procedure TFinger.init;
var
  sTemp: WideString;
  pVerTemplate: OleVariant;
  pid: integer;
begin
  try
    FReceived := true;
    if not Finitsuccess then
    begin
      if (ZKFPEngX1.InitEngine = 0) and (ZKFPEngX1.SensorCount > 0) then
      begin
        // FLabInfo.Caption := '指纹设备初始化成功！';
        Finitsuccess := true;
      end
      else
      begin
        // FLabInfo.Caption := '指纹设备初始化失败！';
        Finitsuccess := False;
      end;
    end;
    { if Finitsuccess then // and FIsRegister
      begin
      benginreg;
      PlaySound('pressfinger.wav', 0, snd_async);
      FLabInfo.Caption := '请按指纹识别器';
      FLabInfo.Font.Color := clred;
      FLabInfo.Refresh;
      end; }
    ZKFPEngX1.IsRegister := IsRegister;
    if Finitsuccess and (not IsRegister) then
    begin
      ZKFPEngX1.SetAutoIdentifyPara(true, fpcHandle, 8);
      if FSpcQry <> nil then
        with FSpcQry do
        begin
          if active then
          begin
            first;
            while (not eof) do
            begin
              try
                sTemp := FieldByName('fingerstr').AsWideString;
                pid := FieldByName('id').AsInteger;
                // ZKFPEngX1.DecodeTemplate(sTemp,pVerTemplate);
                ZKFPEngX1.AddRegTemplateStrToFPCacheDB(fpcHandle, pid, sTemp);
              except
                on E: Exception do
                begin
                  SysLog.WriteErr(inttostr(pid) + '驾驶员指纹注册失败：' + E.Message);
                end;
              end;
              next;
            end;
          end;

        end;
      if FStwedQry <> nil then
        with FStwedQry do
        begin
          if active then
          begin
            first;
            while (not eof) do
            begin
              try
                sTemp := FieldByName('fingerstr').AsWideString;
                pid := FieldByName('id').AsInteger;
                ZKFPEngX1.AddRegTemplateStrToFPCacheDB(fpcHandle, pid, sTemp);
              except
                on E: Exception do
                begin
                  SysLog.WriteErr(inttostr(pid) + '乘务员指纹注册失败：' + E.Message);
                end;
              end;
              next;
            end;
          end;

        end;

    end;

  except
    on E: Exception do
    begin
      SysLog.WriteErr(inttostr(pid) + '指纹初始化失败：' + E.Message);
    end;
  end;
end;

procedure TFinger.PlayPressSound;
begin
  PlaySound('pressfinger.wav', 0, snd_async);
end;

procedure TFinger.setDriver1Compent(var nvdriver1: TNovaHelp);
begin
  Fnvdriver1 := nvdriver1;
end;

procedure TFinger.setDriver2Compent(var nvdriver2: TNovaHelp);
begin
  Fnvdriver2 := nvdriver2;
end;

procedure TFinger.setDriver3Compent(var nvdriver3: TNovaHelp);
begin
  Fnvdriver3 := nvdriver3;
end;

procedure TFinger.setDriverDataSet(var spcQry: TjsonClientDataSet);
begin
  FSpcQry := spcQry;
end;

procedure TFinger.setEmployees(const Value: integer);
begin
  Femployees := Value;
end;

procedure TFinger.setHintCompent(var LabInfo: TLabel);
begin
  FLabInfo := LabInfo;
end;

procedure TFinger.setLabInfo1(var LabInfo: TLabel);
begin
  FLabInfo := LabInfo;
end;

procedure TFinger.SetRegister(const Value: boolean);
begin
  FIsRegister := Value;
end;

procedure TFinger.setRouteid(const Value: int64);
begin
  Frouteid := Value;
end;

procedure TFinger.setStewardCompent(var nvsteward: TNovaHelp);
begin
  Fnvsteward := nvsteward;
end;

procedure TFinger.setStewardDataSet(var spcQry: TjsonClientDataSet);
begin
  FStwedQry := spcQry;
end;

procedure TFinger.ZKFPEngX1Capture(ASender: TObject; ActionResult: WordBool;
  ATemplate: OleVariant);
var
  ID, lvnresult: integer;
  lvsresult: string;

begin
  // if not FReceived then
  // exit;
  isexist := False;
  ID := ATemplate[0];
  if ID = -1 then
  begin
    // employeeid1:=0;
    FLabInfo.Caption := '系统中不存在该指纹信息！';
    FLabInfo.Font.Color := clred;
    FLabInfo.Refresh;
    sleep(500);
    FLabInfo.Font.Color := clblack;
    FLabInfo.Refresh;
    sleep(500);
    FLabInfo.Caption := '请按指纹识别器……';
    FLabInfo.Font.Color := clblue;
    FLabInfo.Refresh;

    PlaySound('Pressagain.wav', 0, snd_async);
  end
  else
  begin
    if FStwedQry <> nil then
      with FStwedQry do
      begin
        first;
        while not eof do
        begin
          if FieldByName('id').AsLargeInt = ID then
          begin
            isexist := true;
            // Driverid := ID;
            // Drivername := FieldByName('name').AsString;

            Fnvsteward.ID := ID;
            Fnvsteward.Text := FieldByName('name').AsString;
            PlaySound('thankyou.wav', 0, snd_async);
            exit;
          end;
          next;
        end;
      end;
    if FSpcQry <> nil then
      with FSpcQry do
      begin
        first;
        while not eof do
        begin
          if FieldByName('id').AsLargeInt = ID then
          begin
            isexist := true;
            Driverid := ID;
            Drivername := FieldByName('name').AsString;
            if Fnvdriver1.ID = 0 then
            begin
              Fnvdriver1.ID := Driverid;
              Fnvdriver1.Text := Drivername;
            end
            else
            begin
              Fnvdriver2.ID := Driverid;
              Fnvdriver2.Text := Drivername;
            end;
            PlaySound('thankyou.wav', 0, snd_async);
            exit;
          end;
          next;
        end;
      end;

    if not isexist then
    begin
      PlaySound('Pressagain.wav', 0, snd_async);
    end;
  end;

end;

procedure TFinger.ZKFPEngX1Enroll(ASender: TObject; ActionResult: WordBool;
  ATemplate: OleVariant);
var
  sTemp: WideString;
  isexist: boolean;
  RegChange: WordBool;
  ID: integer;
  Score, ProcessNum: integer;
  lvnresult: integer;
  lvsresult: string;
begin
  if not FReceived then
    exit;
  if not IsRegister then
  begin
    isexist := False;
    Score := 8;
    sRegTemplate := ZKFPEngX1.GetTemplateAsString;
    ID := ZKFPEngX1.IdentificationFromStrInFPCacheDB(fpcHandle, sRegTemplate,
      Score, ProcessNum);
    if ID = -1 then
    begin
      sRegTemplate := '';
      FLabInfo.Caption := '系统中不存在该指纹信息！';
      FLabInfo.Font.Color := clred;
      FLabInfo.Refresh;
      sleep(500);
      FLabInfo.Font.Color := clblack;
      FLabInfo.Refresh;
      sleep(500);
      FLabInfo.Caption := '请按指纹识别器……';
      FLabInfo.Font.Color := clblue;
      FLabInfo.Refresh;
      PlaySound('Pressagain.wav', 0, snd_async);
    end
    else
    begin

      if not isexist then
        if FStwedQry <> nil then
          with FStwedQry do
          begin
            first;
            while not eof do
            begin
              if FieldByName('id').AsLargeInt = ID then
              begin
                isexist := true;
                // Driverid := ID;
                // Drivername := FieldByName('name').AsString;

                Fnvsteward.ID := ID;
                Fnvsteward.Text := FieldByName('name').AsString;
                PlaySound('thankyou.wav', 0, snd_async);
                exit;
              end;
              next;
            end;
          end;

      if FSpcQry <> nil then
        with FSpcQry do
        begin
          first;
          while not eof do
          begin
            if FieldByName('id').AsLargeInt = ID then
            begin
              isexist := true;
              Driverid := ID;
              Drivername := FieldByName('name').AsString;
              if Fnvdriver1.ID = 0 then
              begin
                Fnvdriver1.ID := Driverid;
                Fnvdriver1.Text := Drivername;
              end
              else
              begin
                Fnvdriver2.ID := Driverid;
                Fnvdriver2.Text := Drivername;
              end;
              PlaySound('thankyou.wav', 0, snd_async);
              exit;
            end;
            next;
          end;

        end;

      if not isexist then
      begin
        PlaySound('Pressagain.wav', 0, snd_async);
      end;
    end;
  end
  else
  begin
    // 采集指纹
    if not ActionResult then
    begin
      FLabInfo.Caption := '指纹登记失败，请重新登记！';
      FLabInfo.Font.Color := clred;
      FLabInfo.Refresh;
      sleep(500);
      FLabInfo.Font.Color := clblack;
      FLabInfo.Refresh;
      sleep(500);
      FLabInfo.Caption := '开始登记，同一手指请按指纹识别器3次';
      benginreg;

      FLabInfo.Font.Color := clblue;
      FLabInfo.Refresh;
      exit;
    end
    else
    begin
      ZKFPEngX1.CancelCapture;
      FLabInfo.Caption := '正在对比指纹，请勿再按指纹！';
      FLabInfo.Font.Color := clred;
      ZKFPEngX1.CancelEnroll;
      FLabInfo.Refresh;
      ZKFPEngX1.EncodeTemplate(ATemplate, sRegTemplate);

      ZKFPEngX1.ModifyTemplateStr(sRegTemplate, true);
      ZKFPEngX1.AddRegTemplateStrToFPCacheDB(fpcHandle, FID, sRegTemplate);

      isexist := False;
      if FSpcQry <> nil then
        with FSpcQry do
        begin
          if active then
          begin
            first;
            while (not eof) do
            begin
              sTemp := FieldByName('fingerstr').AsString;
              if ZKFPEngX1.VerFingerFromStr(sTemp, sRegTemplate, False,
                RegChange) then
              begin
                isexist := true;
                break;
              end;
              next;
            end;
          end;
        end;
      if isexist then
      begin
        FLabInfo.Caption := '该指纹已经存在，请重新登记！';
        FLabInfo.Font.Color := clred;
        FLabInfo.Refresh;
        sleep(500);
        FLabInfo.Font.Color := clblack;
        FLabInfo.Refresh;
        sleep(500);
        FLabInfo.Caption := '开始登记，同一手指请按指纹识别器3次';
        benginreg;
        FLabInfo.Font.Color := clblue;
        FLabInfo.Refresh;
        exit;
      end
      else
      begin
        OnEnroll(sRegTemplate);
        FLabInfo.Caption := '指纹登记成功!';
        // benginreg;
        FLabInfo.Font.Color := clblue;
        FLabInfo.Refresh;
        PlaySound('thankyou.wav', 0, snd_async);
        sleep(2000);
        FLabInfo.Caption := '开始登记，同一手指请按指纹识别器3次';
        benginreg;
        // PlaySound('pressfinger.wav', 0, snd_async);
        FImage1.Picture := nil;
        FLabInfo.Font.Color := clblue;
        FLabInfo.Refresh;
      end;

    end;
  end;

end;

procedure TFinger.ZKFPEngX1FeatureInfo(ASender: TObject; AQuality: integer);
var
  sTemp: string;
begin
  sTemp := '';
  if ZKFPEngX1.EnrollIndex <> 1 then
    if ZKFPEngX1.IsRegister then
      if ZKFPEngX1.EnrollIndex - 1 > 0 then
        sTemp := '请再按手指 ' + inttostr(ZKFPEngX1.EnrollIndex - 1) + ' 次!'
      else
        sTemp := '';
  sTemp := sTemp + ' 当前指纹';

  if AQuality <> 0 then
    sTemp := sTemp + '不合格，请重新按指纹！'
  else
    sTemp := sTemp + '合格';
  FLabInfo.Caption := sTemp;

end;

procedure TFinger.setImage1Compent(var Image1: TImage);
begin
  FImage1 := Image1;
end;

procedure TFinger.setImage2Compent(var Image2: TImage);
begin
  FImage2 := Image2;
end;

procedure TFinger.ZKFPEngX1ImageReceived(ASender: TObject;
  var AImageValid: WordBool);
var
  sFileName: string;
begin
  if not FReceived then
    exit;

  sFileName := 'C:\Fingerprint.jpg';
  with ZKFPEngX1 do
  begin
    if Femployees = 1 then
    begin
      FImage1.Picture := nil;
      ZKFPEngX1.SaveJPG(sFileName);
      FImage1.Picture.LoadFromFile(sFileName);
      FImage1.Refresh;
    end
    else
    begin
      if (FImage1.Picture = nil) or (Femployeeid1 = 0) then
      begin
        FImage1.Picture := nil;
        ZKFPEngX1.SaveJPG(sFileName);
        FImage1.Picture.LoadFromFile(sFileName);
        FImage1.Refresh;
      end
      else
      begin
        FImage2.Picture := nil;
        ZKFPEngX1.SaveJPG(sFileName);
        FImage2.Picture.LoadFromFile(sFileName);
        FImage2.Refresh;
      end;
    end;
  end;

end;

Initialization

Finalization

end.
