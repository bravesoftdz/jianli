unit UFrmNotify;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, pngimage, DB,
  DBClient, jsonClientDataSet, services, MPlayer;

type
  TFrmNotify = class(TSimpleEditForm)
    Timer1: TTimer;
    jscdupdateNotifyByid: TjsonClientDataSet;
    Label1: TLabel;
    LabUserName: TLabel;
    Label2: TLabel;
    LabLoginTime: TLabel;
    LabInfo: TLabel;
    Timer2: TTimer;
    Label3: TLabel;
    mp1: TMediaPlayer;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabInfoMouseEnter(Sender: TObject);
    procedure LabInfoMouseLeave(Sender: TObject);
    procedure pnlEditBoxMouseEnter(Sender: TObject);
    procedure pnlEditBoxMouseLeave(Sender: TObject);
//    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  private
    { Private declarations }
  public
    { Public declarations }
    id: integer;
    var isAuthority:Boolean;
  end;

var
  FrmNotify: TFrmNotify;

implementation

uses PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmNotify.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  mp1.Stop;
//  with jscdupdateNotifyByid do
//  begin
//    active := false;
//    Params.ParamByName('notifyid').Value := id;
//    execute;
//  end;

end;

procedure TFrmNotify.FormShow(Sender: TObject);

begin
  inherited;
  begin

      self.Left := screen.Width - 280;
      self.Top := screen.Height - 220;
  //  Label3.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  Label2.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  Label1.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  LabLoginTime.OnMouseEnter:= pnlEditBoxMouseEnter;
  //  LabUserName.OnMouseEnter:= pnlEditBoxMouseEnter;
      LabUserName.Top:=Label2.Top;
  //  mp1.Rewind;
      mp1.Open;
      mp1.Play;
      if (mp1.Position=mp1.Length)  then
      begin
       mp1.AutoRewind:=true;
       mp1.Notify:=true;
      end;
  end;


end;

procedure TFrmNotify.LabInfoMouseEnter(Sender: TObject);
begin
  inherited;
  AlphaBlendValue := 255;
  Timer2.Enabled:=false;
  LabInfo.Font.Style := [fsUnderline];
end;

procedure TFrmNotify.LabInfoMouseLeave(Sender: TObject);
begin
  inherited;
  LabInfo.Font.Style := [];
end;

procedure TFrmNotify.pnlEditBoxMouseEnter(Sender: TObject);
begin
  inherited;
  AlphaBlendValue := 255;
  Timer2.Enabled:=false;
end;

procedure TFrmNotify.pnlEditBoxMouseLeave(Sender: TObject);
begin
  inherited;
  Timer2.Enabled:=true;
end;

procedure TFrmNotify.Timer1Timer(Sender: TObject);
begin
  inherited;
  Timer1.Enabled := false;
  Timer2.Enabled := true;
end;

procedure TFrmNotify.Timer2Timer(Sender: TObject);
begin
  inherited;
  if AlphaBlendValue > 0 then
  begin
//    AlphaBlendValue := AlphaBlendValue - 17;
  end
  else
  begin
    Timer2.Enabled := false;
    // AlphaBlendValue := 0;
//    close;
  end;
end;
//procedure TFrmNotify.HandleAuthority(const Key: TGUID;
//  aEnable: boolean);
// begin
//   inherited;
//
//     if GUIDToString(Key) = '{71C6592B-3759-4235-95C6-5412A505AB84}' then
//      begin
//       isAuthority := aEnable;
//      end;
// end;
end.
