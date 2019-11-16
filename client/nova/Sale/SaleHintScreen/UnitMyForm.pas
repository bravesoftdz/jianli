unit UnitMyForm;   //班次列表

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, DB, ADODB,StdCtrls,
  DBGridEh, Sockets,ActiveX, ScktComp, jpeg;

type
  TMiniScreenMSG=(LISTSCHEDULE,//显示班次信息
                  FINISH,//售票完成显示等待界面
                  EXITSELL //退出售票时
                  );

type
  TMyForm = class(TForm)
    Panel2: TPanel;
    lblDateTimedd: TLabel;
    ServerSocket1: TServerSocket;
    lblToStationname: TLabel;
    imgtop: TImage;
    imgclient: TImage;
    imgbottom: TImage;
    lblscheduletype: TLabel;
    lbldatetimehh: TLabel;
    lbldatetimenn: TLabel;
    lblprice: TLabel;
    lbltotalprice: TLabel;
    lbltotalpricesum: TLabel;
    lblrecive: TLabel;
    lblchange: TLabel;
    lblfullnum: TLabel;
    lblhalfnum: TLabel;
    lblentrance: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
    procedure handmsg(msg:TMiniScreenMSG;info:String);
  public
    { Public declarations }
    procedure MyError(Sender: TObject; E:Exception) ;
  end;

var
  MyForm: TMyForm;
  CS : TRTLCriticalSection;
  curusercode:string; //当前售票员工号

implementation
uses UnitWait,UnitUtil, Unitpause, UnitReceiptDelayThread;

{$R *.dfm}

procedure TMyForm.FormCreate(Sender: TObject);
begin
  Application.OnException := MyError ;
end;

procedure TMyForm.MyError(Sender: TObject; E: Exception);
begin
   Application.Terminate ;
end;

procedure TMyForm.handmsg(msg: TMiniScreenMSG;info:String);
var tmpinfo:String;
begin
  tmpinfo:=info;
  case TMiniScreenMSG(msg) of
    LISTSCHEDULE: //显示班次列表
      begin
        startnewsell:=true;
        lblToStationname.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblscheduletype.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblDateTimedd.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lbldatetimehh.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lbldatetimenn.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblprice.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblfullnum.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblhalfnum.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lbltotalprice.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lbltotalpricesum.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblrecive.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblchange.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
        tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
        lblentrance.Caption:=tmpinfo;

        MyForm.Show;
        FormWait.Hide;
        Formpause.Hide;
      end;
    FINISH:
      begin
        startnewsell:=false;
        curusercode:=info;
        FormWait.lblusercode.Caption:=curusercode;
        InitializeCriticalSection(CS);
        TReceiptDelayThread.Create(false);
      end;
    EXITSELL:
      begin
        startnewsell:=false;
        Formpause.show;
        MyForm.Hide;
        FormWait.Hide;
      end;
  end;
end;

procedure TMyForm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var revmsg:string;
    curcmd:string;
begin
  revmsg:=Socket.ReceiveText;
  while Pos(#13,revmsg)>0 do
  begin
    if Trim(Copy(revmsg,Pos(#13,revmsg)+1,Length(revmsg)-Pos(#13,revmsg)))<>'' then
    begin
//      ShowMessage(revmsg);
      try
        curcmd:=Copy(revmsg,1,Pos(#13,revmsg)-1);
        handmsg(TMiniScreenMSG(StrToInt(trim(Copy(curcmd,1,Pos(';',curcmd)-1))))
                ,trim(Copy(curcmd,Pos(';',curcmd)+1,Length(curcmd)-Pos(';',curcmd)))
                );
      except
    //    ShowMessage(revmsg);
      end;
      revmsg:=Copy(revmsg,Pos(#13,revmsg)+1,Length(revmsg)-Pos(#13,revmsg));
    end
    else
    begin
      Break;
    end;
  end;
  try
    curcmd:=revmsg;
    handmsg(TMiniScreenMSG(StrToInt(trim(Copy(curcmd,1,Pos(';',curcmd)-1))))
            ,trim(Copy(curcmd,Pos(';',curcmd)+1,Length(curcmd)-Pos(';',curcmd)))
            );
  except
//    ShowMessage(revmsg);
  end;
end;

initialization

finalization

end.

