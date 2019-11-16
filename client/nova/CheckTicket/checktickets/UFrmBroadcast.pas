unit UFrmBroadcast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet;

type
  TFrmBroadcast = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    MeContent: TMemo;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    jscdaddMusicContent: TjsonClientDataSet;
    NovaHelpSchedule: TNovaEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      departtime ,ticketentrance,vehicleno,routename,departdate,jianpin,lccontent:String;
  end;

var
  FrmBroadcast: TFrmBroadcast;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmBroadcast.BitBtn1Click(Sender: TObject);
var
  nresult: Integer;
  sresult: string;
begin
  inherited;
  try
  with  jscdaddMusicContent do
  begin
    active := false;
    Params.ParamValues['lc.content'] := lccontent;
    Params.ParamValues['lc.ticketentrance'] := ticketentrance;
    Params.ParamValues['lc.departtime'] := departtime;
    Params.ParamValues['lc.mccontent'] := MeContent.Text;
    Params.ParamValues['lc.orgname'] := Sysinfo.LoginUserInfo.OrgName;
    Params.ParamValues['lc.routename'] := routename;
    Params.ParamValues['lc.departdate'] := departdate;
    Params.ParamValues['lc.vehicleno'] := vehicleno;
    Params.ParamValues['lc.jianpin'] := jianpin;
    execute;
    nresult := Params.ParamValues['flag'];
    sresult := Params.ParamValues['msg'];
    if nresult = 1 then
    begin
      SysDialogs.ShowMessage(sresult);
      ModalResult := mrok;
    end
    else
    begin
      SysDialogs.Warning(sresult);
      NovaHelpSchedule.SetFocus;
    end;
  end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('Á¬¼ì²Ù×÷Ê§°Ü£º' + E.Message);
    end;
  end;
end;

end.
