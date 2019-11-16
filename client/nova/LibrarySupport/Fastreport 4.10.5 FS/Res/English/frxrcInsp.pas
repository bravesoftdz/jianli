unit frxrcInsp;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="1252">  <StrRes Name='+
'"propActive" Text="Specifies if a dataset is open"/>  <StrRes Name="propActive.T'+
'frxHighlight" Text="Specifies if a highlight is active"/>  <StrRes Name="propAli'+
'asName" Text="The name of the DB alias"/>  <StrRes Name="propAlign" Text="Determ'+
'ines the alignment of the object relative to band or page"/>  <StrRes Name="prop'+
'Alignment" Text="The alignment of the object''s text"/>  <StrRes Name="propAllowA'+
'llUp" Text="Specifies if all speed buttons in the group can be unselected at the'+
' same time"/>  <StrRes Name="propAllowEdit" Text="Determines if the user may edi'+
't the prepared report pages"/>  <StrRes Name="propAllowExpressions" Text="Determ'+
'ines if the text object may contain expressions inside the text"/>  <StrRes Name'+
'="propAllowGrayed" Text="Allows grayed state of the control checkboxes"/>  <StrR'+
'es Name="propAllowHTMLTags" Text="Determines if the text object may contain HTML'+
' tags inside the text"/>  <StrRes Name="propAllowSplit" Text="Determines if the '+
'band may split its contents across pages"/>  <StrRes Name="propAuthor" Text="The'+
' author of the report"/>  <StrRes Name="propAutoSize.TfrxPictureView" Text="Dete'+
'rmines if the picture should handle its size automatically"/>  <StrRes Name="pro'+
'pAutoWidth" Text="Determines if the text object should handle its width automati'+
'cally"/>  <StrRes Name="propBackPicture" Text="The background page picture"/>  <'+
'StrRes Name="propBarType" Text="The type of the barcode"/>  <StrRes Name="propBe'+
'velInner" Text="The type of the inner bevel"/>  <StrRes Name="propBevelOuter" Te'+
'xt="The type of the outer bevel"/>  <StrRes Name="propBevelWidth" Text="The widt'+
'h of the bevel"/>  <StrRes Name="propBorder" Text="Determines if outer border is'+
' shown"/>  <StrRes Name="propBorderStyle" Text="The style of the window"/>  <Str'+
'Res Name="propBottomMargin" Text="The size of the bottom page margin"/>  <StrRes'+
' Name="propBrushStyle" Text="The style of the brush used for object''s background'+
'"/>  <StrRes Name="propCalcCheckSum" Text="Determines if the barcode should calc'+
'ulate the checksum digit"/>  <StrRes Name="propCancel" Text="Determines if the b'+
'utton should be activated when Esc key pressed"/>  <StrRes Name="propCaption" Te'+
'xt="The caption of the control"/>  <StrRes Name="propCellFields" Text="Names of '+
'DB fields represents the cross cells"/>  <StrRes Name="propCellLevels" Text="Num'+
'ber of cell levels"/>  <StrRes Name="propCenter" Text="Determines if the image s'+
'hould be centered inside the control"/>  <StrRes Name="propCharset" Text="The fo'+
'nt charset"/>  <StrRes Name="propCharSpacing" Text="Amount of pixels between two'+
' characters"/>  <StrRes Name="propCheckColor" Text="The color of the check mark"'+
'/>  <StrRes Name="propChecked" Text="Indicates if the control is checked"/>  <St'+
'rRes Name="propCheckStyle" Text="The style of the check mark"/>  <StrRes Name="p'+
'ropChild" Text="Child band connected to this band"/>  <StrRes Name="propClipped"'+
' Text="Determines if the text should be clipped inside the objects bounds"/>  <S'+
'trRes Name="propCollate" Text="Default setting of collation"/>  <StrRes Name="pr'+
'opColor.TFont" Text="The color of the text"/>  <StrRes Name="propColor" Text="Th'+
'e color of the object"/>  <StrRes Name="propColor.TfrxFrame" Text="The color of '+
'the frame"/>  <StrRes Name="propColor.TfrxHighlight" Text="Determines the color '+
'of the object if highlight is active"/>  <StrRes Name="propColumnFields" Text="N'+
'ames of DB fields represents the cross columns"/>  <StrRes Name="propColumnGap" '+
'Text="The gap between band columns"/>  <StrRes Name="propColumnLevels" Text="Num'+
'ber of column levels"/>  <StrRes Name="propColumns" Text="Number of columns in t'+
'he band"/>  <StrRes Name="propColumnWidth" Text="The width of the band column"/>'+
'  <StrRes Name="propCondition" Text="The grouping condition. The group will brea'+
'k if value of this expression changed"/>  <StrRes Name="propCondition.TfrxHighli'+
'ght" Text="Expression string. If this expression is True, the highlight will be '+
'active"/>  <StrRes Name="propConnected" Text="Indicates if the database connecti'+
'on is active"/>  <StrRes Name="propConvertNulls" Text="Determines if null DB val'+
'ues will converted to 0, False or empty string"/>  <StrRes Name="propCopies" Tex'+
't="The default number of copies"/>  <StrRes Name="propCursor" Text="The cursor o'+
'f the object"/>  <StrRes Name="propDatabaseName" Text="The name of the database"'+
'/>  <StrRes Name="propDataField" Text="Specifies the field from which the object'+
' gets data"/>  <StrRes Name="propDataSet" Text="Links the object to the dataset '+
'that contains the field it represents"/>  <StrRes Name="propDate" Text="The date'+
' value of the control"/>  <StrRes Name="propDateFormat" Text="Specifies format i'+
'n which the date is presented"/>  <StrRes Name="propDecimalSeparator" Text="The '+
'decimal separator"/>  <StrRes Name="propDefault" Text="Determines if the button '+
'is the default button"/>  <StrRes Name="propDefHeight" Text="Default height of t'+
'he row"/>  <StrRes Name="propDescription.TfrxReportOptions" Text="The report des'+
'cription"/>  <StrRes Name="propDescription" Text="Object''s description"/>  <StrR'+
'es Name="propDiagonal" Text="Indicates that the line is diagonal"/>  <StrRes Nam'+
'e="propDisplayFormat" Text="The format of the displayed value"/>  <StrRes Name="'+
'propDoublePass" Text="Determines if the report engine should perform the second '+
'pass"/>  <StrRes Name="propDown" Text="Determines if the speed button is pressed'+
' or not"/>  <StrRes Name="propDownThenAcross" Text="Determines how a large cross'+
' table will be split across pages"/>  <StrRes Name="propDriverName" Text="The na'+
'me of the BDE driver"/>  <StrRes Name="propDropShadow" Text="Determines if the o'+
'bjects has a shadow"/>  <StrRes Name="propDuplex" Text="Specifies the duplex mod'+
'e for the page"/>  <StrRes Name="propEditMask" Text="Specifies the mask that rep'+
'resents what text is valid for the masked edit control"/>  <StrRes Name="propEna'+
'bled" Text="Determines if the control is enabled"/>  <StrRes Name="propEngineOpt'+
'ions" Text="The engine options of the report"/>  <StrRes Name="propExpression" T'+
'ext="Value of this expression will be shown in the object"/>  <StrRes Name="prop'+
'ExpressionDelimiters" Text="The characters that will be used for enclosing the e'+
'xpressions contained in the text"/>  <StrRes Name="propFieldAliases" Text="The d'+
'ataset field''s aliases"/>  <StrRes Name="propFilter" Text="The filtering conditi'+
'on for the dataset"/>  <StrRes Name="propFiltered" Text="Determines if the datas'+
'et should filter the records using the condition in the Filter property"/>  <Str'+
'Res Name="propFlowTo" Text="The text object that will show the text that not fit'+
' in the object"/>  <StrRes Name="propFont" Text="The font attributes of the obje'+
'ct"/>  <StrRes Name="propFooterAfterEach" Text="Determines if the footer band sh'+
'ould be shown after each data row"/>  <StrRes Name="propFormatStr" Text="The for'+
'matting string"/>  <StrRes Name="propFrame" Text="The frame attributes of the ob'+
'ject"/>  <StrRes Name="propGapX" Text="The left indent of the text"/>  <StrRes N'+
'ame="propGapY" Text="The top indent of the text"/>  <StrRes Name="propGlyph" Tex'+
't="The image of the control"/>  <StrRes Name="propGroupIndex" Text="Allows speed'+
' buttons to work together as a group"/>  <StrRes Name="propHAlign" Text="The hor'+
'izontal alignment of the text"/>  <StrRes Name="propHeight" Text="The height of '+
'the object"/>  <StrRes Name="propHideZeros" Text="Determines if the text object '+
'will hide the zero values"/>  <StrRes Name="propHighlight" Text="The conditional'+
' highlight attributes"/>  <StrRes Name="propIndexName" Text="The name of the ind'+
'ex"/>  <StrRes Name="propInitString" Text="Printer init string for dot-matrix re'+
'ports"/>  <StrRes Name="propItems" Text="List items of the object"/>  <StrRes Na'+
'me="propKeepAspectRatio" Text="Keep the original aspect ratio of the image"/>  <'+
'StrRes Name="propKeepChild" Text="Determines if the band will be printed togethe'+
'r with its child"/>  <StrRes Name="propKeepFooter" Text="Determines if the band '+
'will be printed together with its footer"/>  <StrRes Name="propKeepHeader" Text='+
'"Determines if the band will be printed together with its header"/>  <StrRes Nam'+
'e="propKeepTogether" Text="Determines if the band will be printed together with '+
'all its subbands"/>  <StrRes Name="propKind.TfrxFormat" Text="The kind of format'+
'ting"/>  <StrRes Name="propKind" Text="The kind of the button"/>  <StrRes Name="'+
'propLargeDesignHeight" Text="Determines if the page will have large height in th'+
'e design mode"/>  <StrRes Name="propLayout" Text="The layout of the button glyph'+
'"/>  <StrRes Name="propLeft" Text="The left coordinate of the object"/>  <StrRes'+
' Name="propLeftMargin" Text="The size of the left page margin"/>  <StrRes Name="'+
'propLines" Text="The text of the object"/>  <StrRes Name="propLineSpacing" Text='+
'"The amount of pixels between two lines of text"/>  <StrRes Name="propLoginPromp'+
't" Text="Determines if to show the login dialog"/>  <StrRes Name="propMargin" Te'+
'xt="Determines the number of pixels between the edge of the image and the edge o'+
'f the button"/>  <StrRes Name="propMaster" Text="The master dataset"/>  <StrRes '+
'Name="propMasterFields" Text="The fields linked by master-detail relationship"/>'+
'  <StrRes Name="propMaxLength" Text="Max length of the text"/>  <StrRes Name="pr'+
'opMaxWidth" Text="Max width of the column"/>  <StrRes Name="propMemo" Text="The '+
'text of the object"/>  <StrRes Name="propMinWidth" Text="Min width of the column'+
'"/>  <StrRes Name="propMirrorMargins" Text="Mirror the page margins on the even '+
'pages"/>  <StrRes Name="propModalResult" Text="Determines if and how the button '+
'closes its modal form"/>  <StrRes Name="propName.TFont" Text="The name of the fo'+
'nt"/>  <StrRes Name="propName.TfrxReportOptions" Text="The name of the report"/>'+
'  <StrRes Name="propName" Text="The name of the object"/>  <StrRes Name="propNum'+
'Glyphs" Text="Indicates the number of images that are in the graphic specified i'+
'n the Glyph property"/>  <StrRes Name="propOpenDataSource" Text="Determines if t'+
'o open datasource automatically or not"/>  <StrRes Name="propOrientation" Text="'+
'The orientation of the page"/>  <StrRes Name="propOutlineText" Text="The text th'+
'at will be shown in the preview outline control"/>  <StrRes Name="propOutlineVis'+
'ible" Text="The visibility of the preview outline control"/>  <StrRes Name="prop'+
'OutlineWidth" Text="The width of the preview outline control"/>  <StrRes Name="p'+
'ropPageNumbers.TfrxPrintOptions" Text="The numbers of the pages to be printed"/>'+
'  <StrRes Name="propPaperHeight" Text="The height of the page"/>  <StrRes Name="'+
'propPaperWidth" Text="The width of the page"/>  <StrRes Name="propParagraphGap" '+
'Text="The indent of the first line of paragraph"/>  <StrRes Name="propParams.Tfr'+
'xBDEDatabase" Text="The parameters of the connection"/>  <StrRes Name="propParam'+
's" Text="The parameters of the query"/>  <StrRes Name="propParentFont" Text="Det'+
'ermines if the object will use parent''s font"/>  <StrRes Name="propPassword" Tex'+
't="The report password"/>  <StrRes Name="propPasswordChar" Text="Indicates the c'+
'haracter, if any, to display in place of the actual characters typed in the cont'+
'rol"/>  <StrRes Name="propPicture" Text="The picture"/>  <StrRes Name="propPictu'+
're.TfrxReportOptions" Text="The description picture of the report"/>  <StrRes Na'+
'me="propPosition" Text="The initial position of the window"/>  <StrRes Name="pro'+
'pPreviewOptions" Text="The preview options of the report"/>  <StrRes Name="propP'+
'rintable" Text="Printability of the object. Objects with the Printable=False wil'+
'l be previewed, but not printed"/>  <StrRes Name="propPrintChildIfInvisible" Tex'+
't="Determines if the child band will be printed if its parent band is invisible"'+
'/>  <StrRes Name="propPrinter" Text="The name of the printer that will be select'+
'ed when open or run this report"/>  <StrRes Name="propPrintIfDetailEmpty" Text="'+
'Determines if the databand will be printed if its subband is empty"/>  <StrRes N'+
'ame="propPrintIfEmpty" Text="Determines if the page will be printed if all its d'+
'atasets are empty"/>  <StrRes Name="propPrintOnFirstPage" Text="Determines if th'+
'e band will be printed on the first page"/>  <StrRes Name="propPrintOnLastPage" '+
'Text="Determines if the band will be printed on the last page"/>  <StrRes Name="'+
'propPrintOnParent" Text="Determines if the subreport can print itself on parent '+
'band"/>  <StrRes Name="propPrintOnPreviousPage" Text="Determines if the page can'+
' be generated on the free space of previously generated page"/>  <StrRes Name="p'+
'ropPrintOptions" Text="Print options of the report"/>  <StrRes Name="propPrintPa'+
'ges" Text="Determines if to print all, odd or even pages"/>  <StrRes Name="propR'+
'angeBegin" Text="Determines the start point of dataset navigation"/>  <StrRes Na'+
'me="propRangeEnd" Text="Determines the end point of dataset navigation"/>  <StrR'+
'es Name="propRangeEndCount" Text="Determines the number of records in the datase'+
't if RangeEnd is reCount"/>  <StrRes Name="propReadOnly" Text="Determines if the'+
' text object is read-only"/>  <StrRes Name="propRepeatHeaders" Text="Determines '+
'if the column and row headers will be reprinted on new page"/>  <StrRes Name="pr'+
'opReportOptions" Text="The options of the report"/>  <StrRes Name="propReprintOn'+
'NewPage" Text="Determines if the band will be reprinted on new page"/>  <StrRes '+
'Name="propRestrictions" Text="Set of restriction flags"/>  <StrRes Name="propRig'+
'htMargin" Text="The size of the right page margin"/>  <StrRes Name="propRotation'+
'.TfrxBarCodeView" Text="The orientation of the barcode"/>  <StrRes Name="propRot'+
'ation" Text="The text rotation"/>  <StrRes Name="propRowCount" Text="Number of v'+
'irtual records in the databand"/>  <StrRes Name="propRowFields" Text="Names of D'+
'B fields represents the cross rows"/>  <StrRes Name="propRowLevels" Text="Number'+
' of row levels"/>  <StrRes Name="propRTLReading" Text="Determines if the text ob'+
'ject will show its text in right-to-left direction"/>  <StrRes Name="propSession'+
'Name" Text="The name of the BDE session"/>  <StrRes Name="propShadowColor" Text='+
'"The color of the shadow"/>  <StrRes Name="propShadowWidth" Text="The width of t'+
'he shadow"/>  <StrRes Name="propShape" Text="The type of the shape"/>  <StrRes N'+
'ame="propShiftMode" Text="Shift behavior of the object"/>  <StrRes Name="propSho'+
'wColumnHeader" Text="Determines if the cross will show column headers"/>  <StrRe'+
's Name="propShowColumnTotal" Text="Determines if the cross will show column gran'+
'd total"/>  <StrRes Name="propShowRowHeader" Text="Determines if the cross will '+
'show row headers"/>  <StrRes Name="propShowRowTotal" Text="Determines if the cro'+
'ss will show row grand total"/>  <StrRes Name="propShowDialog" Text="Determines '+
'if the print dialog will be shown in the preview window"/>  <StrRes Name="propSh'+
'owText" Text="Determines if the barcode object will show a readable text"/>  <St'+
'rRes Name="propSize" Text="The size of the font"/>  <StrRes Name="propSorted" Te'+
'xt="Determines if the items are sorted or not"/>  <StrRes Name="propSpacing" Tex'+
't="Determines the number of pixels between the image and the text"/>  <StrRes Na'+
'me="propSQL" Text="The SQL statement"/>  <StrRes Name="propStartNewPage" Text="S'+
'tarts a new page before printing a band"/>  <StrRes Name="propStretch" Text="Str'+
'etches the picture to fit the object bounds"/>  <StrRes Name="propStretched" Tex'+
't="Determines if the object can be stretched"/>  <StrRes Name="propStretchMode" '+
'Text="Stretch behavior of the object"/>  <StrRes Name="propStyle.TFont" Text="Th'+
'e style of the font"/>  <StrRes Name="propStyle" Text="The style of the control"'+
'/>  <StrRes Name="propStyle.TfrxFrame" Text="The style of the object''s frame"/> '+
' <StrRes Name="propSuppressRepeated" Text="Suppresses repeated values"/>  <StrRe'+
's Name="propTableName" Text="The name of the data table"/>  <StrRes Name="propTa'+
'g" Text="Tag number of the object"/>  <StrRes Name="propTagStr" Text="Tag string'+
' of the object"/>  <StrRes Name="propText" Text="The text of the object"/>  <Str'+
'Res Name="propTitleBeforeHeader" Text="Determines if report title shown before p'+
'age header"/>  <StrRes Name="propTop" Text="The top coordinate of the object"/> '+
' <StrRes Name="propTopMargin" Text="The size of the top page margin"/>  <StrRes '+
'Name="propTyp" Text="The type of the frame"/>  <StrRes Name="propUnderlines" Tex'+
't="Determines if the text object will show under lines after each text line"/>  '+
'<StrRes Name="propURL" Text="The URL of the object"/>  <StrRes Name="propUserNam'+
'e" Text="User name of the data object. This name will be shown in the data tree"'+
'/>  <StrRes Name="propVAlign" Text="The vertical alignment of the text"/>  <StrR'+
'es Name="propVersionBuild" Text="Version info, build"/>  <StrRes Name="propVersi'+
'onMajor" Text="Version info, major version"/>  <StrRes Name="propVersionMinor" T'+
'ext="Version info, minor version"/>  <StrRes Name="propVersionRelease" Text="Ver'+
'sion info, release"/>  <StrRes Name="propVisible" Text="Visibility of the object'+
'"/>  <StrRes Name="propWidth" Text="Width of the object"/>  <StrRes Name="propWi'+
'dth.TfrxFrame" Text="The width of the frame"/>  <StrRes Name="propWindowState" T'+
'ext="Initial state of the window"/>  <StrRes Name="propWordBreak" Text="Break ru'+
'ssian words"/>  <StrRes Name="propWordWrap" Text="Determines if the text object '+
'inserts soft carriage returns so text wraps at the right margin"/>  <StrRes Name'+
'="propZoom.TfrxBarCodeView" Text="Zooms the barcode"/>  <StrRes Name="propConnec'+
'tionName" Text="Name of the connection to the database used in the report"/>  <S'+
'trRes Name="propCurve" Text="Curvature of the roundrectangle edges"/>  <StrRes N'+
'ame="propDrillDown" Text="Determines if the group can be drilled down"/>  <StrRe'+
's Name="propFontStyle" Text="Dot-matrix font style"/>  <StrRes Name="propHideIfS'+
'ingleDataRecord" Text="Hide the footer if a group has only one data record"/>  <'+
'StrRes Name="propOutlineExpand" Text="Determines if the report outline expands o'+
'r not"/>  <StrRes Name="propPlainCells" Text="Determines whether to print severa'+
'l cells side-by-side or stacked"/>  <StrRes Name="propPrintMode" Text="Print mod'+
'e: normal, split big pages to small one, or print several small pages on a big o'+
'ne"/>  <StrRes Name="propPrintOnSheet" Text="Paper size to print report on. Used'+
' if PrintMode is not pmDefault"/>  <StrRes Name="propResetPageNumbers" Text="Res'+
'et page number/total pages numbers when print a group. Should be used with Start'+
'NewPage option set to true"/>  <StrRes Name="propReverse" Text="Determines if pa'+
'ges print in reverse order"/>  <StrRes Name="propShowFooterIfDrillDown" Text="De'+
'termines if group footer is shown if group is drilldown"/>  <StrRes Name="propSi'+
'zeMode" Text="Display mode of the OLE object"/>  <StrRes Name="propVersion" Text'+
'="Version of the FastReport"/>  <StrRes Name="propWideBarRatio" Text="Relative w'+
'ith of wide bars of the barcode"/>  <StrRes Name="propWysiwyg" Text="Determines '+
'if the object should use the printer canvas to format the text. A printer should'+
' be installed and ready."/>  <StrRes Name="propArrowEnd" Text="Determines if an '+
'arrow is shown at end of a line"/>  <StrRes Name="propArrowLength" Text="Length '+
'of the arrow"/>  <StrRes Name="propArrowSolid" Text="Determines if arrow has sol'+
'id-fill "/>  <StrRes Name="propArrowStart" Text="Determines if an arrow is shown'+
' at the start of a line"/>  <StrRes Name="propArrowWidth" Text="Width of the arr'+
'ow"/>  <StrRes Name="propCloseDataSource" Text="Determines whether to close the '+
'dataset when report is finished"/>  <StrRes Name="propDatabase" Text="Database c'+
'onnection"/>  <StrRes Name="propIndexFieldNames" Text="Names of index fields"/> '+
' <StrRes Name="propCommandTimeOut" Text="Amount of time needed to execute a quer'+
'y"/>  <StrRes Name="propExpandDrillDown" Text="Determines if all drill-down elem'+
'ents are expanded at first start of a report"/>  <StrRes Name="propWysiwyg.TfrxM'+
'emoView" Text="Determines if text is displayed in WYSIWYG mode"/>  <StrRes Name='+
'"propLeftLine" Text="Left line of a frame"/>  <StrRes Name="propTopLine" Text="T'+
'op line of a frame"/>  <StrRes Name="propRightLine" Text="Right line of a frame"'+
'/>  <StrRes Name="propBottomLine" Text="Bottom line of a frame"/>  <StrRes Name='+
'"propColor.TfrxFrameLine" Text="The color of the frame line"/>  <StrRes Name="pr'+
'opStyle.TfrxFrameLine" Text="The style of the frame line"/>  <StrRes Name="propW'+
'idth.TfrxFrameLine" Text="The width of the frame line"/>  <StrRes Name="propFile'+
'Link" Text="Expression or name of the file containing a picture"/>  <StrRes Name'+
'="propEndlessWidth" Text="Endless page mode. If true, page will grow depending o'+
'n number of data records on it"/>  <StrRes Name="propEndlessHeight" Text="Endles'+
's page mode. If true, page will grow depending on number of data records on it"/'+
'>  <StrRes Name="propAddHeight" Text="Adds specified amount of space to the cell'+
' height"/>  <StrRes Name="propAddWidth" Text="Adds specified amount of space to '+
'the cell width"/>  <StrRes Name="propAllowDuplicates" Text="Determines if the ce'+
'll can accept duplicate string values"/>  <StrRes Name="propJoinEqualCells" Text'+
'="Determines if the crosstab should join cells with equal values"/>  <StrRes Nam'+
'e="propNextCross" Text="Pointer to the next crosstab that will be displayed side'+
'-by-side"/>  <StrRes Name="propNextCrossGap" Text="Gap between side-by-side cros'+
'stabs"/>  <StrRes Name="propShowCorner" Text="Determines if the crosstab should '+
'display a left-top corner elements"/>  <StrRes Name="propSuppressNullRecords" Te'+
'xt="!Determines if the crosstab should suppress records with all NULL values"/> '+
' <StrRes Name="propShowTitle" Text="!Determines if the crosstab should display a'+
' title"/>  <StrRes Name="propAutoSize" Text="!Determines if the crosstab should '+
'handle its size automatically"/>  <StrRes Name="propShowHint" Text="Determines i'+
'f object should show hint when move cursor on it"/>  <StrRes Name="propHint" Tex'+
't="Hint text"/>  <StrRes Name="propPaperSize" Text="PaperSize"/>  <StrRes Name="'+
'propPageCount" Text="Count of pages"/>  <StrRes Name="propBackPictureVisible" Te'+
'xt="Determines if the page should display a background picture"/>  <StrRes Name='+
'"propBackPicturePrintable" Text="Determines if the page should print a backgroun'+
'd picture"/>  <StrRes Name="propHightQuality" Text="Show picture in high quality'+
'"/>  <StrRes Name="propLockType" Text="Specifies the lock type to use when openi'+
'ng a dataset"/>  <StrRes Name="propIgnoreDupParams" Text="Ignore duplicate param'+
'eters in ParamEditor"/>  <StrRes Name="propTransparent" Text="Determinates if th'+
'e picture can be transparent"/>  <StrRes Name="propTransparentColor" Text="Trans'+
'parent color"/>  <StrRes Name="propIgnoreNulls" Text="Allow to ingnore Nulls val'+
'ues in Chart"/>  <StrRes Name="propShowClildIfDrillDown" Text="Determinates if c'+
'hild band shown if group is drilldown"/></Resources>'+
'';
initialization
    frxResources.AddXML(Utf8Encode(resXML));

end.
