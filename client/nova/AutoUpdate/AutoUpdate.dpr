program AutoUpdate;

uses
 // ExceptionLog,
  Forms,
  Windows,
  UFrmUpdate in 'UFrmUpdate.pas' {FrmUpdate},
  NativeXml in '..\public\NativeXml.pas',
  sdStreams in '..\public\sdStreams.pas',
  sdDebug in '..\public\sdDebug.pas',
  sdStringTable in '..\public\sdStringTable.pas',
  RunOnce in '..\MainAPP\RunOnce.pas';

{$R *.res}

begin
  Application.Initialize;
  if AppHasRun(Application.Handle) then
    Application.Terminate;
  Application.Title := 'NvBus����վ��ϵͳ��������';
  CreateMutex(nil,false,'NvBus����վ��ϵͳ��������');
  Application.CreateForm(TFrmUpdate, FrmUpdate);
  Application.Run;
end.
