unit frxrcInsp;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="936">  <StrRes Name="'+
'propActive" Text="设置是否打开数据库(DataSet)。"/>  <StrRes Name="propActive.TfrxHighlight'+
'" Text="是否启动高亮功能。"/>  <StrRes Name="propAliasName" Text="BDE 别名(alias)。"/>  <Str'+
'Res Name="propAlign" Text="决定对象与Band或page对齐。"/>  <StrRes Name="propAlignment" Te'+
'xt="对象文本的对齐方式。"/>  <StrRes Name="propAllowAllUp" Text="同群组的的快速按钮是否可同时取消选取。"/>  <'+
'StrRes Name="propAllowEdit" Text="使用者是否可以编辑预览中的报表。"/>  <StrRes Name="propAllowEx'+
'pressions" Text="决定文本对象是否可以包括运算式。"/>  <StrRes Name="propAllowGrayed" Text="允许复选框'+
'呈现灰色的状态。"/>  <StrRes Name="propAllowHTMLTags" Text="决定文本对象的内容是否可使用 HTML 标签。"/>  '+
'<StrRes Name="propAllowSplit" Text="决定页面的内容是否可跨页打印。"/>  <StrRes Name="propAuthor'+
'" Text="报表作者。"/>  <StrRes Name="propAutoSize.TfrxPictureView" Text="决定是否自动调整图像的大'+
'小。"/>  <StrRes Name="propAutoWidth" Text="决定是否自动调整文本的宽度。"/>  <StrRes Name="propB'+
'ackPicture" Text="报表页面的背景图。"/>  <StrRes Name="propBarType" Text="条码的类型。"/>  <Str'+
'Res Name="propBevelInner" Text="bevel内部的类型。"/>  <StrRes Name="propBevelOuter" Te'+
'xt="bevel外部的类型。"/>  <StrRes Name="propBevelWidth" Text="bevel的宽度。"/>  <StrRes Na'+
'me="propBorder" Text="决定是否显示外框。"/>  <StrRes Name="propBorderStyle" Text="视窗的样式。"'+
'/>  <StrRes Name="propBottomMargin" Text="页面下方的边距。"/>  <StrRes Name="propBrushSt'+
'yle" Text="对象背景的画笔样式。"/>  <StrRes Name="propCalcCheckSum" Text="自动计算条码的检查码。"/>  '+
'<StrRes Name="propCancel" Text="决定当按下Esc键时，此按钮恢  动作。"/>  <StrRes Name="propCapti'+
'on" Text="控制项的标题。"/>  <StrRes Name="propCellFields" Text="交叉报表数据库字段名称。"/>  <StrR'+
'es Name="propCellLevels" Text="交叉报表的阶层数。"/>  <StrRes Name="propCenter" Text="影像居'+
'中。"/>  <StrRes Name="propCharset" Text="字元集。"/>  <StrRes Name="propCharSpacing" '+
'Text="两个字元间的间距，以像素(Pixels)表示。。"/>  <StrRes Name="propCheckColor" Text="复选框勾选状态的颜'+
'色。"/>  <StrRes Name="propChecked" Text="控制项的勾选状态。"/>  <StrRes Name="propCheckSty'+
'le" Text="复选框勾选的样式。"/>  <StrRes Name="propChild" Text="连接至此band的Child Band名称。"/>'+
'  <StrRes Name="propClipped" Text="确定是否应该省略对象范围内的文本"/>  <StrRes Name="propCollat'+
'e" Text="预设的输出顺序设置"/>  <StrRes Name="propColor.TFont" Text="文本的颜色。"/>  <StrRes N'+
'ame="propColor" Text="对象的颜色。"/>  <StrRes Name="propColor.TfrxFrame" Text="框架(Fra'+
'me)的颜色"/>  <StrRes Name="propColor.TfrxHighlight" Text="假如高亮属性动作时，决定对象显示的颜色。"/> '+
' <StrRes Name="propColumnFields" Text="交叉报表的字段名称。"/>  <StrRes Name="propColumnGa'+
'p" Text="栏间距"/>  <StrRes Name="propColumnLevels" Text="栏的阶层数。"/>  <StrRes Name="'+
'propColumns" Text="栏的个数。"/>  <StrRes Name="propColumnWidth" Text="Band的列宽度。"/>  '+
'<StrRes Name="propCondition" Text="群组条件，假如此运算式的值改变，群组自动改变。"/>  <StrRes Name="pro'+
'pCondition.TfrxHighlight" Text="运算式字串。假如运算式为真(True)，醒目的显示上将会启动。"/>  <StrRes Name'+
'="propConnected" Text="设置是否连接数据库。"/>  <StrRes Name="propConvertNulls" Text="是否自动'+
'将Null转成 0, False 或 空字串。"/>  <StrRes Name="propCopies" Text="预设报表打印份数。"/>  <StrRe'+
's Name="propCursor" Text="对象的游标。"/>  <StrRes Name="propDatabaseName" Text="数据库名称'+
'。"/>  <StrRes Name="propDataField" Text="抓取数据库的字段名称。"/>  <StrRes Name="propDataS'+
'et" Text="连结至数据库。"/>  <StrRes Name="propDate" Text="控制项的日期值。"/>  <StrRes Name="p'+
'ropDateFormat" Text="日期输出格式。"/>  <StrRes Name="propDecimalSeparator" Text="小数点的分'+
'隔字元。"/>  <StrRes Name="propDefault" Text="决定此按钮是否为预设按钮。"/>  <StrRes Name="propDe'+
'fHeight" Text="预设列高。"/>  <StrRes Name="propDescription.TfrxReportOptions" Text="'+
'报表用途描述"/>  <StrRes Name="propDescription" Text="对象的描述"/>  <StrRes Name="propDiag'+
'onal" Text="将线条指定为斜线。"/>  <StrRes Name="propDisplayFormat" Text="数据显示格式。"/>  <St'+
'rRes Name="propDoublePass" Text="决定报表引擎是否执行二次处理。"/>  <StrRes Name="propDown" Tex'+
't="决定按钮是否已被按下。"/>  <StrRes Name="propDownThenAcross" Text="指定多栏式报表采由上而下，由左至右打印。"'+
'/>  <StrRes Name="propDriverName" Text="BDE驱动程序名称。"/>  <StrRes Name="propDropSha'+
'dow" Text="决定对象是否有阴影。"/>  <StrRes Name="propDuplex" Text="双面打印模式。"/>  <StrRes Na'+
'me="propEditMask" Text="输入编辑遮罩。"/>  <StrRes Name="propEnabled" Text="决定控制项是否可动作。'+
'"/>  <StrRes Name="propEngineOptions" Text="报表引擎的选项。"/>  <StrRes Name="propExpre'+
'ssion" Text="对象的运算式。"/>  <StrRes Name="propExpressionDelimiters" Text="运算式的分隔字元。'+
'"/>  <StrRes Name="propFieldAliases" Text="数据库字段的别名。"/>  <StrRes Name="propFilte'+
'r" Text="数据库的过滤条件。"/>  <StrRes Name="propFiltered" Text="决定 Filter 过滤条件是否启动。"/> '+
' <StrRes Name="propFlowTo" Text="文本对象无法容纳时，显示至其他对象。"/>  <StrRes Name="propFont" '+
'Text="对象的字体属性。"/>  <StrRes Name="propFooterAfterEach" Text="决定是否在每个数据列之后，跟着打印脚注 '+
'band。"/>  <StrRes Name="propFormatStr" Text="输出格式编辑字串。"/>  <StrRes Name="propFra'+
'me" Text="对象的框架属性。"/>  <StrRes Name="propGapX" Text="文本与左边对齐。"/>  <StrRes Name="'+
'propGapY" Text="文本与上面对齐。"/>  <StrRes Name="propGlyph" Text="控制项的影像。"/>  <StrRes '+
'Name="propGroupIndex" Text="允许快速按钮设为同一群组。"/>  <StrRes Name="propHAlign" Text="文本'+
'水平对齐方式。"/>  <StrRes Name="propHeight" Text="对象的高度。"/>  <StrRes Name="propHideZer'+
'os" Text="数字前面的 0 不显示。"/>  <StrRes Name="propHighlight" Text="高亮属性的条件。"/>  <StrR'+
'es Name="propIndexName" Text="索引名称。"/>  <StrRes Name="propInitString" Text="供点矩阵'+
'报表使用的打印机初始字串。"/>  <StrRes Name="propItems" Text="对象的清单项目"/>  <StrRes Name="propK'+
'eepAspectRatio" Text="保留影像的显示比率"/>  <StrRes Name="propKeepChild" Text="决定Band是否与'+
'Child打印在一起"/>  <StrRes Name="propKeepFooter" Text="是否与脚注打印在一起"/>  <StrRes Name="'+
'propKeepTogether" Text="决定band与subband一起打印"/>  <StrRes Name="propKind.TfrxFormat'+
'" Text="格式种类"/>  <StrRes Name="propKind" Text="按钮类型"/>  <StrRes Name="propLargeD'+
'esignHeight" Text="设计报表页面的最大高度"/>  <StrRes Name="propLayout" Text="按钮图形的格式"/>  <'+
'StrRes Name="propLeft" Text="对象的左边座标"/>  <StrRes Name="propLeftMargin" Text="左边距'+
'的大小"/>  <StrRes Name="propLines" Text="对象的文本"/>  <StrRes Name="propLineSpacing" '+
'Text="列距"/>  <StrRes Name="propLoginPrompt" Text="显示登入视窗"/>  <StrRes Name="propM'+
'argin" Text="按钮图形与边距的距离(像素)"/>  <StrRes Name="propMaster" Text="主数据库"/>  <StrRes'+
' Name="propMasterFields" Text="主数据与明细数据关联的字段"/>  <StrRes Name="propMaxLength" Te'+
'xt="文本的最大长度"/>  <StrRes Name="propMaxWidth" Text="最大栏宽"/>  <StrRes Name="propMem'+
'o" Text="对象的文本"/>  <StrRes Name="propMinWidth" Text="栏的最小宽度"/>  <StrRes Name="pr'+
'opMirrorMargins" Text="镜射页面边距至偶数页"/>  <StrRes Name="propModalResult" Text="Modal'+
'视窗关闭时传回的值"/>  <StrRes Name="propName.TFont" Text="字体名称"/>  <StrRes Name="propNam'+
'e.TfrxReportOptions" Text="报表名称"/>  <StrRes Name="propName" Text="对象名称"/>  <StrR'+
'es Name="propNumGlyphs" Text="Glyph属性内图形的数目"/>  <StrRes Name="propOpenDataSource'+
'" Text="决定是否自动打开数据来源"/>  <StrRes Name="propOrientation" Text="报表页面的方向"/>  <StrRe'+
's Name="propOutlineText" Text="显示在报表大纲对象的文本"/>  <StrRes Name="propOutlineVisible'+
'" Text="显示预览大纲"/>  <StrRes Name="propOutlineWidth" Text="报表大纲的宽度"/>  <StrRes Nam'+
'e="propPageNumbers.TfrxPrintOptions" Text="打印的页数"/>  <StrRes Name="propPaperHeig'+
'ht" Text="页的高度"/>  <StrRes Name="propPaperWidth" Text="页的宽度"/>  <StrRes Name="pr'+
'opParagraphGap" Text="段落首行内缩"/>  <StrRes Name="propParams.TfrxBDEDatabase" Text='+
'"BDE数据库连接参数"/>  <StrRes Name="propParams" Text="查询的参数"/>  <StrRes Name="propPare'+
'ntFont" Text="决定对象是否显示上层对象的字体设置"/>  <StrRes Name="propPassword" Text="报表密码"/>  <'+
'StrRes Name="propPasswordChar" Text="密码字段输入时显示的字元"/>  <StrRes Name="propPicture"'+
' Text="图像"/>  <StrRes Name="propPicture.TfrxReportOptions" Text="报表图像"/>  <StrRe'+
's Name="propPosition" Text="视窗的初始位置"/>  <StrRes Name="propPreviewOptions" Text="'+
'报表预览选项"/>  <StrRes Name="propPrintable" Text="对象是否可打印"/>  <StrRes Name="propPrin'+
'tChildIfInvisible" Text="假如parent band不打印，决定child band是否打印"/>  <StrRes Name="pro'+
'pPrinter" Text="报表预设的打印机名称"/>  <StrRes Name="propPrintIfDetailEmpty" Text="假如sub'+
'nband是空的，决定是否打印"/>  <StrRes Name="propPrintIfEmpty" Text="假如报表数据库是空的，决定是否继续打印"/>'+
'  <StrRes Name="propPrintOnFirstPage" Text="决定Band是否打印在首页"/>  <StrRes Name="prop'+
'PrintOnLastPage" Text="决定Band是否打印在末页"/>  <StrRes Name="propPrintOnParent" Text="'+
'决定子报表是否打印在上层肯  nd"/>  <StrRes Name="propPrintOnPreviousPage" Text="决定本页是否可打印在上页的'+
'剩余空间"/>  <StrRes Name="propPrintOptions" Text="报表打印选项。"/>  <StrRes Name="propPri'+
'ntPages" Text="决定打印全部的报表、奇数页或偶数页。"/>  <StrRes Name="propRangeBegin" Text="打印数据库的'+
'起点。"/>  <StrRes Name="propRangeEnd" Text="打印数据库的终点。"/>  <StrRes Name="propRangeE'+
'ndCount" Text="决定打印笔数。"/>  <StrRes Name="propReadOnly" Text="决定文本对象是否唯读。"/>  <St'+
'rRes Name="propRepeatHeaders" Text="决定页首是否打印在每个新的页面。"/>  <StrRes Name="propRepor'+
'tOptions" Text="报表选项。"/>  <StrRes Name="propReprintOnNewPage" Text="决定是否重新打印在下一页'+
'"/>  <StrRes Name="propRestrictions" Text="报表限制旗标。"/>  <StrRes Name="propRightMa'+
'rgin" Text="右边距。"/>  <StrRes Name="propRotation.TfrxBarCodeView" Text="条码方向"/>  '+
'<StrRes Name="propRotation" Text="旋转文本"/>  <StrRes Name="propRowCount" Text="Dat'+
'aband的虚拟数据笔数。"/>  <StrRes Name="propRowFields" Text="交叉报表列的数据库字段名称"/>  <StrRes N'+
'ame="propRowLevels" Text="列阶层的数目"/>  <StrRes Name="propRTLReading" Text="决定文本对象是'+
'否由右至左显示"/>  <StrRes Name="propSessionName" Text="BDE 连线名称。"/>  <StrRes Name="pro'+
'pShadowColor" Text="阴影的颜色。"/>  <StrRes Name="propShadowWidth" Text="阴影的宽度。"/>  <'+
'StrRes Name="propShape" Text="外型的样式"/>  <StrRes Name="propShiftMode" Text="对象变动的'+
'行为"/>  <StrRes Name="propShowColumnHeader" Text="决定交叉报表是否显示字段表头"/>  <StrRes Name'+
'="propShowColumnTotal" Text="决定交叉报表是否显示字段总计"/>  <StrRes Name="propShowRowHeader"'+
' Text="决定交叉报表是否显示列的表头"/>  <StrRes Name="propShowRowTotal" Text="决定交叉报表是否显示列的总计"/'+
'>  <StrRes Name="propShowDialog" Text="决定打印对话框是否出现在预览视窗"/>  <StrRes Name="propSh'+
'owText" Text="决定条码对象是否显示文本说明"/>  <StrRes Name="propSize" Text="字体大小。"/>  <StrRes'+
' Name="propSorted" Text="项目是否要排序。"/>  <StrRes Name="propSpacing" Text="文本与影像间的像素'+
'(Pixels)间距。"/>  <StrRes Name="propSQL" Text="SQL叙述"/>  <StrRes Name="propStartNe'+
'wPage" Text="在打印Band之前，先执行跳页动作。"/>  <StrRes Name="propStretch" Text="调整图像至对象的大小。'+
'"/>  <StrRes Name="propStretched" Text="决定对象可以伸缩。"/>  <StrRes Name="propStretchM'+
'ode" Text="对象伸缩的行为。"/>  <StrRes Name="propStyle.TFont" Text="字体样式。"/>  <StrRes N'+
'ame="propStyle" Text="控制项样式。"/>  <StrRes Name="propStyle.TfrxFrame" Text="对象的框架样'+
'式。"/>  <StrRes Name="propSuppressRepeated" Text="删除重复的值(重复的值不打印)。"/>  <StrRes Na'+
'me="propTableName" Text="数据表名称。"/>  <StrRes Name="propTag" Text="对象的数字标签"/>  <St'+
'rRes Name="propTagStr" Text="对象的字串标签。"/>  <StrRes Name="propText" Text="对象的文本。"/'+
'>  <StrRes Name="propTitleBeforeHeader" Text="决定是否在页首前显示报表抬头。"/>  <StrRes Name="'+
'propTop" Text="对象上方的座标。"/>  <StrRes Name="propTopMargin" Text="页面与纸张上缘的边距。"/>  <'+
'StrRes Name="propTyp" Text="框架的类型。"/>  <StrRes Name="propUnderlines" Text="决定文本对'+
'象再每一列之后显示底线。"/>  <StrRes Name="propURL" Text="对象连结的 URL 位址。"/>  <StrRes Name="pr'+
'opUserName" Text="数据对象的使用者名称，此名称将显示于数据树状结构。"/>  <StrRes Name="propVAlign" Text="'+
'文本垂直对齐方式。"/>  <StrRes Name="propVersionBuild" Text="版本编号"/>  <StrRes Name="propV'+
'ersionMajor" Text="版本编号, 主版本编号。"/>  <StrRes Name="propVersionMinor" Text="版本编号，次'+
'版本编号。"/>  <StrRes Name="propVersionRelease" Text="版本发行信息。"/>  <StrRes Name="prop'+
'Visible" Text="对象可见。"/>  <StrRes Name="propWidth" Text="对象宽度。"/>  <StrRes Name="'+
'propWidth.TfrxFrame" Text="框架宽度。"/>  <StrRes Name="propWindowState" Text="视窗初始状态'+
'。"/>  <StrRes Name="propWordBreak" Text="断字"/>  <StrRes Name="propWordWrap" Text'+
'="文本是否自动换行。"/>  <StrRes Name="propZoom.TfrxBarCodeView" Text="条码显示比例"/>  <StrRes'+
' Name="propKeepHeader" Text="确定band是否和它的头部打印在一起"/>  <StrRes Name="propConnection'+
'Name" Text="报表中使用的数据库连接名称"/>  <StrRes Name="propCurve" Text="刻画圆框的边"/>  <StrRes '+
'Name="propDrillDown" Text="确定分组能否钻取"/>  <StrRes Name="propFontStyle" Text="点阵字体样'+
'式"/>  <StrRes Name="propHideIfSingleDataRecord" Text="如果组只有一个记录，隐藏脚注"/>  <StrRes'+
' Name="propOutlineExpand" Text="确定是否展开报表大纲"/>  <StrRes Name="propPlainCells" Tex'+
't="确定是否打印并排或叠在一起的单元格"/>  <StrRes Name="propPrintMode" Text="打印模式: 正常, 切分大页到小页, 或'+
'者在大页上打印几个小页"/>  <StrRes Name="propPrintOnSheet" Text="纸的大小调为适合报告的打印机. 如果使用打印模式不是'+
'pmDefault,则使用该方式"/>  <StrRes Name="propResetPageNumbers" Text="打印组时, 重置页号/全部页号. '+
'应该在StartNewPage选项设为真的时候使用"/>  <StrRes Name="propReverse" Text="确定是否反转打印页"/>  <St'+
'rRes Name="propShowFooterIfDrillDown" Text="确定是否显示钻取的组脚注"/>  <StrRes Name="propS'+
'izeMode" Text="显示OLE对象的模式"/>  <StrRes Name="propVersion" Text="FastReport的版本"/> '+
' <StrRes Name="propWideBarRatio" Text="和条形码的wide bars有关"/>  <StrRes Name="propWy'+
'siwyg" Text="确定rich对象是否用打印机场景格式化文本.应该已经安装\准备好一台打印机"/>  <StrRes Name="propArrowEn'+
'd" Text="确定是否在线的末端画箭头"/>  <StrRes Name="propArrowLength" Text="箭头的长度"/>  <StrRes'+
' Name="propArrowSolid" Text="确定是否画立体填充的箭头"/>  <StrRes Name="propArrowStart" Text'+
'="确定是否在线的起始处画箭头"/>  <StrRes Name="propArrowWidth" Text="箭头宽度"/>  <StrRes Name="p'+
'ropCloseDataSource" Text="确定是否在报表完成后关闭数据集"/>  <StrRes Name="propDatabase" Text="'+
'数据库连接"/>  <StrRes Name="propIndexFieldNames" Text="索引字段的名称"/>  <StrRes Name="pro'+
'pCommandTimeOut" Text="执行查询的时候需要时间量"/>  <StrRes Name="propExpandDrillDown" Text='+
'"确定是否在报表首次启动时展开所有的钻取元素 "/>  <StrRes Name="propWysiwyg.TfrxMemoView" Text="确定是否以所'+
'见即所得模式显示文本"/>  <StrRes Name="propLeftLine" Text="框的左边线条"/>  <StrRes Name="propTo'+
'pLine" Text="框的顶部线条"/>  <StrRes Name="propRightLine" Text="框的右边线条"/>  <StrRes Na'+
'me="propBottomLine" Text="框的底部线条"/>  <StrRes Name="propColor.TfrxFrameLine" Text'+
'="框线颜色"/>  <StrRes Name="propStyle.TfrxFrameLine" Text="框线样式"/>  <StrRes Name="p'+
'ropWidth.TfrxFrameLine" Text="框线宽度"/>  <StrRes Name="propFileLink" Text="表达式或者包含'+
'图片的文件名"/>  <StrRes Name="propEndlessWidth" Text="无限制页模式. 若为 true, 页面依赖在其中的数据记录量而'+
'增长"/>  <StrRes Name="propEndlessHeight" Text="无限制页模式. 若为 true, 页面依赖在其中的数据记录量而增长"'+
'/>  <StrRes Name="propAddHeight" Text="单元格高度增加指定的空间量"/>  <StrRes Name="propAddWi'+
'dth" Text="单元格宽度度增加指定的空间量"/>  <StrRes Name="propAllowDuplicates" Text="确定单元格是否接收'+
'重复的串"/>  <StrRes Name="propJoinEqualCells" Text="确定交叉表是否应该按相等值连接单元格"/>  <StrRes '+
'Name="propNextCross" Text="指向下一个并排显示的交叉表"/>  <StrRes Name="propNextCrossGap" Tex'+
't="并排的交叉表的间隙"/>  <StrRes Name="propShowCorner" Text="确定是否应该显示左上角元素"/>  <StrRes N'+
'ame="propSuppressNullRecords" Text="!确定交叉表是否该抑制所有为空的记录"/>  <StrRes Name="propSho'+
'wTitle" Text="!确定交叉表是否该显示标题"/>  <StrRes Name="propAutoSize" Text="!确定交叉表是否该自动处理大'+
'小"/>  <StrRes Name="propShowHint" Text="Determines if object should show hint wh'+
'en move cursor on it"/>  <StrRes Name="propHint" Text="Hint text"/>  <StrRes Nam'+
'e="propPaperSize" Text="PaperSize"/>  <StrRes Name="propPageCount" Text="Count o'+
'f pages"/>  <StrRes Name="propBackPictureVisible" Text="Determines if the page s'+
'hould display a background picture"/>  <StrRes Name="propBackPicturePrintable" T'+
'ext="Determines if the page should print a background picture"/>  <StrRes Name="'+
'propHightQuality" Text="Show picture in high quality"/>  <StrRes Name="propLockT'+
'ype" Text="Specifies the lock type to use when opening a dataset"/>  <StrRes Nam'+
'e="propIgnoreDupParams" Text="Ignore duplicate parameters in ParamEditor"/>  <St'+
'rRes Name="propTransparent" Text="Determinates if the picture can be transparent'+
'"/>  <StrRes Name="propTransparentColor" Text="Transparent color"/>  <StrRes Nam'+
'e="propIgnoreNulls" Text="Allow to ingnore Nulls values in Chart"/>  <StrRes Nam'+
'e="propShowClildIfDrillDown" Text="Determinates if child band shown if group is '+
'drilldown"/></Resources>'+
'';
initialization
    frxResources.AddXML(Utf8Encode(resXML));

end.
