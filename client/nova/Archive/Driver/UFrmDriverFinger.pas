unit UFrmDriverFinger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, Services, ImgList, StdCtrls, Buttons, ExtCtrls,
  NovaEdit,
  NovaHelp, OleCtrls, mmsystem, ZKFPEngXControl_TLB, DB, DBClient,
  jsonClientDataSet, jpeg;

type
  TFrmDriverFinger = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    LabInfo: TLabel;
    GroupBox1: TGroupBox;
    Image1: TImage;
    ZKFPEngX1: TZKFPEngX;
    jsonSpcQry: TjsonClientDataSet;
    jscdSaveFinger: TjsonClientDataSet;
    NovaDriver: TNovaHelp;
    procedure ZKFPEngX1ImageReceived(ASender: TObject;
      var AImageValid: WordBool);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ZKFPEngX1FeatureInfo(ASender: TObject; AQuality: Integer);
    procedure ZKFPEngX1Enroll(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure NovaDriverIdChange(Sender: TObject);
    procedure ZKFPEngX1Capture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    FID: Integer;
    FMatchType: Integer;
    FAutoIdentify:boolean;
    FFingerName: TStringList;
    iOld: DWORD;
    sRegTemplate: WideString;
    fpcHandle: Integer;
    procedure beginreg;
    procedure savefinger(fingercode: WideString);
  public
    { Public declarations }
  end;

var
  FrmDriverFinger: TFrmDriverFinger;

implementation

uses PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmDriverFinger.beginreg;
begin
  ZKFPEngX1.CancelEnroll;
  //ZKFPEngX1.CancelCapture;
  ZKFPEngX1.EnrollCount := 3;
  ZKFPEngX1.BeginEnroll;
  //ZKFPEngX1.BeginCapture;
end;

procedure TFrmDriverFinger.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //ZKFPEngX1.CancelCapture;
end;

procedure TFrmDriverFinger.FormDestroy(Sender: TObject);
begin
   if fpcHandle<=0 then exit;
   ZKFPEngX1.FreeFPCacheDB(fpcHandle);
   //ZKFPEngX1.Free;
  inherited;
end;

procedure TFrmDriverFinger.FormShow(Sender: TObject);
begin
  inherited;

  with jsonSpcQry do
  begin
    active := False;
    active := true;
  end;
  FFingerName := TStringList.Create;
  fpcHandle := ZKFPEngX1.CreateFPCacheDB;
  FAutoIdentify := False;
  if (ZKFPEngX1.InitEngine = 0) and (ZKFPEngX1.SensorCount > 0) then
  begin
    LabInfo.Caption := '指纹设备初始化成功！';
    // Finitsuccess := true;

  end
  else
  begin
    ZKFPEngX1.Visible := False;
    LabInfo.Caption := '指纹设备初始化失败！';
    // Finitsuccess := False;
  end;
  beginreg;


end;

procedure TFrmDriverFinger.NovaDriverIdChange(Sender: TObject);
begin
  inherited;
  if (NovaDriver.Text<>'') and  (NovaDriver.Id>0) then
  begin
    LabInfo.Caption := '请按指纹！';
    LabInfo.Refresh;
    PlaySound('pressfinger.wav', 0, snd_async);
  end;
end;

procedure TFrmDriverFinger.savefinger(fingercode: WideString);
var
  nResult: Integer;
  sResult, result: string;
  jpgimage: TJPEGImage;
  memoryStream: TMemoryStream;
begin
  memoryStream := nil;
  with jscdSaveFinger do
  begin
    close;
    Params.ParamByName('driver.id').Value := NovaDriver.Id;
    Params.ParamByName('driver.fingerstr1').Value := fingercode;

    if Image1.Picture.Graphic <> nil then
    begin
      if not Assigned(memoryStream) then
        memoryStream := TMemoryStream.Create
      else
        memoryStream.Clear;
      jpgimage := TJPEGImage.Create;
      try
        jpgimage.Assign(Image1.Picture.Graphic);
        jpgimage.CompressionQuality := 30;
        jpgimage.Compress;
        jpgimage.SaveToStream(memoryStream);
      finally
        jpgimage.Free;
      end;
      if memoryStream.Size > 32768 then
      begin
        ShowMessage(inttostr(memoryStream.Size) + '图片过大！');
        exit;
      end;

      if memoryStream <> nil then
        Params.ParamByName('pictures').Value := MemoryStreamToHexStr
          (memoryStream);
      // Parameters.ParambyName('iv_blob_finger').LoadFromStream(memoryStream,
      // ftBlob);

      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        LabInfo.Caption := (sResult);
        LabInfo.Refresh;
        if (nResult = 1) then
        begin
          PlaySound('thankyou.wav', 0, snd_async);
          Image1.Picture := nil;
          Image1.Refresh;
          NovaDriver.Clear;
          NovaDriver.Id := 0;
          beginreg;
        end;
        if Assigned(memoryStream) then
          memoryStream.Free;
      except
        On E: Exception do
        begin
          if Assigned(memoryStream) then
            memoryStream.Free;
          exit;
        end;
      end;
    end;
  end;

end;

procedure TFrmDriverFinger.ZKFPEngX1Capture(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
var
  ID, I: Integer;
  Score, ProcessNum: Integer;
  RegChange: wordBool;
  iNew: Integer;
  sTemp, sName: string;
  Num1, Num2: Integer;
  //tmp: OleVariant;
 // p, p1: Pointer;
 // sVerTemplate:WideString;
begin
  iNew:=0;
  //EdtFingerStr.text:=ZKFPEngX1.GetTemplateAsString;
  if FMatchType = 1 then
  begin //1:1
     sTemp:=ZKFPEngX1.GetTemplateAsString;
     if ZKFPEngX1.VerFingerFromStr(sRegTemplate,sTemp, false, regChange) then
        LabInfo.Caption:='指纹校验成功！'
     else
        LabInfo.Caption:='指纹校验失败！';
  end
  else if FMatchType = 2 then
  begin //1:N
     if not FAutoIdentify then
     begin
        Score := 8;
        ID := ZKFPEngX1.IdentificationFromStrInFPCacheDB(fpcHandle, ZKFPEngX1.GetTemplateAsString, Score, ProcessNum);
        iNew := GetTickCount - iOld;
        if ID = -1 then
          LabInfo.Caption:='指纹校验成功,分值:' + IntToStr(Score) + ' ID = ' + IntToStr(ProcessNum)
        else
        begin
           for I := 0 to FFingerName.Count - 1 do
             if ID = Integer(FFingerName.Objects[I]) then
               LabInfo.Caption:=Format('指纹校验成功, Name= %s Score = %d Processed Number = %d time = %dms',
                   [FFingerName.Strings[I], Score, ProcessNum, iNew]);

        end;
     end
     else
     begin
        ID := ATemplate[0];
        Score := ATemplate[1];
        if ID = -1 then
           sTemp := 'Fingerprint verification Failed! '
        else
           sTemp := 'Fingerprint identification success!';
        Num1 := ATemplate[2];
        Num2 := ATemplate[3];
        for I := 0 to FFingerName.Count - 1 do
        begin
          if ID = Integer(FFingerName.Objects[I]) then
              sName := FFingerName.Strings[I];
        end;
        LabInfo.Caption:=sTemp + Format(' Name= %s Score = %d Processed Number = %d | %d  time = %d',
              [sName, Score, num1, num2, iNew]);
     end;
  end;

end;

procedure TFrmDriverFinger.ZKFPEngX1Enroll(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
var
  sTemp: WideString;
  isexist: boolean;
  RegChange: WordBool;
  Id: Integer;
  Score, ProcessNum: Integer;
  lvnresult: Integer;
  lvsresult: string;
begin
  inherited;
  if not ActionResult then
  begin
    LabInfo.Caption := '指纹登记失败，请重新登记！';
    LabInfo.Font.Color := clRed;
    LabInfo.Refresh;
    // sleep(500);
    LabInfo.Font.Color := clblack;
    LabInfo.Refresh;
    // sleep(500);
    LabInfo.Caption := '开始登记，同一手指请按指纹识别器3次';
    beginreg;

    LabInfo.Font.Color := clblue;
    LabInfo.Refresh;
    exit;
  end
  else
  begin
    // ZKFPEngX1.CancelCapture;
    ZKFPEngX1.EncodeTemplate(ATemplate, sRegTemplate);
    ZKFPEngX1.ModifyTemplateStr(sRegTemplate, true);
    ZKFPEngX1.AddRegTemplateStrToFPCacheDB(fpcHandle, FID, sRegTemplate);
    LabInfo.Caption := '正在对比指纹，请勿再按指纹！';
    LabInfo.Font.Color := clRed;
    // ZKFPEngX1.CancelEnroll;
    LabInfo.Refresh;
    isexist := False;
    with jsonSpcQry do
    begin
      if active then
      begin
        first;
        while (not eof) do
        begin
          sTemp := FieldByName('fingerstr').AsString;
          if ZKFPEngX1.VerFingerFromStr(sTemp, sRegTemplate, False, RegChange)
            then
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
      LabInfo.Caption := '该指纹已经存在，请重新登记！';
      LabInfo.Font.Color := clRed;
      LabInfo.Refresh;
      // sleep(500);
      LabInfo.Font.Color := clblack;
      LabInfo.Refresh;
      sleep(500);
      LabInfo.Caption := '开始登记，同一手指请按指纹识别器3次';
      beginreg;
      LabInfo.Font.Color := clblue;
      LabInfo.Refresh;
      PlaySound('pressfinger.wav', 0, snd_async);
      exit;
    end
    else
    begin
      savefinger(sRegTemplate);
      LabInfo.Caption := '指纹登记成功!';
      // benginreg;
      LabInfo.Font.Color := clblue;
      LabInfo.Refresh;
      sleep(500);
      LabInfo.Caption := '开始登记，同一手指请按指纹识别器3次';
      beginreg;
      LabInfo.Font.Color := clblue;
      PlaySound('pressfinger.wav', 0, snd_async);
      LabInfo.Refresh;
    end;
  end;
end;

procedure TFrmDriverFinger.ZKFPEngX1FeatureInfo(ASender: TObject;
  AQuality: Integer);
var
  sTemp: string;
begin
  sTemp := '';
  if ZKFPEngX1.EnrollIndex <> 1 then
    if ZKFPEngX1.IsRegister then
      if ZKFPEngX1.EnrollIndex - 1 > 0 then
      begin
        sTemp := '请再按手指 ' + inttostr(ZKFPEngX1.EnrollIndex - 1) + ' 次!';
        PlaySound('Pressagain.wav', 0, snd_async);
      end
      else
        sTemp := '';
  sTemp := sTemp + ' 当前指纹';

  if AQuality <> 0 then
    sTemp := sTemp + '不合格，请重新按指纹！'
  else
    sTemp := sTemp + '合格';
  LabInfo.Caption := sTemp;

end;

procedure TFrmDriverFinger.ZKFPEngX1ImageReceived(ASender: TObject;
  var AImageValid: WordBool);
var
  sFileName: string;
begin
  // if not FReceived then
  // exit;

  sFileName :=ExtractFilePath(Paramstr(0))+'\Fingerprint.jpg';
  with ZKFPEngX1 do
  begin
    Image1.Picture := nil;
    ZKFPEngX1.SaveJPG(sFileName);
    Image1.Picture.LoadFromFile(sFileName);
    Image1.Refresh;
  end;

end;

end.
