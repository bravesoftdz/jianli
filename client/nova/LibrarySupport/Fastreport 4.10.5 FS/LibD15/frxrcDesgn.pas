unit frxrcDesgn;

interface
{$I frx.inc}
implementation
uses frxRes;
const resXML =
'<?xml version="1.1" encoding="utf-8"?><Resources CodePage="936">  <StrRes Name="'+
'2000" Text="对象查看器"/>  <StrRes Name="oiProp" Text="属性"/>  <StrRes Name="oiEvent" '+
'Text="事件"/>  <StrRes Name="2100" Text="数据树"/>  <StrRes Name="2101" Text="数据"/>  '+
'<StrRes Name="2102" Text="变量"/>  <StrRes Name="2103" Text="函数"/>  <StrRes Name="'+
'2104" Text="建立字段"/>  <StrRes Name="2105" Text="建立标题"/>  <StrRes Name="2106" Text'+
'="类"/>  <StrRes Name="dtNoData" Text="没有数据库可以使用"/>  <StrRes Name="dtNoData1" Tex'+
't="继续 用&#38;#34;报表|数据...&#38;#34; 菜单添加一个已存在的数据集到报表中,或者转换到 &#38;#34;Data&#38;#34;'+
' 页签,然后创建一个新的数据集."/>  <StrRes Name="dtData" Text="数据"/>  <StrRes Name="dtSysVar" '+
'Text="系统变量"/>  <StrRes Name="dtVar" Text="变量"/>  <StrRes Name="dtFunc" Text="函数"'+
'/>  <StrRes Name="2200" Text="报表树"/>  <StrRes Name="2300" Text="打开脚本"/>  <StrRes'+
' Name="2301" Text="保存脚本"/>  <StrRes Name="2302" Text="执行脚本"/>  <StrRes Name="230'+
'3" Text="追踪至"/>  <StrRes Name="2304" Text="结束脚本"/>  <StrRes Name="2305" Text="求值'+
'"/>  <StrRes Name="2306" Text="语言:"/>  <StrRes Name="2307" Text="对齐"/>  <StrRes '+
'Name="2308" Text="齐左"/>  <StrRes Name="2309" Text="水平居中"/>  <StrRes Name="2310" '+
'Text="齐右"/>  <StrRes Name="2311" Text="齐上"/>  <StrRes Name="2312" Text="垂直居中"/> '+
' <StrRes Name="2313" Text="齐底"/>  <StrRes Name="2314" Text="水平空间"/>  <StrRes Nam'+
'e="2315" Text="垂直空间"/>  <StrRes Name="2316" Text="水平居中"/>  <StrRes Name="2317" T'+
'ext="垂直居中"/>  <StrRes Name="2318" Text="相同宽度"/>  <StrRes Name="2319" Text="相同高度"'+
'/>  <StrRes Name="2320" Text="文本"/>  <StrRes Name="2321" Text="样式"/>  <StrRes Na'+
'me="2322" Text="字体名称"/>  <StrRes Name="2323" Text="字体大小"/>  <StrRes Name="2324" '+
'Text="粗体"/>  <StrRes Name="2325" Text="斜体"/>  <StrRes Name="2326" Text="底线"/>  <'+
'StrRes Name="2327" Text="字体颜色"/>  <StrRes Name="2328" Text="强调"/>  <StrRes Name='+
'"2329" Text="文本方向"/>  <StrRes Name="2330" Text="左对齐"/>  <StrRes Name="2331" Text'+
'="居中"/>  <StrRes Name="2332" Text="右对齐"/>  <StrRes Name="2333" Text="左对齐"/>  <St'+
'rRes Name="2334" Text="上对齐"/>  <StrRes Name="2335" Text="垂直居中"/>  <StrRes Name="'+
'2336" Text="底部对齐"/>  <StrRes Name="2337" Text="外框"/>  <StrRes Name="2338" Text="'+
'上方线"/>  <StrRes Name="2339" Text="下方线"/>  <StrRes Name="2340" Text="左边线"/>  <Str'+
'Res Name="2341" Text="右边线"/>  <StrRes Name="2342" Text="框线"/>  <StrRes Name="234'+
'3" Text="没有边框"/>  <StrRes Name="2344" Text="阴影"/>  <StrRes Name="2345" Text="背景颜'+
'色"/>  <StrRes Name="2346" Text="外框颜色"/>  <StrRes Name="2347" Text="外框样式"/>  <Str'+
'Res Name="2348" Text="外框宽度"/>  <StrRes Name="2349" Text="标准"/>  <StrRes Name="23'+
'50" Text="新报表"/>  <StrRes Name="2351" Text="打开报表"/>  <StrRes Name="2352" Text="保'+
'存报表"/>  <StrRes Name="2353" Text="预览"/>  <StrRes Name="2354" Text="新报表页面"/>  <St'+
'rRes Name="2355" Text="新对话框"/>  <StrRes Name="2356" Text="删除页"/>  <StrRes Name="'+
'2357" Text="页面设置"/>  <StrRes Name="2358" Text="变量"/>  <StrRes Name="2359" Text="'+
'剪切"/>  <StrRes Name="2360" Text="复制"/>  <StrRes Name="2361" Text="粘贴"/>  <StrRes'+
' Name="2362" Text="复制格式"/>  <StrRes Name="2363" Text="撤消"/>  <StrRes Name="2364"'+
' Text="重复"/>  <StrRes Name="2365" Text="群组"/>  <StrRes Name="2366" Text="取消群组"/>'+
'  <StrRes Name="2367" Text="显示珊格"/>  <StrRes Name="2368" Text="珊格对齐"/>  <StrRes '+
'Name="2369" Text="Fit to Grid"/>  <StrRes Name="2370" Text="显示比率"/>  <StrRes Nam'+
'e="2371" Text="额外工具"/>  <StrRes Name="2372" Text="选取工具"/>  <StrRes Name="2373" T'+
'ext="徒手工具"/>  <StrRes Name="2374" Text="显示比率工具"/>  <StrRes Name="2375" Text="编辑文'+
'本工具"/>  <StrRes Name="2376" Text="复制格式工具"/>  <StrRes Name="2377" Text="插入Band"/>'+
'  <StrRes Name="2378" Text="文件(&amp;F)"/>  <StrRes Name="2379" Text="编辑(&amp;E)"'+
'/>  <StrRes Name="2380" Text="查找..."/>  <StrRes Name="2381" Text="找下一个"/>  <StrR'+
'es Name="2382" Text="替换..."/>  <StrRes Name="2383" Text="报表(&amp;R)"/>  <StrRes '+
'Name="2384" Text="数据..."/>  <StrRes Name="2385" Text="选项..."/>  <StrRes Name="23'+
'86" Text="样式..."/>  <StrRes Name="2387" Text="视图(&amp;V)"/>  <StrRes Name="2388"'+
' Text="工具栏"/>  <StrRes Name="2389" Text="标准"/>  <StrRes Name="2390" Text="文本"/> '+
' <StrRes Name="2391" Text="矩形"/>  <StrRes Name="2392" Text="对齐"/>  <StrRes Name='+
'"2393" Text="其它"/>  <StrRes Name="2394" Text="对象查看器"/>  <StrRes Name="2395" Text'+
'="数据树"/>  <StrRes Name="2396" Text="报表树"/>  <StrRes Name="2397" Text="标尺"/>  <St'+
'rRes Name="2398" Text="向导"/>  <StrRes Name="2399" Text="删除向导"/>  <StrRes Name="2'+
'400" Text="选项..."/>  <StrRes Name="2401" Text="帮助(&amp;H)"/>  <StrRes Name="2402'+
'" Text="帮助..."/>  <StrRes Name="2403" Text="关于 FastReport..."/>  <StrRes Name="2'+
'404" Text="Tab 次序..."/>  <StrRes Name="2405" Text="撤消"/>  <StrRes Name="2406" Te'+
'xt="重复"/>  <StrRes Name="2407" Text="剪切"/>  <StrRes Name="2408" Text="复制"/>  <St'+
'rRes Name="2409" Text="粘贴"/>  <StrRes Name="2410" Text="群组"/>  <StrRes Name="241'+
'1" Text="取消群组"/>  <StrRes Name="2412" Text="删除"/>  <StrRes Name="2413" Text="删除页'+
'"/>  <StrRes Name="2414" Text="全选"/>  <StrRes Name="2415" Text="编辑..."/>  <StrRe'+
's Name="2416" Text="置于顶层"/>  <StrRes Name="2417" Text="置于底层"/>  <StrRes Name="24'+
'18" Text="新建..."/>  <StrRes Name="2419" Text="新报表"/>  <StrRes Name="2420" Text="'+
'新页面"/>  <StrRes Name="2421" Text="新对话框"/>  <StrRes Name="2422" Text="打开..."/>  <'+
'StrRes Name="2423" Text="保存"/>  <StrRes Name="2424" Text="另存为..."/>  <StrRes Nam'+
'e="2425" Text="变量..."/>  <StrRes Name="2426" Text="页面设置..."/>  <StrRes Name="242'+
'7" Text="预览"/>  <StrRes Name="2428" Text="退出"/>  <StrRes Name="2429" Text="报表抬头"'+
'/>  <StrRes Name="2430" Text="报表合计"/>  <StrRes Name="2431" Text="页首"/>  <StrRes '+
'Name="2432" Text="页尾"/>  <StrRes Name="2433" Text="头"/>  <StrRes Name="2434" Tex'+
't="尾"/>  <StrRes Name="2435" Text="主数据"/>  <StrRes Name="2436" Text="明细数据"/>  <S'+
'trRes Name="2437" Text="子明性数据"/>  <StrRes Name="2438" Text="第4阶数据"/>  <StrRes Na'+
'me="2439" Text="第5阶数据"/>  <StrRes Name="2440" Text="第6阶数据"/>  <StrRes Name="2441'+
'" Text="群组首"/>  <StrRes Name="2442" Text="群组尾"/>  <StrRes Name="2443" Text="子"/>'+
'  <StrRes Name="2444" Text="栏首"/>  <StrRes Name="2445" Text="栏尾"/>  <StrRes Name'+
'="2446" Text="重叠"/>  <StrRes Name="2447" Text="垂直Band"/>  <StrRes Name="2448" Te'+
'xt="头"/>  <StrRes Name="2449" Text="尾"/>  <StrRes Name="2450" Text="主数据"/>  <Str'+
'Res Name="2451" Text="明细数据"/>  <StrRes Name="2452" Text="子明细数据"/>  <StrRes Name='+
'"2453" Text="群组首"/>  <StrRes Name="2454" Text="群组尾"/>  <StrRes Name="2455" Text='+
'"子"/>  <StrRes Name="2456" Text="0度"/>  <StrRes Name="2457" Text="45度"/>  <StrRe'+
's Name="2458" Text="90度"/>  <StrRes Name="2459" Text="180度"/>  <StrRes Name="246'+
'0" Text="270度"/>  <StrRes Name="2461" Text="字体设置"/>  <StrRes Name="2462" Text="粗'+
'体"/>  <StrRes Name="2463" Text="斜体"/>  <StrRes Name="2464" Text="底线"/>  <StrRes '+
'Name="2465" Text="SuperScript"/>  <StrRes Name="2466" Text="SubScript"/>  <StrRe'+
's Name="2467" Text="压缩"/>  <StrRes Name="2468" Text="宽"/>  <StrRes Name="2469" T'+
'ext="12 cpi"/>  <StrRes Name="2470" Text="15 cpi"/>  <StrRes Name="2471" Text="R'+
'eport (*.fr3)|*.fr3"/>  <StrRes Name="2472" Text="Pascal files (*.pas)|*.pas|C++'+
' files (*.cpp)|*.cpp|JavaScript files (*.js)|*.js|Basic files (*.vb)|*.vb|All fi'+
'les|*.*"/>  <StrRes Name="2473" Text="Pascal files (*.pas)|*.pas|C++ files (*.cp'+
'p)|*.cpp|JavaScript files (*.js)|*.js|Basic files (*.vb)|*.vb|All files|*.*"/>  '+
'<StrRes Name="2474" Text="连接..."/>  <StrRes Name="2475" Text="语言"/>  <StrRes Nam'+
'e="2476" Text="放置断点"/>  <StrRes Name="2477" Text="运行到光标处"/>  <StrRes Name="2478"'+
' Text="!添加子band"/>  <StrRes Name="dsCm" Text="厘米"/>  <StrRes Name="dsInch" Text='+
'"英寸"/>  <StrRes Name="dsPix" Text="像素"/>  <StrRes Name="dsChars" Text="字符"/>  <S'+
'trRes Name="dsCode" Text="代码"/>  <StrRes Name="dsData" Text="数据"/>  <StrRes Name'+
'="dsPage" Text="页"/>  <StrRes Name="dsRepFilter" Text="Report (*.fr3)|*.fr3"/>  '+
'<StrRes Name="dsComprRepFilter" Text="Compressed report (*.fr3)|*.fr3"/>  <StrRe'+
's Name="dsSavePreviewChanges" Text="保存变更至预览页面?"/>  <StrRes Name="dsSaveChangesTo'+
'" Text="保存修改至 "/>  <StrRes Name="dsCantLoad" Text="无法载入文件"/>  <StrRes Name="dsSt'+
'yleFile" Text="样式"/>  <StrRes Name="dsCantFindProc" Text="找不到主过程"/>  <StrRes Nam'+
'e="dsClearScript" Text="清除所有的脚本，你要继续吗?"/>  <StrRes Name="dsNoStyle" Text="没有样式"/'+
'>  <StrRes Name="dsStyleSample" Text="样式范例"/>  <StrRes Name="dsTextNotFound" Tex'+
't="文本 ''%s'' 找不到"/>  <StrRes Name="dsReplace" Text="替换文本 ''%s''?"/>  <StrRes Name="2'+
'600" Text="关于 FastReport"/>  <StrRes Name="2601" Text="访问我们的网站以取得更多的信息:"/>  <Str'+
'Res Name="2602" Text="销售:"/>  <StrRes Name="2603" Text="支援:"/>  <StrRes Name="27'+
'00" Text="页面设置"/>  <StrRes Name="2701" Text="纸张"/>  <StrRes Name="2702" Text="宽度'+
'"/>  <StrRes Name="2703" Text="高度"/>  <StrRes Name="2704" Text="大小"/>  <StrRes N'+
'ame="2705" Text="方向"/>  <StrRes Name="2706" Text="左边距"/>  <StrRes Name="2707" Te'+
'xt="上边距"/>  <StrRes Name="2708" Text="右边距"/>  <StrRes Name="2709" Text="下边距"/>  '+
'<StrRes Name="2710" Text="边距"/>  <StrRes Name="2711" Text="纸张来源"/>  <StrRes Name'+
'="2712" Text="第一页"/>  <StrRes Name="2713" Text="其他页"/>  <StrRes Name="2714" Text'+
'="纵向"/>  <StrRes Name="2715" Text="横向"/>  <StrRes Name="2716" Text="其他选项"/>  <St'+
'rRes Name="2717" Text="分栏"/>  <StrRes Name="2718" Text="栏数"/>  <StrRes Name="271'+
'9" Text="栏间距"/>  <StrRes Name="2720" Text="位置"/>  <StrRes Name="2721" Text="其他"/'+
'>  <StrRes Name="2722" Text="双面打印"/>  <StrRes Name="2723" Text="打印至前一页"/>  <StrR'+
'es Name="2724" Text="伸展至打印区"/>  <StrRes Name="2725" Text="在设计模式使用大的纸张高度"/>  <Str'+
'Res Name="2726" Text="无限页宽"/>  <StrRes Name="2727" Text="无限页高"/>  <StrRes Name="'+
'2800" Text="选取报表数据库"/>  <StrRes Name="2900" Text="编辑变量"/>  <StrRes Name="2901" T'+
'ext="类别"/>  <StrRes Name="2902" Text="变量"/>  <StrRes Name="2903" Text="编辑"/>  <S'+
'trRes Name="2904" Text="删除"/>  <StrRes Name="2905" Text="清单"/>  <StrRes Name="29'+
'06" Text="载入"/>  <StrRes Name="2907" Text="保存"/>  <StrRes Name="2908" Text=" 运算式'+
':"/>  <StrRes Name="2909" Text="Dictionary (*.fd3)|*.fd3"/>  <StrRes Name="2910"'+
' Text="Dictionary (*.fd3)|*.fd3"/>  <StrRes Name="vaNoVar" Text="(未定义变量)"/>  <St'+
'rRes Name="vaVar" Text="变量"/>  <StrRes Name="vaDupName" Text="名称重复"/>  <StrRes N'+
'ame="3000" Text="设计选项"/>  <StrRes Name="3001" Text="珊格"/>  <StrRes Name="3002" T'+
'ext="类型"/>  <StrRes Name="3003" Text="大小"/>  <StrRes Name="3004" Text="对话框:"/>  '+
'<StrRes Name="3005" Text="其他"/>  <StrRes Name="3006" Text="字体"/>  <StrRes Name="'+
'3007" Text="代码编辑器"/>  <StrRes Name="3008" Text="文本编辑器"/>  <StrRes Name="3009" Te'+
'xt="大小"/>  <StrRes Name="3010" Text="大小"/>  <StrRes Name="3011" Text="颜色"/>  <St'+
'rRes Name="3012" Text="间距:"/>  <StrRes Name="3013" Text="cm"/>  <StrRes Name="30'+
'14" Text="in"/>  <StrRes Name="3015" Text="pt"/>  <StrRes Name="3016" Text="pt"/'+
'>  <StrRes Name="3017" Text="pt"/>  <StrRes Name="3018" Text="毫米:"/>  <StrRes Na'+
'me="3019" Text="英寸:"/>  <StrRes Name="3020" Text="像素:"/>  <StrRes Name="3021" Te'+
'xt="显示珊格"/>  <StrRes Name="3022" Text="珊格对齐"/>  <StrRes Name="3023" Text="插入后显示编'+
'辑器"/>  <StrRes Name="3024" Text="使用对象的字体设置"/>  <StrRes Name="3025" Text="工作空间"/>'+
'  <StrRes Name="3026" Text="工具视窗"/>  <StrRes Name="3027" Text="LCD 珊格颜色"/>  <Str'+
'Res Name="3028" Text="自由摆设Band的位置"/>  <StrRes Name="3029" Text="显示下拉field列表"/>  '+
'<StrRes Name="3030" Text="显示启始屏幕"/>  <StrRes Name="3031" Text="还原默认设置"/>  <StrRe'+
's Name="3032" Text="显示Band的标题"/>  <StrRes Name="3100" Text="选取数据库"/>  <StrRes Na'+
'me="3101" Text="记录数量:"/>  <StrRes Name="dbNotAssigned" Text="[未指定]"/>  <StrRes N'+
'ame="3200" Text="群组"/>  <StrRes Name="3201" Text="群组分隔于"/>  <StrRes Name="3202" '+
'Text="选项"/>  <StrRes Name="3203" Text="数据字段"/>  <StrRes Name="3204" Text="运算式"/>'+
'  <StrRes Name="3205" Text="保持与群组在一起"/>  <StrRes Name="3206" Text="换页"/>  <StrRe'+
's Name="3207" Text="显示在大纲"/>  <StrRes Name="3300" Text="系统备忘"/>  <StrRes Name="3'+
'301" Text="数据band"/>  <StrRes Name="3302" Text="数据库"/>  <StrRes Name="3303" Text'+
'="数据字段"/>  <StrRes Name="3304" Text="函数"/>  <StrRes Name="3305" Text="表示式"/>  <S'+
'trRes Name="3306" Text="聚合值"/>  <StrRes Name="3307" Text="系统变量"/>  <StrRes Name='+
'"3308" Text="计算不可见band的数目"/>  <StrRes Name="3309" Text="文本"/>  <StrRes Name="331'+
'0" Text="执行总数"/>  <StrRes Name="agAggregate" Text="插入合计"/>  <StrRes Name="vt1" T'+
'ext="[DATE]"/>  <StrRes Name="vt2" Text="[TIME]"/>  <StrRes Name="vt3" Text="[PA'+
'GE#]"/>  <StrRes Name="vt4" Text="[TOTALPAGES#]"/>  <StrRes Name="vt5" Text="[PA'+
'GE#] of [TOTALPAGES#]"/>  <StrRes Name="vt6" Text="[LINE#]"/>  <StrRes Name="340'+
'0" Text="OLE 对象"/>  <StrRes Name="3401" Text="插入..."/>  <StrRes Name="3402" Text'+
'="编辑..."/>  <StrRes Name="3403" Text="关闭"/>  <StrRes Name="olStretched" Text="St'+
'retched"/>  <StrRes Name="3500" Text="条码编辑器"/>  <StrRes Name="3501" Text="码"/>  '+
'<StrRes Name="3502" Text="条码类型"/>  <StrRes Name="3503" Text="比率:"/>  <StrRes Nam'+
'e="3504" Text="选项"/>  <StrRes Name="3505" Text="旋转"/>  <StrRes Name="3506" Text='+
'"计算检查码 "/>  <StrRes Name="3507" Text="文本"/>  <StrRes Name="3508" Text="0度"/>  <S'+
'trRes Name="3509" Text="90度"/>  <StrRes Name="3510" Text="180度"/>  <StrRes Name='+
'"3511" Text="270度"/>  <StrRes Name="bcCalcChecksum" Text="计算检查码"/>  <StrRes Name'+
'="bcShowText" Text="显示文本"/>  <StrRes Name="3600" Text="编辑别名"/>  <StrRes Name="36'+
'01" Text="按 Enter 编辑项目"/>  <StrRes Name="3602" Text="数据库别名"/>  <StrRes Name="360'+
'3" Text="字段别名"/>  <StrRes Name="3604" Text="重置"/>  <StrRes Name="3605" Text="更新"'+
'/>  <StrRes Name="alUserName" Text="使用者名称"/>  <StrRes Name="alOriginal" Text="原来'+
'的名称"/>  <StrRes Name="3700" Text="参数编辑器"/>  <StrRes Name="qpName" Text="名称"/>  <'+
'StrRes Name="qpDataType" Text="数据类型"/>  <StrRes Name="qpValue" Text="值"/>  <StrR'+
'es Name="3800" Text="主-从 连结"/>  <StrRes Name="3801" Text="Detail 字段"/>  <StrRes '+
'Name="3802" Text="Master 字段"/>  <StrRes Name="3803" Text="Linked 字段"/>  <StrRes '+
'Name="3804" Text="新增"/>  <StrRes Name="3805" Text="清除"/>  <StrRes Name="3900" Te'+
'xt="备忘"/>  <StrRes Name="3901" Text="插入运算式"/>  <StrRes Name="3902" Text="插入合计"/>'+
'  <StrRes Name="3903" Text="插入输出格式"/>  <StrRes Name="3904" Text="文本自动换行"/>  <Str'+
'Res Name="3905" Text="文本"/>  <StrRes Name="3906" Text="格式"/>  <StrRes Name="3907'+
'" Text="突显"/>  <StrRes Name="4000" Text="图像"/>  <StrRes Name="4001" Text="载入"/> '+
' <StrRes Name="4002" Text="复制"/>  <StrRes Name="4003" Text="粘贴"/>  <StrRes Name='+
'"4004" Text="清除"/>  <StrRes Name="piEmpty" Text="清空"/>  <StrRes Name="4100" Text'+
'="统计图编辑器"/>  <StrRes Name="4101" Text="新增系列"/>  <StrRes Name="4102" Text="删除系列"/'+
'>  <StrRes Name="4103" Text="编辑图表"/>  <StrRes Name="4104" Text="Band 数据源"/>  <St'+
'rRes Name="4105" Text="固定数据"/>  <StrRes Name="4106" Text="数据库"/>  <StrRes Name="'+
'4107" Text="Data 数据源"/>  <StrRes Name="4108" Text="值"/>  <StrRes Name="4109" Tex'+
't="选择图表系列或新增一个系列."/>  <StrRes Name="4114" Text="其他选项"/>  <StrRes Name="4115" Tex'+
't="前N名的值"/>  <StrRes Name="4116" Text="前N名的标题"/>  <StrRes Name="4117" Text="排列顺序'+
'"/>  <StrRes Name="4126" Text="X 轴"/>  <StrRes Name="ch3D" Text="3D 查看"/>  <StrR'+
'es Name="chAxis" Text="显示轴"/>  <StrRes Name="chsoNone" Text="无"/>  <StrRes Name='+
'"chsoAscending" Text="递增"/>  <StrRes Name="chsoDescending" Text="递减"/>  <StrRes '+
'Name="chxtText" Text="文本"/>  <StrRes Name="chxtNumber" Text="数值"/>  <StrRes Name'+
'="chxtDate" Text="日期"/>  <StrRes Name="4200" Text="RTF 文件编辑器"/>  <StrRes Name="4'+
'201" Text="打开文件"/>  <StrRes Name="4202" Text="保存文件"/>  <StrRes Name="4203" Text='+
'"  原"/>  <StrRes Name="4204" Text="字体"/>  <StrRes Name="4205" Text="插入运算式"/>  <S'+
'trRes Name="4206" Text="粗体"/>  <StrRes Name="4207" Text="斜体"/>  <StrRes Name="42'+
'08" Text="底线"/>  <StrRes Name="4209" Text="左对齐"/>  <StrRes Name="4210" Text="居中"'+
'/>  <StrRes Name="4211" Text="右对齐"/>  <StrRes Name="4212" Text="区块对齐"/>  <StrRes'+
' Name="4213" Text="著重号"/>  <StrRes Name="4300" Text="交叉报表编辑器"/>  <StrRes Name="4'+
'301" Text="来源数据"/>  <StrRes Name="4302" Text="空间"/>  <StrRes Name="4303" Text="列'+
'"/>  <StrRes Name="4304" Text="栏"/>  <StrRes Name="4305" Text="小方格"/>  <StrRes N'+
'ame="4306" Text="交叉报表结构"/>  <StrRes Name="4307" Text="列首"/>  <StrRes Name="4308"'+
' Text="栏首"/>  <StrRes Name="4309" Text="列总计"/>  <StrRes Name="4310" Text="栏总计"/>'+
'  <StrRes Name="4311" Text="列/栏互换"/>  <StrRes Name="4312" Text="!选择样式"/>  <StrRe'+
's Name="4313" Text="!保存当前样式..."/>  <StrRes Name="4314" Text="!显示标题"/>  <StrRes N'+
'ame="4315" Text="!显示转角"/>  <StrRes Name="4316" Text="!在新页面上打印页头"/>  <StrRes Name'+
'="4317" Text="!自动大小"/>  <StrRes Name="4318" Text="!围绕单元格的边框"/>  <StrRes Name="43'+
'19" Text="!往下打印然后交叉"/>  <StrRes Name="4320" Text="!并排单元格"/>  <StrRes Name="4321"'+
' Text="!连接相等单元格"/>  <StrRes Name="4322" Text="无"/>  <StrRes Name="4323" Text="合计'+
'"/>  <StrRes Name="4324" Text="最小值"/>  <StrRes Name="4325" Text="最大值"/>  <StrRes'+
' Name="4326" Text="平均值"/>  <StrRes Name="4327" Text="计数"/>  <StrRes Name="4328" '+
'Text="递增 (A-Z)"/>  <StrRes Name="4329" Text="递减 (Z-A)"/>  <StrRes Name="4330" Te'+
'xt="不排序"/>  <StrRes Name="crStName" Text="!输入样式名:"/>  <StrRes Name="crResize" Te'+
'xt="!重置交叉表大小,请设置&#38;#34;AutoSize&#38;#34;属性为&#38;#34;False&#38;#34; ."/>  <StrR'+
'es Name="crSubtotal" Text="小计"/>  <StrRes Name="crNone" Text="无"/>  <StrRes Name'+
'="crSum" Text="合计"/>  <StrRes Name="crMin" Text="最小值"/>  <StrRes Name="crMax" Te'+
'xt="最大值"/>  <StrRes Name="crAvg" Text="平均值"/>  <StrRes Name="crCount" Text="计数"/'+
'>  <StrRes Name="crAsc" Text="A-Z"/>  <StrRes Name="crDesc" Text="Z-A"/>  <StrRe'+
's Name="crFillMx" Text="填入交叉报表中..."/>  <StrRes Name="crBuildMx" Text="建立交叉报表中...'+
'"/>  <StrRes Name="4400" Text="运算式编辑器"/>  <StrRes Name="4401" Text="运算式:"/>  <St'+
'rRes Name="4500" Text="显示格式"/>  <StrRes Name="4501" Text="类别"/>  <StrRes Name="4'+
'502" Text="格式"/>  <StrRes Name="4503" Text="格式字串:"/>  <StrRes Name="4504" Text="'+
'小数点分隔字元:"/>  <StrRes Name="fkText" Text="文本 (未格式化)"/>  <StrRes Name="fkNumber" T'+
'ext="数字"/>  <StrRes Name="fkDateTime" Text="日期/时间"/>  <StrRes Name="fkBoolean" T'+
'ext="布林"/>  <StrRes Name="fkNumber1" Text="1234.5;%g"/>  <StrRes Name="fkNumber2'+
'" Text="1234.50;%2.2f"/>  <StrRes Name="fkNumber3" Text="1,234.50;%2.2n"/>  <Str'+
'Res Name="fkNumber4" Text="$1,234.50;%2.2m"/>  <StrRes Name="fkDateTime1" Text="'+
'11.28.2002;mm.dd.yyyy"/>  <StrRes Name="fkDateTime2" Text="28 nov 2002;dd mmm yy'+
'yy"/>  <StrRes Name="fkDateTime3" Text="November 28, 2002;mmmm dd, yyyy"/>  <Str'+
'Res Name="fkDateTime4" Text="02:14;hh:mm"/>  <StrRes Name="fkDateTime5" Text="02'+
':14am;hh:mm am/pm"/>  <StrRes Name="fkDateTime6" Text="02:14:00;hh:mm:ss"/>  <St'+
'rRes Name="fkDateTime7" Text="02:14am, November 28, 2002;hh:mm am/pm, mmmm dd, y'+
'yyy"/>  <StrRes Name="fkBoolean1" Text="0,1;0,1"/>  <StrRes Name="fkBoolean2" Te'+
'xt="No,Yes;No,Yes"/>  <StrRes Name="fkBoolean3" Text="_,x;_,x"/>  <StrRes Name="'+
'fkBoolean4" Text="False,True;False,True"/>  <StrRes Name="4600" Text="突显"/>  <St'+
'rRes Name="4601" Text="颜色..."/>  <StrRes Name="4602" Text="颜色..."/>  <StrRes Nam'+
'e="4603" Text="条件"/>  <StrRes Name="4604" Text="字体"/>  <StrRes Name="4605" Text='+
'"背景"/>  <StrRes Name="4606" Text="粗体"/>  <StrRes Name="4607" Text="斜体"/>  <StrRe'+
's Name="4608" Text="底线"/>  <StrRes Name="4609" Text="透明"/>  <StrRes Name="4610" '+
'Text="其他"/>  <StrRes Name="4700" Text="报表设置"/>  <StrRes Name="4701" Text="常规"/> '+
' <StrRes Name="4702" Text="打印机设置"/>  <StrRes Name="4703" Text="打印份数"/>  <StrRes '+
'Name="4704" Text="常规"/>  <StrRes Name="4705" Text="密码"/>  <StrRes Name="4706" Te'+
'xt="自动分页"/>  <StrRes Name="4707" Text="两遍过程"/>  <StrRes Name="4708" Text="空打印"/>'+
'  <StrRes Name="4709" Text="描述"/>  <StrRes Name="4710" Text="名称"/>  <StrRes Name'+
'="4711" Text="描述"/>  <StrRes Name="4712" Text="图像"/>  <StrRes Name="4713" Text="'+
'作者"/>  <StrRes Name="4714" Text="Major"/>  <StrRes Name="4715" Text="Minor"/>  <'+
'StrRes Name="4716" Text="Release"/>  <StrRes Name="4717" Text="Build"/>  <StrRes'+
' Name="4718" Text="建立"/>  <StrRes Name="4719" Text="修改"/>  <StrRes Name="4720" T'+
'ext="描述"/>  <StrRes Name="4721" Text="版本"/>  <StrRes Name="4722" Text="浏览..."/> '+
' <StrRes Name="4723" Text="继承设置"/>  <StrRes Name="4724" Text="选项:"/>  <StrRes Na'+
'me="4725" Text="不改变"/>  <StrRes Name="4726" Text="分离基本报表"/>  <StrRes Name="4727"'+
' Text="继承基本报表:"/>  <StrRes Name="4728" Text="继承"/>  <StrRes Name="rePrnOnPort" T'+
'ext="在"/>  <StrRes Name="riNotInherited" Text="报表不是继承的."/>  <StrRes Name="riInhe'+
'rited" Text="报表是从基本报表继承的: %s"/>  <StrRes Name="4800" Text="字串清单"/>  <StrRes Name'+
'="4900" Text="SQL"/>  <StrRes Name="4901" Text="Query 创建"/>  <StrRes Name="5000"'+
' Text="密码"/>  <StrRes Name="5001" Text="输入密码:"/>  <StrRes Name="5100" Text="样式编辑'+
'器"/>  <StrRes Name="5101" Text="颜色..."/>  <StrRes Name="5102" Text="字体..."/>  <S'+
'trRes Name="5103" Text="外框..."/>  <StrRes Name="5104" Text="加入"/>  <StrRes Name='+
'"5105" Text="删除"/>  <StrRes Name="5106" Text="编辑"/>  <StrRes Name="5107" Text="载'+
'入"/>  <StrRes Name="5108" Text="保存"/>  <StrRes Name="5200" Text="外框编辑器"/>  <StrR'+
'es Name="5201" Text="外框"/>  <StrRes Name="5202" Text="框线"/>  <StrRes Name="5203"'+
' Text="阴影"/>  <StrRes Name="5204" Text="上线"/>  <StrRes Name="5205" Text="底线"/>  '+
'<StrRes Name="5206" Text="左线"/>  <StrRes Name="5207" Text="右线"/>  <StrRes Name="'+
'5208" Text="外框线"/>  <StrRes Name="5209" Text="无框线"/>  <StrRes Name="5210" Text="'+
'外框颜色"/>  <StrRes Name="5211" Text="外框样式"/>  <StrRes Name="5212" Text="外框宽度"/>  <'+
'StrRes Name="5213" Text="阴影"/>  <StrRes Name="5214" Text="阴影颜色"/>  <StrRes Name='+
'"5215" Text="阴影宽度"/>  <StrRes Name="5300" Text="新项目"/>  <StrRes Name="5301" Text'+
'="项目"/>  <StrRes Name="5302" Text="模板"/>  <StrRes Name="5303" Text="继承报表"/>  <St'+
'rRes Name="5400" Text="Tab键次序"/>  <StrRes Name="5401" Text="控制项的Tab键次序:"/>  <Str'+
'Res Name="5402" Text="上移"/>  <StrRes Name="5403" Text="下移"/>  <StrRes Name="5500'+
'" Text="求值"/>  <StrRes Name="5501" Text="运算式"/>  <StrRes Name="5502" Text="结果"/>'+
'  <StrRes Name="5600" Text="报表向导"/>  <StrRes Name="5601" Text="数据"/>  <StrRes Na'+
'me="5602" Text="Fields"/>  <StrRes Name="5603" Text="群组"/>  <StrRes Name="5604" '+
'Text="格式"/>  <StrRes Name="5605" Text="样式"/>  <StrRes Name="5606" Text="第一步:选择数据'+
'集."/>  <StrRes Name="5607" Text="第二步:选择显示字段. "/>  <StrRes Name="5608" Text="第三步:'+
'创建分组(可选). "/>  <StrRes Name="5609" Text="第四步:定义页方向和数据布局. "/>  <StrRes Name="5610'+
'" Text="第五步:选择报表样式."/>  <StrRes Name="5611" Text="加入 &#62;"/>  <StrRes Name="561'+
'2" Text="全部加入 &#62;&#62;"/>  <StrRes Name="5613" Text="&#60; 移除"/>  <StrRes Name'+
'="5614" Text="&#60;&#60; 全部移除"/>  <StrRes Name="5615" Text="加入 &#62;"/>  <StrRes'+
' Name="5616" Text="&#60; 移除"/>  <StrRes Name="5617" Text="选取的字段:"/>  <StrRes Nam'+
'e="5618" Text="可用的字段:"/>  <StrRes Name="5619" Text="群组:"/>  <StrRes Name="5620" '+
'Text="方向"/>  <StrRes Name="5621" Text="格式"/>  <StrRes Name="5622" Text="纵向"/>  <'+
'StrRes Name="5623" Text="横向"/>  <StrRes Name="5624" Text="表格式"/>  <StrRes Name="'+
'5625" Text="分栏式"/>  <StrRes Name="5626" Text="调整字段至页面宽度"/>  <StrRes Name="5627" '+
'Text="&#60;&#60; 上一步"/>  <StrRes Name="5628" Text="下一步 &#62;&#62;"/>  <StrRes Na'+
'me="5629" Text="完成"/>  <StrRes Name="5630" Text="新建表..."/>  <StrRes Name="5631" '+
'Text="新建查询..."/>  <StrRes Name="5632" Text="选择数据库连接:"/>  <StrRes Name="5633" Tex'+
't="选择表:"/>  <StrRes Name="5634" Text="或"/>  <StrRes Name="5635" Text="创建一个查询..."'+
'/>  <StrRes Name="5636" Text="配置连接"/>  <StrRes Name="wzStd" Text="标准报表向导"/>  <St'+
'rRes Name="wzDMP" Text="点矩阵报表向导"/>  <StrRes Name="wzStdEmpty" Text="标准报表"/>  <St'+
'rRes Name="wzDMPEmpty" Text="点矩阵报表"/>  <StrRes Name="5700" Text="连接向导"/>  <StrRe'+
's Name="5701" Text="连接"/>  <StrRes Name="5702" Text="选择连接类型:"/>  <StrRes Name="5'+
'703" Text="选择数据库:"/>  <StrRes Name="5704" Text="登录"/>  <StrRes Name="5705" Text='+
'"密码"/>  <StrRes Name="5706" Text="登录提示"/>  <StrRes Name="5707" Text="用户登录名/密码:"/'+
'>  <StrRes Name="5708" Text="表"/>  <StrRes Name="5709" Text="选择表名:"/>  <StrRes N'+
'ame="5710" Text="过滤记录:"/>  <StrRes Name="5711" Text="查询"/>  <StrRes Name="5712" '+
'Text="SQL语句:"/>  <StrRes Name="5713" Text="查询创建"/>  <StrRes Name="5714" Text="编辑'+
'查询参数"/>  <StrRes Name="ftAllFiles" Text="所有文件"/>  <StrRes Name="ftPictures" Text'+
'="图片"/>  <StrRes Name="ftDB" Text="数据库"/>  <StrRes Name="ftRichFile" Text="RichT'+
'ext 文件"/>  <StrRes Name="ftTextFile" Text="Text 文件"/>  <StrRes Name="prNotAssign'+
'ed" Text="(未设置)"/>  <StrRes Name="prInvProp" Text="无效属性值"/>  <StrRes Name="prDup'+
'l" Text="重复的名称"/>  <StrRes Name="prPict" Text="(图片)"/>  <StrRes Name="mvExpr" Te'+
'xt="允许表达式"/>  <StrRes Name="mvStretch" Text="伸缩"/>  <StrRes Name="mvStretchToMax'+
'" Text="伸缩到最大高度"/>  <StrRes Name="mvShift" Text="切换"/>  <StrRes Name="mvShiftOve'+
'r" Text="重叠时切换"/>  <StrRes Name="mvVisible" Text="可见的"/>  <StrRes Name="mvPrinta'+
'ble" Text="可打印的"/>  <StrRes Name="mvFont" Text="字体..."/>  <StrRes Name="mvFormat'+
'" Text="显示格式..."/>  <StrRes Name="mvClear" Text="清除内容"/>  <StrRes Name="mvAutoWi'+
'dth" Text="自动宽度"/>  <StrRes Name="mvWWrap" Text="自动换行"/>  <StrRes Name="mvSuppre'+
'ss" Text="抑制重复值"/>  <StrRes Name="mvHideZ" Text="隐藏0"/>  <StrRes Name="mvHTML" T'+
'ext="允许HTML标记"/>  <StrRes Name="lvDiagonal" Text="斜纹的"/>  <StrRes Name="pvAutoSi'+
'ze" Text="自动大小"/>  <StrRes Name="pvCenter" Text="中间"/>  <StrRes Name="pvAspect" '+
'Text="保持纵横比率"/>  <StrRes Name="bvSplit" Text="允许切分"/>  <StrRes Name="bvKeepChild'+
'" Text="Keep Child Together"/>  <StrRes Name="bvPrintChild" Text=" 若可视则打印 Child"'+
'/>  <StrRes Name="bvStartPage" Text="开始新页面"/>  <StrRes Name="bvPrintIfEmpty" Tex'+
't="若明细为空,打印 "/>  <StrRes Name="bvKeepDetail" Text="保持明细聚在一起"/>  <StrRes Name="bv'+
'KeepFooter" Text="保持脚注聚在一起"/>  <StrRes Name="bvReprint" Text="在新的页面上重打印"/>  <Str'+
'Res Name="bvOnFirst" Text="在第一页上打印"/>  <StrRes Name="bvOnLast" Text="在最后一页上打印"/>'+
'  <StrRes Name="bvKeepGroup" Text="保持聚集"/>  <StrRes Name="bvFooterAfterEach" Tex'+
't="每行后脚注"/>  <StrRes Name="bvDrillDown" Text="钻取"/>  <StrRes Name="bvResetPageNo'+
'" Text="重置页号"/>  <StrRes Name="srParent" Text="在Parent上打印"/>  <StrRes Name="obCa'+
'tDraw" Text="绘制"/>  <StrRes Name="obCatOther" Text="其它对象"/>  <StrRes Name="obCat'+
'OtherControls" Text="其它控件"/>  <StrRes Name="obDiagLine" Text="斜线"/>  <StrRes Nam'+
'e="obRect" Text="方框"/>  <StrRes Name="obRoundRect" Text="圆框"/>  <StrRes Name="ob'+
'Ellipse" Text="椭圆"/>  <StrRes Name="obTrian" Text="三角"/>  <StrRes Name="obDiamon'+
'd" Text="菱形"/>  <StrRes Name="obLabel" Text="文本控件"/>  <StrRes Name="obEdit" Text'+
'="编辑控件"/>  <StrRes Name="obMemoC" Text="Memo控件"/>  <StrRes Name="obButton" Text='+
'"按钮控件"/>  <StrRes Name="obChBoxC" Text="复选框控件"/>  <StrRes Name="obRButton" Text='+
'"单选框控件"/>  <StrRes Name="obLBox" Text="列表框控件"/>  <StrRes Name="obCBox" Text="Com'+
'bo框控件"/>  <StrRes Name="obDateEdit" Text="日期控件"/>  <StrRes Name="obImageC" Text='+
'"图像控件"/>  <StrRes Name="obPanel" Text="面板控件"/>  <StrRes Name="obGrBox" Text="组框控'+
'件"/>  <StrRes Name="obBBtn" Text="BitBtn控件"/>  <StrRes Name="obSBtn" Text="Speed'+
'Button控件"/>  <StrRes Name="obMEdit" Text="掩码编辑框控件"/>  <StrRes Name="obChLB" Text'+
'="复选列表框控件"/>  <StrRes Name="obDBLookup" Text="数据查询Combo控件"/>  <StrRes Name="obBe'+
'vel" Text="Bevel对象"/>  <StrRes Name="obShape" Text="形状对象"/>  <StrRes Name="obTex'+
't" Text="文本对象"/>  <StrRes Name="obSysText" Text="系统文本"/>  <StrRes Name="obLine" '+
'Text="线型对象"/>  <StrRes Name="obPicture" Text="图片对象"/>  <StrRes Name="obBand" Tex'+
't="Band对象"/>  <StrRes Name="obDataBand" Text="数据对象"/>  <StrRes Name="obSubRep" T'+
'ext="子报表对象"/>  <StrRes Name="obDlgPage" Text="对话框表单"/>  <StrRes Name="obRepPage"'+
' Text="报表页面"/>  <StrRes Name="obReport" Text="报表对象"/>  <StrRes Name="obRich" Tex'+
't="rich文本对象"/>  <StrRes Name="obOLE" Text="OLE对象"/>  <StrRes Name="obChBox" Text'+
'="复选框对象"/>  <StrRes Name="obChart" Text="图表对象"/>  <StrRes Name="obBarC" Text="条形'+
'码对象"/>  <StrRes Name="obCross" Text="交叉表对象"/>  <StrRes Name="obDBCross" Text="DB'+
' 交叉表对象"/>  <StrRes Name="obGrad" Text="渐进色对象"/>  <StrRes Name="obDMPText" Text="'+
'点阵文本对象"/>  <StrRes Name="obDMPLine" Text="点阵线型对象"/>  <StrRes Name="obDMPCmd" Tex'+
't="点阵命令对象"/>  <StrRes Name="obBDEDB" Text="BDE数据库"/>  <StrRes Name="obBDETb" Tex'+
't="BDE表"/>  <StrRes Name="obBDEQ" Text="BDE查询"/>  <StrRes Name="obBDEComps" Text'+
'="BDE组件"/>  <StrRes Name="obIBXDB" Text="IBX数据库"/>  <StrRes Name="obIBXTb" Text='+
'"IBX表"/>  <StrRes Name="obIBXQ" Text="IBX查询"/>  <StrRes Name="obIBXComps" Text="'+
'IBX组件"/>  <StrRes Name="obADODB" Text="ADO数据库"/>  <StrRes Name="obADOTb" Text="A'+
'DO表"/>  <StrRes Name="obADOQ" Text="ADO查询"/>  <StrRes Name="obADOComps" Text="AD'+
'O组件"/>  <StrRes Name="obDBXDB" Text="DBX数据库"/>  <StrRes Name="obDBXTb" Text="DBX'+
'表"/>  <StrRes Name="obDBXQ" Text="DBX查询"/>  <StrRes Name="obDBXComps" Text="DBX组'+
'件"/>  <StrRes Name="obFIBDB" Text="FIB数据库"/>  <StrRes Name="obFIBTb" Text="FIB表"'+
'/>  <StrRes Name="obFIBQ" Text="FIB查询"/>  <StrRes Name="obFIBComps" Text="FIB组件"'+
'/>  <StrRes Name="ctString" Text="串"/>  <StrRes Name="ctDate" Text="日期和时间"/>  <S'+
'trRes Name="ctConv" Text="转化"/>  <StrRes Name="ctFormat" Text="格式化"/>  <StrRes N'+
'ame="ctMath" Text="数学"/>  <StrRes Name="ctOther" Text="其它"/>  <StrRes Name="IntT'+
'oStr" Text="整型值转换为串"/>  <StrRes Name="FloatToStr" Text="浮点型值转换为串"/>  <StrRes Nam'+
'e="DateToStr" Text="日期型值转换为串"/>  <StrRes Name="TimeToStr" Text="时间型值转换为串"/>  <St'+
'rRes Name="DateTimeToStr" Text="浮点型值转换为串"/>  <StrRes Name="VarToStr" Text="varia'+
'nt转换为串"/>  <StrRes Name="StrToInt" Text="串转换为整型值"/>  <StrRes Name="StrToInt64" T'+
'ext="串转换为Int64值"/>  <StrRes Name="StrToFloat" Text="串转换为浮点值"/>  <StrRes Name="St'+
'rToDate" Text="串转换为日期格式"/>  <StrRes Name="StrToTime" Text="串转换为时间格式"/>  <StrRes '+
'Name="StrToDateTime" Text="串转换为日期-时间格式"/>  <StrRes Name="Format" Text="从一系列数组参数返'+
'回格式化串集"/>  <StrRes Name="FormatFloat" Text="格式化浮点值"/>  <StrRes Name="FormatDateT'+
'ime" Text="格式化日期-时间值"/>  <StrRes Name="FormatMaskText" Text="用掩码编辑返回一个格式化串"/>  <'+
'StrRes Name="EncodeDate" Text="用指定的年、月、日返回日期类型"/>  <StrRes Name="DecodeDate" Tex'+
't="分解日期类型值为年、月、日值"/>  <StrRes Name="EncodeTime" Text="用指定的时、分、秒返回时间类型"/>  <StrRe'+
's Name="DecodeTime" Text="分解时间类型值为时、分、秒值"/>  <StrRes Name="Date" Text="返回当前日期"/>'+
'  <StrRes Name="Time" Text="返回当前时间"/>  <StrRes Name="Now" Text="返回当前日期和时间"/>  <S'+
'trRes Name="DayOfWeek" Text="返回指定日期的星期"/>  <StrRes Name="IsLeapYear" Text="指示指定的'+
'年是否闰年"/>  <StrRes Name="DaysInMonth" Text="返回指定月的天数"/>  <StrRes Name="Length" Te'+
'xt="返回串长度"/>  <StrRes Name="Copy" Text="返回一个串的子串"/>  <StrRes Name="Pos" Text="返回'+
'一个串的子串的起始位置"/>  <StrRes Name="Delete" Text="从串中移除子串"/>  <StrRes Name="Insert" Te'+
'xt="在串中插入子串"/>  <StrRes Name="Uppercase" Text="转换串中的所有字符为大写"/>  <StrRes Name="Lo'+
'wercase" Text="转换串中的所有字符为小写"/>  <StrRes Name="Trim" Text="去除串的首部和尾部空格"/>  <StrRe'+
's Name="NameCase" Text="转换一个单词的首字符为大写"/>  <StrRes Name="CompareText" Text="比较两个串'+
'"/>  <StrRes Name="Chr" Text="整型值转换为字符型"/>  <StrRes Name="Ord" Text="字符值转换为整型"/>'+
'  <StrRes Name="SetLength" Text="设置串长度"/>  <StrRes Name="Round" Text="浮点数舍入到最接近的'+
'整数值"/>  <StrRes Name="Trunc" Text="浮点数截尾为一个整型"/>  <StrRes Name="Int" Text="返回实型的'+
'整数部分"/>  <StrRes Name="Frac" Text="返回实型的小数部分"/>  <StrRes Name="Sqrt" Text="返回指定数'+
'值的平方根"/>  <StrRes Name="Abs" Text="返回绝对值"/>  <StrRes Name="Sin" Text="返回角度(弧度格式)'+
'的正弦值"/>  <StrRes Name="Cos" Text="返回角度(弧度格式)的余弦值"/>  <StrRes Name="ArcTan" Text='+
'"得到反正切值"/>  <StrRes Name="Tan" Text="返回正切值"/>  <StrRes Name="Exp" Text="返回指数值"/>'+
'  <StrRes Name="Ln" Text="返回实型表达式的自然对数值"/>  <StrRes Name="Pi" Text="返回圆周率3.14159'+
'26...数值"/>  <StrRes Name="Inc" Text="增加值"/>  <StrRes Name="Dec" Text="减少值"/>  <S'+
'trRes Name="RaiseException" Text="引发异常"/>  <StrRes Name="ShowMessage" Text="显示消息'+
'窗"/>  <StrRes Name="Randomize" Text="开始随机数生成器"/>  <StrRes Name="Random" Text="返回'+
'随机数"/>  <StrRes Name="ValidInt" Text="如果指定的串含有一个有效的整数，返回 True "/>  <StrRes Name='+
'"ValidFloat" Text="如果指定的串含有一个有效的浮点数，返回 True "/>  <StrRes Name="ValidDate" Text="'+
'如果指定的串含有一个有效的日期值，返回 True "/>  <StrRes Name="IIF" Text="如果表达式为真，返回 True, 否则返回 Fal'+
'se "/>  <StrRes Name="Get" Text="仅内部使用"/>  <StrRes Name="Set" Text="仅内部使用"/>  <S'+
'trRes Name="InputBox" Text="显示输入对话框，以便用户输入串"/>  <StrRes Name="InputQuery" Text="'+
'显示输入对话框，以便用户输入串"/>  <StrRes Name="MessageDlg" Text="显示消息框"/>  <StrRes Name="Crea'+
'teOleObject" Text="创建一个OLE 对象"/>  <StrRes Name="VarArrayCreate" Text="创建一个 varia'+
'nt 数组"/>  <StrRes Name="VarType" Text="返回一个variant值的类型"/>  <StrRes Name="DayOf" '+
'Text="返回给定日期的天数(1..31) "/>  <StrRes Name="MonthOf" Text="返回给定日期的月份(1..12)"/>  <S'+
'trRes Name="YearOf" Text="返回给定日期的年份"/>  <StrRes Name="wzDBConn" Text="新建连接向导"/> '+
' <StrRes Name="wzDBTable" Text="新建表向导"/>  <StrRes Name="wzDBQuery" Text="新建查询向导"'+
'/>  <StrRes Name="5800" Text="连接"/>  <StrRes Name="5801" Text="新建"/>  <StrRes Na'+
'me="5802" Text="删除"/>  <StrRes Name="cpName" Text="名称"/>  <StrRes Name="cpConnSt'+
'r" Text="连接串"/>  <StrRes Name="ctAggregate" Text="聚合"/>  <StrRes Name="Sum" Text'+
'="计算band数据行的求和表达式"/>  <StrRes Name="Avg" Text="计算band数据行的求平均值达式"/>  <StrRes Name'+
'="Min" Text="计算band数据行的求最小值表达式"/>  <StrRes Name="Max" Text="计算band数据行的求最大值表达式"/>'+
'  <StrRes Name="Count" Text="计算band数据行的数量"/>  <StrRes Name="bvKeepHeader" Text="'+
'保持头部聚合"/>  <StrRes Name="startCreateNew" Text="创建新报表"/>  <StrRes Name="startCrea'+
'teBlank" Text="创建空报表"/>  <StrRes Name="startOpenReport" Text="打开报表"/>  <StrRes N'+
'ame="startOpenLast" Text="打开最近的报表"/>  <StrRes Name="startEditAliases" Text="编辑连接'+
'别名"/>  <StrRes Name="startHelp" Text="帮助"/>  <StrRes Name="5900" Text="监视"/>  <S'+
'trRes Name="5901" Text="添加监视"/>  <StrRes Name="5902" Text="删除监视"/>  <StrRes Name'+
'="5903" Text="编辑监视"/>  <StrRes Name="6000" Text="继承错误"/>  <StrRes Name="6001" Te'+
'xt="基本和继承的报表有重复的对象。该怎么办?"/>  <StrRes Name="6002" Text="删除重复对象"/>  <StrRes Name="'+
'6003" Text="重命名重复对象"/></Resources>'+
'';
initialization
    frxResources.AddXML(Utf8Encode(resXML));

end.
