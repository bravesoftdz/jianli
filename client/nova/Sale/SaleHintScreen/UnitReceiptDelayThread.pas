unit UnitReceiptDelayThread;

interface

uses
  Windows,SysUtils,Classes,Dialogs;

type
  TReceiptDelayThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

var
  startnewsell:Boolean;

implementation
uses UnitMyform, unitWait, Unitpause;


{ THreadStopCheckOut }

procedure TReceiptDelayThread.Execute;
begin
  { Place thread code here }
  EnterCriticalSection(CS);    //建立临界区

  if MyForm.Visible  then
  begin
    if (not startnewsell) then
    begin
      sleep(3*1000);   //  结帐界面等待时间
      FormWait.Show;
      MyForm.Hide;
      Formpause.Hide;
    end;
  end
  else
  begin
    FormWait.Show;
    MyForm.Hide;
    Formpause.Hide;
  end;
  LeaveCriticalSection(CS);//离开临界区
  DeleteCriticalSection(CS);//不用临界区时,删除临界区
end;

end.
 