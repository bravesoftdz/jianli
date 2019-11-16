unit UFrmCheckNTickets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet;

type
  TFrmCheckNTickets = class(TSimpleEditForm)
    Label1: TLabel;
    MeTicketnos: TMemo;
    jscdChecktickets: TjsonClientDataSet;
    MeResult: TMemo;
    Label2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function split(ticketnos, spstr: String): string;
  public
    { Public declarations }
    scheduleplanid, vehiclereportid: int64;
  end;

var
  FrmCheckNTickets: TFrmCheckNTickets;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}
procedure TFrmCheckNTickets.bbtnCloseClick(Sender: TObject);
begin
  inherited;
ModalResult := mrok;
end;
procedure TFrmCheckNTickets.bbtnSaveClick(Sender: TObject);
var
  ticketnos,sResult,temp: string;
  nResult:integer;
begin
  inherited;
  ticketnos := MeTicketnos.Text;
  if(ticketnos='')then
  begin
    SysDialogs.Warning('ÇëÉ¨Ãè´æ´¢Æ±ºÅ£¡');
    MeTicketnos.SetFocus;
    exit;
  end;

  //ticketnos := split(ticketnos, ',');
  try
    with jscdChecktickets do
    begin
      active := false;
      Params.ParamValues['checkstationid'] := SysInfo.LoginUserInfo.StationID;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['ticketno'] := ticketnos;
      Params.ParamValues['islazycheck'] := true;
      Params.ParamValues['ip'] := Sysinfo.LocalHostAddress;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      while Pos('#', sResult) > 0 do
      begin
          temp := Copy(sResult, 1, Pos('#', sResult) - 1);
          MeResult.Lines.Add(temp);
          //Delete(sResult, 1, Pos('#', sResult));
          System.Delete(sResult, 1, Pos('#', sResult));
      end;
      MeTicketnos.SetFocus;
      {if (nResult = 1) then
      begin
        SysDialogs.ShowMessage(sResult);
        //MeResult.Lines.Add(temp);
        ModalResult := mrok;
      end
      else
      begin
        //SysDialogs.Warning(sResult);
        while Pos('#', sResult) > 0 do
        begin
          temp := Copy(sResult, 1, Pos('#', sResult) - 1);
          MeResult.Lines.Add(temp);
          //Delete(sResult, 1, Pos('#', sResult));
          System.Delete(sResult, 1, Pos('#', sResult));
        end;
        MeTicketnos.SetFocus;
      end;}
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('Í¨¼ì²Ù×÷Ê§°Ü£º' + E.Message);
    end;
  end;
end;

procedure TFrmCheckNTickets.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ModalResult := mrok;
end;

function TFrmCheckNTickets.split(ticketnos, spstr: String): string;
var
  ticketlength: integer;
  _curticketno: string;
begin
  ticketlength := Sysinfo.curBillLength.Items['Ticket'];
  while Pos(spstr, ticketnos) > 0 do
  begin
    _curticketno := (Copy(ticketnos, 1, Pos(spstr, ticketnos) - 1));
    if (length(_curticketno) > ticketlength) then
      _curticketno := Copy(_curticketno,
        length(_curticketno) - ticketlength + 1, length(_curticketno));
    Result := Result + _curticketno + ',';
    Delete(ticketnos, 1, Pos(spstr, ticketnos));
  end;
  if (length(ticketnos) > ticketlength) then
  begin
    _curticketno := Copy(ticketnos, length(ticketnos) - ticketlength + 1,
      length(_curticketno));
    Result := Result  + _curticketno+',';
  end;
  if(length(Result)>0 ) then
    Result:=copy(Result,1,length(Result)-1);
end;

end.
