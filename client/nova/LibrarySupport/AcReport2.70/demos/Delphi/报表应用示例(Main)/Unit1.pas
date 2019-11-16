
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
    Add('����չʾ');
    Add('�嵥�б�');
    Add('ͼ��/�̶�����');
    Add('ͼ���嵥��ϱ���');
    Add('��������/�����ӡ');
    Add('��������/ͼ���ֶ�/����֤��ӡ');
    Add('��������ӡ');
    Add('���ӱ���');
    Add('���ӱ�ʵ�ֵ����ӱ���');
    Add('���汨��');
    Add('���汨��2');
    Add('���鱨��/���ֶ�');
    Add('���鱨��/������');
    Add('�кϲ�����');
    Add('��̬��Rich�ı�');
    Add('���ڿ��϶�����ı���');

  end;
  with st2 do
  begin
    Clear;
    Add('��ʾȷ�Ͽ�ı���');
    Add('��ӡ������ַ�');
    Add('������ȷ�ϵı���');
    Add('�ýű�ʵ���м���ɫ�ı仯');
    Add('�ڽ���ʹ�����ı�ʶ');
  end;

  with st3 do
  begin
    Clear;
    Add('�ڲ�Table');
    Add('�ڲ�Query');
    Add('�ڲ�Query(ADO)');
    Add('����ѯ�����ı���');
  end;

  with st4 do
  begin
    Clear;
    Add('�ӱ���1');
    Add('���ӱ���ʵ���кϲ�����');
    Add('���ӱ���ʵ�����ӱ��ӡ');
    Add('����ӱ���');
  end;

  with st5 do
  begin
    Clear;
    Add('������ͼƬ�ı���');
    Add('��ҳüҳ�Ų�����ʽ');
    Add('�����ɶ���ı���');
    Add('���ű��ĵ�Ԫ��');
    Add('������ı���');
    Add('ָ��ȱʡԤ������');
  end;

  with st6 do
  begin
    Clear;
    Add('�����ֶα���');
    Add('ҳβ������ҳ��ײ�');
    Add('ҳβ������ҳ��ײ�(���������)');
    Add('����ҳβ����ҳ��ײ�');
    Add('�����ҳ�������');
    Add('��ϸ��������ӡ(����˳�����)');
    Add('�״������(����ӡ����ͼ��)');
    Add('�����϶�����ı������1');
    Add('�����϶�����ı������2');
    Add('������ģ��ı���');
    Add('������ͼ-���е���ϸ');
    Add('������ͼ2');
    Add('������ͼ3');
    Add('�ּ���м������');
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var I: integer;
   aItem: TMenuItem;
   AConnStr: string;
begin
  FAcRptEngine := TAcRptEngine.Create(nil);
  SetRegisterInfo;

  FAcRptEngine.PreviewOptions.WindowTitle := '����Ԥ��';
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

  FAcRptEngine.SetAppConnectionString(AConnStr); //���е������ǽ���ǰ�����ַ������뱨��
                             //���ڡ�����������������һ����ΪAppConnString����������ű��п�������ADO�Ӵ˱����õ������ַ�������Ӧ�ó������ݿ������Զ�����

  FAcRptEngine.Init();
  //�����е����ݼ�������ADOר�ŵķ���(AddDataset)�����ݴ��뱨������
  for I := 0 to ComponentCount -1 do
  if Components[I] is TADOQuery then
  begin
    TADOQuery(Self.Components[I]).Open;
    with TADOQuery(Components[I]) do
      FAcRptEngine.AddDataset(Name, Recordset); //��ADO RecordSet����(�ӿ�)���뱨������
  end
  else
  if Components[I] is TADOTable then
  begin
    TADOTable(Components[I]).Open;
    with TADOTable(Components[I]) do
      FAcRptEngine.AddDataset(Name, Recordset); //��ADO RecordSet����(�ӿ�)���뱨������
  end;


//ʹ��ADO Recordset��ʽ�������ݼ�����ֱ�ӽ�ADO��Recordset������Ϊһ���������ݸ�AcRptEngine

{  FAcRptEngine.AddDataset('��Ʒ��', qryGoods.Recordset);
  FAcRptEngine.AddDataset('�̵㵥����', qryMaster.Recordset);
  FAcRptEngine.AddDataset('�̵㵥��ϸ', qryDetail.Recordset);
  FAcRptEngine.AddDataset('��Ա����', qryEmp.Recordset);
  FAcRptEngine.AddDataset('����֤����', qryPhoto.Recordset);
  FAcRptEngine.AddDataset('���ʱ�', qryGzTotal.Recordset);
  FAcRptEngine.AddDataset('ѧ������', qryXueLi.Recordset);
  FAcRptEngine.AddDataset('ѧ��ͳ�Ʊ�', qryXuLiHz.Recordset);
  FAcRptEngine.AddDataset('����', qryDept.Recordset);
  FAcRptEngine.AddDataset('��Ա��', qryPerson.Recordset);
  FAcRptEngine.AddDataset('�ͻ�����', Customers.Recordset);
  FAcRptEngine.AddDataset('������', Orders.Recordset);
  FAcRptEngine.AddDataset('�ֲ�', Parts.Recordset);
  FAcRptEngine.AddDataset('������ϸ', LineItems.Recordset);
}

  //ʹ��CustDataBuilder�ķ�ʽ�������ݼ������ַ�ʽ�ٶȽ���������AcRptEngine���γ�һ�����ݼ��Ŀ�����
  //�ŵ��ǲ�������ADO��֧��BDE��ClientDataset�����ݼ������ұ������ֶ���֧�����ķ�ʽ��
  AddCommonDatasetToAcReport(qryGoods, FAcRptEngine, '��Ʒ��');
  AddCommonDatasetToAcReport(qryPerson, FAcRptEngine, '��Ա��');
 // AddDatasetToAcReport(qryPhoto, FAcRptEngine, '����֤����'); //����Blob���͵����ݼ����Ƽ�ʹ�� AddDatasetToAcReport���ٶȺ�����
  AddCommonDatasetToAcReport(qryMaster, FAcRptEngine, '�̵㵥����');
  AddCommonDatasetToAcReport(qryDetail, FAcRptEngine, '�̵㵥��ϸ');
  AddCommonDatasetToAcReport(qryEmp, FAcRptEngine, '��Ա����');
  AddCommonDatasetToAcReport(qryGzTotal, FAcRptEngine, '���ʱ�');
  AddCommonDatasetToAcReport(qryXueLi, FAcRptEngine, 'ѧ������');
  AddCommonDatasetToAcReport(qryXuLiHz, FAcRptEngine, 'ѧ��ͳ�Ʊ�');

  //2.5�°汾��������ADO�ӿڵķ�ʽ������ֱ�ӽ�BDE/ClientDataset��Delphi��Datasetģ��ΪADO Recordset���뱨���ٶȱ����渴�Ƶķ�ʽҪ��ܶ�

  ProxDS1 := TAcProxDataset.Create(qryEmp); //�ǵ��ͷ�
  FAcRptEngine.AddDataset('��Ա����', _RecordSet(ProxDS1));
  AcSetFieldsAliasByDispName('��Ա����', qryEmp.Fields, FAcRptEngine); //�Զ�����Field.DisplayLabel���ñ���

  ProxDS2 := TAcProxDataset.Create(qryPhoto); //�ǵ��ͷ�
  FAcRptEngine.AddDataset('����֤����', _RecordSet(ProxDS2));


  //�����ֶα���
  FAcRptEngine.AddDataset('��Ƭ', qryPhoto.Recordset);
  FAcRptEngine.SetDataFieldAliasName('��Ƭ', 'Dept,DptName,Code,CardNo,Name,BornDate,Sfz,Sex,PyDate,SyMonths,RoomBed,Photo',
     '���ű��,��������,���,����,����,��������,���֤,�Ա�,Ƹ������,������,����,��Ƭ');

 with FAcRptEngine do
 begin
   AddVariable('����1', VEd1.Text);
   AddVariable('����2', VEd2.Text);
   AddVariable('����3', VEd3.Text);
   AddVariable('����4', VEd4.Text);
   AddVariable('����1', VEd5.Date);
   AddVariable('����2', VEd6.Date);
 end;

end;


procedure TForm1.OnAcRptEngineBeforePrepare(Sender: TObject; const ARptEngine: IAcRptEngine);
begin
 with ARptEngine do
 begin
     AddVariable('����1', VEd1.Text);
     AddVariable('����2', VEd2.Text);
     AddVariable('����3', VEd3.Text);
     AddVariable('����4', VEd4.Text);
     
     AddVariable('����1', VEd5.Date);
     AddVariable('����2', VEd6.Date);

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
    Text := '��'
  else Text := 'Ů';
end;

procedure TForm1.BooleanField1GetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
  if not BooleanField1.Value then
    Text := '��'
  else Text := 'Ů';
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
    oRoot := Add(nil, '����ģ��');
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

                '�췽������(acreport@sina.com qq:1655373859)', '23bd', '', '', '', '', ErrCode, ErrMsg);


 if ErrCode <> 0 then
   ShowMessage(ErrMsg);

 //������ҵע���û������������Զ�����Ϣ���������������Ԥ�����ڱ��⣬��ӡ�������ƣ�ͼ�꣬�ĵ���չ�����˵��Ŀɼ��Եȵ�  
{ FAcRptEngine.SetCustInfo('�����', '����Ԥ��', '�����ӡ', 'att', 'aar',
   '���ݼ�,�����б�,����,����,�༭', '�½�ģ��,��Ԫ�����ͺ͸�ʽ,ɾ����ǰҳ', 'c:\cust.ico', ErrCode, ErrMsg);
 if ErrCode <> 0 then
   ShowMessage(ErrMsg);

}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 //���ֶ���װ��һ��ģ��
//  AcRptUtils.LoadAcFromCommonBlobField(FAcRptEngine, qryRptDocFRptDoc, '����ģ��1');
///  FAcRptEngine.ShowDesigner;

 //���޸ĺ��ģ�屣�浽���ݿ�
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
