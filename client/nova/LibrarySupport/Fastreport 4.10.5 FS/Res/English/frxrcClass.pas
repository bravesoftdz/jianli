unit frxrcClass;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252">  <StrRes Name='+
'"1" Text="OK"/>  <StrRes Name="2" Text="Cancel"/>  <StrRes Name="3" Text="All"/>'+
'  <StrRes Name="4" Text="Current page"/>  <StrRes Name="5" Text="Pages:"/>  <Str'+
'Res Name="6" Text="Page breaks"/>  <StrRes Name="7" Text="Page range"/>  <StrRes'+
' Name="8" Text="Export settings"/>  <StrRes Name="9" Text="Enter page numbers an'+
'd/or page ranges, separated by commas. For example, 1,3,5-12"/>  <StrRes Name="1'+
'00" Text="Preview"/>  <StrRes Name="101" Text="Print"/>  <StrRes Name="102" Text'+
'="Print"/>  <StrRes Name="103" Text="Open"/>  <StrRes Name="104" Text="Open"/>  '+
'<StrRes Name="105" Text="Save"/>  <StrRes Name="106" Text="Save"/>  <StrRes Name'+
'="107" Text="Export"/>  <StrRes Name="108" Text="Export"/>  <StrRes Name="109" T'+
'ext="Find"/>  <StrRes Name="110" Text="Find"/>  <StrRes Name="111" Text="Whole P'+
'age"/>  <StrRes Name="112" Text="Whole Page"/>  <StrRes Name="113" Text="Page Wi'+
'dth"/>  <StrRes Name="114" Text="Page Width"/>  <StrRes Name="115" Text="100%"/>'+
'  <StrRes Name="116" Text="100%"/>  <StrRes Name="117" Text="Two Pages"/>  <StrR'+
'es Name="118" Text="Two Pages"/>  <StrRes Name="119" Text="Zoom"/>  <StrRes Name'+
'="120" Text="Page Settings"/>  <StrRes Name="121" Text="Page Settings"/>  <StrRe'+
's Name="122" Text="Outline"/>  <StrRes Name="123" Text="Outline"/>  <StrRes Name'+
'="124" Text="Zoom In"/>  <StrRes Name="125" Text="Zoom In"/>  <StrRes Name="126"'+
' Text="Zoom Out"/>  <StrRes Name="127" Text="Zoom Out"/>  <StrRes Name="128" Tex'+
't="Outline"/>  <StrRes Name="129" Text="Report outline"/>  <StrRes Name="130" Te'+
'xt="Thumbnails"/>  <StrRes Name="131" Text="Thumbnails"/>  <StrRes Name="132" Te'+
'xt="Edit"/>  <StrRes Name="133" Text="Edit Page"/>  <StrRes Name="134" Text="Fir'+
'st"/>  <StrRes Name="135" Text="First Page"/>  <StrRes Name="136" Text="Prior"/>'+
'  <StrRes Name="137" Text="Prior Page"/>  <StrRes Name="138" Text="Next"/>  <Str'+
'Res Name="139" Text="Next Page"/>  <StrRes Name="140" Text="Last"/>  <StrRes Nam'+
'e="141" Text="Last Page"/>  <StrRes Name="142" Text="Page Number"/>  <StrRes Nam'+
'e="150" Text="Full Screen"/>  <StrRes Name="151" Text="Export to PDF"/>  <StrRes'+
' Name="152" Text="Send by E-mail"/>  <StrRes Name="zmPageWidth" Text="Page width'+
'"/>  <StrRes Name="zmWholePage" Text="Whole page"/>  <StrRes Name="200" Text="Pr'+
'int"/>  <StrRes Name="201" Text="Printer"/>  <StrRes Name="202" Text="Pages"/>  '+
'<StrRes Name="203" Text="Number of copies"/>  <StrRes Name="204" Text="Collate"/'+
'>  <StrRes Name="205" Text="Copies"/>  <StrRes Name="206" Text="Print"/>  <StrRe'+
's Name="207" Text="!Other"/>  <StrRes Name="208" Text="Where:"/>  <StrRes Name="'+
'209" Text="Properties..."/>  <StrRes Name="210" Text="Print to file"/>  <StrRes '+
'Name="211" Text="!Order"/>  <StrRes Name="212" Text="Name:"/>  <StrRes Name="213'+
'" Text="Print mode"/>  <StrRes Name="214" Text="Print on sheet"/>  <StrRes Name='+
'"216" Text="Duplex"/>  <StrRes Name="ppAll" Text="All pages"/>  <StrRes Name="pp'+
'Odd" Text="Odd pages"/>  <StrRes Name="ppEven" Text="Even pages"/>  <StrRes Name'+
'="pgDefault" Text="Default"/>  <StrRes Name="pmDefault" Text="Default"/>  <StrRe'+
's Name="pmSplit" Text="Split big pages"/>  <StrRes Name="pmJoin" Text="Join smal'+
'l pages"/>  <StrRes Name="pmScale" Text="Scale"/>  <StrRes Name="poDirect" Text='+
'"!Direct (1-9)"/>  <StrRes Name="poReverse" Text="!Reverse (9-1)"/>  <StrRes Nam'+
'e="300" Text="Find Text"/>  <StrRes Name="301" Text="Text to find:"/>  <StrRes N'+
'ame="302" Text="Search options"/>  <StrRes Name="303" Text="Replace with"/>  <St'+
'rRes Name="304" Text="Search from beginning"/>  <StrRes Name="305" Text="Case se'+
'nsitive"/>  <StrRes Name="400" Text="Page Settings"/>  <StrRes Name="401" Text="'+
'Width"/>  <StrRes Name="402" Text="Height"/>  <StrRes Name="403" Text="Size"/>  '+
'<StrRes Name="404" Text="Orientation"/>  <StrRes Name="405" Text="Left"/>  <StrR'+
'es Name="406" Text="Top"/>  <StrRes Name="407" Text="Right"/>  <StrRes Name="408'+
'" Text="Bottom"/>  <StrRes Name="409" Text="Margins"/>  <StrRes Name="410" Text='+
'"Portrait"/>  <StrRes Name="411" Text="Landscape"/>  <StrRes Name="412" Text="Ot'+
'her"/>  <StrRes Name="413" Text="Apply to the current page"/>  <StrRes Name="414'+
'" Text="Apply to all pages"/>  <StrRes Name="500" Text="Print"/>  <StrRes Name="'+
'501" Text="Printer"/>  <StrRes Name="502" Text="Pages"/>  <StrRes Name="503" Tex'+
't="Copies"/>  <StrRes Name="504" Text="Number of copies"/>  <StrRes Name="505" T'+
'ext="Options"/>  <StrRes Name="506" Text="Escape commands"/>  <StrRes Name="507"'+
' Text="Print to file"/>  <StrRes Name="508" Text="OEM codepage"/>  <StrRes Name='+
'"509" Text="Pseudographic"/>  <StrRes Name="510" Text="Printer file (*.prn)|*.pr'+
'n"/>  <StrRes Name="mbConfirm" Text="Confirm"/>  <StrRes Name="mbError" Text="Er'+
'ror"/>  <StrRes Name="mbInfo" Text="Information"/>  <StrRes Name="xrCantFindClas'+
's" Text="Cannot find class"/>  <StrRes Name="prVirtual" Text="Virtual"/>  <StrRe'+
's Name="prDefault" Text="Default"/>  <StrRes Name="prCustom" Text="Custom"/>  <S'+
'trRes Name="enUnconnHeader" Text="Unconnected header/footer"/>  <StrRes Name="en'+
'UnconnGroup" Text="No data band for the group"/>  <StrRes Name="enUnconnGFooter"'+
' Text="No group header for"/>  <StrRes Name="enBandPos" Text="Incorrect band pos'+
'ition:"/>  <StrRes Name="dbNotConn" Text="DataSet %s is not connected to data"/>'+
'  <StrRes Name="dbFldNotFound" Text="Field not found:"/>  <StrRes Name="clDSNotI'+
'ncl" Text="(dataset is not included in Report.DataSets)"/>  <StrRes Name="clUnkn'+
'ownVar" Text="Unknown variable or datafield:"/>  <StrRes Name="clScrError" Text='+
'"Script error at %s: %s"/>  <StrRes Name="clDSNotExist" Text="Dataset &#38;#34;%'+
's&#38;#34; does not exist"/>  <StrRes Name="clErrors" Text="The following error('+
's) have occured:"/>  <StrRes Name="clExprError" Text="Error in expression"/>  <S'+
'trRes Name="clFP3files" Text="Prepared Report"/>  <StrRes Name="clSaving" Text="'+
'Saving file..."/>  <StrRes Name="clCancel" Text="Cancel"/>  <StrRes Name="clClos'+
'e" Text="Close"/>  <StrRes Name="clPrinting" Text="Printing page"/>  <StrRes Nam'+
'e="clLoading" Text="Loading file..."/>  <StrRes Name="clPageOf" Text="Page %d of'+
' %d"/>  <StrRes Name="clFirstPass" Text="First pass: page "/>  <StrRes Name="clN'+
'oPrinters" Text="No printers installed on your system"/>  <StrRes Name="clDecomp'+
'ressError" Text="Stream decompress error"/>  <StrRes Name="crFillMx" Text="Filli'+
'ng the cross-tab..."/>  <StrRes Name="crBuildMx" Text="Building the cross-tab...'+
'"/>  <StrRes Name="prRunningFirst" Text="First pass: page %d"/>  <StrRes Name="p'+
'rRunning" Text="Preparing page %d"/>  <StrRes Name="prPrinting" Text="Printing p'+
'age %d"/>  <StrRes Name="prExporting" Text="Exporting page %d"/>  <StrRes Name="'+
'uCm" Text="cm"/>  <StrRes Name="uInch" Text="in"/>  <StrRes Name="uPix" Text="px'+
'"/>  <StrRes Name="uChar" Text="chr"/>  <StrRes Name="dupDefault" Text="Default"'+
'/>  <StrRes Name="dupVert" Text="Vertical"/>  <StrRes Name="dupHorz" Text="Horiz'+
'ontal"/>  <StrRes Name="dupSimpl" Text="Simplex"/>  <StrRes Name="SLangNotFound"'+
' Text="Language ''%s'' not found"/>  <StrRes Name="SInvalidLanguage" Text="Invalid'+
' language definition"/>  <StrRes Name="SIdRedeclared" Text="Identifier redeclare'+
'd: "/>  <StrRes Name="SUnknownType" Text="Unknown type: "/>  <StrRes Name="SInco'+
'mpatibleTypes" Text="Incompatible types"/>  <StrRes Name="SIdUndeclared" Text="U'+
'ndeclared identifier: "/>  <StrRes Name="SClassRequired" Text="Class type requir'+
'ed"/>  <StrRes Name="SIndexRequired" Text="Index required"/>  <StrRes Name="SStr'+
'ingError" Text="Strings do not have properties or methods"/>  <StrRes Name="SCla'+
'ssError" Text="Class %s does not have a default property"/>  <StrRes Name="SArra'+
'yRequired" Text="Array type required"/>  <StrRes Name="SVarRequired" Text="Varia'+
'ble required"/>  <StrRes Name="SNotEnoughParams" Text="Not enough actual paramet'+
'ers"/>  <StrRes Name="STooManyParams" Text="Too many actual parameters"/>  <StrR'+
'es Name="SLeftCantAssigned" Text="Left side cannot be assigned to"/>  <StrRes Na'+
'me="SForError" Text="For loop variable must be numeric variable"/>  <StrRes Name'+
'="SEventError" Text="Event handler must be a procedure"/>  <StrRes Name="600" Te'+
'xt="Expand all"/>  <StrRes Name="601" Text="Collapse all"/>  <StrRes Name="clStr'+
'NotFound" Text="Text not found"/></Resources>'+
'';
initialization
    frxResources.AddXML(Utf8Encode(resXML));

end.
