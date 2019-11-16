unit ruleConvert;

interface

uses
  SysUtils;

function getWeekName(item: String): String;
function getoldMonthName(item: String): String;
function getnewMonthName(item: String): String;
function ruleSort(rules: String): String;

implementation

function getWeekName(item: String): String;
begin
  if item = '1' then
    result := '星期一'
  else if item = '2' then
    result := '星期二'
  else if item = '3' then
    result := '星期三'
  else if item = '4' then
    result := '星期四'
  else if item = '5' then
    result := '星期五'
  else if item = '6' then
    result := '星期六'
  else
    result := '星期日';
end;

function getnewMonthName(item: String): String;
begin
  result := item + '号';
end;

function getoldMonthName(item: String): String;
begin
  if item = '1' then
    result := '初一'
  else if item = '2' then
    result := '初二'
  else if item = '3' then
    result := '初三'
  else if item = '4' then
    result := '初四'
  else if item = '5' then
    result := '初五'
  else if item = '6' then
    result := '初六'
  else if item = '7' then
    result := '初七'
  else if item = '8' then
    result := '初八'
  else if item = '9' then
    result := '初九'
  else if item = '10' then
    result := '初十'
  else if item = '11' then
    result := '十一'
  else if item = '12' then
    result := '十二'
  else if item = '13' then
    result := '十三'
  else if item = '14' then
    result := '十四'
  else if item = '15' then
    result := '十五'
  else if item = '16' then
    result := '十六'
  else if item = '17' then
    result := '十七'
  else if item = '18' then
    result := '十八'
  else if item = '19' then
    result := '十九'
  else if item = '20' then
    result := '二十'
  else if item = '21' then
    result := '廿一'
  else if item = '22' then
    result := '廿二'
  else if item = '23' then
    result := '廿三'
  else if item = '24' then
    result := '廿四'
  else if item = '25' then
    result := '廿五'
  else if item = '26' then
    result := '廿六'
  else if item = '27' then
    result := '廿七'
  else if item = '28' then
    result := '廿八'
  else if item = '29' then
    result := '廿九'
  else if item = '30' then
    result := '三十'
  else
    result := '';
end;

function ruleSort(rules: String): String;
var
  i, j: integer;
  item: String;
  items: array of integer;
  temp: integer;
begin
  i := 0;
  while (length(rules) > 0) do
  begin
    item := copy(rules, 1, pos(',', rules) - 1);
    SetLength(items,i+1);
    items[i] := strtoint(item);
    i := i + 1;
    rules := copy(rules, pos(',', rules) + 1, length(rules));
  end;
  for i := 0 to length(items) - 1 do
  begin
    for j := 0 to i do
      if items[j] > items[i] then
      begin
        temp := items[j];
        items[j] := items[i];
        items[i] := temp;
      end;
  end;
  item:='';
  for i := 0 to length(items)-1 do
    item := item + ','+inttostr(items[i]);
  result := copy(item,2,length(item));
end;

end.
