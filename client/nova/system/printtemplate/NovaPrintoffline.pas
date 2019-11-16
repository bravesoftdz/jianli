unit NovaPrintoffline;

interface
uses SysUtils, Classes, Variants,DBClient,jsonClientDataSet,
  Printers, db, windows, math, IniFiles,Constant,Dialogs,Registry,Graphics,
  Generics.Collections,HBarCode,TypInfo,forms,UDMPublic,Jpeg,ExtCtrls,Controls;
function moneyToChinaStr(const n: Real): string;
type
  TNovaPrint = class(TComponent)
  private
    FPrintTemplateName:String;
    FPrintTemplateid:Int64;
    cdsPrintTemplate: TjsonClientDataSet;  //ģ����Ϣ
    cdsPrintTemplateitem: TjsonClientDataSet;  //ģ���ӡ��Ŀ
//    cdsPrintTemplate: TClientDataSet;  //ģ����Ϣ
//    cdsPrintTemplateitem: TClientDataSet;  //ģ���ӡ��Ŀ
    PageCount: integer;  //��¼��ӡ����
    px,py:integer;
    portname:string;


    FbillNoFieldName:String;
    procedure SetPaperSize(X, Y: Integer);
    procedure writeString(strdata:string;fontheight:Double;var f:textfile);
    function Get_char_from_number(num: double; param: integer; Upper, currency: boolean): string;
                                //ԭ��ֵ   ����          ��д�� ��ӡ���ַ��ţ�
    function FormatByParameter(parameter: variant; str: string): string;
    function getPrintPortByName(printname:string):string;
    function getPrintPortByName1(printname:string):string;

//    procedure initPrintTemplate(var flag:Integer);
//    procedure initPrintTemplateItem(var flag:Integer);
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
    flag:Integer;
    printerName:string;
    printerport:string;
    printtype:string;
    SingleValue:TDictionary<String,String>;//���������
    MultipleValue:TList<TDictionary<String,String>>;//������ݼ�
    currency: boolean;  //�Ƿ��ӡ��
//   constructor create(AOwner: TComponent);overload;
   constructor create(AOwner: TComponent;templatename: string);overload;
   destructor Destroy; override;
    procedure Print;    //��ӡ
    procedure commandPrint;
    procedure init;
    //�����������ļ���ȡ�ô�ӡģ������
    class Function GetTicketModelName(templateTypeName,templateName: string): string;
    function getPrintPageCount(MultipleValueCount:integer):integer;//�������ݼ���¼��ȡ��ӡҳ��
    property CurPrintPageCount:integer read getCurPrintPageCount;//ȡ��ǰҪ��ӡ��ҳ���������߱���������MultipleValue
    property billNoFieldName:String read FbillNoFieldName write FbillNoFieldName;//Ʊ֤�����ֶΣ����ڴ�ӡ��ҳʱ���Զ�������һҳ��Ʊ֤��
  end;


implementation
uses PubFn,Services;

function zerofill(source: string; totalLength: Integer): string;
begin
  result := source;
  while Length(result) < totalLength do
  begin
    result := '0' + result;
  end;
end;

function _strtodatetime(Strdate: string): Tdatetime;
begin
  try
    if pos('.', Strdate) > 0 then
    begin
      DateSeparator := '.';
    end
    else
    begin
      DateSeparator := '-';
    end;
    result := strtodatetime(Strdate)
  finally
    DateSeparator := '-';
  end;
end;

function moneyToChinaStr(const n: Real): string;   //���Ե����ڣ����ҿ����������Χ
  const cNum: WideString = '��Ҽ��������½��ƾ�--��Ǫ��ʰ��Ǫ��ʰ��Ǫ��ʰԪ�Ƿ�';
        cCha:array[0..1, 0..12]of string =
        (( '��Ԫ','��ʰ','���','��Ǫ','����','����','����','������','����','����','����','����','��Ԫ'),
         ( 'Ԫ','��','��','��','��','��','��','��','��','��','��','��','Ԫ'));
  var i : Integer;
      sNum,sTemp : WideString;
begin
  if n<0 then
  begin
    Result := '��'+moneyToChinaStr(n*-1);
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
    if pos('���',result)=0
      then Result := StringReplace(Result, '���', '��', [rfReplaceAll])
      else Result := StringReplace(Result, '���','��', [rfReplaceAll]);
    Result := StringReplace(Result, '���','', [rfReplaceAll]);
  end;
end;



function Changdx2(mmje: Double): String;
const s1: String = '��Ҽ��������½��ƾ�';
      s2: String = '�ֽ�Ԫʰ��Ǫ��ʰ��Ǫ��ʰ��Ǫ��';

 function StrTran(const S, S1, S2: String): String;
  begin
    Result := StringReplace(S, S1, S2, [rfReplaceAll]);
  end;
 var s, dx: String;
     i, Len: Integer;
begin
if mmje < 0 then
  begin dx := '��';
        mmje := -mmje;
  end;
   s := Format('%.0f', [mmje*100]);
   Len := Length(s);
  for i := 1 to Len do
   dx := dx + Copy(s1, (Ord(s[i]) - Ord('0'))*2 + 1, 2) + Copy(s2, (Len - i)*2 + 1, 2);
   dx := StrTran(StrTran(StrTran(StrTran(StrTran(dx, '��Ǫ', '��'), '���', '��'), '��ʰ', '��'), '���', '��'), '���', '��');
   dx := StrTran(StrTran(StrTran(StrTran(StrTran(dx, '����', '��'), '����', '��'), '����', '��'), '����', '��'), '��Ԫ', 'Ԫ');
 if dx = '��' then Result := '��Ԫ��'
  else Result := StrTran(StrTran(dx, '����', '����'), '����', '��');
end;

{ Tskyprint }
//�Զ���ֽ�Ź���x,yΪ0.1mm
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
        //�Զ���ֽ�Ŵ�С
        pDMode^.dmFields := pDMode^.dmFields or
          DM_PAPERSIZE or
          DM_PAPERWIDTH or
          DM_PAPERLENGTH;
        pDMode^.dmPaperSize := DMPAPER_USER;
        //showmessage(inttostr(pdmode^.dmorientation));
        {һ��Ҫ�����������жϣ�����ֽ�ŵķ�������ѡ�񳤡�
        ��x,y)��ʹ�����������ʹ�������͵�����һ�����һ��
        dmorient_landscapeֵΪ2��dmorient_portraitֵΪ1
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
const S1 = '��Ҽ��������½��ƾ�';
  S2 = '0123456789';
begin
  max := length(inttostr(trunc(num)));
  if param = 0 then
    Result := '��'
  else if max + 1 < param then
    result := ''
  else if max + 1 = param then
    if currency then
      result := '��'
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

//procedure TNovaPrint.initPrintTemplate(var flag:Integer);
//var localfilename,aa,ExecPath :string;
//begin
//  if flag=0 then
//    begin
//      localfilename:='ticketPrinttemplate.cds';
//    end
//  else  if flag=1 then
//  begin
//    localfilename:='returnVoucherPrinttemplate.cds';
//  end ;
//  cdsPrintTemplate:=TClientDataSet.Create(self);
//  with cdsPrintTemplate do
//  begin
//    if not FileExists(localfilename) then
//    begin
//      application.MessageBox('�Ҳ�����ӡ�������ݼ�','����',MB_ICONERROR);
//      Application.Terminate;
//    end;
//    LoadFromFile(localfilename);
//    if RecordCount<=0 then
//    begin
//      application.MessageBox('���ߴ�ӡ�������ݼ�Ϊ��','����',MB_ICONERROR);
//      Application.Terminate;
//    end;
//    FPrintTemplateName:=FieldByName('name').AsString;
//    printerName:=FieldByName('printername').AsString;
//    portname:=getPrintPortByName(FieldByName('printername').AsString);
//    printerport:=getPrintPortByName(FieldByName('printername').AsString);
//    if portname='' then
//      portname:=getPrintPortByName(Printer.Printers.Strings[Printer.PrinterIndex]);
//    if not((Win32Platform   <>   VER_PLATFORM_WIN32_WINDOWS)
//      or (Win32MajorVersion   >   4)) and (Pos(' on ',FieldByName('printername').AsString)=0)   then
//    begin
//      Edit;
//      FieldByName('printername').AsString := FieldByName('printername').AsString+' on '+getPrintPortByName1(FieldByName('printername').AsString);
//    end;
//  end;
//end;

//procedure TNovaPrint.initPrintTemplateItem(var flag:Integer);
//var localdetailfilename:string;
//begin
//
//if flag=0 then
//  begin
//localdetailfilename:='ticketPrinttemplatedetail.cds';
//  end
//  else  if flag=1 then
//  begin
//    localdetailfilename:='returnVoucherPrinttemplatedetail.cds';
//end ;
//  cdsPrintTemplateitem:=TClientDataSet.Create(self);
//  with cdsPrintTemplateitem do
//  begin
//    if not FileExists(localdetailfilename) then
//    begin
//      application.MessageBox('�Ҳ�����ӡ�������ݼ�','����',MB_ICONERROR);
//      Application.Terminate;
//    end;
//    LoadFromFile(localdetailfilename);
//    if RecordCount<=0 then
//      raise Exception.Create('���ߴ�ӡģ�壺'+FPrintTemplateName+'����ϸΪ��');
//  end;
//end;

//constructor TNovaPrint.create(AOwner: TComponent);  //��ʼ�� ģ����Ϣ����ӡ��Ŀ
//begin
//     inherited create(AOwner);
//end;

constructor TNovaPrint.create(AOwner: TComponent;templatename: string);  //��ʼ�� ģ����Ϣ����ӡ��Ŀ
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

procedure TNovaPrint.init;
begin
  FbillNoFieldName:='';
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


destructor TNovaPrint.Destroy;
begin
  SingleValue.Free;
  MultipleValue.Free;
  inherited;
end;

procedure TNovaPrint.Print;
var
//Barcode: TBarcode;   //������
  i, j: integer; //ѭ����ӡ���ݼ�
  f:textfile;
  ix,iy:integer;  //��ӡλ��
  printtext,HexStr:String;
  bmp:TBitmap;

  printPageCount,curPageNo:integer;
  H_Modul:Integer;
  H_Ratio:Double;

  jpeg: TJPEGImage;  //ͼƬ
  Image1:TImage;
  RR: TRect;
  ScaleX, ScaleY: Integer;
  lw,lh:integer;
begin
  if printtype<>'0' then
  begin
    commandprint;
    exit;
  end;
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
        //��ӡ���ͣ�0���ߡ�1�̶����⡢2�ַ�����3��д���֡�4Сд���֡�5����ʱ�䡢6-�����롢7-ͼƬ��8-��д��
          case FieldByName('valuetype').AsInteger of      //�ж������������
            0:    //��
            begin
              ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']);
              iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);
                  //����������
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
                  //����������
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
            1:  //�̶�����
            begin
              if not FieldByName('title').IsNull then
              begin
                canvas.Font.Name := FieldValues['fontname'];
                Canvas.font.size := FieldValues['fontsize'];//����
                canvas.font.PixelsPerInch := round(py);
                canvas.TextOut(getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']),
                               getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']),
                               FieldValues['title']);//���
              end;
            end;
            7://ͼƬ
            begin
               if FieldByName('printpicture').AsString<>'' then
               begin
                   ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']);
                   iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);

                    try
                      jpeg:= TJPEGImage.Create;
                      HexStr := FieldByName('printpicture').AsString;
                      if (HexStr <> '') then
                      jpeg := HexStrToJpg(HexStr);
                      ScaleX := ix+getXPixelByMm(FieldValues['Width']);
                      ScaleY := iy+getXPixelByMm(FieldValues['Height']) ;
                      RR := Rect(ix, iy,ScaleX ,ScaleY);
                      //ֱ������ӡ�����"Printer.Canvas.StretchDraw"
                      Canvas.StretchDraw(Rr, jpeg);
                    finally
                      jpeg.Free;
                  end;
               end;
            end
          else  //���������Ҫ�ٴ��жϴ�ӡ����
          begin
            if (SingleValue<>nil) and (FieldValues['islist'] = false) and (getSingleValue(FieldValues['itemcode'],curPageNo)<>'') then //��������  //and (SingleValue.ContainsKey(FieldValues['itemcode']))
            begin
              canvas.Font.Name := FieldValues['fontname'];
              Canvas.font.size := FieldValues['fontsize'];//����
              canvas.font.PixelsPerInch := round(py);
              ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']);
              iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']);
              printtext:=getSingleValue(FieldValues['itemcode'],curPageNo);
              case FieldByName('valuetype').AsInteger of
                2:  //2�ַ���
                  canvas.TextOut(ix,iy,
                                 FormatByParameter(FieldValues['parameter'],printtext)
                                );//���
                3:      //3-��д����
                  canvas.TextOut(ix,iy,
                                 Get_char_from_number(strtofloat(printtext),
                                                      FieldValues['parameter'], true, currency)
                                );//���
                4:  //4-Сд����
                  canvas.TextOut(ix,iy,
                                 Get_char_from_number(strtofloat(printtext),
                                                      FieldValues['parameter'], false, currency)
                                 );//���
                5:  //4-����ʱ��
                  canvas.TextOut(ix,iy,
                                 FormatDateTime(FieldValues['parameter'],
                                                _strtodatetime(printtext))
                                 );//���
                6: //6-������
                begin
                  bmp:=TBitmap.create;
                  try
                    bmp.Width:=HBarCode.H_GetBarWidth(TBarType(GetEnumValue(TypeInfo(TBarType),FieldValues['parameter'])),
                                                      printtext,
                                                      H_Modul, H_Ratio,csNone);
                    bmp.Height:=Round(FieldValues['Height'] / 254 * Screen.PixelsPerInch);
                    bmp.canvas.Font.Name := FieldValues['fontname'];
                    bmp.Canvas.font.size := FieldValues['fontsize'];//����
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
                8:  //7-��д���
                  canvas.TextOut(ix,iy,
                                 FormatByParameter(FieldValues['parameter'],
                                                   moneyToChinaStr(strtofloat(printtext))
                                                   )
                                 );//���
              else
                ;
              end;   //case
            end;  //end if;
            if (MultipleValue<>nil) and (MultipleValue.Count>0) and (FieldValues['islist'] = true) then  //�������ݼ�
            begin
              canvas.Font.Name := FieldValues['fontname'];
              Canvas.font.size := FieldValues['fontsize'];//����
              canvas.font.PixelsPerInch := round(py);
              for i := 0 to cdsPrintTemplate.FieldValues['columnsperpage'] - 1 do  //ѭ�����ݼ���Ŀ��
              begin
                ix:=getXPixelByMm(FieldValues['left'] + cdsPrintTemplate.FieldValues['left']
                                  +round(cdsPrintTemplate.FieldValues['width']/cdsPrintTemplate.FieldValues['columnsperpage']*i));
                for j := 0 to cdsPrintTemplate.FieldValues['rowperpage'] - 1 do //ѭ�����ݼ�����
                  if j + cdsPrintTemplate.FieldValues['rowperpage'] * i < MultipleValue.Count then
                  begin
                    printtext:=getMultipleValue(j + cdsPrintTemplate.FieldValues['rowperpage'] * i
                                                +curPageNo*cdsPrintTemplate.FieldValues['rowperpage']*cdsPrintTemplate.FieldValues['columnsperpage'],
                                                                       FieldValues['itemcode']
                                                                       );
                    iy:=getYPixelByMm(FieldValues['top'] + cdsPrintTemplate.FieldValues['top']
                                      +(cdsPrintTemplate.FieldValues['rowspace'])*j
                                      )+Canvas.TextHeight(printtext)*j;
                    case FieldByName('valuetype').AsInteger of
                      2:  //2�ַ���
                        canvas.TextOut(ix,iy,
                                       FormatByParameter(FieldValues['parameter'],printtext)
                                       );//���
                      3:      //2-��д����
                        canvas.TextOut(ix,iy,
                                       Get_char_from_number(strtofloat(printtext),FieldValues['parameter'], true, currency)
                                      );//���
                      4:  //4-Сд����
                        canvas.TextOut(ix,iy,
                                       Get_char_from_number(strtofloat(printtext),FieldValues['parameter'], false, currency)
                          );//���
                      5:  //5-����ʱ��
                        canvas.TextOut(ix,iy,
                                       FormatDateTime(FieldValues['parameter'], strtodatetime(printtext))
                                       );//���
                      6: //6-������
                      begin
                        bmp:=TBitmap.create;
                        try
                          bmp.Width:=HBarCode.H_GetBarWidth(TBarType(GetEnumValue(TypeInfo(TBarType),FieldValues['parameter'])),
                                                            SingleValue.Items[FieldValues['itemcode']],
                                                            H_Modul, H_Ratio,csNone);
                          bmp.Height:=Round(FieldValues['Height'] / 254 * Screen.PixelsPerInch);
                          bmp.canvas.Font.Name := FieldValues['fontname'];
                          bmp.Canvas.font.size := FieldValues['fontsize'];//����
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
                      7:  //7-��д���
                        canvas.TextOut(ix,iy,
                                       FormatByParameter(FieldValues['parameter'],
                                                         moneyToChinaStr(strtofloat(printtext))
                                                         )
                                       );//���
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
    Write(F,chr($18));//����л���������
    CloseFile(f);
  end;
end;

procedure TNovaPrint.commandPrint;
var
//Barcode: TBarcode;   //������
  i,printPageCount: integer;
  f:textfile;
  printtext:String;
  pageheight,pagewidth,linesize:integer;
  printer1 : TClientDataSet;
  curPageNo:integer;
  tmp,left1,left2:Integer;
  left,pretop,top:Double;
  maxbottop,minheadtop:Integer;
  Ini: TIniFile;
  portvalue:string;
begin
  Ini := TIniFile.Create(ExtractFilePath(Paramstr(0))+applicationCfgName);
  portvalue := Ini.ReadString('portvalue', 'portvalue', '');
  with cdsPrintTemplate do
  begin
    pageheight := FieldByName('height').AsInteger;
    pagewidth := FieldByName('width').AsInteger
  end;
  if pageheight>896 then
  begin
    raise Exception.Create('�������߶ȣ����߶�Ϊ8.9cm');
    exit;
  end;

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
  for curPageNo := 0 to printPageCount - 1 do
  begin
    portname:= portvalue;
    if portname<>'' then
    begin
      AssignFile(f,portname);
      Rewrite(f);
    end
    else
    begin
      raise Exception.Create('�����ӡ���Ƿ����');
      exit;
    end;
    write(f,chr(27)+chr(64));//��ʼ����ӡ��
  //  Write(f,chr(27)+chr(74)+chr(255));
    write(f,chr(27)+chr(102));//����˳����ֽ
    write(f,chr(27)+chr(51)+chr(5));//�����и�Ϊ5/180Ӣ��
    linesize := Round(pageheight/254/5*180);
    write(f,Ansichar(27)+Ansichar(67)+Ansichar(linesize)); //ҳ��x��

    printer1:=TClientDataSet.Create(self);
    with  printer1 do
    begin
      FieldDefs.Add('left',ftInteger);
      FieldDefs.Add('top',ftInteger);
      FieldDefs.Add('bottop',ftInteger);//Ԫ�صײ��ඥ�߶�
      FieldDefs.Add('title',ftString,30);
      FieldDefs.Add('height',ftInteger);
      fieldDefs.add('valuetype',ftInteger);
      FieldDefs.Add('islist',ftString,30);
      FieldDefs.Add('itemcode',ftString,30);
      FieldDefs.Add('parameter',ftString,30);
      fieldDefs.add('lineheight',ftinteger);
    end;
    printer1.CreateDataSet;
    printer1.open;
  //  ds2.DataSet := printer1;

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
        //�߶ȳ���Ʊ�ķ�Χ�ı������˵�
        if FieldByName('top').AsInteger+FieldByName('height').AsInteger > pageheight then
        begin
          Next;
          Continue;

        end;
        //����೬��Ʊ�ķ�Χ�ı������˵�
        if FieldByName('left').AsInteger > pagewidth then
        begin
          Next;
          Continue;

        end;
        printer1.Append;
        printer1.FieldValues['left'] := FieldByName('left').AsInteger;
        if(FieldByName('top').AsInteger<0) then
        begin
          printer1.FieldValues['top'] := 0;
        end
        else
        begin
          printer1.FieldValues['top'] := FieldByName('top').AsInteger;
        end;

        printer1.FieldValues['bottop'] := FieldByName('top').AsInteger+FieldByName('height').AsInteger;
  //      printer1.FieldValues['top'] := FieldByName('top').AsInteger+33.6;
        printer1.FieldValues['title'] := FieldByName('title').AsString;
        printer1.FieldValues['height'] := FieldByName('height').AsInteger;
        printer1.FieldValues['valuetype'] := FieldByName('valuetype').AsInteger;
        printer1.FieldValues['islist'] := FieldByName('islist').AsString;
        printer1.FieldValues['itemcode'] := FieldByName('itemcode').AsString;
        printer1.FieldValues['parameter'] := FieldByName('parameter').AsString;
    //    str := str + FieldByName('left').AsString+',';
        next;
      end;
    end;
    printer1.AddIndex('Index_1', 'bottop; top', []);             { ���� }
    printer1.AddIndex('Index_2', 'bottop; left', [ixDescending]); { ���� }
    //ѭ������
    with printer1 do
    begin
      IndexName :='Index_2';
      first;
      maxbottop := FieldByName('bottop').AsInteger;      //��һ��Ԫ�صĵײ��߶�Ϊ���ײ�
      minheadtop := FieldByName('top').AsInteger;        //��һ��Ԫ�ص�ͷ���߶�Ϊ�ඥ�������
      Next;
      while not eof do
      begin
        if minheadtop < FieldByName('bottop').AsInteger then  //�����ǰԪ�صĵײ���maxbottop��minheadtop֮�䣨�н��棩
        begin
          edit;                                    //��������ǰһ��Ԫ�صײ�����
          FieldValues['bottop'] := maxbottop;
          if FieldByName('top').AsInteger < minheadtop then  //����н����Ҹ�Ԫ�ص�top��minheadtopС
          begin                                              //��ȡ��ֵΪminheadtop
            minheadtop := FieldByName('top').AsInteger;
          end;
        end
        else if minheadtop > FieldByName('bottop').AsInteger then  //�����Ԫ�صײ���minheadtopС�����޽���
        begin                                                      //��minheadtop��maxbottop���¸�ֵ
          minheadtop := FieldByName('top').AsInteger;
          maxbottop := FieldByName('bottop').AsInteger;
        end;
        next;
      end;
    end;



    pretop := 0;
    with printer1 do
    begin
      IndexName :='Index_1';
      first;
      while not eof do
      begin
        top := FieldByName('bottop').AsFloat;
        if top<0 then
        begin
          top := 0;
        end;

        {����λ�ƿ�ʼ}
        if(top <> pretop)then
        begin
          //�߶Ȳ�-�����С��������������߶�-24*24��׼����߶�(24*0.14)��
          tmp := round((top-pretop - (FieldByName('height').AsFloat-33.6))/2.54/100*180);
          if tmp<0 then
          begin

          end
          else if tmp>0 then
          begin
            for i:=1 to (tmp div 255) do
            begin
              Write(f,AnsiChar(27)+AnsiChar(74)+AnsiChar(255));//˳������
            end;
            Write(f,AnsiChar(27)+AnsiChar(74)+AnsiChar(tmp mod 255));
            pretop := top;
          end;
        end;
        {����λ�ƽ���}
        {����λ�ƿ�ʼ}
        left := FieldByName('left').AsFloat;
        if left<0 then
        begin
          left := 0;
        end;
        left1 := round(left/2.54*60/100);
        left2 := 0;
        if(left>255) then
        begin
          left2:=left1 div 256;
          left1:=left1 mod 256;
        end;
        write(f,AnsiChar(27)+AnsiChar(36)+AnsiChar(left1)+AnsiChar(left2));//���Ժ�������
        {����λ�ƽ���}
        //��ӡ���ͣ�0���ߡ�1�̶����⡢2�ַ�����3��д���֡�4Сд���֡�5����ʱ�䡢6-�����룩
        case FieldByName('valuetype').AsInteger of      //�ж������������
          0:    //��
          begin

          end;
          1:  //�̶�����
          begin
            if not FieldByName('title').IsNull then
            begin
              OutputDebugString(pchar(FieldByName('title').AsString));
              writeString(FieldByName('title').AsString,FieldByName('height').AsInteger,f);
            end;
          end;
        else  //���������Ҫ�ٴ��жϴ�ӡ����
          begin
            if (SingleValue<>nil) and (FieldByName('islist').AsBoolean = false) and (getSingleValue(FieldByName('itemcode').AsString,curPageNo)<>'') then //��������  //and (SingleValue.ContainsKey(FieldValues['itemcode']))
            begin
  //            ix:=getXPixelByMm(FieldByName('left').AsInteger+ cdsPrintTemplate.FieldByName('left').AsInteger);
  //            iy:=getYPixelByMm(FieldByName('top').AsInteger+ cdsPrintTemplate.FieldByName('top').AsInteger);
              printtext:=getSingleValue(FieldValues['itemcode'],curPageNo);
              case FieldByName('valuetype').AsInteger of
                2:  //2�ַ���
                  begin
//                  SysDialogs.showMessage(printtext);
                  writeString(FormatByParameter(FieldValues['parameter'],printtext),FieldByName('height').AsInteger,f);
                  end;
                3:      //3-��д����
                  writeString(Get_char_from_number(strtofloat(printtext),
                                                      FieldValues['parameter'], true, currency),FieldByName('height').AsInteger,f);
                4:  //4-Сд����
                  writeString(Get_char_from_number(strtofloat(printtext),
                                                      4, false, currency),FieldByName('height').AsInteger,f);
                5:  //4-����ʱ��
                  writeString(FormatDateTime(FieldValues['parameter'],
                                                _strtodatetime(printtext)),FieldByName('height').AsInteger,f);
                7:  //7-��д���
                  writeString(FormatByParameter(FieldValues['parameter'],
                              moneyToChinaStr(strtofloat(printtext))
                                                   ),FieldByName('height').AsInteger,f);
              else
                ;
              end;   //case
            end;  //end if;

          end;  //end if;
        end;  //end begin;
        next;
      end;   //case

    end;
    if portname<>'' then
    begin
      write(f,chr(27)+chr(102)+chr(12));//˳����ֽһҳ��ֽ
      CloseFile(f);
    end;
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
  if (parameter = null) or (parameter='')  then
  begin
    formatstr :='%s';
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
  // ������ / DPI = Ӣ����   Ӣ���� * 25.4 = ������
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
  reg:TRegistry;//����һ��TRegistry�����
  s:string;
begin
  s:='';
  reg:=TRegistry.Create;//����ʵ��
  reg.RootKey:=HKEY_LOCAL_MACHINE;//ָ����Ҫ������ע��������
  //if reg.OpenKey('\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Print\Printers\'+printname,false) then//����򿪳ɹ���������²���
  if reg.OpenKey('\System\CurrentControlSet\Control\Print\Printers\'+printname,false) then//����򿪳ɹ���������²���
  begin
    s:=reg.ReadString('Port');//��ע����ж�ȡ��Ӧ�ַ�����ֵ
    //������ַ����������򷵻�ֵΪ���ַ���
    reg.CloseKey;//�ر�ע���
  end;
  reg.Free;//�ͷű�����ռ�ڴ�
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
      result:=zerofill(inttostr(strtoint64(SingleValue.Items[itemcode])+pageNo),length(SingleValue.Items[itemcode]));
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

procedure TNovaPrint.writeString(strdata:string;fontheight:Double;var f:textfile);
var
  fontpoint : Integer;
  //strReturn:string;
begin
  //result:='';
//  fontpoint := round(fontheight/10/0.14);//һ��������0.14mm
//  Write(f,AnsiChar(27)+AnsiChar(101)+AnsiChar(48)+AnsiChar(72));//�趨�����С
  if fontheight>45 then  //����13������
  begin
      Write(f,AnsiChar(28)+AnsiChar(87)+AnsiChar(1));  //�趨�����С���ı��Ǻ��ִ�ӡ
  end;
  Write(f,strdata);
  Write(f,AnsiChar(28)+AnsiChar(87)+AnsiChar(0)); //�ָ�Ĭ�������С-�����ı��Ǻ��ִ�ӡ
//  Write(f,AnsiChar(27)+AnsiChar(101)+AnsiChar(0)+AnsiChar(0));//�ָ�Ĭ�������С
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
      raise Exception.Create('�Ҳ�����ӡģ�壺'+FPrintTemplateName)
    else if RecordCount>1 then
      raise Exception.Create('��ӡģ�壺'+FPrintTemplateName+'�����ظ�')
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
      raise Exception.Create('��ӡģ�壺'+FPrintTemplateName+'����ϸΪ��');
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

end.

