program AcDesigner;

uses
  Forms,
  ACReport_TLB;  //use ACReport_TLBµ¥Ôª

{$R *.res}
{$R XpStyle.RES}

var
  RptEngine: TAcRptEngine;
begin
  Application.Initialize;
  RptEngine := TAcRptEngine.Create(nil);
  RptEngine.ShowDesigner;
  RptEngine.Free;
  Application.Run;
end.
