unit DBJson;

interface

uses SysUtils, Classes, Variants, DB, DBClient, SuperObject, Base64;

type
  TTableJSon = class
    // 以下是数据集时用到
  private const
    cstFieldType = 'fieldType';

  const
    cstFieldName = 'fieldName';

  const
    cstFieldSize = 'fieldSize';

  const
    cstJsonType = 'jsonType';

  const
    cstRequired = 'required';

  const
    cstFieldIndex = 'fieldIndex';

  const
    cstCols = 'Cols';

  const
    cstData = 'Data';

    // 以下是参数时用到常量
  const
    cstParam = 'param';

  const
    cstParamName = 'paramName';

  const
    cstParamValue = 'paramValue';

  const
    cstParamSize = 'paramSize';

  const
    cstEncrypt = 'encrypt';

  const
    cstProviderName = 'providerName';

  const
    cstSql = 'Sql';

    class function ImportDataFromJSon(DataSet: TDataSet;
      DataJson: ISuperObject): Integer;

    class function GetValue(Json: ISuperObject; const Name: string): Variant;

    class function CreateJsonValue(Json: ISuperObject; const Name: string;
      const Value: Variant): Boolean;

    class function CreateJsonValueByField(Json: ISuperObject;
      Field: TField): Boolean;

    class function GetValue2Field(Field: TField;
      JsonValue: ISuperObject): Variant;

    class procedure GetFieldTypeInfo(Field: TField;
      var Fieldtyp, JsonTyp: string);

    class function CreateFieldByJson(Fields: TFieldDefs;
      ColsJson: ISuperObject): Boolean;

    class function GetJSONFmtParamValue(AParam: TParam): string;

    class function SetJSONFmtValue(AValue: WideString;
      AFieldType: TFieldType): WideString;

    class function FormatClob(AValue: WideString;
      AFieldType: TFieldType): string;

    class function CreateXmlFieldByJson(ProviderName: String;
      ColsJson: ISuperObject): String;
    class function CreateXmlDataFromJSon(DataJson: ISuperObject): String;
    class function isInteger(fieldValue: String): Boolean;
    class function isFloat(fieldValue: String): Boolean;

  public
    // 数据集转成JSON
    class function JSonFromDataSet(DataSet: TDataSet): string;

    // 数据集参数转成JSON
    class function JSonFromDataSetParam(AProviderName: string;
      AParams: OleVariant; ASQL: string): string;

    // JSON转换成数据集
    class function CDSFromJSon(CDS: TCustomClientDataSet;
      Json: ISuperObject): Boolean;

    // JSON转换成XML
    class function XMLFromJSon(ProviderName: String;
      Json: ISuperObject): String;
    // 合并JSON格式的两条记录，取第一条记录的ID保存到第二条记录中
    class function MergeFromJson(Pkey: String; sJson: String): String;

    class function CDSFromJSon2(var CDS: TCustomClientDataSet; sData: String;
      sDatasetType: String; sFiledSize: String): Boolean;

    class function CreateField(Fields: TFieldDefs; fieldTypes: String;
      sFiledSize: String): Boolean;

    class function GetFieldSize(_FieldName: String;
      sFiledSize: String): Integer;

  end;

implementation

uses TypInfo, encddecd;

{ TTableJSon }
class function TTableJSon.FormatClob(AValue: WideString;
  AFieldType: TFieldType): string;
begin
  Result := Base64Encode(AValue);
end;

class function TTableJSon.SetJSONFmtValue(AValue: WideString;
  AFieldType: TFieldType): WideString;
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
      sValue := StringReplace(sValue, '''', '&apos;', [rfReplaceAll]);
      sValue := StringReplace(sValue, '<', '&lt;', [rfReplaceAll]);
      sValue := StringReplace(sValue, '>', '&gt;', [rfReplaceAll]);
      sValue := StringReplace(sValue, '\', '&#092;', [rfReplaceAll]);
      sValue := StringReplace(sValue, #9, '^$%x%$^09;', [rfReplaceAll]);
      sValue := StringReplace(sValue, #13#10, '^$%x%$^0D;^$%x%$^0A;',
        [rfReplaceAll]);
      // sValue := StringReplace(sValue,' ','&#x0020;',[rfReplaceAll]);
    end
    else if (AFieldType = ftDateTime) then
    begin
      sValue := FormatDateTime('yyyy-mm-dd" "hh:nn:ss', StrToDateTime(AValue));
    end
    else if (AFieldType = ftDate) then
    begin
      sValue := FormatDateTime('yyyy-mm-dd', StrToDateTime(AValue));
    end
    else if (AFieldType = ftOraClob) or (AFieldType = ftOraBlob) then
    begin
      if sValue <> '' then
        sValue := FormatClob(AValue, AFieldType);
    end;
  end;
  Result := sValue;
end;

class procedure TTableJSon.GetFieldTypeInfo(Field: TField;
  var Fieldtyp, JsonTyp: string);
begin
  Fieldtyp := GetEnumName(TypeInfo(TFieldType), ord(Field.DataType));
  Delete(Fieldtyp, 1, 2);
  if Field is TStringField then
    JsonTyp := 'string'
  else if Field is TDateTimeField then
    JsonTyp := 'integer'
  else if (Field is TIntegerField) or (Field is TLargeintField) then
    JsonTyp := 'integer'
  else if Field is TCurrencyField then
    JsonTyp := 'currency'
  else if Field is TNumericField then
    JsonTyp := 'double'
  else if Field is TBooleanField then
    JsonTyp := 'boolean'
  else
    JsonTyp := 'variant';
end;

class function TTableJSon.GetJSONFmtParamValue(AParam: TParam): string;
var
  sValue: string;
begin
  Result := SetJSONFmtValue(AParam.AsString, AParam.DataType);
end;

class function TTableJSon.CDSFromJSon(CDS: TCustomClientDataSet;
  Json: ISuperObject): Boolean;
var
  ColsJson: ISuperObject;
begin
  Result := False;
  if Json = nil then
    Exit;
  CDS.Close;
  CDS.Data := Null;
  // 创建字段
  ColsJson := Json.O[cstCols];
  CreateFieldByJson(CDS.FieldDefs, ColsJson);

  if CDS.FieldDefs.Count > 0 then
    CDS.CreateDataSet;
  ImportDataFromJSon(CDS, Json.O[cstData]);
  Result := True;

end;

class function TTableJSon.CDSFromJSon2(var CDS: TCustomClientDataSet;
  sData: String; sDatasetType: String; sFiledSize: String): Boolean;
var
  ColsJson, DataJson: ISuperObject;
begin
  Result := False;
  if trim(sData) = '' then
    Exit;
  CDS.Close;
  CDS.Data := Null;
  // 创建字段
  if CDS.FieldDefs.Count > 0 then
  begin
    CDS.CreateDataSet;
    DataJson := SO(sData);
    ImportDataFromJSon(CDS, DataJson);
  end
  else
  begin
    DataJson := SO(sData);
    CreateField(CDS.FieldDefs, sDatasetType, sFiledSize);
    CDS.CreateDataSet;
    ImportDataFromJSon(CDS, DataJson);
  end;
  Result := True;

end;

class function TTableJSon.ImportDataFromJSon(DataSet: TDataSet;
  DataJson: ISuperObject): Integer;
var
  SubJson: ISuperObject;
  iter: TSuperObjectIter;
  i: Integer;
begin

  if not DataSet.Active then
    DataSet.Open;
  // 空数据集直接返回
  // if DataJson.asArray[0].asstring='{"msg":""}' then
  // exit;

  { for SubJson in DataJson do
    begin
    if ObjectFindFirst(SubJson, iter) then
    begin
    repeat
    if (iter.Ite.Current.Name = 'NOT-DATA-FLAG') then
    begin
    exit;
    end;
    until not ObjectFindNext(iter);
    end;
    end; }
  i := 0;
  DataSet.DisableControls;
  try
    for SubJson in DataJson do
    begin
      DataSet.Append;
      if ObjectFindFirst(SubJson, iter) then
      begin
        repeat
          if DataSet.FindField(iter.Ite.Current.Name) <> nil then
          begin

            if (DataSet.FindField(uppercase(iter.Ite.Current.Name))
                is TBlobField) then
            begin
              i := i + 1;
            end;
            DataSet.FindField(uppercase(iter.Ite.Current.Name)).Value :=
              GetValue2Field
              (DataSet.FindField(uppercase(iter.Ite.Current.Name)),
              iter.Ite.Current.Value);
          end;
        until not ObjectFindNext(iter);
      end;
      DataSet.Post;

    end;
    i := i + 1;
  finally
    DataSet.EnableControls;
  end;

end;

class function TTableJSon.isFloat(fieldValue: String): Boolean;
var
  i, j: Integer;
  achar: char;
begin
  i := 1;
  j := 0;
  while (i <= length(fieldValue)) do
  begin
    achar := fieldValue[i];
    if achar = '.' then
      j := j + 1;
    if not(achar in ['.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
      then
    begin
      Result := False;
      Exit;
    end;
    i := i + 1;
  end;
  if j = 1 then
  begin
    try
      strtofloat(fieldValue);
      Result := True;
    except
      Result := False;
    end;
  end
  else
    Result := False;
end;

class function TTableJSon.isInteger(fieldValue: String): Boolean;
var
  i: Integer;
  achar: char;
begin
  i := 1;
  while (i <= length(fieldValue)) do
  begin
    achar := fieldValue[i];
    if (achar in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
    begin

    end
    else
    begin
      Result := False;
      Exit; ;
    end;
    i := i + 1;
  end;
  try
    strtoint(fieldValue);
    Result := True;
  except
    Result := False;
  end;
end;

class function TTableJSon.GetFieldSize(_FieldName, sFiledSize: String): Integer;
var
  ft: TFieldType;
  fieldSize: Integer;
  fieldName, fieldType: String;
  iter: TSuperObjectIter;
  SubJson: ISuperObject;
begin
  Result := 0;
  SubJson := SO(sFiledSize);
  if ObjectFindFirst(SubJson, iter) then
  begin
    repeat
      fieldName := iter.Ite.Current.Name;
      fieldSize := iter.Ite.Current.Value.AsInteger;
      if fieldName = _FieldName then
      begin
        if fieldSize < 300 then
          Result := 300
        else
          Result := fieldSize;
        break;
      end;
    until not ObjectFindNext(iter);
  end;
  if Result = 0 then
    Result := 300;
end;

class function TTableJSon.CreateField(Fields: TFieldDefs;
  fieldTypes, sFiledSize: String): Boolean;
var
  ft: TFieldType;
  fieldSize: Integer;
  fieldName, fieldType: String;
  iter: TSuperObjectIter;
  SubJson: ISuperObject;
begin
  Result := False;
  SubJson := SO(fieldTypes);
  Fields.DataSet.Close;
  Fields.Clear;

  if ObjectFindFirst(SubJson, iter) then
  begin
    repeat
      fieldName := iter.Ite.Current.Name;
      fieldType := iter.Ite.Current.Value.AsString;
      if ((fieldType = 'BigDecimal') or (fieldType = 'Float') or
          (fieldType = 'float') or (fieldType = 'Double') or
          (fieldType = 'double')) then
        Fields.Add(fieldName, ftFloat, 0, False)
      else if ((fieldType = 'BigInteger') or (fieldType = 'Long') or
          (fieldType = 'long')) then
        Fields.Add(fieldName, ftLargeint, 0, False)
      else if ((fieldType = 'Byte') or (fieldType = 'byte') or
          (fieldType = 'int') or (fieldType = 'short') or
          (fieldType = 'Integer') or (fieldType = 'Short')) then
        Fields.Add(fieldName, ftInteger, 0, False)
      else if ((fieldType = 'Boolean') or (fieldType = 'boolean')) then
        Fields.Add(fieldName, ftBoolean, 0, False)
      else if (fieldType = 'Date') then
        Fields.Add(fieldName, ftDate, 0, False)
      else if (fieldType = 'Timestamp') then
        Fields.Add(fieldName, ftDateTime, 0, False)
      else if (fieldType = 'byte[]') then
        Fields.Add(fieldName, ftBlob, 0, False)
      else
      begin
        fieldSize := GetFieldSize(fieldName, sFiledSize);
        if fieldSize > 20000 then
          Fields.Add(fieldName, ftBlob, fieldSize, False)
        else
          Fields.Add(fieldName, ftWideString, fieldSize, False);
      end;
    until not ObjectFindNext(iter);
  end;
  Result := True;

end;

class function TTableJSon.CreateFieldByJson(Fields: TFieldDefs;
  ColsJson: ISuperObject): Boolean;
var
  SubJson: ISuperObject;
  ft: TFieldType;
begin
  Result := False;
  Fields.DataSet.Close;
  Fields.Clear;
  // Fields.Add();
  for SubJson in ColsJson do
  begin
    ft := TFieldType(GetEnumValue(TypeInfo(TFieldType),
        'ft' + SubJson.S[cstFieldType]));
    if ft = ftAutoInc then // 自增字段不能录入，必须更改
      ft := ftInteger;
    if ft = ftDateTime then
      Fields.Add(SubJson.S[cstFieldName], ft, 0, False)
    else
      Fields.Add(SubJson.S[cstFieldName], ft, SubJson.i[cstFieldSize], False);
    // MyField.ProviderFlags := [pfInKey, pfInWhere];
  end;
  Result := True;

end;

class function TTableJSon.CreateJsonValue(Json: ISuperObject;
  const Name: string; const Value: Variant): Boolean;
begin
  Result := False;
  Json.O[Name] := SO(Value);
  Result := True;

end;

class function TTableJSon.CreateJsonValueByField(Json: ISuperObject;
  Field: TField): Boolean;
begin
  Result := False;
  if Field Is TDateTimeField then
    Json.O[Field.fieldName] := SO(Field.AsDateTime)
  else if Field is TBlobField then
    Json.S[Field.fieldName] := EncodeString(Field.AsString)
  else
    Json.O[Field.fieldName] := SO(Field.Value);
  Result := True;

end;

class function TTableJSon.GetValue(Json: ISuperObject;
  const Name: string): Variant;
begin
  case Json.DataType of
    stNull:
      Result := Null;
    stBoolean:
      Result := Json.B[Name];
    stDouble:
      Result := Json.D[Name];
    stCurrency:
      Result := Json.C[Name];
    stInt:
      Result := Json.i[Name];
    stString:
      Result := Json.S[Name];

  end;
end;

class function TTableJSon.GetValue2Field(Field: TField;
  JsonValue: ISuperObject): Variant;
var
  datetime: TDatetime;
  str: String;
begin
  if JsonValue.DataType = stNull then
    Result := Null
  else if Field is TDateTimeField then
  begin
    str := JsonValue.AsString;
    str := copy(str, 0, 10) + ' ' + copy(str, 12, length(str));
    DateSeparator := '-';
    // str:=  '2010-12-10 12:50:30';
    datetime := StrToDateTime(str);

    DateSeparator := '.';
    Result := datetime;
    // Result := JavaToDelphiDateTime(JsonValue.AsInteger);
  end
  else if (Field is TIntegerField) or (Field is TLargeintField) then
    Result := JsonValue.AsInteger
  else if Field is TNumericField then
    Result := JsonValue.AsDouble
  else if Field is TBooleanField then
    Result := JsonValue.AsBoolean
  else if Field is TStringField then
    Result := JsonValue.AsString
  else if Field is TBlobField then
  begin
    // Result := DecodeString(JsonValue.AsString)
    Result := JsonValue.AsString;
  end;

end;

class function TTableJSon.JSonFromDataSet(DataSet: TDataSet): string;
var
  sj, aj, sj2: ISuperObject;
  i: Integer;
  Fieldtyp, JsonTyp: string;
  // List: TStringList;
begin
  sj := SO();
  // 创建列
  aj := SA([]);
  // List := TStringList.Create;
  try
    // List.Sorted := True;

    for i := 0 to DataSet.FieldCount - 1 do
    begin
      sj2 := SO();
      GetFieldTypeInfo(DataSet.Fields[i], Fieldtyp, JsonTyp);

      sj2.S[cstFieldName] := DataSet.Fields[i].fieldName;
      sj2.S[cstFieldType] := Fieldtyp;
      sj2.S[cstJsonType] := JsonTyp;
      sj2.i[cstFieldSize] := DataSet.Fields[i].Size;
      sj2.B[cstRequired] := DataSet.Fields[i].Required;
      sj2.i[cstFieldIndex] := DataSet.Fields[i].Index;
      aj.AsArray.Add(sj2);
      // List.Add(DataSet.Fields[I].FieldName + '=' + JsonTyp);
    end;
    sj.O['Cols'] := aj;
    // 创建数据集的数据
    DataSet.DisableControls;
    DataSet.First;
    aj := SA([]);
    while not DataSet.Eof do
    begin
      sj2 := SO();
      for i := 0 to DataSet.FieldCount - 1 do
      begin
        if VarIsNull(DataSet.Fields[i].Value) then
          sj2.O[DataSet.Fields[i].fieldName] := SO(Null)
        else
        begin
          CreateJsonValueByField(sj2, DataSet.Fields[i]);
        end;
      end;
      aj.AsArray.Add(sj2);
      DataSet.Next;
    end;
    sj.O['Data'] := aj;
    Result := sj.AsString;
  finally
    // List.Free;
    DataSet.EnableControls;
  end;

end;

class function TTableJSon.JSonFromDataSetParam(AProviderName: string;
  AParams: OleVariant; ASQL: string): string;

  function GetFieldJSONType(AFieldType: TFieldType): string;
  begin
    case AFieldType of
      ftString:
        Result := 'string';
      ftSmallint:
        Result := 'i4';
      ftInteger:
        Result := 'i4';
      ftWord:
        Result := 'i4';
      ftBoolean:
        Result := 'boolean';
      ftAutoInc:
        Result := 'i4';
      ftFloat:
        Result := 'r8';
      ftCurrency:
        Result := 'r8';
      ftBCD:
        Result := 'r8';
      ftDate:
        Result := 'date';
      ftTime:
        Result := 'time';
      ftDateTime:
        Result := 'datetime';
    end;
  end;

var
  sXML, sParamValues, sJson, sCols, sParams: string;
  i: Integer;
  MyParams: TParams;
  MyParam: TParam;

  List: TStringList;
  Fieldtyp, JsonTyp: string;
  sj, aj, sj2: ISuperObject;
begin

  sj := SO();
  // 创建
  aj := SA([]);

  // sj.S[cstProviderName] := AProviderName;

  // 取出参数
  if (not VarIsNull(AParams)) then
  begin
    MyParams := TParams.Create();
    try
      UnpackParams(AParams, MyParams);
      for i := 0 to MyParams.Count - 1 do
      begin
        MyParam := MyParams.Items[i];
        sj2 := SO();
        JsonTyp := GetFieldJSONType(MyParam.DataType);
        sj2.S[cstParamName] := MyParam.Name;
        sj2.S[cstJsonType] := JsonTyp;
        sj2.B[cstEncrypt] := False; // 暂时不加密
        sj2.i[cstParamSize] := MyParam.Size;
        sj2.S[cstParamValue] := GetJSONFmtParamValue(MyParam);
        aj.AsArray.Add(sj2);
      end;
      if (ASQL <> '') then
      begin
        sj2 := SO();
        JsonTyp := 'string';
        sj2.S[cstParamName] := 'SQL';
        sj2.S[cstJsonType] := JsonTyp;
        sj2.i[cstFieldSize] := length(ASQL);
        sj2.S[cstParamValue] := SetJSONFmtValue(ASQL, ftString);
        aj.AsArray.Add(sj2);
      end;

      sj.O[cstParam] := aj;
    finally
      FreeAndNil(MyParams);
    end;
  end;

  Result := sj.AsString;

end;

class function TTableJSon.CreateXmlFieldByJson(ProviderName: String;
  ColsJson: ISuperObject): String;
var
  SubJson: ISuperObject;
  ft: TFieldType;
  sXML, sRow: WideString;
  ftType: String;

begin

  sXML :=
    '<?xml version="1.0" encoding="gb2312" standalone="yes"?><DATAPACKET Version="2.0"><METADATA><FIELDS>';

  // Fields.Add();
  for SubJson in ColsJson do
  begin
    // ft := TFieldType(GetEnumValue(TypeInfo(TFieldType),
    // 'ft' + SubJson.S[cstFieldType]));
    ftType := SubJson.S[cstFieldType];
    // ftType := 'string';
    // if (SubJson.S[cstFieldName] = 'userid') then
    // sRow := sRow + '<FIELD attrname="' + SubJson.S[cstFieldName]
    // + '" fieldtype="fixed"'
    // else
    sRow := sRow + '<FIELD attrname="' + SubJson.S[cstFieldName]
      + '" fieldtype="' + ftType;
    if (SubJson.i[cstFieldSize] > 0) then
      sRow := sRow + '" WIDTH="' + IntToStr(SubJson.i[cstFieldSize]) + '" />'
    else
      sRow := sRow + '" WIDTH="10" />';
  end;

  sXML := sXML + sRow + '</FIELDS><PARAMS/></METADATA><ROWDATA>';

  Result := sXML;

end;

class function TTableJSon.CreateXmlDataFromJSon(DataJson: ISuperObject): String;
var
  SubJson: ISuperObject;
  i: Integer;
  iter: TSuperObjectIter;
  sRow: WideString;
begin
  sRow := '';
  // sRow:=DataJson.AsString;
  for SubJson in DataJson do
  begin
    if ObjectFindFirst(SubJson, iter) then
    begin
      sRow := sRow + '<ROW ';
      repeat
        sRow := sRow + ' ' + iter.Ite.Current.Name + '="' +
          iter.Ite.Current.Value.AsString + '"';
      until not ObjectFindNext(iter);
      sRow := sRow + ' />';
    end;
  end;
  Result := sRow;
end;

class function TTableJSon.XMLFromJSon(ProviderName: String;
  Json: ISuperObject): String;
var
  ColsJson, DataJson: ISuperObject;
  aXml: WideString;
begin

  if Json = nil then
    Exit;
  DataJson := Json.O['Data'];
  // 创建字段
  ColsJson := Json.O['Cols'];
  aXml := CreateXmlFieldByJson(ProviderName, ColsJson);
  aXml := aXml + CreateXmlDataFromJSon(DataJson) + '</ROWDATA></DATAPACKET>';
  Result := aXml;

end;

// 合并JSON格式的两条记录，取第一条记录的ID保存到第二条记录中
class function TTableJSon.MergeFromJson(Pkey, sJson: String): String;
var
  SubJson, second, jo: ISuperObject;
  ja: TSuperArray;
  item, item2: TSuperAvlEntry;
begin
  jo := SO(sJson);
  ja := jo['Data'].AsArray;
  if (ja.length < 2) then
    Exit;
  SubJson := ja[0];
  second := ja[1];

  for item in SubJson.AsObject do
    for item2 in second.AsObject do
    begin
      if ((item.name = item2.Name) and (item2.Name = Pkey) and
          (item2.Value.AsString = '')) then
      begin
        item2.Value := item.Value;
        break;
      end;
    end;
  Result := second.AsString;
end;

end.
