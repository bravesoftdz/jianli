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
    result := '����һ'
  else if item = '2' then
    result := '���ڶ�'
  else if item = '3' then
    result := '������'
  else if item = '4' then
    result := '������'
  else if item = '5' then
    result := '������'
  else if item = '6' then
    result := '������'
  else
    result := '������';
end;

function getnewMonthName(item: String): String;
begin
  result := item + '��';
end;

function getoldMonthName(item: String): String;
begin
  if item = '1' then
    result := '��һ'
  else if item = '2' then
    result := '����'
  else if item = '3' then
    result := '����'
  else if item = '4' then
    result := '����'
  else if item = '5' then
    result := '����'
  else if item = '6' then
    result := '����'
  else if item = '7' then
    result := '����'
  else if item = '8' then
    result := '����'
  else if item = '9' then
    result := '����'
  else if item = '10' then
    result := '��ʮ'
  else if item = '11' then
    result := 'ʮһ'
  else if item = '12' then
    result := 'ʮ��'
  else if item = '13' then
    result := 'ʮ��'
  else if item = '14' then
    result := 'ʮ��'
  else if item = '15' then
    result := 'ʮ��'
  else if item = '16' then
    result := 'ʮ��'
  else if item = '17' then
    result := 'ʮ��'
  else if item = '18' then
    result := 'ʮ��'
  else if item = '19' then
    result := 'ʮ��'
  else if item = '20' then
    result := '��ʮ'
  else if item = '21' then
    result := 'إһ'
  else if item = '22' then
    result := 'إ��'
  else if item = '23' then
    result := 'إ��'
  else if item = '24' then
    result := 'إ��'
  else if item = '25' then
    result := 'إ��'
  else if item = '26' then
    result := 'إ��'
  else if item = '27' then
    result := 'إ��'
  else if item = '28' then
    result := 'إ��'
  else if item = '29' then
    result := 'إ��'
  else if item = '30' then
    result := '��ʮ'
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
