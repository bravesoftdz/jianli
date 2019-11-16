program DelphiDemo;

uses
  Forms,
  main in 'main.pas' {Form1},
  data in 'data.pas' {DM: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
