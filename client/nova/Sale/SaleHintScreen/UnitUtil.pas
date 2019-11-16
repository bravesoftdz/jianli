unit UnitUtil;

interface
uses messages,windows,dialogs,forms,classes,
     SysUtils,db,ComCtrls,StdCtrls,Controls,DateUtils;


function GetWeek: string;
function GetSystemDatetime: string;

implementation

function GetWeek: string;
var
  mytime:_SYSTEMTIME;
begin
  GetLocalTime(mytime);
  case mytime.wDayOfWeek of
  0: Result:='������';
  1: Result:='����һ';
  2: Result:='���ڶ�';
  3: Result:='������';
  4: Result:='������';
  5: Result:='������';
  6: Result:='������';
  end;
end;

function GetSystemDatetime: string;
var
  dd,mm,yyyy:string;
begin
  yyyy :=formatdatetime('yyyy',now)+'��';
  mm :=formatdatetime('mm',now)+'��';
  dd :=formatdatetime('dd',now)+'��';
  yyyy:=yyyy+ mm+  dd   ;
  result:= yyyy+' '+GetWeek()+' '+
  formatdatetime('hh:mm:ss',now);
end;

initialization

finalization

end.

