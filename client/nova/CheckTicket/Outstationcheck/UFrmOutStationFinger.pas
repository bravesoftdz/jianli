unit UFrmOutStationFinger;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, UDMPublic, Buttons, ExtCtrls,
//  UFinger,
  DB, Services;

type
  TFrmOutStationFinger = class(TSimpleEditForm)
    Label7: TLabel;
    LabInfo: TLabel;
    Image1: TImage;
    LabDriver1: TLabel;
    LabDriver2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
//    employees:integer;
    procedure OnCapture(driver1id: int64;driver2id: int64; ovnresult: integer;
      ovsresult: string);
  public
    { Public declarations }
    vhielcid, scheduleplanid,driverid: int64;
    drivername:string;
  end;

var
  FrmOutStationFinger: TFrmOutStationFinger;
//  finger:TFinger;
implementation

{$R *.dfm}

procedure TFrmOutStationFinger.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
//  if  Assigned(finger)  then
//    finger.cancelcapture;
end;

procedure TFrmOutStationFinger.FormShow(Sender: TObject);
begin
  inherited;
  //finger :=TFinger.Create(self);

//  finger.setImage1Compent(Image1);
//  finger.setImage2Compent(Image1);
//  finger.setHintCompent(LabInfo);
//  finger.setCompareFinger(ADOSpcQry);
//  finger.setDriver1Compent(LabDriver1);
//  finger.setIsOnlyName(true); //只需要获取驾驶员姓名，不需做其他验证
//  finger.IsRegister := false;
//  finger.OnCapture := OnCapture;
//  finger.employees:= 1;
 // finger.init;
//  if driverid > 0 then
//  begin
//        ModalResult := mrOk;
//        bbtnClose.Click;
//  end;

end;

procedure TFrmOutStationFinger.OnCapture(driver1id: int64;driver2id: int64; ovnresult: integer;
  ovsresult: string);
begin
//  drivername := finger.FDrivername;
//  driverid := finger.FDriverid;
  sleep(1000);
  if LabDriver1.Caption<>'' then
    ModalResult := mrok;
end;

end.
