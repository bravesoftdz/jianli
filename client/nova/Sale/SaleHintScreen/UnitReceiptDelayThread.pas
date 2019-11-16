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
  EnterCriticalSection(CS);    //�����ٽ���

  if MyForm.Visible  then
  begin
    if (not startnewsell) then
    begin
      sleep(3*1000);   //  ���ʽ���ȴ�ʱ��
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
  LeaveCriticalSection(CS);//�뿪�ٽ���
  DeleteCriticalSection(CS);//�����ٽ���ʱ,ɾ���ٽ���
end;

end.
 