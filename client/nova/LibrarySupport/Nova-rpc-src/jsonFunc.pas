unit jsonFunc;

interface

uses
  SysUtils, db, Variants, classes, Forms,
  Dialogs, Base64;

function GetParams(AProviderName: string; AParams: OleVariant): string;
// 将字段值以XML格式取出
function GetXMLFmtFieldValue(AField: TField): string;

// 设置成XML格式的值
function SetXMLFmtValue(AValue: WideString; AFieldType: TFieldType): WideString;

// 将ftOraClob和ftOraBlob的字符串格式化,用于解决大对象的问题 add by yexinyao@20081212
function FormatClob(AValue: WideString; AFieldType: TFieldType): string;

function GetXMLValue(AXML, ANodeName: string; AOffset: Integer;
  AParams: TParams; var AValue: string): Integer;

//取出XML格式的参数，写入AParams中
function SetXMLParams(AParamsStr: string; AParams: TParams): Boolean;

function SetParam(AParamsName,AParamValue: string; AParams: TParams): Boolean;
function GetDataSetXML(ADataSet: TDataSet): string;
//取字段类型
function GetFieldXMLType(AFieldType: TFieldType): string;

//日期转换
Function _strtodate(value:string):Tdate;
function _strtodatetime(Strdate:string):Tdatetime;
Function _formatdatetime(FormatStr:string;Dt:Tdatetime):string;

implementation

function GetParams(AProviderName: string; AParams: OleVariant): string;
var
  sXML, sParamValues: string;
  i: Integer;
  MyParams: TParams;
  MyParam: TParam;
begin
  sParamValues := '"providername":"' + AProviderName + '","isquery":"true"';

  Result := sXML;
end;

function GetXMLFmtFieldValue(AField: TField): string;
var
  sValue: string;
begin
  Result := SetXMLFmtValue(AField.AsString, AField.DataType);
end;

function SetXMLFmtValue(AValue: WideString; AFieldType: TFieldType): WideString;
var
  sValue: string;
begin
  sValue := AValue;
  if (sValue <> '') then
  begin
    if (AFieldType = ftString) or (AFieldType = ftWideString) then
    begin
      sValue := StringReplace(AValue, '&', '&amp;', [rfReplaceAll]);



      sValue := StringReplace(sValue, '"', '&quot;', [rfReplaceAll]);
    //  sValue := StringReplace(sValue, '''', '&apos;', [rfReplaceAll]);
     // sValue := StringReplace(sValue, '<', '&lt;', [rfReplaceAll]);
    //  sValue := StringReplace(sValue, '>', '&gt;', [rfReplaceAll]);
   //   sValue := StringReplace(sValue, '\', '&#092;', [rfReplaceAll]);

      sValue := StringReplace(sValue, '%', '%25', [rfReplaceAll]);
     // sValue := StringReplace(sValue, '#', '%23', [rfReplaceAll]);
      sValue := StringReplace(sValue, '+', '%2B', [rfReplaceAll]);
     // sValue := StringReplace(sValue, '?', '%3F', [rfReplaceAll]);
     // sValue := StringReplace(sValue, '=', '%3D', [rfReplaceAll]);
     // sValue := StringReplace(sValue, #9, '^$%x%$^09;', [rfReplaceAll]);
     // sValue := StringReplace(sValue, #13#10, '^$%x%$^0D;^$%x%$^0A;',
     //   [rfReplaceAll]);
      // sValue := StringReplace(sValue,' ','&#x0020;',[rfReplaceAll]);
    //  sValue:=HttpEncode(sValue);

    end
    else if (AFieldType = ftDateTime) then
    begin
      sValue := FormatDateTime('yyyy-mm-dd" "hh:nn:ss', _strtodatetime(AValue));
    end
    else if (AFieldType = ftDate) then
    begin
      sValue := FormatDateTime('yyyy-mm-dd', _strtodate(AValue));
    end
    else if (AFieldType = ftOraClob) or (AFieldType = ftOraBlob) then
    begin
      if sValue <> '' then
        sValue := FormatClob(AValue, AFieldType);
    end;
  end;
  Result := sValue;
end;

function FormatClob(AValue: WideString; AFieldType: TFieldType): string;
begin
  Result := Base64Encode(AValue);
end;

function GetXMLValue(AXML, ANodeName: string; AOffset: Integer;
  AParams: TParams; var AValue: string): Integer;
var
  sValue: string;
  c, sWord: string;
  i, iLen, iNodeNameLen: Integer;
  bEvenInvertedComma: Boolean;
  iBracket: Integer;
  iBegin, iEnd: Integer;
  sParamStr: string;
  sBreakString: string;
begin
  sBreakString := ' '#13#10#9;
  sValue := '';
  bEvenInvertedComma := true;
  iBracket := 0;
  i := AOffset;
  iEnd := 0;
  iNodeNameLen := Length(ANodeName);
  iLen := Length(AXML);
  while i < iLen do
  begin
    // 取出属性字
    sWord := '';
    while (i < iLen) do
    begin
      Inc(i);
      c := Copy(AXML, i, 1);
      if ((Pos(c, sBreakString) > 0) and bEvenInvertedComma and (iBracket = 0))
        then
        break
      else
        sWord := sWord + c;
      if (c = '"') then
      begin
        bEvenInvertedComma := (not bEvenInvertedComma);
      end
      else if (bEvenInvertedComma) then // 若为偶数单引号时，作括号检查
      begin
        if (c = '<') then
        begin
          Inc(iBracket);
        end
        else if (c = '>') then
        begin
          Dec(iBracket);
          if (iBracket = 0) then
            break;
        end;
      end;
    end;
    // 检查是否为所需的属性字
    if (sWord = '<' + ANodeName + '>') then
    begin
      iBegin := i + 1;
    end
    else if (Copy(sWord, 1, iNodeNameLen + 2) = '<' + ANodeName + ' ') then
    begin
      iBegin := i + 1;
      sParamStr := Copy(sWord, iNodeNameLen + 3,
        Length(sWord) - iNodeNameLen - 3);
      if (Copy(sParamStr, Length(sParamStr), 1) = '/') then
      begin
        // 最后一个字符为“/”则认为结束
        Delete(sParamStr, Length(sParamStr), 1);
        iEnd := iBegin;
      end;
      SetXMLParams(sParamStr, AParams);
      if (iBegin = iEnd) then
      begin
        AValue := '';
        break;
      end;
    end
    else if (sWord = '</' + ANodeName + '>') then
    begin
      iEnd := i - iNodeNameLen - 2;
      AValue := Copy(AXML, iBegin, iEnd - iBegin);
      break;
    end;
  end;
  Result := i;
end;


function SetXMLParams(AParamsStr: string; AParams: TParams): Boolean;
var
  i,iLen: Integer;
  c,sWord,sParamName,sValue: string;
  bEvenInvertedComma: Boolean;
  bSetParamsOK: Boolean;
begin
  bSetParamsOK := true;
  bEvenInvertedComma := true;
  i := 0;
  iLen := Length(AParamsStr);
  while (i < iLen) do
  begin
    sWord := '';
    while (i < iLen) do
    begin
      Inc(i);
      c := Copy(AParamsStr,i,1);
      if (c = '"') then
      begin
        bEvenInvertedComma := (not bEvenInvertedComma);
        //第一个引号则跳出
        if (not bEvenInvertedComma) then
          break;
      end;
      if (bEvenInvertedComma and (Pos(c,' ="') > 0)) then
        break
      else
        sWord := sWord+c;
    end;
    if (sWord <> '') then
    begin
      if (c = '=') then
      begin
        sParamName := Trim(sWord);
      end
      else
      begin
        sValue := sWord;
        if (not SetParam(sParamName,sValue,AParams)) then
        begin
          bSetParamsOK := false;
          break;
        end;
      end;
    end;
  end;
  Result := bSetParamsOK;
end;



function SetParam(AParamsName,AParamValue: string; AParams: TParams): Boolean;
var
  sValueUpper,SaveShortDateFormat: string;
  bSetParamsOK: Boolean;
  dtValue: TDateTime;
begin
  bSetParamsOK := True;
  try
    sValueUpper := UpperCase(AParamValue);
    if ((sValueUpper = 'TRUE') or (sValueUpper = 'FALSE')) then
    begin
      if (AParams.FindParam(AParamsName) = nil) then
        AParams.CreateParam(ftBoolean,AParamsName,ptInput);
      AParams.ParamByName(AParamsName).AsBoolean := (sValueUpper = 'TRUE');
    end
    else if ((Copy(AParamValue,1,1) >= '0') and (Copy(AParamValue,1,1) <= '9')
        and (Pos('-',Copy(AParamValue,3,Length(AParamValue))) > 0)) then
    begin
      SaveShortDateFormat := ShortDateFormat;
      ShortDateFormat := 'yyyy-mm-dd';
      try
        dtValue := StrToDate(AParamValue);
        if (AParams.FindParam(AParamsName) = nil) then
          AParams.CreateParam(ftDateTime,AParamsName,ptInput);
        AParams.ParamByName(AParamsName).AsDateTime := dtValue;
      except
        if (AParams.FindParam(AParamsName) = nil) then
          AParams.CreateParam(ftString,AParamsName,ptInput);
        AParams.ParamByName(AParamsName).AsString := AParamValue;
      end;
      ShortDateFormat := SaveShortDateFormat;
    end
    else
    begin
      if (AParams.FindParam(AParamsName) = nil) then
        AParams.CreateParam(ftString,AParamsName,ptInput);
      AParams.ParamByName(AParamsName).AsString := AParamValue;
    end;
  except
    bSetParamsOK := false;
  end;
  Result := bSetParamsOK;
end;

function GetDataSetXML(ADataSet: TDataSet): string;
var
  sXML: string;
  i: Integer;
  MyField: TField;
begin
  if (ADataSet.Fields.Count = 0) then
  begin
    sXML := '';
  end
  else
  begin
    sXML := '<?xml version="1.0" encoding="gb2312" standalone="yes"?>  <DATAPACKET Version="2.0"><METADATA><FIELDS>';
    for i := 0 to ADataSet.Fields.Count-1 do
    begin
      MyField := ADataSet.Fields.Fields[i];
      sXML := sXML+'<FIELD attrname="'+MyField.FieldName+'" fieldtype="'+GetFieldXMLType(MyField.DataType)+'" WIDTH="'+IntToStr(MyField.Size)+'"/>';
    end;
    sXML := sXML+'</FIELDS><PARAMS/></METADATA><ROWDATA></ROWDATA></DATAPACKET>';
  end;
  Result := sXML;
end;

function GetFieldXMLType(AFieldType: TFieldType): string;
begin
  case AFieldType of
    ftString: Result := 'string';
    ftSmallint: Result := 'i4';
    ftInteger: Result := 'i4';
    ftWord: Result := 'i4';
    ftBoolean: Result := 'boolean';
    ftAutoInc: Result := 'i4';
    ftFloat: Result := 'r8';
    ftCurrency: Result := 'r8';
    ftBCD: Result := 'r8';
    ftDate: Result := 'date';
    ftTime: Result := 'time';
    ftDateTime: Result := 'datetime';
  end;
end;


//日期转换
Function _strtodate(value:string):Tdate;
var
 oldSeparator : char;
begin
oldSeparator := DateSeparator     ;
  if pos('-',value)>0 then
   begin
     DateSeparator := '-';
   end
  else
  if pos('.',value)>0 then
   begin
     DateSeparator := '.';
   end;
 result := strtodate(value);
 DateSeparator :=  oldSeparator    ;
end;
function _strtodatetime(Strdate:string):Tdatetime;
begin
 if pos('.',Strdate)>0 then
 begin
  DateSeparator:='.';
 end
 else
  begin
   DateSeparator:='-';
  end;
   Result:=strtodatetime(strdate)
end;

Function _formatdatetime(FormatStr:string;Dt:Tdatetime):string;
var
 OLDSep :char;
begin
oldSep := DateSeparator;
 if pos('.',FormatStr)>0 then
 begin
  DateSeparator:='.';
  Result:=formatdatetime(FormatStr,Dt);
 end
 else
  begin
   DateSeparator:='-';
   Result:=formatdatetime(FormatStr,Dt);
  end;
 DateSeparator:= oldSep;
end;

end.
