unit UFrmStewardFinger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, OleCtrls,
  ZKFPEngXControl_TLB, jpeg,DB, mmsystem,DBClient, jsonClientDataSet, NovaEdit, NovaHelp;

type
  TFrmStewardFinger = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    LabInfo: TLabel;
    GroupBox1: TGroupBox;
    Image1: TImage;
    jscdSaveFinger: TjsonClientDataSet;
    jsonSpcQry: TjsonClientDataSet;
    ZKFPEngX1: TZKFPEngX;
    NovaHelpsteward: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHelpstewardIdChange(Sender: TObject);
    procedure ZKFPEngX1Enroll(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure ZKFPEngX1ImageReceived(ASender: TObject;
      var AImageValid: WordBool);
    procedure ZKFPEngX1FeatureInfo(ASender: TObject; AQuality: Integer);
  private
    { Private declarations }
    FID: Integer;
    // mem: TMemoryStream;
    sRegTemplate: WideString;
    fpcHandle: Integer;
    procedure beginreg;
    procedure savefinger(fingercode: WideString);
  public
    { Public declarations }
  end;

var
  FrmStewardFinger: TFrmStewardFinger;

implementation

uses PubFn, UDMPublic;
{$R *.dfm}

{ TFrmStewardFinger }

procedure TFrmStewardFinger.beginreg;
begin
  ZKFPEngX1.CancelEnroll;
  ZKFPEngX1.CancelCapture;
  ZKFPEngX1.EnrollCount := 3;
  ZKFPEngX1.BeginEnroll;
  ZKFPEngX1.BeginCapture;
end;

procedure TFrmStewardFinger.FormCreate(Sender: TObject);
begin
  inherited;
 fpcHandle := ZKFPEngX1.CreateFPCacheDB;
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
  PlaySound('pressfinger.wav', 0, snd_async);
end;

procedure TFrmStewardFinger.FormDestroy(Sender: TObject);
begin

  ZKFPEngX1.EndEngine;
  ZKFPEngX1.FreeFPCacheDB(fpcHandle);
  inherited;
end;

procedure TFrmStewardFinger.FormShow(Sender: TObject);
begin
  inherited;
  beginreg;
  with jsonSpcQry do
  begin
    active := False;
    active := true;
  end;
end;

procedure TFrmStewardFinger.NovaHelpstewardIdChange(Sender: TObject);
begin
  inherited;
  if (NovaHelpsteward.Text<>'') and  (NovaHelpsteward.Id>0) then
  begin
    LabInfo.Caption := '请按指纹！';
    LabInfo.Refresh;
    PlaySound('pressfinger.wav', 0, snd_async);
  end;
end;

procedure TFrmStewardFinger.savefinger(fingercode: WideString);
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
    Params.ParamByName('steward.id').Value := NovaHelpsteward.Id;
    Params.ParamByName('steward.fingerstr1').Value := fingercode;

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
          Image1.Picture := nil;
          Image1.Refresh;
          NovaHelpsteward.Clear;
          NovaHelpsteward.Id := 0;
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

procedure TFrmStewardFinger.ZKFPEngX1Enroll(ASender: TObject;
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
      // benginreg;
      LabInfo.Font.Color := clblue;
      LabInfo.Refresh;
    end;
  end;

end;

procedure TFrmStewardFinger.ZKFPEngX1FeatureInfo(ASender: TObject;
  AQuality: Integer);
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
  LabInfo.Caption := sTemp;

end;

procedure TFrmStewardFinger.ZKFPEngX1ImageReceived(ASender: TObject;
  var AImageValid: WordBool);
var
  sFileName: string;
begin
  // if not FReceived then
  // exit;

  sFileName := 'C:\Fingerprint.jpg';
  with ZKFPEngX1 do
  begin
    Image1.Picture := nil;
    ZKFPEngX1.SaveJPG(sFileName);
    Image1.Picture.LoadFromFile(sFileName);
    Image1.Refresh;
  end;
end;

end.
