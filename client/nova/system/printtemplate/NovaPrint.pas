unit NovaPrint;

interface
uses SysUtils, Classes, Variants,jsonClientDataSet,services,
  Printers, db, windows, math, IniFiles,Dialogs,Registry,pubFn, Graphics,
  UDMPublic,Generics.Collections,HBarCode,TypInfo,forms,Jpeg,ExtCtrls,Controls;
function moneyToChinaStr(const n: Real): string;
type
  TNovaPrint = class(TComponent)
  private
    FPrintTemplateName:String;
    FPrintTemplateid:Int64;
    cdsPrintTemplate: TjsonClientDataSet;  //模板信息
    cdsPrintTemplateitem: TjsonClientDataSet;  //模板打印项目
    PageCount: integer;  //记录打印数量
    px,py:integer;
    portname:string;

    FbillNoFieldName:String;
    procedure SetPaperSize(X, Y: Integer);
    function Get_char_from_number(num: double; param: integer; Upper, currency: boolean): string;
                                //原数值   参数          大写？ 打印币种符号￥
    function FormatByParameter(parameter: variant; str: string): string;
    function getPrintPortByName(printname:string):string;
    function getPrintPortByName1(printname:string):string;

    procedure FindPrintTemplateByid();
    procedure FindPrintTemplateByName();
    procedure initPrintTemplate();
    procedure initPrintTemplateItem();
    function getPixelByMm(mm,p:integer): integer;
    function getXPixelByMm(mm:integer): integer;
    function getYPixelByMm(mm:integer): integer;
    function getMultipleValue(rowno:integer;itemcode:String):String;
    function getSingleValue(itemcode:String;pageNo:integer=0):String;

    function getCurPrintPageCount:integer;
  public
    SingleValue:TDictionary<String,String>;//输出单变量
    MultipleValue:TList<TDictionary<String,String>>;//输出数据集
    currency: boolean;  //是否打印￥
    constructor create(AOwner: TComponent;templatename: string);overload;
    constructor create(AOwner: TComponent;templateid: int64);overload;
    destructor Destroy; override;
    procedure Print;    //打印
    //读本地配置文件，取得打印模板名称
    class Function GetTicketModelName(templateTypeName,templateName: string): string;
    function getPrintPageCount(MultipleValueCount:integer):integer;//根据数据集记录数取打印页数
    property CurPrintPageCount:integer read getCurPrintPageCount;//取当前要打印的页数，调用者必须先设置MultipleValue
    property billNoFieldName:String read FbillNoFieldName write FbillNoFieldName;//票证号码字段，用于打印多页时，自动计算下一页的票证号
  end;


implementation

function moneyToChinaStr(const n: Real): string;   //可以到万亿，并且可以随便扩大范围
  const cNum: WideString = '零壹贰叁肆伍陆柒捌玖--万仟佰拾亿仟佰拾万仟佰拾元角分';
        cCha:array[0..1, 0..12]of string =
        (( '零元','零拾','零佰','零仟','零万','零亿','亿万','零零零','零零','零万','零亿','亿万','零元'),
         ( '元','零','零','零','万','亿','亿','零','零','万','亿','亿','元'));
  var i : Integer;
      sNum,sTemp : WideString;
begin
  if n<0 then
  begin
    Result := '负'+moneyToChinaStr(n*-1);
  end
  else
  begin
    result :='';
    sNum := format('%15d',[round(n * 100)]);
    for i := 0 to 14 do
    begin
      stemp := copy(snum,i+1,1);
      if stemp=' ' then continue
      else result := result + cNum[strtoint(stemp)+1] + cNum[i+13];
    end;
    for i:= 0 to 12 do
    Result := StringReplace(Result, cCha[0,i], cCha[1,i], [rfReplaceAll]);
    if pos('零分',result)=0
      then Result := StringReplace(Result, '零角', '零', [rfReplaceAll])
      else Result := StringReplace(Result, '零角','整', [rfReplaceAll]);
    Result := StringReplace(Result, '零分','', [rfReplaceAll]);
  end;
end;



function Changdx2(mmje: Double): String;
const s1: String = '零壹贰叁肆伍陆柒捌玖';
      s2: String = '分角元拾佰仟万拾佰仟亿拾佰仟万';

 function StrTran(const S, S1, S2: String): String;
  begin
    Result := StringReplace(S, S1, S2, [rfReplaceAll]);
  end;
 var s, dx: String;
     i, Len: Integer;
begin
if mmje < 0 then
  begin dx := '负';
        mmje := -mmje;
  end;
   s := Format('%.0f', [mmje*100]);
   Len := Length(s);
  for i := 1 to Len do
   dx := dx + Copy(s1, (Ord(s[i]) - Ord('0'))*2 + 1, 2) + Copy(s2, (Len - i)*2 + 1, 2);
   dx := StrTran(StrTran(StrTran(StrTran(StrTran(dx, '零仟', '零'), '零佰', '零'), '零拾', '零'), '零角', '零'), '零分', '整');
   dx := StrTran(StrTran(StrTran(StrTran(StrTran(dx, '零零', '零'), '零零', '零'), '零亿', '亿'), '零万', '万'), '零元', '元');
 if dx = '整' then Result := '零元整'
  else Result := StrTran(StrTran(dx, '亿万', '亿零'), '零整', '整');
end;

{ Tskyprint }
//自定义纸张过程x,y为0.1mm
procedure TNovaPrint.SetPaperSize(X, Y: Integer);
var
  Device: array[0..255] of char;
  Driver: array[0..255] of char;
  Port: array[0..255] of char;
  hDMode: THandle;
  PDMode: PDEVMODE;
begin
  Printer.GetPrinter(Device, Driver, Port, hDMode);
  if hDMode <> 0 then
  begin
    pDMode := GlobalLock(hDMode);
    if pDMode <> nil then
    begin
      if (x = 0) or (y = 0) then
      begin
        pDMode^.dmFields := pDMode^.dmFields or dm_PaperSize;
        pDMode^.dmPaperSize := DMPAPER_FANFOLD_US;
      end
      else
      begin
        //自定义纸张大小
        pDMode^.dmFields := pDMode^.dmFields or
          DM_PAPERSIZE or
          DM_PAPERWIDTH or
          DM_PAPERLENGTH;
        pDMode^.dmPaperSize := DMPAPER_USER;
        //showmessage(inttostr(pdmode^.dmorientation));
        {一定要加入这样的判断，根据纸张的方向设置选择长、
        宽（x,y)的使用情况。可以使用上面释掉的这一句测试一下
        dmorient_landscape值为2；dmorient_portrait值为1
        }
        {if pdmode^.dmOrientation=dmorient_landscape then
         begin
          pDMode^.dmPaperWidth :=y;
          pDMode^.dmPaperLength :=x;
        end;
        if PDMode^.dmOrientation=dmorient_portrait then
        begin
         pdmode^.dmPaperWidth:=x;
         pdmode^.dmPaperLength:=y;
        end;}
        pdmode^.dmPaperWidth := x;
        pdmode^.dmPaperLength := y;
      end;
      pDMode^.dmFields := pDMode^.dmFields or DMBIN_MANUAL;
      //pDMode^.dmDefaultSource := DMBIN_MANUAL;
      GlobalUnlock(hDMode);
    end;//end else
  end;//end if
end;

function TNovaPrint.Get_char_from_number(num: double; param: integer; Upper, currency: boolean): string;
var str: string;
  max: integer;
  res_int: integer;
const S1 = '零壹贰叁肆伍陆柒捌玖';
  S2 = '0123456789';
begin
  max := length(inttostr(trunc(num)));
  if param = 0 then
    Result := '点'
  else if max + 1 < param then
    result := ''
  else if max + 1 = param then
    if currency then
      result := '￥'
    else
      result := ''
  else
  begin
    if param < 0 then
      str := inttostr(trunc(num / power(10, param)))
    else
      str := inttostr(trunc(num / power(10, param - 1)));

    res_int := strtoint(copy(str, length(str), 1));
    if Upper then
      result := s1[res_int + 1]
    else
      result := s2[res_int + 1];
  end;
end;

procedure TNovaPrint.initPrintTemplate;
begin
  cdsPrintTemplate:=TjsonClientDataSet.Create(self);
  with cdsPrintTemplate do
  begin
    if FPrintTemplateid<=0 then
      FindPrintTemplateByName
    else
      FindPrintTemplateByid;
    if RecordCount<=0 then
      raise Exception.Create('找不到打印模板：'+FPrintTemplateName)
    else if RecordCount>1 then
      raise Exception.Create('打印模板：'+FPrintTemplateName+'名称重复')
    else
    begin
        portname:=getPrintPortByName(FieldByName('printername').AsString);
        if portname='' then
          portname:=getPrintPortByName(Printer.Printers.Strings[Printer.PrinterIndex]);
        if not((Win32Platform   <>   VER_PLATFORM_WIN32_WINDOWS)
          or (Win32MajorVersion   >   4)) and (Pos(' on ',FieldByName('printername').AsString)=0)   then
        begin
          FieldByName('printername').AsString := FieldByName('printername').AsString+' on '+getPrintPortByName1(FieldByName('printername').AsString);
        end;
    end;
  end;
end;

procedure TNovaPrint.FindPrintTemplateByid;
begin
  with cdsPrintTemplate do
  begin
    QueryAddress:='system/queryPrinttemplate';
    RemoteServer:=DMPublic.jcon;
    DataSourceName:='printtemplatelist';

    Params.CreateParam(ftString,'filter_EQL_pt!id',ptInput);
    Params.ParamValues['filter_EQL_pt!id']:=FPrintTemplateid;
    Active:=true;
  end
end;

procedure TNovaPrint.FindPrintTemplateByName;
begin
  with cdsPrintTemplate do
  begin
    QueryAddress:='system/queryPrinttemplate';
    RemoteServer:=DMPublic.jcon;
    DataSourceName:='printtemplatelist';

    Params.CreateParam(ftString,'filter_EQS_pt!name',ptInput);
    Params.ParamValues['filter_EQS_pt!name']:=FPrintTemplateName;
    Active:=true;
  end
end;

procedure TNovaPrint.initPrintTemplateItem;
begin
  cdsPrintTemplateitem:=TjsonClientDataSet.Create(self);
  with cdsPrintTemplateitem do
  begin
    QueryAddress:='system/queryPrinttemplateitem';
    RemoteServer:=DMPublic.jcon;
    DataSourceName:='printtemplateitemlist';

    Params.CreateParam(ftString,'filter_EQL_pti!printtemplate.id',ptInput);
    Params.ParamValues['filter_EQL_pti!printtemplate.id']:=cdsPrintTemplate.FieldByName('id').AsLargeInt;
    Active:=true;
    if RecordCount<=0 then
      raise Exception.Create('打印模板：'+FPrintTemplateName+'的明细为空');
  end;
end;

constructor TNovaPrint.create(AOwner: TComponent;templatename: string);  //初始化 模板信息、打印项目
begin
  inherited create(AOwner);
  FbillNoFieldName:='';
  FPrintTemplateName:=templatename;
  initPrintTemplate();
  initPrintTemplateItem();
  portname:='';
  PageCount:=1;
  SingleValue:=TDictionary<String,String>.Create;
  MultipleValue:=TList<TDictionary<String,String>>.Create;
  if (PageCount mod 2) = 0 then
    SetPaperSize(max(2500,cdsPrintTemplate.FieldByName('width').AsInteger+cdsPrintTemplate.FieldByName('left').AsInteger*2),
                 cdsPrintTemplate.FieldByName('heightcorrection').AsInteger)
  else
    SetPaperSize(max(2500,cdsPrintTemplate.FieldByName('width').AsInteger+cdsPrintTemplate.FieldByName('left').AsInteger*2),
                 cdsPrintTemplate.FieldByName('height').AsInteger);
  px := GetDeviceCaps(printer.handle, logpixelsx);
  py := GetDeviceCaps(printer.handle, logpixelsy);
end;

constructor TNovaPrint.create(AOwner: TComponent; templateid: int64);
begin
  FbillNoFieldName:='';
  FPrintTemplateid:=templateid;
  create(AOwner,'');
end;

destructor TNovaPrint.Destroy;
begin
  SingleValue.Free;
  MultipleValue.Free;
  inherited;
end;

procedure TNovaPrint.Print;
var
//Barcode: TBarcode;   //条形码
  i, j: integer; //循环打印数据集
  f:textfile;
  ix,iy:integer;  //打印位置
  printtext,HexStr:String;
  bmp:TBitmap;
  autopages:Boolean;
  listfirstttop:Integer;//数据集的最后一行高度
  listlasttop:Integer;//数据集的最后一行高度
  printPageCount,curPageNo:integer;
  H_Modul:Integer;
  H_Ratio:Double;
  jpeg: TJPEGImage;  //图片
  Image1:TImage;
  RR: TRect;
  ScaleX, ScaleY: Integer;
  lw,lh:integer;
begin
  H_Modul:=2;
  H_Ratio:=2;
  Printer.PrinterIndex := Printer.Printers.IndexOf(cdsPrintTemplate.FieldByName('printername').AsString);
  if portname<>'' then
  begin
    AssignFile(f,portname);
    Rewrite(f);
  end;
  px := GetDeviceCaps(printer.handle, logpixelsx);
  py := GetDeviceCaps(printer.handle, logpixelsy);

  printPageCount:=1;
  if (MultipleValue<>nil) and (MultipleValue.Count>0)
    and (cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage']<MultipleValue.Count) then
  begin
    printPageCount:=cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage'] div MultipleValue.Count;
    if (cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage'] mod MultipleValue.Count)>0 then
    begin
      printPageCount:=printPageCount+1;
    end;
  end;
  autopages:=cdsPrintTemplate.FieldValues['autopages'];
  listfirstttop:=0;
  listlasttop:=0;
  for curPageNo := 0 to printPageCount - 1 do
  begin
    if (PageCount mod 2) = 0 then
      SetPaperSize(max(2500,cdsPrintTemplate.FieldByName('width').AsInteger+cdsPrintTemplate.FieldByName('left').AsInteger*2),
                   cdsPrintTemplate.FieldByName('heightcorrection').AsInteger)
    else
      SetPaperSize(max(2500,cdsPrintTemplate.FieldByName('width').AsInteger+cdsPrintTemplate.FieldByName('left').AsInteger*2),
                   cdsPrintTemplate.FieldByName('height').AsInteger);
    with printer do
    begin
      BeginDoc;
      with cdsPrintTemplateitem do
      begin
        first;
        while not eof do
        begin
          if not FieldByName('isprint').AsBoolean then
          begin
            Next;
            Continue;
          end;
        //打印类型（0画线、1固定标题、2字符串、3大写数字、4小写数字、5日期时间、6-条形码、7-图片、8-大写金额）
          case FieldByName('valuetype').AsInteger of      //判断输出变量类型
            0:    //线
            begin
              ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']);
              iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);
              if (autopages) and (listlasttop>listfirstttop) and (iy>listfirstttop) then
              begin
                iy:=iy+listlasttop-listfirstttop;
              end;
                  //画两条竖线
              if FieldValues['height'] > 1 then
              begin
                canvas.MoveTo(ix,iy);
                canvas.LineTo(ix,iy+getYPixelByMm(FieldValues['height']));
                if FieldValues['width'] > 1 then
                begin
                  canvas.MoveTo(ix+getXPixelByMm(FieldValues['width']),
                                iy+getYPixelByMm(FieldValues['height']));
                  canvas.LineTo(ix+getXPixelByMm(FieldValues['width']),iy);
                end;
              end;
                  //画两条横线
              if FieldValues['width'] > 1 then
              begin
                canvas.MoveTo(ix,
                              iy+getYPixelByMm(FieldValues['height']));
                canvas.LineTo(ix+getXPixelByMm(FieldValues['width']),
                              iy+getYPixelByMm(FieldValues['height']));
                if FieldValues['height'] > 1 then
                begin
                  canvas.MoveTo(ix+getXPixelByMm(FieldValues['width']),iy);
                  canvas.LineTo(ix,iy);
                end;
              end;
            end;
            1:  //固定标题
            begin
              if not FieldByName('title').IsNull then
              begin
                canvas.Font.Name := FieldValues['fontname'];
                Canvas.font.size := FieldValues['fontsize'];//字体
                canvas.font.PixelsPerInch := round(py);
                iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);
                if (autopages) and  (listlasttop>listfirstttop) and (iy>listfirstttop) then
                begin
                  iy:=iy+listlasttop-listfirstttop;
                end;
                canvas.TextOut(getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']),
                               iy,
                               FieldValues['title']);//输出
              end;
            end;
            7://图片
            begin
               if FieldByName('printpicture').AsString<>'' then
               begin
                   ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']);
                   iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);
                   (*jpeg:= TJPEGImage.Create;
                      try
                        HexStr := FieldByName('printpicture').AsString;
                        if (HexStr <> '') then
                        jpeg := HexStrToJpg(HexStr);
                        bmp:= TBitmap.Create;
                        try
                          bmp.Assign(jpeg);
                          //bmp.SetSize(FieldByName('Height').AsInteger,FieldByName('Width').AsInteger);
                          //bmp.Height := FieldByName('Height').AsInteger;
                          //bmp.Width := FieldByName('Width').AsInteger;
                          //bmp.Canvas.CopyRect(Rect(0,0,bmp.Width,bmp.Height),bmp.Canvas,Rect(801,149,2595,2359));
                          canvas.Draw(ix,iy,bmp);
                        finally
                          bmp.free;
                        end;
                      finally
                        jpeg.Free;
                      end;*)
                    try
                      jpeg:= TJPEGImage.Create;
                      HexStr := FieldByName('printpicture').AsString;
                      if (HexStr <> '') then
                      jpeg := HexStrToJpg(HexStr);
                      ScaleX := ix+getXPixelByMm(FieldValues['Width']);
                      ScaleY := iy+getXPixelByMm(FieldValues['Height']) ;
                      RR := Rect(ix, iy,ScaleX ,ScaleY);
                      //直接往打印机输出"Printer.Canvas.StretchDraw"
                      Canvas.StretchDraw(Rr, jpeg);
                    finally
                      jpeg.Free;
                  end;
               end;
            end
          else  //其它情况下要再次判断打印类型
          begin
            if (SingleValue<>nil) and (FieldValues['islist'] = false) and (getSingleValue(FieldValues['itemcode'],curPageNo)<>'') then //单个变量  //and (SingleValue.ContainsKey(FieldValues['itemcode']))
            begin
              canvas.Font.Name := FieldValues['fontname'];
              Canvas.font.size := FieldValues['fontsize'];//字体
              canvas.font.PixelsPerInch := round(py);
              ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']);
              iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);
              //SysLog.WriteErr('iy1='+inttostr(iy)+','+IntToStr(listlasttop)+'-'+IntToStr(listfirstttop));
              if  (autopages) and (listlasttop>listfirstttop) and (iy>listfirstttop) then
              begin
                //ShowMessage('iy='+inttostr(iy)+','+IntToStr(listlasttop)+'-'+IntToStr(listfirstttop));
                iy:=iy+listlasttop-listfirstttop;
              end;
              //SysLog.WriteErr('iy2======'+inttostr(iy)+','+IntToStr(listlasttop)+'-'+IntToStr(listfirstttop));
              printtext:=getSingleValue(FieldValues['itemcode'],curPageNo);
              //SysLog.WriteErr('print'+printtext);
              case FieldByName('valuetype').AsInteger of
                2:  //2字符串
                  canvas.TextOut(ix,iy,
                                 FormatByParameter(FieldValues['parameter'],printtext)
                                );//输出
                3:      //3-大写数字
                  canvas.TextOut(ix,iy,
                                 Get_char_from_number(strtofloat(printtext),
                                                      FieldValues['parameter'], true, currency)
                                );//输出
                4:  //4-小写数字
                  canvas.TextOut(ix,iy,
                                 Get_char_from_number(strtofloat(printtext),
                                                      FieldValues['parameter'], false, currency)
                                 );//输出
                5:  //4-日期时间
                  canvas.TextOut(ix,iy,
                                 FormatDateTime(FieldValues['parameter'],
                                                _strtodatetime(printtext))
                                 );//输出
                6: //6-条形码
                begin
                  bmp:=TBitmap.create;
                  try
                    bmp.Width:=HBarCode.H_GetBarWidth(TBarType(GetEnumValue(TypeInfo(TBarType),FieldValues['parameter'])),
                                                      printtext,
                                                      H_Modul, H_Ratio,csNone);
                    bmp.Height:=Round(FieldValues['Height'] / 254 * Screen.PixelsPerInch);
                    bmp.canvas.Font.Name := FieldValues['fontname'];
                    bmp.Canvas.font.size := FieldValues['fontsize'];//字体
                    HBarCode.H_DrawBar(bmp.Canvas, TBarType(GetEnumValue(TypeInfo(TBarType), FieldValues['parameter'])),
                                      printtext,
                                        H_Modul,H_Ratio,  //H_Modul, H_Ratio,
                                      csNone, 0, 0, Round(FieldValues['Height'] / 254 * Screen.PixelsPerInch),
                                      bmp.Canvas.Font, tsNone, tpBottomCenter,
                                      clBlack, clWhite, clWhite, 0);
                    canvas.Draw(ix,iy,bmp);
//                    canvas.StretchDraw(Rect(ix,iy,
//                                            round(ix+bmp.Width*px/screen.PixelsPerInch),
//                                            round(iy+bmp.Height*py/screen.PixelsPerInch))
//                                      ,bmp);
                  finally
                    bmp.Free;
                  end;
                end;  //case 6
                8:  //7-大写金额
                  canvas.TextOut(ix,iy,
                                 FormatByParameter(FieldValues['parameter'],
                                                   moneyToChinaStr(strtofloat(printtext))
                                                   )
                                 );//输出
              else
                ;
              end;   //case
            end;  //end if;
            if (MultipleValue<>nil) and (MultipleValue.Count>0) and (FieldValues['islist'] = true) then  //处理数据集
            begin
              canvas.Font.Name := FieldValues['fontname'];
              Canvas.font.size := FieldValues['fontsize'];//字体
              canvas.font.PixelsPerInch := round(py);
              for i := 0 to cdsPrintTemplate.FieldValues['columnsperpage'] - 1 do  //循环数据集栏目数
              begin
                ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']
                                  +round(cdsPrintTemplate.FieldValues['width']/cdsPrintTemplate.FieldValues['columnsperpage']*i));
                for j := 0 to cdsPrintTemplate.FieldValues['rowperpage'] - 1 do //循环数据集行数
                  if j + cdsPrintTemplate.FieldValues['rowperpage'] * i < MultipleValue.Count then
                  begin
                    printtext:=getMultipleValue(j + cdsPrintTemplate.FieldValues['rowperpage'] * i
                                                +curPageNo*cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage'],
                                                                       FieldValues['itemcode']
                                                                       );
                    iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']
                                      +(cdsPrintTemplate.FieldValues['rowspace'])*j
                                      )+Canvas.TextHeight(printtext)*j;
                    //SysLog.WriteErr('print----------'+printtext);
                    if(listfirstttop=0)then
                    begin
                      listfirstttop:=iy;
                    end ;
                    if iy>listlasttop then
                    begin
                      listlasttop:=iy;
                      //SysDialogs.ShowError('iy='+inttostr(iy)+','+IntToStr(listlasttop)+'-'+IntToStr(listfirstttop));
                    end;
                    //SysLog.WriteErr('listlasttop---------='+inttostr(listlasttop));
                    case FieldByName('valuetype').AsInteger of
                      2:  //2字符串
                        canvas.TextOut(ix,iy,
                                       FormatByParameter(FieldValues['parameter'],printtext)
                                       );//输出
                      3:      //2-大写数字
                        canvas.TextOut(ix,iy,
                                       Get_char_from_number(strtofloat(printtext),FieldValues['parameter'], true, currency)
                                      );//输出
                      4:  //4-小写数字
                        canvas.TextOut(ix,iy,
                                       Get_char_from_number(strtofloat(printtext),FieldValues['parameter'], false, currency)
                          );//输出
                      5:  //5-日期时间
                        canvas.TextOut(ix,iy,
                                       FormatDateTime(FieldValues['parameter'], strtodatetime(printtext))
                                       );//输出
                      6: //6-条形码
                      begin
                        bmp:=TBitmap.create;
                        try
                          bmp.Width:=HBarCode.H_GetBarWidth(TBarType(GetEnumValue(TypeInfo(TBarType),FieldValues['parameter'])),
                                                            SingleValue.Items[FieldValues['itemcode']],
                                                            H_Modul, H_Ratio,csNone);
                          bmp.Height:=Round(FieldValues['Height'] / 254 * Screen.PixelsPerInch);
                          bmp.canvas.Font.Name := FieldValues['fontname'];
                          bmp.Canvas.font.size := FieldValues['fontsize'];//字体
                          HBarCode.H_DrawBar(bmp.Canvas, TBarType(GetEnumValue(TypeInfo(TBarType), FieldValues['parameter'])),
                                            SingleValue.Items[FieldValues['itemcode']],
                                            H_Modul,H_Ratio,  //H_Modul, H_Ratio,
                                            csNone, 0, 0, Round(FieldValues['Height'] / 254 * Screen.PixelsPerInch),
                                            bmp.Canvas.Font, tsNone, tpBottomCenter,
                                            clBlack, clWhite, clWhite, 0);
                          canvas.Draw(ix,iy,bmp);
//                          canvas.StretchDraw(Rect(ix,iy,
//                                                  round(ix+bmp.Width*px/screen.PixelsPerInch),
//                                                  round(iy+bmp.Height*py/screen.PixelsPerInch))
//                                            ,bmp);
                        finally
                          bmp.Free;
                        end;
                      end;  //case 6
                      7:  //7-大写金额
                        canvas.TextOut(ix,iy,
                                       FormatByParameter(FieldValues['parameter'],
                                                         moneyToChinaStr(strtofloat(printtext))
                                                         )
                                       );//输出
                    else
                      ;
                    end;   //case
                  end;
              end; //end for i
            end;  //end if;
          end;  //end begin;
          end;   //case
          next;
        end;  //while
      end;  // printitem
      EndDoc;
    end;//with printer
    PageCount := PageCount + 1;
  end;
  if portname<>'' then
  begin
    Write(f,chr(29)+chr(40)+chr(70)+chr(4)+chr(0)+chr(1)+chr(0)+chr(70)+chr(0));
    Write(f,chr(29)+chr(12));
    Write(F,chr($18));//清除行缓冲区数据
    CloseFile(f);
  end;
end;

function TNovaPrint.FormatByParameter(parameter: variant; str: string): string;
var formatstr: string;
    p:array   [0..0]of   TVarRec;
    e:extended;
    i:Integer;
    i64:Int64;
begin
  if str='' then
  begin
    result:='';
    Exit;
  end;
  if parameter = null then
  begin
    formatstr := '%s';
    Result := str;
  end
  else
  begin
    try
      e:=StrToFloat(str);
      p[0].VType:=3;
      p[0].VExtended:=@e;
      result := format(parameter,p);
    except
      try
        i:=StrToInt(str);
        p[0].VType:=0;
        p[0].VInteger:=i;
        result := format(parameter,p);
      except
        try
          i64:=StrToInt64(str);
          p[0].VType:=16;
          p[0].vInt64:=@i64;
          result := format(parameter,p);
        except
          try
            p[0].VType:=10;
            p[0].VPWideChar:=PWideChar(str);
            result := format(parameter,p);
          except
            Result:=str;
          end;
        end;
      end;
    end;
//    if pos('%s', parameter) = 0 then
//      formatstr := parameter + '%s'
//    else
//      formatstr := parameter;
  end;
//  result := StringReplace(formatstr, '%s', str, [rfIgnoreCase]);
//  result := StringReplace(result, '%s', '', [rfIgnoreCase, rfReplaceAll]);
end;

function TNovaPrint.getCurPrintPageCount: integer;
begin
  result:=1;
  if (MultipleValue<>nil) and (MultipleValue.Count>0) then
  begin
    result:=getPrintPageCount(MultipleValue.Count);
  end;
end;

function TNovaPrint.getMultipleValue(rowno:integer;itemcode:String): String;
var rows:TDictionary<String,String>;
begin
  rows:=MultipleValue.Items[rowno];
  if rows.ContainsKey(itemcode) then
    Result:=rows.Items[itemcode]
  else
    Result:='';
end;

function TNovaPrint.getPixelByMm(mm,p: integer): integer;
begin
  // 象素数 / DPI = 英寸数   英寸数 * 25.4 = 毫米数
  Result := Round(mm / 254 * p);
end;

function TNovaPrint.getPrintPageCount(MultipleValueCount: integer): integer;
begin
  result:=1;
  if (cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage']<MultipleValueCount) then
  begin
    result:=cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage'] div MultipleValueCount;
    if (cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage'] mod MultipleValueCount)>0 then
    begin
      result:=result+1;
    end;
  end;
end;

function TNovaPrint.getPrintPortByName(printname:string): string;
begin
  Result:=getPrintPortByName1(printname);
  if Pos(':',Result)>0 then
    Result:=Copy(Result,1,Length(Result)-1);
end;

function TNovaPrint.getPrintPortByName1(printname: string): string;
var
  reg:TRegistry;//声明一个TRegistry类变量
  s:string;
begin
  s:='';
  reg:=TRegistry.Create;//创建实例
  reg.RootKey:=HKEY_LOCAL_MACHINE;//指定需要操作的注册表的主键
  //if reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\'+printname,false) then//如果打开成功则进行以下操作
  if reg.OpenKey('\System\CurrentControlSet\Control\Print\Printers\'+printname,false) then//如果打开成功则进行以下操作
  begin
    s:=reg.ReadString('Port');//从注册表中读取对应字符串的值
    //如果该字符串不存在则返回值为空字符串
    reg.CloseKey;//关闭注册表
  end;
  reg.Free;//释放变量所占内存
  Result:=s;
end;

function TNovaPrint.getSingleValue(itemcode: String;pageNo:integer): String;
begin
  result:='';
  if (itemcode='pageno') then
  begin
    result:=inttostr(pageNo+1);
  end
  else if (itemcode='totalpage') then
  begin
    result:=inttostr(CurPrintPageCount);
  end
  else if (itemcode='printtime') then
  begin
    result:=FormatDateTime('yyyy-mm-dd hh:nn:ss',now);
  end
  else if (SingleValue.ContainsKey(itemcode)) then
  begin
    if (itemcode=billNoFieldName)and (pageNo>0) and (trim(SingleValue.Items[itemcode])<>'') then
    begin
      result:=PubFn.zerofill(inttostr(strtoint64(SingleValue.Items[itemcode])+pageNo),length(SingleValue.Items[itemcode]));
    end
    else
    begin
      result:=SingleValue.Items[itemcode];
    end;
  end;
end;

class function TNovaPrint.GetTicketModelName(templateTypeName,
  templateName: string): string;
var
  inif: Tinifile;
  Exepath: string;
  ReadIni: string;
begin
  ExePath := ExtractFilePath(Paramstr(0)) + 'PrintConfig.ini';
  inif := Tinifile.Create(ExePath);
  ReadIni := inif.ReadString(templateTypeName, 'templateName', '0');
  if ReadIni = '0' then
  begin
    inif.WriteString(templateTypeName, 'templateName', templateName);
    ReadIni := templateName;
  end;
  result := ReadIni;
  inif.Free;
end;

function TNovaPrint.getXPixelByMm(mm: integer): integer;
begin
  Result:=getPixelByMm(mm,px);
end;

function TNovaPrint.getYPixelByMm(mm: integer): integer;
begin
  Result:=getPixelByMm(mm,py);
end;

end.
