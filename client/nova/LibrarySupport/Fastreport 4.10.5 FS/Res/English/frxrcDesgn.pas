unit frxrcDesgn;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252">  <StrRes Name='+
'"2000" Text="Object Inspector"/>  <StrRes Name="oiProp" Text="Properties"/>  <St'+
'rRes Name="oiEvent" Text="Events"/>  <StrRes Name="2100" Text="Data Tree"/>  <St'+
'rRes Name="2101" Text="Data"/>  <StrRes Name="2102" Text="Variables"/>  <StrRes '+
'Name="2103" Text="Functions"/>  <StrRes Name="2104" Text="Create field"/>  <StrR'+
'es Name="2105" Text="Create caption"/>  <StrRes Name="2106" Text="Classes"/>  <S'+
'trRes Name="dtNoData" Text="No data available"/>  <StrRes Name="dtNoData1" Text='+
'"Go to the &#38;#34;Report|Data...&#38;#34; menu to add existing datasets to you'+
'r report, or switch to the &#38;#34;Data&#38;#34; tab and create new datasets."/'+
'>  <StrRes Name="dtData" Text="Data"/>  <StrRes Name="dtSysVar" Text="System var'+
'iables"/>  <StrRes Name="dtVar" Text="Variables"/>  <StrRes Name="dtFunc" Text="'+
'Functions"/>  <StrRes Name="2200" Text="Report Tree"/>  <StrRes Name="2300" Text'+
'="Open Script File"/>  <StrRes Name="2301" Text="Save Script to File"/>  <StrRes'+
' Name="2302" Text="Run Script"/>  <StrRes Name="2303" Text="Trace Into"/>  <StrR'+
'es Name="2304" Text="Terminate Script"/>  <StrRes Name="2305" Text="Evaluate"/> '+
' <StrRes Name="2306" Text="Language:"/>  <StrRes Name="2307" Text="Align"/>  <St'+
'rRes Name="2308" Text="Align Left"/>  <StrRes Name="2309" Text="Align Middle"/> '+
' <StrRes Name="2310" Text="Align Right"/>  <StrRes Name="2311" Text="Align Top"/'+
'>  <StrRes Name="2312" Text="Align Center"/>  <StrRes Name="2313" Text="Align Bo'+
'ttom"/>  <StrRes Name="2314" Text="Space Horizontally"/>  <StrRes Name="2315" Te'+
'xt="Space Vertically"/>  <StrRes Name="2316" Text="Center Horizontally in Band"/'+
'>  <StrRes Name="2317" Text="Center Vertically in Band"/>  <StrRes Name="2318" T'+
'ext="Same Width"/>  <StrRes Name="2319" Text="Same Height"/>  <StrRes Name="2320'+
'" Text="Text"/>  <StrRes Name="2321" Text="Style"/>  <StrRes Name="2322" Text="F'+
'ont Name"/>  <StrRes Name="2323" Text="Font Size"/>  <StrRes Name="2324" Text="B'+
'old"/>  <StrRes Name="2325" Text="Italic"/>  <StrRes Name="2326" Text="Underline'+
'"/>  <StrRes Name="2327" Text="Font Color"/>  <StrRes Name="2328" Text="Highligh'+
't"/>  <StrRes Name="2329" Text="Text Rotation"/>  <StrRes Name="2330" Text="Alig'+
'n Left"/>  <StrRes Name="2331" Text="Align Center"/>  <StrRes Name="2332" Text="'+
'Align Right"/>  <StrRes Name="2333" Text="Justify"/>  <StrRes Name="2334" Text="'+
'Align Top"/>  <StrRes Name="2335" Text="Align Middle"/>  <StrRes Name="2336" Tex'+
't="Align Bottom"/>  <StrRes Name="2337" Text="Frame"/>  <StrRes Name="2338" Text'+
'="Top Line"/>  <StrRes Name="2339" Text="Bottom Line"/>  <StrRes Name="2340" Tex'+
't="Left Line"/>  <StrRes Name="2341" Text="Right Line"/>  <StrRes Name="2342" Te'+
'xt="All Frame Lines"/>  <StrRes Name="2343" Text="No Frame"/>  <StrRes Name="234'+
'4" Text="Shadow"/>  <StrRes Name="2345" Text="Background Color"/>  <StrRes Name='+
'"2346" Text="Frame Color"/>  <StrRes Name="2347" Text="Frame Style"/>  <StrRes N'+
'ame="2348" Text="Frame Width"/>  <StrRes Name="2349" Text="Standard"/>  <StrRes '+
'Name="2350" Text="New Report"/>  <StrRes Name="2351" Text="Open Report"/>  <StrR'+
'es Name="2352" Text="Save Report"/>  <StrRes Name="2353" Text="Preview"/>  <StrR'+
'es Name="2354" Text="New Report Page"/>  <StrRes Name="2355" Text="New Dialog Pa'+
'ge"/>  <StrRes Name="2356" Text="Delete Page"/>  <StrRes Name="2357" Text="Page '+
'Settings"/>  <StrRes Name="2358" Text="Variables"/>  <StrRes Name="2359" Text="C'+
'ut"/>  <StrRes Name="2360" Text="Copy"/>  <StrRes Name="2361" Text="Paste"/>  <S'+
'trRes Name="2362" Text="Copy Formatting"/>  <StrRes Name="2363" Text="Undo"/>  <'+
'StrRes Name="2364" Text="Redo"/>  <StrRes Name="2365" Text="Group"/>  <StrRes Na'+
'me="2366" Text="Ungroup"/>  <StrRes Name="2367" Text="Show Grid"/>  <StrRes Name'+
'="2368" Text="Align to Grid"/>  <StrRes Name="2369" Text="Fit to Grid"/>  <StrRe'+
's Name="2370" Text="Zoom"/>  <StrRes Name="2371" Text="Extra Tools"/>  <StrRes N'+
'ame="2372" Text="Select Tool"/>  <StrRes Name="2373" Text="Hand Tool"/>  <StrRes'+
' Name="2374" Text="Zoom Tool"/>  <StrRes Name="2375" Text="Edit Text Tool"/>  <S'+
'trRes Name="2376" Text="Copy Format Tool"/>  <StrRes Name="2377" Text="Insert Ba'+
'nd"/>  <StrRes Name="2378" Text="&amp;File"/>  <StrRes Name="2379" Text="&amp;Ed'+
'it"/>  <StrRes Name="2380" Text="Find..."/>  <StrRes Name="2381" Text="Find Next'+
'"/>  <StrRes Name="2382" Text="Replace..."/>  <StrRes Name="2383" Text="&amp;Rep'+
'ort"/>  <StrRes Name="2384" Text="Data..."/>  <StrRes Name="2385" Text="Options.'+
'.."/>  <StrRes Name="2386" Text="Styles..."/>  <StrRes Name="2387" Text="&amp;Vi'+
'ew"/>  <StrRes Name="2388" Text="Toolbars"/>  <StrRes Name="2389" Text="Standard'+
'"/>  <StrRes Name="2390" Text="Text"/>  <StrRes Name="2391" Text="Frame"/>  <Str'+
'Res Name="2392" Text="Alignment Palette"/>  <StrRes Name="2393" Text="Extra Tool'+
's"/>  <StrRes Name="2394" Text="Object Inspector"/>  <StrRes Name="2395" Text="D'+
'ata Tree"/>  <StrRes Name="2396" Text="Report Tree"/>  <StrRes Name="2397" Text='+
'"Rulers"/>  <StrRes Name="2398" Text="Guides"/>  <StrRes Name="2399" Text="Delet'+
'e Guides"/>  <StrRes Name="2400" Text="Options..."/>  <StrRes Name="2401" Text="'+
'&amp;Help"/>  <StrRes Name="2402" Text="Help Contents..."/>  <StrRes Name="2403"'+
' Text="About FastReport..."/>  <StrRes Name="2404" Text="Tab Order..."/>  <StrRe'+
's Name="2405" Text="Undo"/>  <StrRes Name="2406" Text="Redo"/>  <StrRes Name="24'+
'07" Text="Cut"/>  <StrRes Name="2408" Text="Copy"/>  <StrRes Name="2409" Text="P'+
'aste"/>  <StrRes Name="2410" Text="Group"/>  <StrRes Name="2411" Text="Ungroup"/'+
'>  <StrRes Name="2412" Text="Delete"/>  <StrRes Name="2413" Text="Delete Page"/>'+
'  <StrRes Name="2414" Text="Select All"/>  <StrRes Name="2415" Text="Edit..."/> '+
' <StrRes Name="2416" Text="Bring to Front"/>  <StrRes Name="2417" Text="Send to '+
'Back"/>  <StrRes Name="2418" Text="New..."/>  <StrRes Name="2419" Text="New Repo'+
'rt"/>  <StrRes Name="2420" Text="New Page"/>  <StrRes Name="2421" Text="New Dial'+
'og"/>  <StrRes Name="2422" Text="Open..."/>  <StrRes Name="2423" Text="Save"/>  '+
'<StrRes Name="2424" Text="Save As..."/>  <StrRes Name="2425" Text="Variables..."'+
'/>  <StrRes Name="2426" Text="Page Settings..."/>  <StrRes Name="2427" Text="Pre'+
'view"/>  <StrRes Name="2428" Text="Exit"/>  <StrRes Name="2429" Text="Report Tit'+
'le"/>  <StrRes Name="2430" Text="Report Summary"/>  <StrRes Name="2431" Text="Pa'+
'ge Header"/>  <StrRes Name="2432" Text="Page Footer"/>  <StrRes Name="2433" Text'+
'="Header"/>  <StrRes Name="2434" Text="Footer"/>  <StrRes Name="2435" Text="Mast'+
'er Data"/>  <StrRes Name="2436" Text="Detail Data"/>  <StrRes Name="2437" Text="'+
'Subdetail Data"/>  <StrRes Name="2438" Text="Data 4th level"/>  <StrRes Name="24'+
'39" Text="Data 5th level"/>  <StrRes Name="2440" Text="Data 6th level"/>  <StrRe'+
's Name="2441" Text="Group Header"/>  <StrRes Name="2442" Text="Group Footer"/>  '+
'<StrRes Name="2443" Text="Child"/>  <StrRes Name="2444" Text="Column Header"/>  '+
'<StrRes Name="2445" Text="Column Footer"/>  <StrRes Name="2446" Text="Overlay"/>'+
'  <StrRes Name="2447" Text="Vertical bands"/>  <StrRes Name="2448" Text="Header"'+
'/>  <StrRes Name="2449" Text="Footer"/>  <StrRes Name="2450" Text="Master Data"/'+
'>  <StrRes Name="2451" Text="Detail Data"/>  <StrRes Name="2452" Text="Subdetail'+
' Data"/>  <StrRes Name="2453" Text="Group Header"/>  <StrRes Name="2454" Text="G'+
'roup Footer"/>  <StrRes Name="2455" Text="Child"/>  <StrRes Name="2456" Text="0бу'+
'"/>  <StrRes Name="2457" Text="45бу"/>  <StrRes Name="2458" Text="90бу"/>  <StrRes'+
' Name="2459" Text="180бу"/>  <StrRes Name="2460" Text="270бу"/>  <StrRes Name="246'+
'1" Text="Font Settings"/>  <StrRes Name="2462" Text="Bold"/>  <StrRes Name="2463'+
'" Text="Italic"/>  <StrRes Name="2464" Text="Underline"/>  <StrRes Name="2465" T'+
'ext="SuperScript"/>  <StrRes Name="2466" Text="SubScript"/>  <StrRes Name="2467"'+
' Text="Condensed"/>  <StrRes Name="2468" Text="Wide"/>  <StrRes Name="2469" Text'+
'="12 cpi"/>  <StrRes Name="2470" Text="15 cpi"/>  <StrRes Name="2471" Text="Repo'+
'rt (*.fr3)|*.fr3"/>  <StrRes Name="2472" Text="Pascal files (*.pas)|*.pas|C++ fi'+
'les (*.cpp)|*.cpp|JavaScript files (*.js)|*.js|Basic files (*.vb)|*.vb|All files'+
'|*.*"/>  <StrRes Name="2473" Text="Pascal files (*.pas)|*.pas|C++ files (*.cpp)|'+
'*.cpp|JavaScript files (*.js)|*.js|Basic files (*.vb)|*.vb|All files|*.*"/>  <St'+
'rRes Name="2474" Text="Connections..."/>  <StrRes Name="2475" Text="Language"/> '+
' <StrRes Name="2476" Text="Toggle breakpoint"/>  <StrRes Name="2477" Text="Run t'+
'o cursor"/>  <StrRes Name="2478" Text="!Add child band"/>  <StrRes Name="dsCm" T'+
'ext="Centimeters"/>  <StrRes Name="dsInch" Text="Inches"/>  <StrRes Name="dsPix"'+
' Text="Pixels"/>  <StrRes Name="dsChars" Text="Characters"/>  <StrRes Name="dsCo'+
'de" Text="Code"/>  <StrRes Name="dsData" Text="Data"/>  <StrRes Name="dsPage" Te'+
'xt="Page"/>  <StrRes Name="dsRepFilter" Text="Report (*.fr3)|*.fr3"/>  <StrRes N'+
'ame="dsComprRepFilter" Text="Compressed report (*.fr3)|*.fr3"/>  <StrRes Name="d'+
'sSavePreviewChanges" Text="Save changes to preview page?"/>  <StrRes Name="dsSav'+
'eChangesTo" Text="Save changes to "/>  <StrRes Name="dsCantLoad" Text="Couldn''t '+
'load file"/>  <StrRes Name="dsStyleFile" Text="Style"/>  <StrRes Name="dsCantFin'+
'dProc" Text="Could not locate the main proc"/>  <StrRes Name="dsClearScript" Tex'+
't="This will clear all code. Do you want to continue?"/>  <StrRes Name="dsNoStyl'+
'e" Text="No style"/>  <StrRes Name="dsStyleSample" Text="Style sample"/>  <StrRe'+
's Name="dsTextNotFound" Text="Text ''%s'' not found"/>  <StrRes Name="dsReplace" T'+
'ext="Replace this occurence of ''%s''?"/>  <StrRes Name="2600" Text="About FastRep'+
'ort"/>  <StrRes Name="2601" Text="Visit our webpage for more info:"/>  <StrRes N'+
'ame="2602" Text="Sales:"/>  <StrRes Name="2603" Text="Support:"/>  <StrRes Name='+
'"2700" Text="Page Options"/>  <StrRes Name="2701" Text="Paper"/>  <StrRes Name="'+
'2702" Text="Width"/>  <StrRes Name="2703" Text="Height"/>  <StrRes Name="2704" T'+
'ext="Size"/>  <StrRes Name="2705" Text="Orientation"/>  <StrRes Name="2706" Text'+
'="Left"/>  <StrRes Name="2707" Text="Top"/>  <StrRes Name="2708" Text="Right"/> '+
' <StrRes Name="2709" Text="Bottom"/>  <StrRes Name="2710" Text="Margins"/>  <Str'+
'Res Name="2711" Text="Paper Source"/>  <StrRes Name="2712" Text="First page"/>  '+
'<StrRes Name="2713" Text="Other pages"/>  <StrRes Name="2714" Text="Portrait"/> '+
' <StrRes Name="2715" Text="Landscape"/>  <StrRes Name="2716" Text="Other options'+
'"/>  <StrRes Name="2717" Text="Columns"/>  <StrRes Name="2718" Text="Number"/>  '+
'<StrRes Name="2719" Text="Width"/>  <StrRes Name="2720" Text="Positions"/>  <Str'+
'Res Name="2721" Text="Other"/>  <StrRes Name="2722" Text="Duplex"/>  <StrRes Nam'+
'e="2723" Text="Print to previous page"/>  <StrRes Name="2724" Text="Mirror margi'+
'ns"/>  <StrRes Name="2725" Text="Large height in design mode"/>  <StrRes Name="2'+
'726" Text="Endless page width"/>  <StrRes Name="2727" Text="Endless page height"'+
'/>  <StrRes Name="2800" Text="Select Report Datasets"/>  <StrRes Name="2900" Tex'+
't="Edit Variables"/>  <StrRes Name="2901" Text="Category"/>  <StrRes Name="2902"'+
' Text="Variable"/>  <StrRes Name="2903" Text="Edit"/>  <StrRes Name="2904" Text='+
'"Delete"/>  <StrRes Name="2905" Text="List"/>  <StrRes Name="2906" Text="Load"/>'+
'  <StrRes Name="2907" Text="Save"/>  <StrRes Name="2908" Text="Expression:"/>  <'+
'StrRes Name="2909" Text="Dictionary (*.fd3)|*.fd3"/>  <StrRes Name="2910" Text="'+
'Dictionary (*.fd3)|*.fd3"/>  <StrRes Name="vaNoVar" Text="(no variables defined)'+
'"/>  <StrRes Name="vaVar" Text="Variables"/>  <StrRes Name="vaDupName" Text="Dup'+
'licate name"/>  <StrRes Name="3000" Text="Designer Options"/>  <StrRes Name="300'+
'1" Text="Grid"/>  <StrRes Name="3002" Text="Type"/>  <StrRes Name="3003" Text="S'+
'ize"/>  <StrRes Name="3004" Text="Dialog form:"/>  <StrRes Name="3005" Text="Oth'+
'er"/>  <StrRes Name="3006" Text="Fonts"/>  <StrRes Name="3007" Text="Code window'+
'"/>  <StrRes Name="3008" Text="Memo editor"/>  <StrRes Name="3009" Text="Size"/>'+
'  <StrRes Name="3010" Text="Size"/>  <StrRes Name="3011" Text="Colors"/>  <StrRe'+
's Name="3012" Text="Gap between bands:"/>  <StrRes Name="3013" Text="cm"/>  <Str'+
'Res Name="3014" Text="in"/>  <StrRes Name="3015" Text="pt"/>  <StrRes Name="3016'+
'" Text="pt"/>  <StrRes Name="3017" Text="pt"/>  <StrRes Name="3018" Text="Centim'+
'eters:"/>  <StrRes Name="3019" Text="Inches:"/>  <StrRes Name="3020" Text="Pixel'+
's:"/>  <StrRes Name="3021" Text="Show grid"/>  <StrRes Name="3022" Text="Align t'+
'o Grid"/>  <StrRes Name="3023" Text="Show editor after insert"/>  <StrRes Name="'+
'3024" Text="Use object''s font settings"/>  <StrRes Name="3025" Text="Workspace"/'+
'>  <StrRes Name="3026" Text="Tool windows"/>  <StrRes Name="3027" Text="LCD grid'+
' color"/>  <StrRes Name="3028" Text="Free bands placement"/>  <StrRes Name="3029'+
'" Text="Show drop-down fields list"/>  <StrRes Name="3030" Text="Show startup sc'+
'reen"/>  <StrRes Name="3031" Text="Restore defaults"/>  <StrRes Name="3032" Text'+
'="Show band captions"/>  <StrRes Name="3100" Text="Select DataSet"/>  <StrRes Na'+
'me="3101" Text="Number of records:"/>  <StrRes Name="dbNotAssigned" Text="[not a'+
'ssigned]"/>  <StrRes Name="3200" Text="Group"/>  <StrRes Name="3201" Text="Break'+
' on"/>  <StrRes Name="3202" Text="Options"/>  <StrRes Name="3203" Text="Data fie'+
'ld"/>  <StrRes Name="3204" Text="Expression"/>  <StrRes Name="3205" Text="Keep g'+
'roup together"/>  <StrRes Name="3206" Text="Start new page"/>  <StrRes Name="320'+
'7" Text="Show in outline"/>  <StrRes Name="3300" Text="System Memo"/>  <StrRes N'+
'ame="3301" Text="Data band"/>  <StrRes Name="3302" Text="DataSet"/>  <StrRes Nam'+
'e="3303" Text="DataField"/>  <StrRes Name="3304" Text="Function"/>  <StrRes Name'+
'="3305" Text="Expression"/>  <StrRes Name="3306" Text="Aggregate value"/>  <StrR'+
'es Name="3307" Text="System variable"/>  <StrRes Name="3308" Text="Count invisib'+
'le bands"/>  <StrRes Name="3309" Text="Text"/>  <StrRes Name="3310" Text="Runnin'+
'g total"/>  <StrRes Name="agAggregate" Text="Insert Aggregate"/>  <StrRes Name="'+
'vt1" Text="[DATE]"/>  <StrRes Name="vt2" Text="[TIME]"/>  <StrRes Name="vt3" Tex'+
't="[PAGE#]"/>  <StrRes Name="vt4" Text="[TOTALPAGES#]"/>  <StrRes Name="vt5" Tex'+
't="[PAGE#] of [TOTALPAGES#]"/>  <StrRes Name="vt6" Text="[LINE#]"/>  <StrRes Nam'+
'e="3400" Text="OLE object"/>  <StrRes Name="3401" Text="Insert..."/>  <StrRes Na'+
'me="3402" Text="Edit..."/>  <StrRes Name="3403" Text="Close"/>  <StrRes Name="ol'+
'Stretched" Text="Stretched"/>  <StrRes Name="3500" Text="Barcode Editor"/>  <Str'+
'Res Name="3501" Text="Code"/>  <StrRes Name="3502" Text="Type of Bar"/>  <StrRes'+
' Name="3503" Text="Zoom:"/>  <StrRes Name="3504" Text="Options"/>  <StrRes Name='+
'"3505" Text="Rotation"/>  <StrRes Name="3506" Text="Calc Checksum"/>  <StrRes Na'+
'me="3507" Text="Text"/>  <StrRes Name="3508" Text="0бу"/>  <StrRes Name="3509" Te'+
'xt="90бу"/>  <StrRes Name="3510" Text="180бу"/>  <StrRes Name="3511" Text="270бу"/>'+
'  <StrRes Name="bcCalcChecksum" Text="Calc Checksum"/>  <StrRes Name="bcShowText'+
'" Text="Show Text"/>  <StrRes Name="3600" Text="Edit Aliases"/>  <StrRes Name="3'+
'601" Text="Press Enter to edit item"/>  <StrRes Name="3602" Text="Dataset alias"'+
'/>  <StrRes Name="3603" Text="Field aliases"/>  <StrRes Name="3604" Text="Reset"'+
'/>  <StrRes Name="3605" Text="Update"/>  <StrRes Name="alUserName" Text="User na'+
'me"/>  <StrRes Name="alOriginal" Text="Original name"/>  <StrRes Name="3700" Tex'+
't="Parameters Editor"/>  <StrRes Name="qpName" Text="Name"/>  <StrRes Name="qpDa'+
'taType" Text="Data Type"/>  <StrRes Name="qpValue" Text="Value"/>  <StrRes Name='+
'"3800" Text="Master-Detail Link"/>  <StrRes Name="3801" Text="Detail fields"/>  '+
'<StrRes Name="3802" Text="Master fields"/>  <StrRes Name="3803" Text="Linked fie'+
'lds"/>  <StrRes Name="3804" Text="Add"/>  <StrRes Name="3805" Text="Clear"/>  <S'+
'trRes Name="3900" Text="Memo"/>  <StrRes Name="3901" Text="Insert Expression"/> '+
' <StrRes Name="3902" Text="Insert Aggregate"/>  <StrRes Name="3903" Text="Insert'+
' Formatting"/>  <StrRes Name="3904" Text="Word Wrap"/>  <StrRes Name="3905" Text'+
'="Text"/>  <StrRes Name="3906" Text="Format"/>  <StrRes Name="3907" Text="Highli'+
'ght"/>  <StrRes Name="4000" Text="Picture"/>  <StrRes Name="4001" Text="Load"/> '+
' <StrRes Name="4002" Text="Copy"/>  <StrRes Name="4003" Text="Paste"/>  <StrRes '+
'Name="4004" Text="Clear"/>  <StrRes Name="piEmpty" Text="Empty"/>  <StrRes Name='+
'"4100" Text="Chart Editor"/>  <StrRes Name="4101" Text="Add Series"/>  <StrRes N'+
'ame="4102" Text="Delete Series"/>  <StrRes Name="4103" Text="Edit Chart"/>  <Str'+
'Res Name="4104" Text="Band source"/>  <StrRes Name="4105" Text="Fixed data"/>  <'+
'StrRes Name="4106" Text="DataSet"/>  <StrRes Name="4107" Text="Data Source"/>  <'+
'StrRes Name="4108" Text="Values"/>  <StrRes Name="4109" Text="Select the chart s'+
'eries or add a new one."/>  <StrRes Name="4114" Text="Other options"/>  <StrRes '+
'Name="4115" Text="TopN values"/>  <StrRes Name="4116" Text="TopN caption"/>  <St'+
'rRes Name="4117" Text="Sort order"/>  <StrRes Name="4126" Text="X Axis"/>  <StrR'+
'es Name="ch3D" Text="3D View"/>  <StrRes Name="chAxis" Text="Show Axis"/>  <StrR'+
'es Name="chsoNone" Text="None"/>  <StrRes Name="chsoAscending" Text="Ascending"/'+
'>  <StrRes Name="chsoDescending" Text="Descending"/>  <StrRes Name="chxtText" Te'+
'xt="Text"/>  <StrRes Name="chxtNumber" Text="Numeric"/>  <StrRes Name="chxtDate"'+
' Text="Date"/>  <StrRes Name="4200" Text="Rich Editor"/>  <StrRes Name="4201" Te'+
'xt="Open File"/>  <StrRes Name="4202" Text="Save File"/>  <StrRes Name="4203" Te'+
'xt="Undo"/>  <StrRes Name="4204" Text="Font"/>  <StrRes Name="4205" Text="Insert'+
' Expression"/>  <StrRes Name="4206" Text="Bold"/>  <StrRes Name="4207" Text="Ita'+
'lic"/>  <StrRes Name="4208" Text="Underline"/>  <StrRes Name="4209" Text="Left A'+
'lign"/>  <StrRes Name="4210" Text="Center Align"/>  <StrRes Name="4211" Text="Ri'+
'ght Align"/>  <StrRes Name="4212" Text="Justify"/>  <StrRes Name="4213" Text="Bu'+
'llets"/>  <StrRes Name="4300" Text="Cross-tab Editor"/>  <StrRes Name="4301" Tex'+
't="Source data"/>  <StrRes Name="4302" Text="Dimensions"/>  <StrRes Name="4303" '+
'Text="Rows"/>  <StrRes Name="4304" Text="Columns"/>  <StrRes Name="4305" Text="C'+
'ells"/>  <StrRes Name="4306" Text="Cross-tab structure"/>  <StrRes Name="4307" T'+
'ext="Row header"/>  <StrRes Name="4308" Text="Column header"/>  <StrRes Name="43'+
'09" Text="Row grand total"/>  <StrRes Name="4310" Text="Column grand total"/>  <'+
'StrRes Name="4311" Text="Swap rows/columns"/>  <StrRes Name="4312" Text="!Select'+
' style"/>  <StrRes Name="4313" Text="!Save current style..."/>  <StrRes Name="43'+
'14" Text="!Show title"/>  <StrRes Name="4315" Text="!Show corner"/>  <StrRes Nam'+
'e="4316" Text="!Reprint headers on new page"/>  <StrRes Name="4317" Text="!Auto '+
'size"/>  <StrRes Name="4318" Text="!Border around cells"/>  <StrRes Name="4319" '+
'Text="!Print down then across"/>  <StrRes Name="4320" Text="!Side-by-side cells"'+
'/>  <StrRes Name="4321" Text="!Join equal cells"/>  <StrRes Name="4322" Text="No'+
'ne"/>  <StrRes Name="4323" Text="Sum"/>  <StrRes Name="4324" Text="Min"/>  <StrR'+
'es Name="4325" Text="Max"/>  <StrRes Name="4326" Text="Average"/>  <StrRes Name='+
'"4327" Text="Count"/>  <StrRes Name="4328" Text="Ascending (A-Z)"/>  <StrRes Nam'+
'e="4329" Text="Descending (Z-A)"/>  <StrRes Name="4330" Text="No Sort"/>  <StrRe'+
's Name="crStName" Text="!Enter the style name:"/>  <StrRes Name="crResize" Text='+
'"!To resize a cross-tab, set its &#38;#34;AutoSize&#38;#34; property to False."/'+
'>  <StrRes Name="crSubtotal" Text="Subtotal"/>  <StrRes Name="crNone" Text="None'+
'"/>  <StrRes Name="crSum" Text="Sum"/>  <StrRes Name="crMin" Text="Min"/>  <StrR'+
'es Name="crMax" Text="Max"/>  <StrRes Name="crAvg" Text="Avg"/>  <StrRes Name="c'+
'rCount" Text="Count"/>  <StrRes Name="crAsc" Text="A-Z"/>  <StrRes Name="crDesc"'+
' Text="Z-A"/>  <StrRes Name="4400" Text="Expression Editor"/>  <StrRes Name="440'+
'1" Text="Expression:"/>  <StrRes Name="4500" Text="Display Format"/>  <StrRes Na'+
'me="4501" Text="Category"/>  <StrRes Name="4502" Text="Format"/>  <StrRes Name="'+
'4503" Text="Format string:"/>  <StrRes Name="4504" Text="Decimal separator:"/>  '+
'<StrRes Name="fkText" Text="Text (no formatting)"/>  <StrRes Name="fkNumber" Tex'+
't="Number"/>  <StrRes Name="fkDateTime" Text="Date/Time"/>  <StrRes Name="fkBool'+
'ean" Text="Boolean"/>  <StrRes Name="fkNumber1" Text="1234.5;%g"/>  <StrRes Name'+
'="fkNumber2" Text="1234.50;%2.2f"/>  <StrRes Name="fkNumber3" Text="1,234.50;%2.'+
'2n"/>  <StrRes Name="fkNumber4" Text="$1,234.50;%2.2m"/>  <StrRes Name="fkDateTi'+
'me1" Text="11.28.2002;mm.dd.yyyy"/>  <StrRes Name="fkDateTime2" Text="28 nov 200'+
'2;dd mmm yyyy"/>  <StrRes Name="fkDateTime3" Text="November 28, 2002;mmmm dd, yy'+
'yy"/>  <StrRes Name="fkDateTime4" Text="02:14;hh:mm"/>  <StrRes Name="fkDateTime'+
'5" Text="02:14am;hh:mm am/pm"/>  <StrRes Name="fkDateTime6" Text="02:14:00;hh:mm'+
':ss"/>  <StrRes Name="fkDateTime7" Text="02:14am, November 28, 2002;hh:mm am/pm,'+
' mmmm dd, yyyy"/>  <StrRes Name="fkBoolean1" Text="0,1;0,1"/>  <StrRes Name="fkB'+
'oolean2" Text="No,Yes;No,Yes"/>  <StrRes Name="fkBoolean3" Text="_,x;_,x"/>  <St'+
'rRes Name="fkBoolean4" Text="False,True;False,True"/>  <StrRes Name="4600" Text='+
'"Highlight"/>  <StrRes Name="4601" Text="Color..."/>  <StrRes Name="4602" Text="'+
'Color..."/>  <StrRes Name="4603" Text="Condition"/>  <StrRes Name="4604" Text="F'+
'ont"/>  <StrRes Name="4605" Text="Background"/>  <StrRes Name="4606" Text="Bold"'+
'/>  <StrRes Name="4607" Text="Italic"/>  <StrRes Name="4608" Text="Underline"/> '+
' <StrRes Name="4609" Text="Transparent"/>  <StrRes Name="4610" Text="Other"/>  <'+
'StrRes Name="4700" Text="Report Settings"/>  <StrRes Name="4701" Text="General"/'+
'>  <StrRes Name="4702" Text="Printer settings"/>  <StrRes Name="4703" Text="Copi'+
'es"/>  <StrRes Name="4704" Text="General"/>  <StrRes Name="4705" Text="Password"'+
'/>  <StrRes Name="4706" Text="Collate copies"/>  <StrRes Name="4707" Text="Doubl'+
'e pass"/>  <StrRes Name="4708" Text="Print if empty"/>  <StrRes Name="4709" Text'+
'="Description"/>  <StrRes Name="4710" Text="Name"/>  <StrRes Name="4711" Text="D'+
'escription"/>  <StrRes Name="4712" Text="Picture"/>  <StrRes Name="4713" Text="A'+
'uthor"/>  <StrRes Name="4714" Text="Major"/>  <StrRes Name="4715" Text="Minor"/>'+
'  <StrRes Name="4716" Text="Release"/>  <StrRes Name="4717" Text="Build"/>  <Str'+
'Res Name="4718" Text="Created"/>  <StrRes Name="4719" Text="Modified"/>  <StrRes'+
' Name="4720" Text="Description"/>  <StrRes Name="4721" Text="Version"/>  <StrRes'+
' Name="4722" Text="Browse..."/>  <StrRes Name="4723" Text="Inheritance settings"'+
'/>  <StrRes Name="4724" Text="Select the option:"/>  <StrRes Name="4725" Text="D'+
'on''t change"/>  <StrRes Name="4726" Text="Detach the base report"/>  <StrRes Nam'+
'e="4727" Text="Inherit from base report:"/>  <StrRes Name="4728" Text="Inheritan'+
'ce"/>  <StrRes Name="4729" Text="Templates path :"/>  <StrRes Name="rePrnOnPort"'+
' Text="on"/>  <StrRes Name="riNotInherited" Text="This report is not inherited."'+
'/>  <StrRes Name="riInherited" Text="This report is inherited from base report: '+
'%s"/>  <StrRes Name="4800" Text="Lines"/>  <StrRes Name="4900" Text="SQL"/>  <St'+
'rRes Name="4901" Text="Query Builder"/>  <StrRes Name="5000" Text="Password"/>  '+
'<StrRes Name="5001" Text="Enter the password:"/>  <StrRes Name="5100" Text="Styl'+
'e Editor"/>  <StrRes Name="5101" Text="Color..."/>  <StrRes Name="5102" Text="Fo'+
'nt..."/>  <StrRes Name="5103" Text="Frame..."/>  <StrRes Name="5104" Text="Add"/'+
'>  <StrRes Name="5105" Text="Delete"/>  <StrRes Name="5106" Text="Edit"/>  <StrR'+
'es Name="5107" Text="Load"/>  <StrRes Name="5108" Text="Save"/>  <StrRes Name="5'+
'200" Text="Frame Editor"/>  <StrRes Name="5201" Text="Frame"/>  <StrRes Name="52'+
'02" Text="Frame line"/>  <StrRes Name="5203" Text="Shadow"/>  <StrRes Name="5204'+
'" Text="Top Line"/>  <StrRes Name="5205" Text="Bottom Line"/>  <StrRes Name="520'+
'6" Text="Left Line"/>  <StrRes Name="5207" Text="Right Line"/>  <StrRes Name="52'+
'08" Text="All Frame Lines"/>  <StrRes Name="5209" Text="No Frame"/>  <StrRes Nam'+
'e="5210" Text="Frame Color"/>  <StrRes Name="5211" Text="Frame Style"/>  <StrRes'+
' Name="5212" Text="Frame Width"/>  <StrRes Name="5213" Text="Shadow"/>  <StrRes '+
'Name="5214" Text="Shadow Color"/>  <StrRes Name="5215" Text="Shadow Width"/>  <S'+
'trRes Name="5300" Text="New Item"/>  <StrRes Name="5301" Text="Items"/>  <StrRes'+
' Name="5302" Text="Templates"/>  <StrRes Name="5303" Text="Inherit the report"/>'+
'  <StrRes Name="5400" Text="Tab Order"/>  <StrRes Name="5401" Text="Controls lis'+
'ted in tab order:"/>  <StrRes Name="5402" Text="Move Up"/>  <StrRes Name="5403" '+
'Text="Move Down"/>  <StrRes Name="5500" Text="Evaluate"/>  <StrRes Name="5501" T'+
'ext="Expression"/>  <StrRes Name="5502" Text="Result"/>  <StrRes Name="5600" Tex'+
't="Report Wizard"/>  <StrRes Name="5601" Text="Data"/>  <StrRes Name="5602" Text'+
'="Fields"/>  <StrRes Name="5603" Text="Groups"/>  <StrRes Name="5604" Text="Layo'+
'ut"/>  <StrRes Name="5605" Text="Style"/>  <StrRes Name="5606" Text="Step 1. Sel'+
'ect the dataset."/>  <StrRes Name="5607" Text="Step 2. Select the fields to disp'+
'lay."/>  <StrRes Name="5608" Text="Step 3. Create groups (optional)."/>  <StrRes'+
' Name="5609" Text="Step 4. Define the page orientation and data layout."/>  <Str'+
'Res Name="5610" Text="Step 5. Choose the report style."/>  <StrRes Name="5611" T'+
'ext="Add &#62;"/>  <StrRes Name="5612" Text="Add all &#62;&#62;"/>  <StrRes Name'+
'="5613" Text="&#60; Remove"/>  <StrRes Name="5614" Text="&#60;&#60; Remove all"/'+
'>  <StrRes Name="5615" Text="Add &#62;"/>  <StrRes Name="5616" Text="&#60; Remov'+
'e"/>  <StrRes Name="5617" Text="Selected fields:"/>  <StrRes Name="5618" Text="A'+
'vailable fields:"/>  <StrRes Name="5619" Text="Groups:"/>  <StrRes Name="5620" T'+
'ext="Orientation"/>  <StrRes Name="5621" Text="Layout"/>  <StrRes Name="5622" Te'+
'xt="Portrait"/>  <StrRes Name="5623" Text="Landscape"/>  <StrRes Name="5624" Tex'+
't="Tabular"/>  <StrRes Name="5625" Text="Columnar"/>  <StrRes Name="5626" Text="'+
'Fit fields to page width"/>  <StrRes Name="5627" Text="&#60;&#60; Back"/>  <StrR'+
'es Name="5628" Text="Next &#62;&#62;"/>  <StrRes Name="5629" Text="Finish"/>  <S'+
'trRes Name="5630" Text="New table..."/>  <StrRes Name="5631" Text="New query..."'+
'/>  <StrRes Name="5632" Text="Select database connection:"/>  <StrRes Name="5633'+
'" Text="Select a table:"/>  <StrRes Name="5634" Text="or"/>  <StrRes Name="5635"'+
' Text="Create a query..."/>  <StrRes Name="5636" Text="Configure connections"/> '+
' <StrRes Name="wzStd" Text="Standard Report Wizard"/>  <StrRes Name="wzDMP" Text'+
'="Dot-Matrix Report Wizard"/>  <StrRes Name="wzStdEmpty" Text="Standard Report"/'+
'>  <StrRes Name="wzDMPEmpty" Text="Dot-Matrix Report"/>  <StrRes Name="5700" Tex'+
't="Connection Wizard"/>  <StrRes Name="5701" Text="Connection"/>  <StrRes Name="'+
'5702" Text="Choose the connection type:"/>  <StrRes Name="5703" Text="Choose the'+
' database:"/>  <StrRes Name="5704" Text="Login"/>  <StrRes Name="5705" Text="Pas'+
'sword"/>  <StrRes Name="5706" Text="Prompt login"/>  <StrRes Name="5707" Text="U'+
'se login/password:"/>  <StrRes Name="5708" Text="Table"/>  <StrRes Name="5709" T'+
'ext="Choose the table name:"/>  <StrRes Name="5710" Text="Filter records:"/>  <S'+
'trRes Name="5711" Text="Query"/>  <StrRes Name="5712" Text="SQL statement:"/>  <'+
'StrRes Name="5713" Text="Query Builder"/>  <StrRes Name="5714" Text="Edit Query '+
'Parameters"/>  <StrRes Name="ftAllFiles" Text="All Files"/>  <StrRes Name="ftPic'+
'tures" Text="Pictures"/>  <StrRes Name="ftDB" Text="Databases"/>  <StrRes Name="'+
'ftRichFile" Text="RichText file"/>  <StrRes Name="ftTextFile" Text="Text file"/>'+
'  <StrRes Name="prNotAssigned" Text="(Not assigned)"/>  <StrRes Name="prInvProp"'+
' Text="Invalid property value"/>  <StrRes Name="prDupl" Text="Duplicate name"/> '+
' <StrRes Name="prPict" Text="(Picture)"/>  <StrRes Name="mvExpr" Text="Allow Exp'+
'ressions"/>  <StrRes Name="mvStretch" Text="Stretch"/>  <StrRes Name="mvStretchT'+
'oMax" Text="Stretch to Max Height"/>  <StrRes Name="mvShift" Text="Shift"/>  <St'+
'rRes Name="mvShiftOver" Text="Shift When Overlapped"/>  <StrRes Name="mvVisible"'+
' Text="Visible"/>  <StrRes Name="mvPrintable" Text="Printable"/>  <StrRes Name="'+
'mvFont" Text="Font..."/>  <StrRes Name="mvFormat" Text="Display Format..."/>  <S'+
'trRes Name="mvClear" Text="Clear Contents"/>  <StrRes Name="mvAutoWidth" Text="A'+
'uto Width"/>  <StrRes Name="mvWWrap" Text="Word Wrap"/>  <StrRes Name="mvSuppres'+
's" Text="Suppress Repeated Values"/>  <StrRes Name="mvHideZ" Text="Hide Zeros"/>'+
'  <StrRes Name="mvHTML" Text="Allow HTML Tags"/>  <StrRes Name="lvDiagonal" Text'+
'="Diagonal"/>  <StrRes Name="pvAutoSize" Text="Auto Size"/>  <StrRes Name="pvCen'+
'ter" Text="Center"/>  <StrRes Name="pvAspect" Text="Keep Aspect Ratio"/>  <StrRe'+
's Name="bvSplit" Text="Allow Split"/>  <StrRes Name="bvKeepChild" Text="Keep Chi'+
'ld Together"/>  <StrRes Name="bvPrintChild" Text="Print Child If Invisible"/>  <'+
'StrRes Name="bvStartPage" Text="Start New Page"/>  <StrRes Name="bvPrintIfEmpty"'+
' Text="Print If Detail Empty"/>  <StrRes Name="bvKeepDetail" Text="Keep Detail T'+
'ogether"/>  <StrRes Name="bvKeepFooter" Text="Keep Footer Together"/>  <StrRes N'+
'ame="bvReprint" Text="Reprint On New Page"/>  <StrRes Name="bvOnFirst" Text="Pri'+
'nt On First Page"/>  <StrRes Name="bvOnLast" Text="Print On Last Page"/>  <StrRe'+
's Name="bvKeepGroup" Text="Keep Together"/>  <StrRes Name="bvFooterAfterEach" Te'+
'xt="Footer After Each Row"/>  <StrRes Name="bvDrillDown" Text="Drill-Down"/>  <S'+
'trRes Name="bvResetPageNo" Text="Reset Page Numbers"/>  <StrRes Name="srParent" '+
'Text="Print On Parent"/>  <StrRes Name="bvKeepHeader" Text="Keep Header Together'+
'"/>  <StrRes Name="obCatDraw" Text="Draw"/>  <StrRes Name="obCatOther" Text="Oth'+
'er objects"/>  <StrRes Name="obCatOtherControls" Text="Other controls"/>  <StrRe'+
's Name="obDiagLine" Text="Diagonal line"/>  <StrRes Name="obRect" Text="Rectangl'+
'e"/>  <StrRes Name="obRoundRect" Text="Rounded rectangle"/>  <StrRes Name="obEll'+
'ipse" Text="Ellipse"/>  <StrRes Name="obTrian" Text="Triangle"/>  <StrRes Name="'+
'obDiamond" Text="Diamond"/>  <StrRes Name="obLabel" Text="Label control"/>  <Str'+
'Res Name="obEdit" Text="Edit control"/>  <StrRes Name="obMemoC" Text="Memo contr'+
'ol"/>  <StrRes Name="obButton" Text="Button control"/>  <StrRes Name="obChBoxC" '+
'Text="CheckBox control"/>  <StrRes Name="obRButton" Text="RadioButton control"/>'+
'  <StrRes Name="obLBox" Text="ListBox control"/>  <StrRes Name="obCBox" Text="Co'+
'mboBox control"/>  <StrRes Name="obDateEdit" Text="DateEdit control"/>  <StrRes '+
'Name="obImageC" Text="Image control"/>  <StrRes Name="obPanel" Text="Panel contr'+
'ol"/>  <StrRes Name="obGrBox" Text="GroupBox control"/>  <StrRes Name="obBBtn" T'+
'ext="BitBtn control"/>  <StrRes Name="obSBtn" Text="SpeedButton control"/>  <Str'+
'Res Name="obMEdit" Text="MaskEdit control"/>  <StrRes Name="obChLB" Text="CheckL'+
'istBox control"/>  <StrRes Name="obDBLookup" Text="DBLookupComboBox control"/>  '+
'<StrRes Name="obBevel" Text="Bevel object"/>  <StrRes Name="obShape" Text="Shape'+
' object"/>  <StrRes Name="obText" Text="Text object"/>  <StrRes Name="obSysText"'+
' Text="System text"/>  <StrRes Name="obLine" Text="Line object"/>  <StrRes Name='+
'"obPicture" Text="Picture object"/>  <StrRes Name="obBand" Text="Band object"/> '+
' <StrRes Name="obDataBand" Text="Data band"/>  <StrRes Name="obSubRep" Text="Sub'+
'report object"/>  <StrRes Name="obDlgPage" Text="Dialog form"/>  <StrRes Name="o'+
'bRepPage" Text="Report page"/>  <StrRes Name="obReport" Text="Report object"/>  '+
'<StrRes Name="obRich" Text="RichText object"/>  <StrRes Name="obOLE" Text="OLE o'+
'bject"/>  <StrRes Name="obChBox" Text="CheckBox object"/>  <StrRes Name="obChart'+
'" Text="Chart object"/>  <StrRes Name="obBarC" Text="Barcode object"/>  <StrRes '+
'Name="obCross" Text="Cross-tab object"/>  <StrRes Name="obDBCross" Text="DB Cros'+
's-tab object"/>  <StrRes Name="obGrad" Text="Gradient object"/>  <StrRes Name="o'+
'bDMPText" Text="Dot-matrix Text object"/>  <StrRes Name="obDMPLine" Text="Dot-ma'+
'trix Line object"/>  <StrRes Name="obDMPCmd" Text="Dot-matrix Command object"/> '+
' <StrRes Name="obBDEDB" Text="BDE Database"/>  <StrRes Name="obBDETb" Text="BDE '+
'Table"/>  <StrRes Name="obBDEQ" Text="BDE Query"/>  <StrRes Name="obBDEComps" Te'+
'xt="BDE components"/>  <StrRes Name="obIBXDB" Text="IBX Database"/>  <StrRes Nam'+
'e="obIBXTb" Text="IBX Table"/>  <StrRes Name="obIBXQ" Text="IBX Query"/>  <StrRe'+
's Name="obIBXComps" Text="IBX Components"/>  <StrRes Name="obADODB" Text="ADO Da'+
'tabase"/>  <StrRes Name="obADOTb" Text="ADO Table"/>  <StrRes Name="obADOQ" Text'+
'="ADO Query"/>  <StrRes Name="obADOComps" Text="ADO Components"/>  <StrRes Name='+
'"obDBXDB" Text="DBX Database"/>  <StrRes Name="obDBXTb" Text="DBX Table"/>  <Str'+
'Res Name="obDBXQ" Text="DBX Query"/>  <StrRes Name="obDBXComps" Text="DBX Compon'+
'ents"/>  <StrRes Name="obFIBDB" Text="FIB Database"/>  <StrRes Name="obFIBTb" Te'+
'xt="FIB Table"/>  <StrRes Name="obFIBQ" Text="FIB Query"/>  <StrRes Name="obFIBC'+
'omps" Text="FIB Components"/>  <StrRes Name="obDataBases" Text="DataBases"/>  <S'+
'trRes Name="obTables" Text="Tables"/>  <StrRes Name="obQueries" Text="Queries"/>'+
'  <StrRes Name="ctString" Text="String"/>  <StrRes Name="ctDate" Text="Date and '+
'Time"/>  <StrRes Name="ctConv" Text="Conversions"/>  <StrRes Name="ctFormat" Tex'+
't="Formatting"/>  <StrRes Name="ctMath" Text="Mathematical"/>  <StrRes Name="ctO'+
'ther" Text="Other"/>  <StrRes Name="IntToStr" Text="Converts an integer value to'+
' a string"/>  <StrRes Name="FloatToStr" Text="Converts a float value to a string'+
'"/>  <StrRes Name="DateToStr" Text="Converts a date to a string"/>  <StrRes Name'+
'="TimeToStr" Text="Converts a time to a string"/>  <StrRes Name="DateTimeToStr" '+
'Text="Converts a date-and-time value to a string"/>  <StrRes Name="VarToStr" Tex'+
't="Converts a variant value to a string"/>  <StrRes Name="StrToInt" Text="Conver'+
'ts a string to an integer value"/>  <StrRes Name="StrToInt64" Text="Converts a s'+
'tring to an Int64 value"/>  <StrRes Name="StrToFloat" Text="Converts a string to'+
' a floating-point value"/>  <StrRes Name="StrToDate" Text="Converts a string to '+
'a date format"/>  <StrRes Name="StrToTime" Text="Converts a string to a time for'+
'mat"/>  <StrRes Name="StrToDateTime" Text="Converts a string to a date-and-time '+
'format"/>  <StrRes Name="Format" Text="Returns formatted string assembled from a'+
' series of array arguments"/>  <StrRes Name="FormatFloat" Text="Formats a floati'+
'ng-point value"/>  <StrRes Name="FormatDateTime" Text="Formats a date-and-time v'+
'alue"/>  <StrRes Name="FormatMaskText" Text="Returns a string formatted using an'+
' edit mask"/>  <StrRes Name="EncodeDate" Text="Returns a TDateTime type for a sp'+
'ecified Year, Month, and Day"/>  <StrRes Name="DecodeDate" Text="Breaks TDateTim'+
'e into Year, Month, and Day values"/>  <StrRes Name="EncodeTime" Text="Returns a'+
' TDateTime type for a specified Hour, Min, Sec, and MSec"/>  <StrRes Name="Decod'+
'eTime" Text="Breaks TDateTime into hours, minutes, seconds, and milliseconds"/> '+
' <StrRes Name="Date" Text="Returns current date"/>  <StrRes Name="Time" Text="Re'+
'turns current time"/>  <StrRes Name="Now" Text="Return current date and time"/> '+
' <StrRes Name="DayOfWeek" Text="Returns the day of the week for a specified date'+
'"/>  <StrRes Name="IsLeapYear" Text="Indicates whether a specified year is a lea'+
'p year"/>  <StrRes Name="DaysInMonth" Text="Returns a number of days in a specif'+
'ied month"/>  <StrRes Name="Length" Text="Returns a length of a string"/>  <StrR'+
'es Name="Copy" Text="Returns a substring of a string"/>  <StrRes Name="Pos" Text'+
'="Returns a position of a substring in a string"/>  <StrRes Name="Delete" Text="'+
'Removes a substring from a string"/>  <StrRes Name="Insert" Text="Inserts a subs'+
'tring into a string"/>  <StrRes Name="Uppercase" Text="Converts all character in'+
' a string to upper case"/>  <StrRes Name="Lowercase" Text="Converts all characte'+
'r in a string to lower case"/>  <StrRes Name="Trim" Text="Trims all trailing and'+
' leading spaces in a string"/>  <StrRes Name="NameCase" Text="Converts first cha'+
'racter of a word to upper case"/>  <StrRes Name="CompareText" Text="Compares two'+
' strings"/>  <StrRes Name="Chr" Text="Converts an integer value to a char"/>  <S'+
'trRes Name="Ord" Text="Converts a character value to an integer"/>  <StrRes Name'+
'="SetLength" Text="Sets the length of a string"/>  <StrRes Name="Round" Text="Ro'+
'unds a floating-point value to the nearest whole number"/>  <StrRes Name="Trunc"'+
' Text="Truncates a floating-point value to an integer"/>  <StrRes Name="Int" Tex'+
't="Returns the integer part of a real number"/>  <StrRes Name="Frac" Text="Retur'+
'ns the fractional part of a real number"/>  <StrRes Name="Sqrt" Text="Returns th'+
'e square root of a specified number"/>  <StrRes Name="Abs" Text="Returns an abso'+
'lute value"/>  <StrRes Name="Sin" Text="Returns the sine of an angle (in radians'+
')"/>  <StrRes Name="Cos" Text="Returns the cosine of an angle (in radians)"/>  <'+
'StrRes Name="ArcTan" Text="Returns the arctangent"/>  <StrRes Name="Tan" Text="R'+
'eturns the tangent"/>  <StrRes Name="Exp" Text="Returns the exponential"/>  <Str'+
'Res Name="Ln" Text="Returns the natural log of a real expression"/>  <StrRes Nam'+
'e="Pi" Text="Returns the 3.1415926... number"/>  <StrRes Name="Inc" Text="Increm'+
'ents a value"/>  <StrRes Name="Dec" Text="Decrements a value"/>  <StrRes Name="R'+
'aiseException" Text="Raises an exception"/>  <StrRes Name="ShowMessage" Text="Sh'+
'ows a message box"/>  <StrRes Name="Randomize" Text="Starts the random numbers g'+
'enerator"/>  <StrRes Name="Random" Text="Returns a random number"/>  <StrRes Nam'+
'e="ValidInt" Text="Returns True if specified string contains a valid integer"/> '+
' <StrRes Name="ValidFloat" Text="Returns True if specified string contains a val'+
'id float"/>  <StrRes Name="ValidDate" Text="Returns True if specified string con'+
'tains a valid date"/>  <StrRes Name="IIF" Text="Returns TrueValue if specified E'+
'xpr is True, otherwise returns FalseValue"/>  <StrRes Name="Get" Text="For inter'+
'nal use only"/>  <StrRes Name="Set" Text="For internal use only"/>  <StrRes Name'+
'="InputBox" Text="Displays an input dialog box that enables the user to enter a '+
'string"/>  <StrRes Name="InputQuery" Text="Displays an input dialog box that ena'+
'bles the user to enter a string"/>  <StrRes Name="MessageDlg" Text="Shows a mess'+
'age box"/>  <StrRes Name="CreateOleObject" Text="Creates an OLE object"/>  <StrR'+
'es Name="VarArrayCreate" Text="Creates a variant array"/>  <StrRes Name="VarType'+
'" Text="Return a type of the variant value"/>  <StrRes Name="DayOf" Text="Return'+
's day number (1..31) of given Date"/>  <StrRes Name="MonthOf" Text="Returns mont'+
'h number (1..12) of given Date"/>  <StrRes Name="YearOf" Text="Returns year of g'+
'iven Date"/>  <StrRes Name="ctAggregate" Text="Aggregate"/>  <StrRes Name="Sum" '+
'Text="Calculates the sum of the Expr for the Band datarow"/>  <StrRes Name="Avg"'+
' Text="Calculates the average of the Expr for the Band datarow"/>  <StrRes Name='+
'"Min" Text="Calculates the minimum of the Expr for the Band datarow"/>  <StrRes '+
'Name="Max" Text="Calculates the maximum of the Expr for the Band datarow"/>  <St'+
'rRes Name="Count" Text="Calculates the number of datarows"/>  <StrRes Name="wzDB'+
'Conn" Text="New Connection Wizard"/>  <StrRes Name="wzDBTable" Text="New Table W'+
'izard"/>  <StrRes Name="wzDBQuery" Text="New Query Wizard"/>  <StrRes Name="5800'+
'" Text="Connections"/>  <StrRes Name="5801" Text="New"/>  <StrRes Name="5802" Te'+
'xt="Delete"/>  <StrRes Name="cpName" Text="Name"/>  <StrRes Name="cpConnStr" Tex'+
't="Connection string"/>  <StrRes Name="startCreateNew" Text="Create new report"/'+
'>  <StrRes Name="startCreateBlank" Text="Create blank report"/>  <StrRes Name="s'+
'tartOpenReport" Text="Open report"/>  <StrRes Name="startOpenLast" Text="Open la'+
'st report"/>  <StrRes Name="startEditAliases" Text="Edit connection aliases"/>  '+
'<StrRes Name="startHelp" Text="Help"/>  <StrRes Name="5900" Text="Watches"/>  <S'+
'trRes Name="5901" Text="Add Watch"/>  <StrRes Name="5902" Text="Delete Watch"/> '+
' <StrRes Name="5903" Text="Edit Watch"/>  <StrRes Name="6000" Text="Inherit erro'+
'r"/>  <StrRes Name="6001" Text="Base and inherited reports have duplicate object'+
's. What should we do?"/>  <StrRes Name="6002" Text="Delete duplicates"/>  <StrRe'+
's Name="6003" Text="Rename duplicates"/>  <StrRes Name="6004" Text="Sort by Name'+
'"/>  <StrRes Name="crGroup" Text="Group"/>  <StrRes Name="4331" Text="Grouping"/'+
'></Resources>'+
'';
initialization
    frxResources.AddXML(Utf8Encode(resXML));

end.
