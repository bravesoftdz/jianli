unit frxrcExports;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252">  <StrRes Name='+
'"8000" Text="Export to Excel"/>  <StrRes Name="8001" Text="Styles"/>  <StrRes Na'+
'me="8002" Text="Pictures"/>  <StrRes Name="8003" Text="Merge cells"/>  <StrRes N'+
'ame="8004" Text="Fast export"/>  <StrRes Name="8005" Text="WYSIWYG"/>  <StrRes N'+
'ame="8006" Text="As text"/>  <StrRes Name="8007" Text="Background"/>  <StrRes Na'+
'me="8008" Text="Open Excel after export"/>  <StrRes Name="8009" Text="Excel file'+
' (*.xls)|*.xls"/>  <StrRes Name="8010" Text=".xls"/>  <StrRes Name="8100" Text="'+
'Export to Excel"/>  <StrRes Name="8101" Text="Styles"/>  <StrRes Name="8102" Tex'+
't="WYSIWYG"/>  <StrRes Name="8103" Text="Background"/>  <StrRes Name="8104" Text'+
'="Open Excel after export"/>  <StrRes Name="8105" Text="XML Excel file (*.xls)|*'+
'.xls"/>  <StrRes Name="8106" Text=".xls"/>  <StrRes Name="8200" Text="Export to '+
'HTML table"/>  <StrRes Name="8201" Text="Open after export"/>  <StrRes Name="820'+
'2" Text="Styles"/>  <StrRes Name="8203" Text="Pictures"/>  <StrRes Name="8204" T'+
'ext="All in one folder"/>  <StrRes Name="8205" Text="Fixed width"/>  <StrRes Nam'+
'e="8206" Text="Page navigator"/>  <StrRes Name="8207" Text="Multipage"/>  <StrRe'+
's Name="8208" Text="Mozilla browser"/>  <StrRes Name="8209" Text="Background"/> '+
' <StrRes Name="8210" Text="HTML file (*.html)|*.html"/>  <StrRes Name="8211" Tex'+
't=".html"/>  <StrRes Name="8300" Text="Export to text (dot-matrix printer)"/>  <'+
'StrRes Name="8301" Text="Preview on/off"/>  <StrRes Name="8302" Text=" Export pr'+
'operties  "/>  <StrRes Name="8303" Text="Page breaks"/>  <StrRes Name="8304" Tex'+
't="OEM codepage"/>  <StrRes Name="8305" Text="Empty lines"/>  <StrRes Name="8306'+
'" Text="Lead spaces"/>  <StrRes Name="8307" Text="Page numbers"/>  <StrRes Name='+
'"8308" Text="Enter numbers and/or page ranges, separated by commas. For example:'+
' 1,3,5-12"/>  <StrRes Name="8309" Text=" Scaling "/>  <StrRes Name="8310" Text="'+
'X Scale"/>  <StrRes Name="8311" Text="Y Scale"/>  <StrRes Name="8312" Text=" Fra'+
'mes "/>  <StrRes Name="8313" Text="None"/>  <StrRes Name="8314" Text="Simple"/> '+
' <StrRes Name="8315" Text="Graphic"/>  <StrRes Name="8316" Text="Only with OEM c'+
'odepage"/>  <StrRes Name="8317" Text="Print after export"/>  <StrRes Name="8318"'+
' Text="Save settings"/>  <StrRes Name="8319" Text=" Preview "/>  <StrRes Name="8'+
'320" Text="Width:"/>  <StrRes Name="8321" Text="Height:"/>  <StrRes Name="8322" '+
'Text="Page"/>  <StrRes Name="8323" Text="Zoom in"/>  <StrRes Name="8324" Text="Z'+
'oom out"/>  <StrRes Name="8325" Text="Text file (dot-matrix printer)(*.prn)|*.pr'+
'n"/>  <StrRes Name="8326" Text=".prn"/>  <StrRes Name="8400" Text="Print"/>  <St'+
'rRes Name="8401" Text="Printer"/>  <StrRes Name="8402" Text="Name"/>  <StrRes Na'+
'me="8403" Text="Setup..."/>  <StrRes Name="8404" Text="Copies"/>  <StrRes Name="'+
'8405" Text="Number of copies"/>  <StrRes Name="8406" Text=" Printer init setup "'+
'/>  <StrRes Name="8407" Text="Printer type"/>  <StrRes Name="8408" Text=".fpi"/>'+
'  <StrRes Name="8409" Text="Printer init template (*.fpi)|*.fpi"/>  <StrRes Name'+
'="8410" Text=".fpi"/>  <StrRes Name="8411" Text="Printer init template (*.fpi)|*'+
'.fpi"/>  <StrRes Name="8500" Text="Export to RTF"/>  <StrRes Name="8501" Text="P'+
'ictures"/>  <StrRes Name="8502" Text="WYSIWYG"/>  <StrRes Name="8503" Text="Open'+
' after export"/>  <StrRes Name="8504" Text="RTF file (*.rtf)|*.rtf"/>  <StrRes N'+
'ame="8505" Text=".rtf"/>  <StrRes Name="8600" Text="Export Settings"/>  <StrRes '+
'Name="8601" Text=" Image settings "/>  <StrRes Name="8602" Text="JPEG quality"/>'+
'  <StrRes Name="8603" Text="Resolution (dpi)"/>  <StrRes Name="8604" Text="Separ'+
'ate files"/>  <StrRes Name="8605" Text="Crop pages"/>  <StrRes Name="8606" Text='+
'"Monochrome"/>  <StrRes Name="8700" Text="Export to PDF"/>  <StrRes Name="8701" '+
'Text="Compressed"/>  <StrRes Name="8702" Text="Embedded fonts"/>  <StrRes Name="'+
'8703" Text="Print optimized"/>  <StrRes Name="8704" Text="Outline"/>  <StrRes Na'+
'me="8705" Text="Background"/>  <StrRes Name="8706" Text="Open after export"/>  <'+
'StrRes Name="8707" Text="Adobe PDF file (*.pdf)|*.pdf"/>  <StrRes Name="8708" Te'+
'xt=".pdf"/>  <StrRes Name="RTFexport" Text="RTF file"/>  <StrRes Name="BMPexport'+
'" Text="BMP image"/>  <StrRes Name="JPEGexport" Text="JPEG image"/>  <StrRes Nam'+
'e="TIFFexport" Text="TIFF image"/>  <StrRes Name="TextExport" Text="Text (matrix'+
' printer)"/>  <StrRes Name="XlsOLEexport" Text="Excel table (OLE)"/>  <StrRes Na'+
'me="HTMLexport" Text="HTML file"/>  <StrRes Name="XlsXMLexport" Text="Excel tabl'+
'e (XML)"/>  <StrRes Name="PDFexport" Text="PDF file"/>  <StrRes Name="ProgressWa'+
'it" Text="Please wait"/>  <StrRes Name="ProgressRows" Text="Setting up rows"/>  '+
'<StrRes Name="ProgressColumns" Text="Setting up columns"/>  <StrRes Name="Progre'+
'ssStyles" Text="Setting up styles"/>  <StrRes Name="ProgressObjects" Text="Expor'+
'ting objects"/>  <StrRes Name="TIFFexportFilter" Text="Tiff image (*.tif)|*.tif"'+
'/>  <StrRes Name="BMPexportFilter" Text="BMP image (*.bmp)|*.bmp"/>  <StrRes Nam'+
'e="JPEGexportFilter" Text="Jpeg image (*.jpg)|*.jpg"/>  <StrRes Name="HTMLNavFir'+
'st" Text="First"/>  <StrRes Name="HTMLNavPrev" Text="Prev"/>  <StrRes Name="HTML'+
'NavNext" Text="Next"/>  <StrRes Name="HTMLNavLast" Text="Last"/>  <StrRes Name="'+
'HTMLNavRefresh" Text="Refresh"/>  <StrRes Name="HTMLNavPrint" Text="Print"/>  <S'+
'trRes Name="HTMLNavTotal" Text="Total pages"/>  <StrRes Name="8800" Text="Export'+
' to Text"/>  <StrRes Name="8801" Text="Text file (*.txt)|*.txt"/>  <StrRes Name='+
'"8802" Text=".txt"/>  <StrRes Name="SimpleTextExport" Text="Text file"/>  <StrRe'+
's Name="8850" Text="Export to CSV"/>  <StrRes Name="8851" Text="CSV file (*.csv)'+
'|*.csv"/>  <StrRes Name="8852" Text=".csv"/>  <StrRes Name="8853" Text="Separato'+
'r"/>  <StrRes Name="CSVExport" Text="CSV file"/>  <StrRes Name="8900" Text="Send'+
' by E-mail"/>  <StrRes Name="8901" Text="E-mail"/>  <StrRes Name="8902" Text="Ac'+
'count"/>  <StrRes Name="8903" Text="Connection"/>  <StrRes Name="8904" Text="Add'+
'ress"/>  <StrRes Name="8905" Text="Attachment"/>  <StrRes Name="8906" Text="Form'+
'at"/>  <StrRes Name="8907" Text="From Address"/>  <StrRes Name="8908" Text="From'+
' Name"/>  <StrRes Name="8909" Text="Host"/>  <StrRes Name="8910" Text="Login"/> '+
' <StrRes Name="8911" Text="Mail"/>  <StrRes Name="8912" Text="Message"/>  <StrRe'+
's Name="8913" Text="Text"/>  <StrRes Name="8914" Text="Organization"/>  <StrRes '+
'Name="8915" Text="Password"/>  <StrRes Name="8916" Text="Port"/>  <StrRes Name="'+
'8917" Text="Remember properties"/>  <StrRes Name="8918" Text="Required fields ar'+
'e Empty"/>  <StrRes Name="8919" Text="Advanced export settings"/>  <StrRes Name='+
'"8920" Text="Signature"/>  <StrRes Name="8921" Text="Build"/>  <StrRes Name="892'+
'2" Text="Subject"/>  <StrRes Name="8923" Text="Best regards"/>  <StrRes Name="89'+
'24" Text="Send mail to"/>  <StrRes Name="EmailExport" Text="E-mail"/>  <StrRes N'+
'ame="FastReportFile" Text="FastReport file"/>  <StrRes Name="GifexportFilter" Te'+
'xt="Gif file (*.gif)|*.gif"/>  <StrRes Name="GIFexport" Text="Gif image"/>  <Str'+
'Res Name="8950" Text="Continuous"/>  <StrRes Name="8951" Text="Page Header/Foote'+
'r"/>  <StrRes Name="8952" Text="Text"/>  <StrRes Name="8953" Text="Header/Footer'+
'"/>  <StrRes Name="8954" Text="None"/>  <StrRes Name="ODSExportFilter" Text="Ope'+
'n Document Spreadsheet file (*.ods)|*.ods"/>  <StrRes Name="ODSExport" Text="Ope'+
'n Document Spreadsheet"/>  <StrRes Name="ODTExportFilter" Text="Open Document Te'+
'xt file (*.odt)|*.odt"/>  <StrRes Name="ODTExport" Text="Open Document Text"/>  '+
'<StrRes Name="8960" Text=".ods"/>  <StrRes Name="8961" Text=".odt"/>  <StrRes Na'+
'me="8962" Text="Security"/>  <StrRes Name="8963" Text="Security settings"/>  <St'+
'rRes Name="8964" Text="Owner password"/>  <StrRes Name="8965" Text="User passwor'+
'd"/>  <StrRes Name="8966" Text="Print the document"/>  <StrRes Name="8967" Text='+
'"Modify the document"/>  <StrRes Name="8968" Text="Copy of text and graphics"/> '+
' <StrRes Name="8969" Text="Add or modify text annotations"/>  <StrRes Name="8970'+
'" Text="PDF Security"/>  <StrRes Name="8971" Text="Document information"/>  <Str'+
'Res Name="8972" Text="Information"/>  <StrRes Name="8973" Text="Title"/>  <StrRe'+
's Name="8974" Text="Author"/>  <StrRes Name="8975" Text="Subject"/>  <StrRes Nam'+
'e="8976" Text="Keywords"/>  <StrRes Name="8977" Text="Creator"/>  <StrRes Name="'+
'8978" Text="Producer"/>  <StrRes Name="8979" Text="Authentification"/>  <StrRes '+
'Name="8980" Text="Permissions"/>  <StrRes Name="8981" Text="Viewer"/>  <StrRes N'+
'ame="8982" Text="Viewer preferences"/>  <StrRes Name="8983" Text="Hide toolbar"/'+
'>  <StrRes Name="8984" Text="Hide menubar"/>  <StrRes Name="8985" Text="Hide win'+
'dow user interface"/>  <StrRes Name="8986" Text="Fit window"/>  <StrRes Name="89'+
'87" Text="Center window"/>  <StrRes Name="8988" Text="Print scaling"/>  <StrRes '+
'Name="8989" Text="Confirmation Reading"/>  <StrRes Name="9000" Text="Rows count:'+
'"/>  <StrRes Name="9001" Text="Split To Sheet"/>  <StrRes Name="9002" Text="Don'''+
't split"/>  <StrRes Name="9003" Text="Use report pages"/>  <StrRes Name="9004" T'+
'ext="Use print on parent"/>    <StrRes Name="9101" Text="Export to DBF"/>  <StrR'+
'es Name="9102" Text="dBase (DBF) export"/>  <StrRes Name="9103" Text=".dbf"/>  <'+
'StrRes Name="9104" Text="Failed to load the file"/>  <StrRes Name="9105" Text="F'+
'ailure"/>  <StrRes Name="9106" Text="Field names"/>  <StrRes Name="9107" Text="A'+
'utomatically"/>  <StrRes Name="9108" Text="Manually"/>  <StrRes Name="9109" Text'+
'="Load from file"/>  <StrRes Name="9110" Text="Text files (*.txt)|*.txt|All file'+
's|*.*"/>  <StrRes Name="9111" Text="DBF files (*.dbf)|*.dbf|All files|*.*"/></Re'+
'sources>'+
'';
initialization
    frxResources.AddXML(Utf8Encode(resXML));

end.
