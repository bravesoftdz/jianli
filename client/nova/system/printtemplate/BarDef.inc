// =============================================================================
//
// Barcode VCL Component
//
// For Delphi 4/5/6/7, C++ Builder 4/5/6, BDS 2005/2005, Turbo Delphi 2006
//
// Copyright (c) 2001, 2007  Han-soft Software, all rights reserved.
//
// $Rev: 44 $   $Id: BarDef.inc 44 2007-01-16 01:16:04Z hanjy $
//
// =============================================================================

{********************}
{  For make barcode  }
{********************}

{ Convert codebar data }
function Convert(const s:string):string;
var
  i, v : integer;
begin
  Result := s;  { same Length as Input - string }
  for i:=1 to Length(s) do
  begin
    v := ord(s[i]) - 1;

    if odd(i) then
      Inc(v, 5);
    Result[i] := Chr(v);
  end;
end;

{ Calculate sum of digitally }
function quersumme(x:integer):integer;
var
  sum:integer;
begin
  sum := 0;
  while x > 0 do
  begin
    sum := sum + (x mod 10);
    x := x div 10;
  end;
  result := sum;
end;

{ Calculate checksum }
function CheckSumModulo10(const data:string):string;
var
  i,fak,sum : Integer;
begin
  sum := 0;
  fak := Length(data);
  for i:=1 to Length(data) do
  begin
    if (fak mod 2) = 0 then
      sum := sum + (StrToInt(data[i])*1)
    else
      sum := sum + (StrToInt(data[i])*3);
    dec(fak);
  end;
  if (sum mod 10) = 0 then
    result := data+'0'
  else
    result := data+IntToStr(10-(sum mod 10));
end;

{ Get checksum }
function DoCheckSumming(const CS_CheckSum:TCheckSum; const data:string):string;
begin
  case CS_CheckSum of
    csNone:
      Result := data;
    csModulo10:
      Result := CheckSumModulo10(data);
  end;
end;

{ Assist function for Get barcode data }
function SetLen(pI:byte; HL_BarCode:string):string;
begin
  Result := StringOfChar('0', pI-Length(HL_BarCode)) + HL_BarCode;
end;

{ Assist function for get UPC data }
function getSupp(Nr : String) : String;
var
  i,fak,sum : Integer;
  tmp   : string;
begin
  sum := 0;
  tmp := copy(Nr,1,Length(Nr)-1);
  fak := Length(tmp);
  for i:=1 to length(tmp) do
  begin
    if (fak mod 2) = 0 then
      sum := sum + (StrToInt(tmp[i])*9)
    else
      sum := sum + (StrToInt(tmp[i])*3);
    dec(fak);
  end;
  sum:=((sum mod 10) mod 10) mod 10;
  result := tmp+IntToStr(sum);
end;

{********************}
{  For EAN           }
{********************}

{ Pattern for Barcode EAN Charset A - L1   S1   L2   S2 }
const tabelle_EAN_A:array['0'..'9'] of string =
  (
  ('2605'),    { 0 }
  ('1615'),    { 1 }
  ('1516'),    { 2 }
  ('0805'),    { 3 }
  ('0526'),    { 4 }
  ('0625'),    { 5 }
  ('0508'),    { 6 }
  ('0706'),    { 7 }
  ('0607'),    { 8 }
  ('2506')     { 9 }
  );

{ Pattern for Barcode EAN Charset B - S1   L1   S2   L2 }
const tabelle_EAN_B:array['0'..'9'] of string =
  (
  ('0517'),    { 0 }
  ('0616'),    { 1 }
  ('1606'),    { 2 }
  ('0535'),    { 3 }
  ('1705'),    { 4 }
  ('0715'),    { 5 }
  ('3505'),    { 6 }
  ('1525'),    { 7 }
  ('2515'),    { 8 }
  ('1507')     { 9 }
  );

{ Pattern for Barcode EAN Charset C - S1   L1   S2   L2 }
const tabelle_EAN_C:array['0'..'9'] of string =
  (
  ('7150' ),    { 0 }
  ('6160' ),    { 1 }
  ('6061' ),    { 2 }
  ('5350' ),    { 3 }
  ('5071' ),    { 4 }
  ('5170' ),    { 5 }
  ('5053' ),    { 6 }
  ('5251' ),    { 7 }
  ('5152' ),    { 8 }
  ('7051' )     { 9 }
  );

{ Get EAN8 data }
function  Code_EAN8(const H_BarCode:string; const H_CheckSum:TCheckSum):string;
var
  i : integer;
  tmp : String;
begin
  if H_CheckSum <> csNone then
  begin
    tmp := SetLen(7,H_BarCode);
    tmp := DoCheckSumming(H_CheckSum,copy(tmp,length(tmp)-6,7));
  end
  else
    tmp := SetLen(8,H_BarCode);

  Assert(Length(tmp)=8, 'EAN8 : ' + ErrorLength);

  result := '505';   {Startcode}

  for i:=1 to 4 do
    result := result + tabelle_EAN_A[tmp[i]] ;

  result := result + '05050';   {Center Guard Pattern}

  for i:=5 to 8 do
    result := result + tabelle_EAN_C[tmp[i]] ;

  result := result + '505';   {Stopcode}
end;

{ Pattern for Barcode EAN 13 }
const tabelle_ParityEAN13:array[0..9, 1..6] of char =
  (
  ('A', 'A', 'A', 'A', 'A', 'A'),    { 0 }
  ('A', 'A', 'B', 'A', 'B', 'B'),    { 1 }
  ('A', 'A', 'B', 'B', 'A', 'B'),    { 2 }
  ('A', 'A', 'B', 'B', 'B', 'A'),    { 3 }
  ('A', 'B', 'A', 'A', 'B', 'B'),    { 4 }
  ('A', 'B', 'B', 'A', 'A', 'B'),    { 5 }
  ('A', 'B', 'B', 'B', 'A', 'A'),    { 6 }
  ('A', 'B', 'A', 'B', 'A', 'B'),    { 7 }
  ('A', 'B', 'A', 'B', 'B', 'A'),    { 8 }
  ('A', 'B', 'B', 'A', 'B', 'A')     { 9 }
  );

{ Get EAN13 data}
function  Code_EAN13(const H_BarCode:string; const H_CheckSum:TCheckSum):string;
var
  i, LK: integer;
  tmp : String;
begin
  if H_CheckSum <> csNone then
  begin
    tmp := SetLen(12,H_BarCode);
    tmp := DoCheckSumming(H_CheckSum, tmp);
  end
  else
    tmp := SetLen(13,H_BarCode);

  Assert(Length(tmp) = 13, 'EAN13 : ' + ErrorLength);

  LK := StrToInt(tmp[1]);
  tmp := copy(tmp,2,12);

  result := '505';   {Startcode}

  for i:=1 to 6 do
  begin
    case tabelle_ParityEAN13[LK,i] of
      'A' : result := result + tabelle_EAN_A[tmp[i]];
      'B' : result := result + tabelle_EAN_B[tmp[i]] ;
      'C' : result := result + tabelle_EAN_C[tmp[i]] ;
  end;
  end;

  result := result + '05050';   {Center Guard Pattern}

  for i:=7 to 12 do
    result := result + tabelle_EAN_C[tmp[i]] ;

    result := result + '505';   {Stopcode}
end;

{********************}
{  For Code 25       }
{********************}

{Pattern for Barcode 2 of 5}
const tabelle_2_5:array['0'..'9', 1..5] of char =
  (
  ('0', '0', '1', '1', '0'),    {'0'}
  ('1', '0', '0', '0', '1'),    {'1'}
  ('0', '1', '0', '0', '1'),    {'2'}
  ('1', '1', '0', '0', '0'),    {'3'}
  ('0', '0', '1', '0', '1'),    {'4'}
  ('1', '0', '1', '0', '0'),    {'5'}
  ('0', '1', '1', '0', '0'),    {'6'}
  ('0', '0', '0', '1', '1'),    {'7'}
  ('1', '0', '0', '1', '0'),    {'8'}
  ('0', '1', '0', '1', '0')     {'9'}
  );

{ Get Code25 interleaved data }
function  Code_2_5_interleaved(const H_BarCode:string):string;
var
  i, j: integer;
  c : char;

begin
  result := '5050';   {Startcode}

  for i:=1 to Length(H_BarCode) div 2 do
  begin
    for j:= 1 to 5 do
    begin
      if tabelle_2_5[H_BarCode[i*2-1], j] = '1' then
        c := '6'
      else
        c := '5';
      result := result + c;
      if tabelle_2_5[H_BarCode[i*2], j] = '1' then
        c := '1'
      else
        c := '0';
      result := result + c;
    end;
  end;

  result := result + '605';    {Stopcode}
end;

{ Get Code25 industrial data }
function  Code_2_5_industrial(const H_BarCode:string):string;
var
  i, j: integer;
begin
  result := '606050';   {Startcode}

  for i:=1 to Length(H_BarCode) do
  begin
    for j:= 1 to 5 do
    begin
    if tabelle_2_5[H_BarCode[i], j] = '1' then
      result := result + '60'
    else
      result := result + '50';
    end;
  end;

  result := result + '605060';   {Stopcode}
end;

{ Get Code25 matrix data }
function  Code_2_5_matrix(const H_BarCode:string):string;
var
  i, j: integer;
  c :char;
begin
  result := '705050';   {Startcode}

  for i:=1 to Length(H_BarCode) do
  begin
    for j:= 1 to 5 do
    begin
      if tabelle_2_5[H_BarCode[i], j] = '1' then
        c := '1'
      else
        c := '0';

      if odd(j) then
        c := chr(ord(c)+5);
      result := result + c;
    end;
   result := result + '0';
  end;

  result := result + '70505';   {Stopcode}
end;

{********************}
{  For Code 39       }
{********************}

{ Get Code39  data }
function  Code_39(const H_BarCode:string; const H_CheckSum:TCheckSum):string;

type TCode39 =
  record
    c : char;
    data : array[0..9] of char;
    chk: shortint;
  end;

const tabelle_39: array[0..43] of TCode39 = (
  ( c:'0'; data:'505160605'; chk:0 ),
  ( c:'1'; data:'605150506'; chk:1 ),
  ( c:'2'; data:'506150506'; chk:2 ),
  ( c:'3'; data:'606150505'; chk:3 ),
  ( c:'4'; data:'505160506'; chk:4 ),
  ( c:'5'; data:'605160505'; chk:5 ),
  ( c:'6'; data:'506160505'; chk:6 ),
  ( c:'7'; data:'505150606'; chk:7 ),
  ( c:'8'; data:'605150605'; chk:8 ),
  ( c:'9'; data:'506150605'; chk:9 ),
  ( c:'A'; data:'605051506'; chk:10),
  ( c:'B'; data:'506051506'; chk:11),
  ( c:'C'; data:'606051505'; chk:12),
  ( c:'D'; data:'505061506'; chk:13),
  ( c:'E'; data:'605061505'; chk:14),
  ( c:'F'; data:'506061505'; chk:15),
  ( c:'G'; data:'505051606'; chk:16),
  ( c:'H'; data:'605051605'; chk:17),
  ( c:'I'; data:'506051605'; chk:18),
  ( c:'J'; data:'505061605'; chk:19),
  ( c:'K'; data:'605050516'; chk:20),
  ( c:'L'; data:'506050516'; chk:21),
  ( c:'M'; data:'606050515'; chk:22),
  ( c:'N'; data:'505060516'; chk:23),
  ( c:'O'; data:'605060515'; chk:24),
  ( c:'P'; data:'506060515'; chk:25),
  ( c:'Q'; data:'505050616'; chk:26),
  ( c:'R'; data:'605050615'; chk:27),
  ( c:'S'; data:'506050615'; chk:28),
  ( c:'T'; data:'505060615'; chk:29),
  ( c:'U'; data:'615050506'; chk:30),
  ( c:'V'; data:'516050506'; chk:31),
  ( c:'W'; data:'616050505'; chk:32),
  ( c:'X'; data:'515060506'; chk:33),
  ( c:'Y'; data:'615060505'; chk:34),
  ( c:'Z'; data:'516060505'; chk:35),
  ( c:'-'; data:'515050606'; chk:36),
  ( c:'.'; data:'615050605'; chk:37),
  ( c:' '; data:'516050605'; chk:38),
  ( c:'*'; data:'515060605'; chk:0 ),
  ( c:'$'; data:'515151505'; chk:39),
  ( c:'/'; data:'515150515'; chk:40),
  ( c:'+'; data:'515051515'; chk:41),
  ( c:'%'; data:'505151515'; chk:42)
  );

function FindIdx(z:char):integer;
var
  i:integer;
begin
  for i:=0 to High(tabelle_39) do
  begin
    if z = tabelle_39[i].c then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1;
end;

var
  i, idx : integer;
  checksum:integer;

begin
  checksum := 0;
  {Startcode}
//20110524 ice  result := tabelle_39[FindIdx('*')].data + '0';
  result := String(tabelle_39[FindIdx('*')].data) + '0';

  for i:=1 to Length(H_BarCode) do
  begin
    idx := FindIdx(H_BarCode[i]);
    if idx < 0 then
      continue;
    result := result + tabelle_39[idx].data + '0';
    Inc(checksum, tabelle_39[idx].chk);
  end;

  {Calculate Checksum Data}
  if H_CheckSum <> csNone then
    begin
    checksum := checksum mod 43;
    for i:=0 to High(tabelle_39) do
      if checksum = tabelle_39[i].chk then
      begin
        result := result + tabelle_39[i].data + '0';
        break;
      end;
    end;

  {Stopcode}
  result := result + tabelle_39[FindIdx('*')].data;
end;

{ Get Code39 extended data }
function  Code_39Extended(const H_BarCode:string;
  const H_CheckSum:TCheckSum):string;
const code39x : array[0..127] of string[2] =
  (
  ('%U'), ('$A'), ('$B'), ('$C'), ('$D'), ('$E'), ('$F'), ('$G'),
  ('$H'), ('$I'), ('$J'), ('$K'), ('$L'), ('$M'), ('$N'), ('$O'),
  ('$P'), ('$Q'), ('$R'), ('$S'), ('$T'), ('$U'), ('$V'), ('$W'),
  ('$X'), ('$Y'), ('$Z'), ('%A'), ('%B'), ('%C'), ('%D'), ('%E'),
   (' '), ('/A'), ('/B'), ('/C'), ('/D'), ('/E'), ('/F'), ('/G'),
  ('/H'), ('/I'), ('/J'), ('/K'), ('/L'), ('/M'), ('/N'), ('/O'),
  ( '0'),  ('1'),  ('2'),  ('3'),  ('4'),  ('5'),  ('6'),  ('7'),
   ('8'),  ('9'), ('/Z'), ('%F'), ('%G'), ('%H'), ('%I'), ('%J'),
  ('%V'),  ('A'),  ('B'),  ('C'),  ('D'),  ('E'),  ('F'),  ('G'),
   ('H'),  ('I'),  ('J'),  ('K'),  ('L'),  ('M'),  ('N'),  ('O'),
   ('P'),  ('Q'),  ('R'),  ('S'),  ('T'),  ('U'),  ('V'),  ('W'),
   ('X'),  ('Y'),  ('Z'), ('%K'), ('%L'), ('%M'), ('%N'), ('%O'),
  ('%W'), ('+A'), ('+B'), ('+C'), ('+D'), ('+E'), ('+F'), ('+G'),
  ('+H'), ('+I'), ('+J'), ('+K'), ('+L'), ('+M'), ('+N'), ('+O'),
  ('+P'), ('+Q'), ('+R'), ('+S'), ('+T'), ('+U'), ('+V'), ('+W'),
  ('+X'), ('+Y'), ('+Z'), ('%P'), ('%Q'), ('%R'), ('%S'), ('%T')
  );
var
  tmp:string;
  i : integer;
begin
  tmp := '';
  for i:=1 to Length(H_BarCode) do
  begin
    if ord(H_BarCode[i]) <= 127 then
      tmp := tmp + code39x[ord(H_BarCode[i])];
  end;
  result := Code_39(tmp,H_CheckSum);
end;

{********************}
{  For Code 128      }
{********************}

{ Get Code128 data }
function  Code_128(const H_BarType:TBarType; const H_BarCode:string;
  const H_CheckSum:TCheckSum; var H_CheckNum:string):string;

  type TCode128 =
  record
    a, b : char;
    c : string[2];
    data : string[6];
  end;

const tabelle_128: array[0..102] of TCode128 = (
  ( a:' '; b:' '; c:'00'; data:'212222' ),
  ( a:'!'; b:'!'; c:'01'; data:'222122' ),
  ( a:'"'; b:'"'; c:'02'; data:'222221' ),
  ( a:'#'; b:'#'; c:'03'; data:'121223' ),
  ( a:'$'; b:'$'; c:'04'; data:'121322' ),
  ( a:'%'; b:'%'; c:'05'; data:'131222' ),
  ( a:'&'; b:'&'; c:'06'; data:'122213' ),
  ( a:''''; b:''''; c:'07'; data:'122312'),
  ( a:'('; b:'('; c:'08'; data:'132212' ),
  ( a:')'; b:')'; c:'09'; data:'221213' ),
  ( a:'*'; b:'*'; c:'10'; data:'221312' ),
  ( a:'+'; b:'+'; c:'11'; data:'231212' ),
  ( a:','; b:','; c:'12'; data:'112232' ),
  ( a:'-'; b:'-'; c:'13'; data:'122132' ),
  ( a:'.'; b:'.'; c:'14'; data:'122231' ),
  ( a:'/'; b:'/'; c:'15'; data:'113222' ),
  ( a:'0'; b:'0'; c:'16'; data:'123122' ),
  ( a:'1'; b:'1'; c:'17'; data:'123221' ),
  ( a:'2'; b:'2'; c:'18'; data:'223211' ),
  ( a:'3'; b:'3'; c:'19'; data:'221132' ),
  ( a:'4'; b:'4'; c:'20'; data:'221231' ),
  ( a:'5'; b:'5'; c:'21'; data:'213212' ),
  ( a:'6'; b:'6'; c:'22'; data:'223112' ),
  ( a:'7'; b:'7'; c:'23'; data:'312131' ),
  ( a:'8'; b:'8'; c:'24'; data:'311222' ),
  ( a:'9'; b:'9'; c:'25'; data:'321122' ),
  ( a:':'; b:':'; c:'26'; data:'321221' ),
  ( a:';'; b:';'; c:'27'; data:'312212' ),
  ( a:'<'; b:'<'; c:'28'; data:'322112' ),
  ( a:'='; b:'='; c:'29'; data:'322211' ),
  ( a:'>'; b:'>'; c:'30'; data:'212123' ),
  ( a:'?'; b:'?'; c:'31'; data:'212321' ),
  ( a:'@'; b:'@'; c:'32'; data:'232121' ),
  ( a:'A'; b:'A'; c:'33'; data:'111323' ),
  ( a:'B'; b:'B'; c:'34'; data:'131123' ),
  ( a:'C'; b:'C'; c:'35'; data:'131321' ),
  ( a:'D'; b:'D'; c:'36'; data:'112313' ),
  ( a:'E'; b:'E'; c:'37'; data:'132113' ),
  ( a:'F'; b:'F'; c:'38'; data:'132311' ),
  ( a:'G'; b:'G'; c:'39'; data:'211313' ),
  ( a:'H'; b:'H'; c:'40'; data:'231113' ),
  ( a:'I'; b:'I'; c:'41'; data:'231311' ),
  ( a:'J'; b:'J'; c:'42'; data:'112133' ),
  ( a:'K'; b:'K'; c:'43'; data:'112331' ),
  ( a:'L'; b:'L'; c:'44'; data:'132131' ),
  ( a:'M'; b:'M'; c:'45'; data:'113123' ),
  ( a:'N'; b:'N'; c:'46'; data:'113321' ),
  ( a:'O'; b:'O'; c:'47'; data:'133121' ),
  ( a:'P'; b:'P'; c:'48'; data:'313121' ),
  ( a:'Q'; b:'Q'; c:'49'; data:'211331' ),
  ( a:'R'; b:'R'; c:'50'; data:'231131' ),
  ( a:'S'; b:'S'; c:'51'; data:'213113' ),
  ( a:'T'; b:'T'; c:'52'; data:'213311' ),
  ( a:'U'; b:'U'; c:'53'; data:'213131' ),
  ( a:'V'; b:'V'; c:'54'; data:'311123' ),
  ( a:'W'; b:'W'; c:'55'; data:'311321' ),
  ( a:'X'; b:'X'; c:'56'; data:'331121' ),
  ( a:'Y'; b:'Y'; c:'57'; data:'312113' ),
  ( a:'Z'; b:'Z'; c:'58'; data:'312311' ),
  ( a:'['; b:'['; c:'59'; data:'332111' ),
  ( a:'\'; b:'\'; c:'60'; data:'314111' ),
  ( a:']'; b:']'; c:'61'; data:'221411' ),
  ( a:'^'; b:'^'; c:'62'; data:'431111' ),
  ( a:'_'; b:'_'; c:'63'; data:'111224' ),
  ( a:' '; b:'`'; c:'64'; data:'111422' ),
  ( a:' '; b:'a'; c:'65'; data:'121124' ),
  ( a:' '; b:'b'; c:'66'; data:'121421' ),
  ( a:' '; b:'c'; c:'67'; data:'141122' ),
  ( a:' '; b:'d'; c:'68'; data:'141221' ),
  ( a:' '; b:'e'; c:'69'; data:'112214' ),
  ( a:' '; b:'f'; c:'70'; data:'112412' ),
  ( a:' '; b:'g'; c:'71'; data:'122114' ),
  ( a:' '; b:'h'; c:'72'; data:'122411' ),
  ( a:' '; b:'i'; c:'73'; data:'142112' ),
  ( a:' '; b:'j'; c:'74'; data:'142211' ),
  ( a:' '; b:'k'; c:'75'; data:'241211' ),
  ( a:' '; b:'l'; c:'76'; data:'221114' ),
  ( a:' '; b:'m'; c:'77'; data:'413111' ),
  ( a:' '; b:'n'; c:'78'; data:'241112' ),
  ( a:' '; b:'o'; c:'79'; data:'134111' ),
  ( a:' '; b:'p'; c:'80'; data:'111242' ),
  ( a:' '; b:'q'; c:'81'; data:'121142' ),
  ( a:' '; b:'r'; c:'82'; data:'121241' ),
  ( a:' '; b:'s'; c:'83'; data:'114212' ),
  ( a:' '; b:'t'; c:'84'; data:'124112' ),
  ( a:' '; b:'u'; c:'85'; data:'124211' ),
  ( a:' '; b:'v'; c:'86'; data:'411212' ),
  ( a:' '; b:'w'; c:'87'; data:'421112' ),
  ( a:' '; b:'x'; c:'88'; data:'421211' ),
  ( a:' '; b:'y'; c:'89'; data:'212141' ),
  ( a:' '; b:'z'; c:'90'; data:'214121' ),
  ( a:' '; b:'{'; c:'91'; data:'412121' ),
  ( a:' '; b:'|'; c:'92'; data:'111143' ),
  ( a:' '; b:'}'; c:'93'; data:'111341' ),
  ( a:' '; b:'~'; c:'94'; data:'131141' ),
  ( a:' '; b:' '; c:'95'; data:'114113' ),     { US,DEL,95 }
  ( a:' '; b:' '; c:'96'; data:'114311' ),     { FNC3,FNC3,96 }
  ( a:' '; b:' '; c:'97'; data:'411113' ),     { FNC2,FNC2,97 }
  ( a:' '; b:' '; c:'98'; data:'411311' ),     { Shift,Shift,98 }
  ( a:' '; b:' '; c:'99'; data:'113141' ),     { CodeC,CodeC,99 }
  ( a:' '; b:' '; c:'CB'; data:'114131' ),     { CodeB,FNC4,CodeB }
  ( a:' '; b:' '; c:'CA'; data:'311141' ),     { FNC4,CodeA,CodeA }
  ( a:' '; b:' '; c:'F1'; data:'411131' )      { FNC1 }
  );

StartA = '211412';
StartB = '211214';
StartC = '211232';
Stop   = '2331112';

{ Find Code 128 Codeset A or B }
function Find_Code128AB(c:char; const H1_BarType:TBarType):integer;
var
  i:integer;
  v:char;
begin
  for i:=0 to High(tabelle_128) do
  begin
    if H1_BarType = bcCode128A then
      v := tabelle_128[i].a
    else
      v := tabelle_128[i].b;

    if c = v then
    begin
      result := i;
      exit;
    end;
    {Upgrade to 1.7.3 ->}
    if Ord(c) >= 195 then
    begin
      result := Ord(c) - 100;
      exit
    end;
    {Upgrade to 1.7.3 <-}
  end;
  result := -1;
end;

{ Find Code 128 Codeset C }
function Find_Code128C(c:string):integer;
var
  i:integer;
begin
  for i:=0 to High(tabelle_128) do begin
    if tabelle_128[i].c = c then begin
     result := i;
     exit;
    end;
  end;
  result := -1;
end;

var
  i, j, idx: integer;
  startcode:string;
  checksum : integer;
  codeword_pos : integer;
  bar: string;
begin

  bar := H_BarCode;
  case H_BarType of
    bcCode128A, bcCodeEAN128A:
      begin checksum := 103; startcode:= StartA; end;
    bcCode128B, bcCodeEAN128B:
      begin checksum := 104; startcode:= StartB; end;
    bcCode128C, bcCodeEAN128C:
      begin checksum := 105; startcode:= StartC; end;
    else
      raise Exception.CreateFmt('%s : %s', ['Code_128 : ',ErrorBarType]);
  end;

  result := startcode;
  codeword_pos := 1;

  case H_BarType of
    bcCodeEAN128A,
    bcCodeEAN128B,
    bcCodeEAN128C:
    begin
      result := result + tabelle_128[102].data;
      Inc(checksum, 102*codeword_pos);
      Inc(codeword_pos);
      if H_CheckSum <> csNone then bar:=DoCheckSumming(H_CheckSum, bar);
    end;
  end;

  if (H_BarType = bcCode128C) or (H_BarType = bccodeEAN128C) then
  begin
    if (Length(bar) mod 2<>0) then bar :='0' + bar;
    for i:=1 to (Length(bar) div 2) do
    begin
      j:=(i-1)*2+1;
      idx:=Find_Code128C(copy(bar,j,2));
      if idx < 0 then idx := Find_Code128C('00');
      result := result + tabelle_128[idx].data;
      Inc(checksum, idx*codeword_pos);
      Inc(codeword_pos);
    end;
  end
  else
    for i:=1 to Length(bar) do
    begin
      idx := Find_Code128AB(bar[i],H_BarType);
      if idx < 0 then
        idx := Find_Code128AB(' ',H_BarType);
      result := result + tabelle_128[idx].data;
      Inc(checksum, idx*codeword_pos);
      Inc(codeword_pos);
    end;

  checksum := checksum mod 103;
  result := result + tabelle_128[checksum].data;

  result := result + Stop;
  Result := Convert(Result);
  H_CheckNum := bar;
end;

{********************}
{  For Code 93       }
{********************}

{ Get Code93 data }
function  Code_93(const H_BarCode:string):string;
type TCode93 =
  record
    c : char;
    data : array[0..5] of char;
  end;

const tabelle_93: array[0..46] of TCode93 = (
  ( c:'0'; data:'131112'  ),
  ( c:'1'; data:'111213'  ),
  ( c:'2'; data:'111312'  ),
  ( c:'3'; data:'111411'  ),
  ( c:'4'; data:'121113'  ),
  ( c:'5'; data:'121212'  ),
  ( c:'6'; data:'121311'  ),
  ( c:'7'; data:'111114'  ),
  ( c:'8'; data:'131211'  ),
  ( c:'9'; data:'141111'  ),
  ( c:'A'; data:'211113'  ),
  ( c:'B'; data:'211212'  ),
  ( c:'C'; data:'211311'  ),
  ( c:'D'; data:'221112'  ),
  ( c:'E'; data:'221211'  ),
  ( c:'F'; data:'231111'  ),
  ( c:'G'; data:'112113'  ),
  ( c:'H'; data:'112212'  ),
  ( c:'I'; data:'112311'  ),
  ( c:'J'; data:'122112'  ),
  ( c:'K'; data:'132111'  ),
  ( c:'L'; data:'111123'  ),
  ( c:'M'; data:'111222'  ),
  ( c:'N'; data:'111321'  ),
  ( c:'O'; data:'121122'  ),
  ( c:'P'; data:'131121'  ),
  ( c:'Q'; data:'212112'  ),
  ( c:'R'; data:'212211'  ),
  ( c:'S'; data:'211122'  ),
  ( c:'T'; data:'211221'  ),
  ( c:'U'; data:'221121'  ),
  ( c:'V'; data:'222111'  ),
  ( c:'W'; data:'112122'  ),
  ( c:'X'; data:'112221'  ),
  ( c:'Y'; data:'122121'  ),
  ( c:'Z'; data:'123111'  ),
  ( c:'-'; data:'121131'  ),
  ( c:'.'; data:'311112'  ),
  ( c:' '; data:'311211'  ),
  ( c:'$'; data:'321111'  ),
  ( c:'/'; data:'112131'  ),
  ( c:'+'; data:'113121'  ),
  ( c:'%'; data:'211131'  ),
  ( c:'['; data:'121221'  ),   {only used for Extended Code 93}
  ( c:']'; data:'312111'  ),   {only used for Extended Code 93}
  ( c:'{'; data:'311121'  ),   {only used for Extended Code 93}
  ( c:'}'; data:'122211'  )    {only used for Extended Code 93}
  );


{Find Code 93}
function Find_Code93(c:char):integer;
var
  i:integer;
begin
  for i:=0 to High(tabelle_93) do
  begin
    if c = tabelle_93[i].c then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1;
end;

var
  i, idx : integer;
  checkC, checkK,   {Checksums}
  weightC, weightK : integer;
begin

  result := '111141';   {Startcode}

  for i:=1 to Length(H_BarCode) do
  begin
    idx := Find_Code93(H_BarCode[i]);
    if idx < 0 then
      raise Exception.CreateFmt('%s : %s', [H_BarCode, ErrorCode93]);
    result := result + tabelle_93[idx].data;
  end;

  checkC := 0;
  checkK := 0;

  weightC := 1;
  weightK := 2;

  for i:=Length(H_BarCode) downto 1 do
  begin
    idx := Find_Code93(H_BarCode[i]);

    Inc(checkC, idx*weightC);
    Inc(checkK, idx*weightK);

    Inc(weightC);
    if weightC > 20 then weightC := 1;
    Inc(weightK);
    if weightK > 15 then weightC := 1;
  end;

  Inc(checkK, checkC);

  checkC := checkC mod 47;
  checkK := checkK mod 47;

  result := result + tabelle_93[checkC].data +
    tabelle_93[checkK].data;

  result := result + '1111411';   {Stopcode}
  Result := Convert(Result);
end;

{ Get Code93 extended data }
function  Code_93Extended(const H_BarCode:string):string;

const code93x : array[0..127] of string[2] =
  (
  (']U'), ('[A'), ('[B'), ('[C'), ('[D'), ('[E'), ('[F'), ('[G'),
  ('[H'), ('[I'), ('[J'), ('[K'), ('[L'), ('[M'), ('[N'), ('[O'),
  ('[P'), ('[Q'), ('[R'), ('[S'), ('[T'), ('[U'), ('[V'), ('[W'),
  ('[X'), ('[Y'), ('[Z'), (']A'), (']B'), (']C'), (']D'), (']E'),
   (' '), ('{A'), ('{B'), ('{C'), ('{D'), ('{E'), ('{F'), ('{G'),
  ('{H'), ('{I'), ('{J'), ('{K'), ('{L'), ('{M'), ('{N'), ('{O'),
  ( '0'),  ('1'),  ('2'),  ('3'),  ('4'),  ('5'),  ('6'),  ('7'),
   ('8'),  ('9'), ('{Z'), (']F'), (']G'), (']H'), (']I'), (']J'),
  (']V'),  ('A'),  ('B'),  ('C'),  ('D'),  ('E'),  ('F'),  ('G'),
   ('H'),  ('I'),  ('J'),  ('K'),  ('L'),  ('M'),  ('N'),  ('O'),
   ('P'),  ('Q'),  ('R'),  ('S'),  ('T'),  ('U'),  ('V'),  ('W'),
   ('X'),  ('Y'),  ('Z'), (']K'), (']L'), (']M'), (']N'), (']O'),
  (']W'), ('}A'), ('}B'), ('}C'), ('}D'), ('}E'), ('}F'), ('}G'),
  ('}H'), ('}I'), ('}J'), ('}K'), ('}L'), ('}M'), ('}N'), ('}O'),
  ('}P'), ('}Q'), ('}R'), ('}S'), ('}T'), ('}U'), ('}V'), ('}W'),
  ('}X'), ('}Y'), ('}Z'), (']P'), (']Q'), (']R'), (']S'), (']T')
  );

var
  tmp : string;
  i : integer;
begin
  tmp := '';
  for i:=0 to Length(H_BarCode)-1 do
  begin
    if ord(H_BarCode[i]) <= 127 then
      tmp := tmp + code93x[ord(H_BarCode[i])];
  end;
  result := Code_93(tmp);
end;

{********************}
{  For Code MSI      }
{********************}

{ Get Code MSI data }
function  Code_MSI(const H_BarCode:string):string;

const tabelle_MSI:array['0'..'9'] of string[8] =
  (
  ( '51515151' ),    {'0'}
  ( '51515160' ),    {'1'}
  ( '51516051' ),    {'2'}
  ( '51516060' ),    {'3'}
  ( '51605151' ),    {'4'}
  ( '51605160' ),    {'5'}
  ( '51606051' ),    {'6'}
  ( '51606060' ),    {'7'}
  ( '60515151' ),    {'8'}
  ( '60515160' )     {'9'}
  );

var
  i:integer;
  check_even, check_odd, checksum:integer;
begin
  result := '60';    {Startcode}
  check_even := 0;
  check_odd  := 0;

  for i:=1 to Length(H_BarCode) do
  begin
    if odd(i-1) then
      check_odd := check_odd*10+ord(H_BarCode[i])
    else
      check_even := check_even+ord(H_BarCode[i]);

    result := result + tabelle_MSI[H_BarCode[i]];
  end;

  checksum := quersumme(check_odd*2) + check_even;

  checksum := checksum mod 10;
  if checksum > 0 then
    checksum := 10-checksum;

  result := result + tabelle_MSI[chr(ord('0')+checksum)];

  result := result + '515'; {Stopcode}
end;

{********************}
{  For Post Net      }
{********************}

{ Get Post Net data }
function  Code_PostNet(const H_BarCode:string):string;

const tabelle_PostNet:array['0'..'9'] of string[10] =
  (
  ( '5151A1A1A1' ),    {'0'}
  ( 'A1A1A15151' ),    {'1'}
  ( 'A1A151A151' ),    {'2'}
  ( 'A1A15151A1' ),    {'3'}
  ( 'A151A1A151' ),    {'4'}
  ( 'A151A151A1' ),    {'5'}
  ( 'A15151A1A1' ),    {'6'}
  ( '51A1A1A151' ),    {'7'}
  ( '51A1A151A1' ),    {'8'}
  ( '51A151A1A1' )     {'9'}
  );
var
  i:integer;
begin
  result := '51';

  for i:=1 to Length(H_BarCode) do
  begin
    result := result + tabelle_PostNet[H_BarCode[i]];
  end;
  result := result + '5';
end;


{********************}
{  For Codabar       }
{********************}

{ Get Codabar data }
function  Code_Codabar(const H_BarCode:string):string;
type TCodabar =
  record
    c : char;
    data : array[0..6] of char;
  end;

const tabelle_cb: array[0..19] of TCodabar = (
  ( c:'1'; data:'5050615'  ),
  ( c:'2'; data:'5051506'  ),
  ( c:'3'; data:'6150505'  ),
  ( c:'4'; data:'5060515'  ),
  ( c:'5'; data:'6050515'  ),
  ( c:'6'; data:'5150506'  ),
  ( c:'7'; data:'5150605'  ),
  ( c:'8'; data:'5160505'  ),
  ( c:'9'; data:'6051505'  ),
  ( c:'0'; data:'5050516'  ),
  ( c:'-'; data:'5051605'  ),
  ( c:'$'; data:'5061505'  ),
  ( c:':'; data:'6050606'  ),
  ( c:'/'; data:'6060506'  ),
  ( c:'.'; data:'6060605'  ),
  ( c:'+'; data:'5060606'  ),
  ( c:'A'; data:'5061515'  ),
  ( c:'B'; data:'5151506'  ),
  ( c:'C'; data:'5051516'  ),
  ( c:'D'; data:'5051615'  )
  );

{find Codabar}
function Find_Codabar(c:char):integer;
var
  i:integer;
begin
  for i:=0 to High(tabelle_cb) do
  begin
    if c = tabelle_cb[i].c then
    begin
      result := i;
      exit;
    end;
  end;
  result := -1;
end;

var
  i, idx : integer;
begin
//20110524 ice  result := tabelle_cb[Find_Codabar('A')].data + '0';
  result := String(tabelle_cb[Find_Codabar('A')].data) + '0';
  for i:=1 to Length(H_BarCode) do
  begin
    idx := Find_Codabar(H_BarCode[i]);
    result := result + tabelle_cb[idx].data + '0';
  end;
  result := result + tabelle_cb[Find_Codabar('B')].data;
end;

{********************}
{  For Code UPC      }
{********************}

{ Get Code UPC A data }
function  Code_UPC_A(const H_BarCode:string; const H_CheckSum:TCheckSum;
  var H_CheckNum:string):string;
var
  i : Integer;
  tmp, bar : string;
begin
  bar := SetLen(12,H_BarCode);
  if H_CheckSum<>csNone then
    tmp:=DoCheckSumming(H_CheckSum, copy(bar,1,11))
  else
    tmp:=bar;
  if H_CheckSum<>csNone then H_CheckNum := tmp;
  result := '505';
  for i:=1 to 6 do
    result := result + tabelle_EAN_A[tmp[i]];
  result := result + '05050';
  for i:=7 to 12 do
    result := result + tabelle_EAN_C[tmp[i]];
  result := result + '505';
end;


{UPC E Parity Pattern Table , Number System 0}
const tabelle_UPC_E0:array['0'..'9', 1..6] of char =
  (
  ('E', 'E', 'E', 'o', 'o', 'o' ),    { 0 }
  ('E', 'E', 'o', 'E', 'o', 'o' ),    { 1 }
  ('E', 'E', 'o', 'o', 'E', 'o' ),    { 2 }
  ('E', 'E', 'o', 'o', 'o', 'E' ),    { 3 }
  ('E', 'o', 'E', 'E', 'o', 'o' ),    { 4 }
  ('E', 'o', 'o', 'E', 'E', 'o' ),    { 5 }
  ('E', 'o', 'o', 'o', 'E', 'E' ),    { 6 }
  ('E', 'o', 'E', 'o', 'E', 'o' ),    { 7 }
  ('E', 'o', 'E', 'o', 'o', 'E' ),    { 8 }
  ('E', 'o', 'o', 'E', 'o', 'E' )     { 9 }
  );

{ Get Code UPC E0 data }
function  Code_UPC_E0(const H_BarCode:string; const H_CheckSum:TCheckSum;
  var H_CheckNum:string):string;
var
  i,j : integer;
  tmp, bar : string;
  c   : char;
begin
  bar := SetLen(7,H_BarCode);
  tmp:=DoCheckSumming(H_CheckSum, Copy(bar,1,6));
  c:=tmp[7];
  if H_CheckSum<>csNone then H_CheckNum:=tmp else tmp := bar;
  result := '505';
  for i:=1 to 6 do
  begin
    if tabelle_UPC_E0[c,i]='E' then
    begin
      for j:= 1 to 4 do result := result + tabelle_EAN_C[tmp[i],5-j];
    end
    else
    begin
      result := result + tabelle_EAN_A[tmp[i]];
    end;
  end;
  result := result + '050505';
end;

{ Get Code UPC E1 data }
function  Code_UPC_E1(const H_BarCode:string; const H_CheckSum:TCheckSum;
  var H_CheckNum:string):string;
var
  i,j : integer;
  tmp,bar : string;
  c   : char;
begin
  bar := SetLen(7,H_BarCode);
  tmp :=DoCheckSumming(H_CheckSum, copy(bar,1,6));
  c:=tmp[7];
  if H_CheckSum<>csNone then H_CheckNum:=tmp else tmp := bar;
  result := '505';
  for i:=1 to 6 do
  begin
    if tabelle_UPC_E0[c,i]='E' then
    begin
      result := result + tabelle_EAN_A[tmp[i]];
    end
    else
    begin
      for j:= 1 to 4 do result := result + tabelle_EAN_C[tmp[i],5-j];
    end;
  end;
  result := result + '050505';
end;

{ Get Code UPC Supp5 data }
function  Code_Supp5(const H_BarCode:string; const H_CheckSum:TCheckSum;
  var H_CheckNum:string):string;
var
  i,j : Integer;
  tmp, bar : string;
  c   : Char;
begin
  bar := SetLen(5,H_BarCode);
  tmp:=getSupp(copy(bar,1,5)+'0');
  c:=tmp[6];
  if H_CheckSum<>csNone then H_CheckNum:=tmp else tmp := bar;
  result := '506';   {Startcode}
  for i:=1 to 5 do
  begin
    if tabelle_UPC_E0[c,(6-5)+i]='E' then
    begin
      for j:= 1 to 4 do result := result + tabelle_EAN_C[tmp[i],5-j];
    end
    else
    begin
      result := result + tabelle_EAN_A[tmp[i]];
    end;
    if i<5 then result:=result+'05'; { character delineator }
  end;
end;

{ Get Code UPC Supp2 data }
function  Code_Supp2(const H_BarCode:string; const H_CheckSum:TCheckSum;
  var H_CheckNum:string):string;
var
  i,j : integer;
  tmp, mS, bar: string;
begin
  bar := SetLen(2,H_BarCode);
  i:=StrToInt(bar);
  case i mod 4 of
    3: mS:='EE';
    2: mS:='Eo';
    1: mS:='oE';
    0: mS:='oo';
  end;
  tmp:=getSupp(copy(bar,1,5)+'0');

  if H_CheckSum<>csNone then H_CheckNum:=tmp else tmp := bar;
  result := '506';
  for i:=1 to 2 do
  begin
    if mS[i]='E' then
    begin
      for j:= 1 to 4 do result := result + tabelle_EAN_C[tmp[i],5-j];
    end
    else
    begin
      result := result + tabelle_EAN_A[tmp[i]];
    end;
    if i<2 then result:=result+'05';
  end;
end;


