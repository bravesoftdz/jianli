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
  0: Result:='星期日';
  1: Result:='星期一';
  2: Result:='星期二';
  3: Result:='星期三';
  4: Result:='星期四';
  5: Result:='星期五';
  6: Result:='星期六';
  end;
end;

function GetSystemDatetime: string;
var
  dd,mm,yyyy:string;
begin
  yyyy :=formatdatetime('yyyy',now)+'年';
  mm :=formatdatetime('mm',now)+'月';
  dd :=formatdatetime('dd',now)+'日';
  yyyy:=yyyy+ mm+  dd   ;
  result:= yyyy+' '+GetWeek()+' '+
  formatdatetime('hh:mm:ss',now);
end;

initialization

finalization

end.

