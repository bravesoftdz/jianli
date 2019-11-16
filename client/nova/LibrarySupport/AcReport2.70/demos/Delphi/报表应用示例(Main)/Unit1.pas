
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ImgList, Db, AcRptUtils, CustAdoInt,
  DBTables, Grids, DBGrids, AcReport_TLB, Menus, ADODB;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    DesignBtn: TButton;
    PreviewBtn: TButton;
    Button2: TButton;
    qryGoods: TADOQuery;
    qryDetail: TADOQuery;
    qryMaster: TADOQuery;
    DataSource1: TDataSource;
    qryGoodsCode: TStringField;
    qryGoodsUnit: TStringField;
    qryGoodsName: TStringField;
    qryGoodsSpec: TStringField;
    qryGoodsStocks_1: TFloatField;
    qryGoodsStocks_2: TFloatField;
    qryDetailsNo: TStringField;
    qryDetailId: TIntegerField;
    qryDetailCode: TStringField;
    qryDetailNum: TFloatField;
    qryDetailPrice_Sale: TFloatField;
    qryDetailPrice: TFloatField;
    qryDetailJe: TFloatField;
    qryDetailName: TStringField;
    qryDetailSpec: TStringField;
    qryDetailUnit: TStringField;
    qryDetailBarCode_1: TStringField;
    qryMastersNo: TStringField;
    qryMasterDate: TDateTimeField;
    qryMasterHandNo: TStringField;
    qryMasterOperator: TStringField;
    qryMasterEnterMan: TStringField;
    qryMasterpdNo: TStringField;
    qryMasterJe: TFloatField;
    qryMasterNote: TStringField;
    qryMasterkindcode: TStringField;
    qryMasterName: TStringField;
    qryPhoto: TADOQuery;
    qryPhotoDept: TStringField;
    qryPhotoDptName: TStringField;
    qryPhotoCode: TStringField;
    qryPhotoCardNo: TStringField;
    qryPhotoName: TStringField;
    qryPhotoBornDate: TDateTimeField;
    qryPhotoSfz: TStringField;
    qryPhotoSex: TBooleanField;
    qryPhotoPyDate: TDateTimeField;
    qryPhotoSyMonths: TIntegerField;
    qryPhotoZzDate: TDateTimeField;
    qryPhotoRoomBed: TStringField;
    qryPhotoLzDate: TDateTimeField;
    qryPhotoMemo: TStringField;
    qryPhotoPhoto: TBlobField;
    qryGzTotal: TADOQuery;
    qryGzTotalEmpID: TIntegerField;
    qryGzTotalChiDaoSj: TIntegerField;
    qryGzTotalChiDaoCs: TIntegerField;
    qryGzTotalZaoTuiSj: TIntegerField;
    qryGzTotalZaoTuiCs: TIntegerField;
    qryGzTotalKgSj: TIntegerField;
    qryGzTotalKgCs: TIntegerField;
    qryGzTotalRcjb1: TIntegerField;
    qryGzTotalRcjb2: TIntegerField;
    qryGzTotalRcjbAll: TIntegerField;
    qryGzTotalYcqSj: TIntegerField;
    qryGzTotalSjcqSj: TIntegerField;
    qryGzTotalKgSj_cd: TIntegerField;
    qryGzTotalKgCs_cd: TIntegerField;
    qryGzTotalKgSj_zt: TIntegerField;
    qryGzTotalKgCs_zt: TIntegerField;
    qryGzTotalJbKgSj: TIntegerField;
    qryGzTotalG_gongJ: TFloatField;
    qryGzTotalG_shiJ: TFloatField;
    qryGzTotalG_bingJ: TFloatField;
    qryGzTotalG_syyl: TFloatField;
    qryGzTotalG_bykl: TFloatField;
    qryGzTotalG_fangj: TFloatField;
    qryGzTotalG_dx: TFloatField;
    qryGzTotalG_rx: TFloatField;
    qryGzTotalG_gwjt: TFloatField;
    qryGzTotalG_sdbc: TFloatField;
    qryGzTotalG_zfbc: TFloatField;
    qryGzTotalG_gzj: TFloatField;
    qryGzTotalG_khxs: TFloatField;
    qryGzTotalG_qtjl: TFloatField;
    qryGzTotalG_qtbz: TFloatField;
    qryGzTotalG_ksd: TFloatField;
    qryGzTotalG_kqt: TFloatField;
    qryGzTotalG_cqts: TFloatField;
    qryGzTotalG_cqgz: TFloatField;
    qryGzTotalG_jbsx: TFloatField;
    qryGzTotalG_jbss: TFloatField;
    qryGzTotalG_jbgz: TFloatField;
    qryGzTotalG_yfgz: TFloatField;
    qryGzTotalG_sfgz: TFloatField;
    qryGzTotalG_sfje: TFloatField;
    qryGzTotalG_ldgl: TFloatField;
    qryGzTotalG_fk: TFloatField;
    qryGzTotalG_kszsd: TFloatField;
    qryGzTotalG_dhf: TFloatField;
    qryGzTotalG_qjts: TFloatField;
    qryGzTotalG_bhs: TFloatField;
    qryGzTotalG_cqts0: TFloatField;
    qryGzTotalG_qqj: TFloatField;
    qryGzTotalG_khgz: TFloatField;
    qryGzTotalG_qjkx: TFloatField;
    qryGzTotalG_khsf: TFloatField;
    qryGzTotalG_khsf1: TFloatField;
    qryGzTotalG_bz: TStringField;
    qryGzTotalG_kfz: TFloatField;
    qryGzTotalG_cdztsj: TFloatField;
    qryGzTotalG_kgts: TFloatField;
    qryGzTotalG_Bxin: TFloatField;
    qryGzTotalCode: TStringField;
    qryGzTotalName: TStringField;
    qryGzTotalSex: TBooleanField;
    qryGzTotalG_hsbc: TFloatField;
    qryEmp: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField1: TDateTimeField;
    StringField6: TStringField;
    BooleanField1: TBooleanField;
    DateTimeField2: TDateTimeField;
    IntegerField1: TIntegerField;
    DateTimeField3: TDateTimeField;
    StringField7: TStringField;
    DateTimeField4: TDateTimeField;
    StringField8: TStringField;
    qryEmpG_email: TStringField;
    qryEmpXueLiN: TStringField;
    DataSource2: TDataSource;
    qryXueLi: TADOQuery;
    qryXueLiCode: TStringField;
    qryXueLiName: TStringField;
    qryXuLiHz: TADOQuery;
    StringField9: TStringField;
    StringField10: TStringField;
    qryXuLiHzFAmount: TIntegerField;
    qryEmpXueLi: TStringField;
    qryDept: TADOQuery;
    qryDeptCode: TStringField;
    qryDeptName: TStringField;
    qryDeptManager: TStringField;
    qryDeptTel: TStringField;
    qryPerson: TADOQuery;
    StringField11: TStringField;
    StringField12: TStringField;
    StringField13: TStringField;
    StringField14: TStringField;
    StringField15: TStringField;
    DateTimeField5: TDateTimeField;
    StringField16: TStringField;
    BooleanField2: TBooleanField;
    DateTimeField6: TDateTimeField;
    IntegerField2: TIntegerField;
    DateTimeField7: TDateTimeField;
    StringField17: TStringField;
    DateTimeField8: TDateTimeField;
    StringField18: TStringField;
    Customers: TADOTable;
    CustomersCustNo: TFloatField;
    CustomersCompany: TStringField;
    CustomersAddr1: TStringField;
    CustomersAddr2: TStringField;
    CustomersCity: TStringField;
    CustomersState: TStringField;
    CustomersZip: TStringField;
    CustomersCountry: TStringField;
    CustomersPhone: TStringField;
    CustomersFAX: TStringField;
    CustomersTaxRate: TFloatField;
    CustomersContact: TStringField;
    CustomersLastInvoiceDate: TDateTimeField;
    Orders: TADOTable;
    OrdersOrderNo: TFloatField;
    OrdersCustNo: TFloatField;
    OrdersCustCompany: TStringField;
    OrdersSaleDate: TDateTimeField;
    OrdersShipDate: TDateTimeField;
    OrdersEmpNo: TIntegerField;
    OrdersShipToContact: TStringField;
    OrdersShipToAddr1: TStringField;
    OrdersShipToAddr2: TStringField;
    OrdersShipToCity: TStringField;
    OrdersShipToState: TStringField;
    OrdersShipToZip: TStringField;
    OrdersShipToCountry: TStringField;
    OrdersShipToPhone: TStringField;
    OrdersShipVIA: TStringField;
    OrdersPO: TStringField;
    OrdersTerms: TStringField;
    OrdersPaymentMethod: TStringField;
    OrdersItemsTotal: TCurrencyField;
    OrdersTaxRate: TFloatField;
    OrdersFreight: TCurrencyField;
    OrdersAmountPaid: TCurrencyField;
    LineItems: TADOTable;
    LineItemsOrderNo: TFloatField;
    LineItemsItemNo: TFloatField;
    LineItemsPartNo: TFloatField;
    LineItemsPartName: TStringField;
    LineItemsQty: TIntegerField;
    LineItemsPrice: TCurrencyField;
    LineItemsDiscount: TFloatField;
    LineItemsTotal: TCurrencyField;
    LineItemsExtendedPrice: TCurrencyField;
    Parts: TADOTable;
    PartsPartNo: TFloatField;
    PartsVendorNo: TFloatField;
    PartsDescription: TStringField;
    PartsOnHand: TFloatField;
    PartsOnOrder: TFloatField;
    PartsCost: TCurrencyField;
    PartsListPrice: TCurrencyField;
    CustomerSource: TDataSource;
    OrderSource: TDataSource;
    LineItemSource: TDataSource;
    PartSource: TDataSource;
    DataSource3: TDataSource;
    popVisible: TPopupMenu;
    Image1: TImage;
    Tab: TTabControl;
    Tree1: TTreeView;
    Memo1: TMemo;
    Bevel1: TBevel;
    VEd1: TEdit;
    VEd2: TEdit;
    VEd3: TEdit;
    VEd4: TEdit;
    VEd5: TDateTimePicker;
    VEd6: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    AdoConn: TADOConnection;
    Button1: TButton;
    RB1: TRadioButton;
    RB2: TRadioButton;
    Doc: TADOQuery;
    DocLines: TADOQuery;
    Label8: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Tree1Change(Sender: TObject; Node: TTreeNode);
    procedure DesignBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnAcRptEngineBeforePrepare(Sender: TObject; const ARptEngine: IAcRptEngine);
    procedure qryMasterAfterScroll(DataSet: TDataSet);
    procedure LineItemsCalcFields(DataSet: TDataSet);
    procedure qryPhotoSexGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure BooleanField1GetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure TabChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RB1Click(Sender: TObject);
    procedure RB2Click(Sender: TObject);
  private
    { Private declarations }
    FAcRptEngine: TAcRptEngine;
    WPath, Wdb: String;
    st1, st2, st3, st4, st5, st6: TStrings;

    ProxDS1, ProxDS2: TAcProxDataset;

    procedure OnItemClick(Sender: TObject);
    procedure SetReportNames;
    procedure SetRegisterInfo;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.DFM}
{$R XpStyle.RES}


procedure TForm1.FormShow(Sender: TObject);
begin
  Tree1.Items[0].Expand(True);
  Tree1.Selected := Tree1.Items[0].Item[0];
  Tree1.TopItem := Tree1.Items[0];
end;

procedure TForm1.Tree1Change(Sender: TObject; Node: TTreeNode);
var
  n: Integer;
  s: string;
begin
  n := Node.Index;
  if n = -1 then
  begin
    DesignBtn.Enabled := False;
    PreviewBtn.Enabled := False;
    Exit;
  end;
  Memo1.Clear;
  s := WPath + 'memo\' +inttostr(Tab.TabIndex) + inttostr(Tree1.Items[0].IndexOf(Node))+'.txt';
  if FileExists(s) then
    Memo1.Lines.LoadFromFile(s);
end;

procedure TForm1.DesignBtnClick(Sender: TObject);
var
  Node: TTreeNode;
  s: string;
begin
  Node := Tree1.Selected;
  if (Node = nil) then Exit;
  s := WPath + inttostr(Tab.TabIndex) + inttostr(Tree1.Items[0].IndexOf(Node))+'.apt';
  with FAcRptEngine do
  begin
   if FileExists(s) then
      LoadFromFile(s)
   else
     begin
       FAcRptEngine.SetReportFile(''); 
       FAcRptEngine.ClearContents;
     end;
    ShowDesigner;
  end;
end;

procedure TForm1.PreviewBtnClick(Sender: TObject);
var
  n: Integer;
  Node: TTreeNode;
  s: string;
begin
  Node := Tree1.Selected;
  if (Node = nil) or (Node.Index = -1) then Exit;
  s := WPath + inttostr(Tab.TabIndex) + inttostr(Tree1.Items[0].IndexOf(Node))+'.apt';
  if ExtractFileName(s) = '45.apt' then
    s := ExtractFilePath(s) + '40.apt';

  with FAcRptEngine do
  begin
    if not FileExists(s) then
      Exit;
    LoadFromFile(s);
    Preview;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.SetReportNames;
begin
  with st1 do
  begin
    Clear;
    Add('功能展示');
    Add('清单列表');
    Add('图表/固定报表');
    Add('图表清单混合报表');
    Add('分栏报表/条码打印');
    Add('分栏报表/图像字段/工作证打印');
    Add('工资条打印');
    Add('主从报表');
    Add('用子表实现的主从报表');
    Add('交叉报表');
    Add('交叉报表2');
    Add('分组报表/按字段');
    Add('分组报表/按条件');
    Add('行合并分组');
    Add('动态的Rich文本');
    Add('基于可拖动对象的报表');

  end;
  with st2 do
  begin
    Clear;
    Add('显示确认框的报表');
    Add('打印输入的字符');
    Add('带密码确认的报表');
    Add('用脚本实现行间颜色的变化');
    Add('在脚中使用中文标识');
  end;

  with st3 do
  begin
    Clear;
    Add('内部Table');
    Add('内部Query');
    Add('内部Query(ADO)');
    Add('带查询参数的报表');
  end;

  with st4 do
  begin
    Clear;
    Add('子报表1');
    Add('用子报表实现行合并报表');
    Add('用子报表实现主从表打印');
    Add('多层子报表');
  end;

  with st5 do
  begin
    Clear;
    Add('带背景图片的报表');
    Add('在页眉页脚插入表达式');
    Add('含自由对象的报表');
    Add('带脚本的单元格');
    Add('带封面的报表');
    Add('指定缺省预览比例');
  end;

  with st6 do
  begin
    Clear;
    Add('设置字段别名');
    Add('页尾保持在页面底部');
    Add('页尾保持在页面底部(保持外框线)');
    Add('分组页尾保持页面底部');
    Add('分组分页补充空行');
    Add('明细分两栏打印(横向顺序分栏)');
    Add('套打辅助设计(不打印背景图案)');
    Add('基于拖动对象的报表设计1');
    Add('基于拖动对象的报表设计2');
    Add('含数据模块的报表');
    Add('报表视图-并列的明细');
    Add('报表视图2');
    Add('报表视图3');
    Add('字间距行间距设置');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var I: integer;
   aItem: TMenuItem;
   AConnStr: string;
begin
  FAcRptEngine := TAcRptEngine.Create(nil);
  SetRegisterInfo;

  FAcRptEngine.PreviewOptions.WindowTitle := '报表预览';
 // FAcRptEngine.PreviewOptions.ButtonVisible_Open := false;
 // FAcRptEngine.PreviewOptions.ButtonVisible_Save := false;

  FAcRptEngine.OnBeforePrepare := OnAcRptEngineBeforePrepare;
  st1 := TStringList.Create;
  st2 := TStringList.Create;
  st3 := TStringList.Create;
  st4 := TStringList.Create;
  st5 := TStringList.Create;
  st6 := TStringList.Create;
  SetReportNames;
  TabChange(Tab);
  WPath := ExtractFilePath(ParamStr(0));
  Wdb := WPath+'..\..\Data\ReportDemo.mdb';
  WPath := WPath + 'rpt\';

  AConnStr := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+
  WDb+ ';Mode=Share Deny None;Extended Properties="";Jet OLEDB:System database="";'+
  'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;'+
  'Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
  'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;'+
  'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
  AdoConn.ConnectionString := AConnStr;
  AdoConn.Connected := true;                               

  FAcRptEngine.SetAppConnectionString(AConnStr); //此行的作用是将当前连接字符串传入报表，
                             //会在“共公变量”中生成一个名为AppConnString变量，报表脚本中可以利用ADO从此变量得到连接字符串连接应用程序数据库生成自定报表

  FAcRptEngine.Init();
  //打开所有的数据集，并以ADO专门的方法(AddDataset)将数据传入报表引擎
  for I := 0 to ComponentCount -1 do
  if Components[I] is TADOQuery then
  begin
    TADOQuery(Self.Components[I]).Open;
    with TADOQuery(Components[I]) do
      FAcRptEngine.AddDataset(Name, Recordset); //将ADO RecordSet对象(接口)传入报表引擎
  end
  else
  if Components[I] is TADOTable then
  begin
    TADOTable(Components[I]).Open;
    with TADOTable(Components[I]) do
      FAcRptEngine.AddDataset(Name, Recordset); //将ADO RecordSet对象(接口)传入报表引擎
  end;


//使用ADO Recordset方式传入数据集，是直接将ADO的Recordset对象作为一个变量传递给AcRptEngine

{  FAcRptEngine.AddDataset('商品表', qryGoods.Recordset);
  FAcRptEngine.AddDataset('盘点单主表', qryMaster.Recordset);
  FAcRptEngine.AddDataset('盘点单明细', qryDetail.Recordset);
  FAcRptEngine.AddDataset('雇员档案', qryEmp.Recordset);
  FAcRptEngine.AddDataset('工作证制作', qryPhoto.Recordset);
  FAcRptEngine.AddDataset('工资表', qryGzTotal.Recordset);
  FAcRptEngine.AddDataset('学历资料', qryXueLi.Recordset);
  FAcRptEngine.AddDataset('学历统计表', qryXuLiHz.Recordset);
  FAcRptEngine.AddDataset('部门', qryDept.Recordset);
  FAcRptEngine.AddDataset('人员表', qryPerson.Recordset);
  FAcRptEngine.AddDataset('客户资料', Customers.Recordset);
  FAcRptEngine.AddDataset('订单表', Orders.Recordset);
  FAcRptEngine.AddDataset('分部', Parts.Recordset);
  FAcRptEngine.AddDataset('订单明细', LineItems.Recordset);
}

  //使用CustDataBuilder的方式传入数据集，这种方式速度较慢，会在AcRptEngine中形成一个数据集的拷贝，
  //优点是不局限于ADO，支持BDE、ClientDataset等数据集，并且表名和字段名支持中文方式。
  AddCommonDatasetToAcReport(qryGoods, FAcRptEngine, '商品表');
  AddCommonDatasetToAcReport(qryPerson, FAcRptEngine, '人员表');
 // AddDatasetToAcReport(qryPhoto, FAcRptEngine, '工作证制作'); //含有Blob类型的数据集不推荐使用 AddDatasetToAcReport，速度很慢。
  AddCommonDatasetToAcReport(qryMaster, FAcRptEngine, '盘点单主表');
  AddCommonDatasetToAcReport(qryDetail, FAcRptEngine, '盘点单明细');
  AddCommonDatasetToAcReport(qryEmp, FAcRptEngine, '雇员档案');
  AddCommonDatasetToAcReport(qryGzTotal, FAcRptEngine, '工资表');
  AddCommonDatasetToAcReport(qryXueLi, FAcRptEngine, '学历资料');
  AddCommonDatasetToAcReport(qryXuLiHz, FAcRptEngine, '学历统计表');

  //2.5新版本中增加了ADO接口的方式，可以直接将BDE/ClientDataset等Delphi的Dataset模拟为ADO Recordset传入报表，速度比上面复制的方式要快很多

  ProxDS1 := TAcProxDataset.Create(qryEmp); //记得释放
  FAcRptEngine.AddDataset('雇员档案', _RecordSet(ProxDS1));
  AcSetFieldsAliasByDispName('雇员档案', qryEmp.Fields, FAcRptEngine); //自动根据Field.DisplayLabel设置别名

  ProxDS2 := TAcProxDataset.Create(qryPhoto); //记得释放
  FAcRptEngine.AddDataset('工作证制作', _RecordSet(ProxDS2));


  //设置字段别名
  FAcRptEngine.AddDataset('照片', qryPhoto.Recordset);
  FAcRptEngine.SetDataFieldAliasName('照片', 'Dept,DptName,Code,CardNo,Name,BornDate,Sfz,Sex,PyDate,SyMonths,RoomBed,Photo',
     '部门编号,部门名称,编号,卡号,名称,出生日期,身份证,性别,聘用日期,试用期,床号,照片');

 with FAcRptEngine do
 begin
   AddVariable('变量1', VEd1.Text);
   AddVariable('变量2', VEd2.Text);
   AddVariable('变量3', VEd3.Text);
   AddVariable('变量4', VEd4.Text);
   AddVariable('日期1', VEd5.Date);
   AddVariable('日期2', VEd6.Date);
 end;

end;


procedure TForm1.OnAcRptEngineBeforePrepare(Sender: TObject; const ARptEngine: IAcRptEngine);
begin
 with ARptEngine do
 begin
     AddVariable('变量1', VEd1.Text);
     AddVariable('变量2', VEd2.Text);
     AddVariable('变量3', VEd3.Text);
     AddVariable('变量4', VEd4.Text);
     
     AddVariable('日期1', VEd5.Date);
     AddVariable('日期2', VEd6.Date);

     AddVariable('ABC', 10);
 end;
end;

procedure TForm1.qryMasterAfterScroll(DataSet: TDataSet);
begin
  qryDetail.Close;
  qryDetail.Parameters.ParamByName('sNo').Value := qryMastersNo.Value;
  qryDetail.Open;
end;

procedure TForm1.LineItemsCalcFields(DataSet: TDataSet);
begin
  LineItemsExtendedPrice.Value := LineItemsPrice.Value *
    ((100 - LineItemsDiscount.Value) / 100);
  LineItemsTotal.Value := LineItemsExtendedPrice.Value *
    LineItemsQty.Value;
end;

procedure TForm1.OnItemClick(Sender: TObject);
begin

end;

procedure TForm1.qryPhotoSexGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if qryPhotoSex.Value then
    Text := '男'
  else Text := '女';
end;

procedure TForm1.BooleanField1GetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if not BooleanField1.Value then
    Text := '男'
  else Text := '女';
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FAcRptEngine.Free;
  st1.Free;
  st2.Free;
  st3.Free;
  st4.Free;
  st5.Free;
  st6.Free;
  ProxDS1.Free;
  ProxDS2.Free;
end;

procedure TForm1.TabChange(Sender: TObject);
var
  oRoot: TTreeNode;
  i: integer;
  st: TStrings;
begin
  with Tree1.Items do
  begin
    BeginUpdate;
    Clear;
    oRoot := Add(nil, '报表模板');
    oRoot.ImageIndex := 0;
    case Tab.TabIndex of
      0: st := st1;
      1: st := st2;
      2: st := st3;
      3: st := st4;
      4: st := st5;
    else st := st6;
    end;
    for i := 0 to st.Count - 1 do
      with AddChild(oRoot, st[i]) do
      begin
        ImageIndex := 1;
        SelectedIndex := 2;
      end;
    oRoot.Expand(false);
    EndUpdate;
  end;
end;

procedure TForm1.SetRegisterInfo;
var
  ErrCode: integer;
  ErrMsg: WideString;
begin
  FAcRptEngine.SetRegisterInfo('280853595D4033132E36CC85879681948B9690A4978D8A85CA878B89C49595DED5D2D1D1D7D' +
       '3D7DCD1DDCDD6D78680D8AD0CFAADC1DDF8F566934E1BAD6B8B296DB4BC968283E9F8FE23728EF0F71F9417C40DB6D30C729ECD01D774746D80E3EE321C6D',

                '天方工作室(acreport@sina.com qq:1655373859)', '23bd', '', '', '', '', ErrCode, ErrMsg);


 if ErrCode <> 0 then
   ShowMessage(ErrMsg);

 //对于企业注册用户，可以设置自定义信息，包括：设计器和预览窗口标题，打印任务名称，图标，文档扩展名，菜单的可见性等等  
{ FAcRptEngine.SetCustInfo('设计器', '报表预览', '报表打印', 'att', 'aar',
   '数据集,属性列表,工具,帮助,编辑', '新建模板,单元格类型和格式,删除当前页', 'c:\cust.ico', ErrCode, ErrMsg);
 if ErrCode <> 0 then
   ShowMessage(ErrMsg);

}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 //数字段中装放一个模板
//  AcRptUtils.LoadAcFromCommonBlobField(FAcRptEngine, qryRptDocFRptDoc, '报表模板1');
///  FAcRptEngine.ShowDesigner;

 //将修改后的模板保存到数据库
 // AcRptUtils.SaveAcToCommonBlobField(FAcRptEngine, qryRptDocFRptDoc);
  //if qryRptDoc.State in [dsEdit, dsInsert] then
    //qryRptDoc.Post;
end;

procedure TForm1.RB1Click(Sender: TObject);
begin
  FAcRptEngine.ShowPreviewOnPrepare := false;
end;

procedure TForm1.RB2Click(Sender: TObject);
begin
  FAcRptEngine.ShowPreviewOnPrepare := true;
end;

end.
