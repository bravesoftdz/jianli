
unit Unit1;
                                        
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, ExtCtrls, ImgList, Db,
  DBTables, Grids, DBGrids,
  AcReportVCL, Menus;

//���� Delphi IDE �˵��У�Tools -> Evironment Options -> Library -> Library Path �н�VCL�ؼ�Դ�����ڵ�·������

{$R XpStyle.RES}

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    DesignBtn: TButton;
    PreviewBtn: TButton;
    Button2: TButton;
    AcReport1: TAcReportVCL;
    qryGoods: TQuery;
    qryDetail: TQuery;
    qryMaster: TQuery;
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
    qryPhoto: TQuery;
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
    qryGzTotal: TQuery;
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
    qryEmp: TQuery;
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
    BlobField1: TBlobField;
    qryEmpG_email: TStringField;
    qryEmpXueLiN: TStringField;
    DataSource2: TDataSource;
    qryXueLi: TQuery;
    qryXueLiCode: TStringField;
    qryXueLiName: TStringField;
    qryXuLiHz: TQuery;
    StringField9: TStringField;
    StringField10: TStringField;
    qryXuLiHzFAmount: TIntegerField;
    qryEmpXueLi: TStringField;
    qryDept: TQuery;
    qryDeptCode: TStringField;
    qryDeptName: TStringField;
    qryDeptManager: TStringField;
    qryDeptTel: TStringField;
    qryPerson: TQuery;
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
    Customers: TTable;
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
    Orders: TTable;
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
    LineItems: TTable;
    LineItemsOrderNo: TFloatField;
    LineItemsItemNo: TFloatField;
    LineItemsPartNo: TFloatField;
    LineItemsPartName: TStringField;
    LineItemsQty: TIntegerField;
    LineItemsPrice: TCurrencyField;
    LineItemsDiscount: TFloatField;
    LineItemsTotal: TCurrencyField;
    LineItemsExtendedPrice: TCurrencyField;
    Parts: TTable;
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
    CBProgr: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure Tree1Change(Sender: TObject; Node: TTreeNode);
    procedure DesignBtnClick(Sender: TObject);
    procedure PreviewBtnClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMasterAfterScroll(DataSet: TDataSet);
    procedure LineItemsCalcFields(DataSet: TDataSet);
    procedure qryPhotoSexGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure BooleanField1GetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure TabChange(Sender: TObject);
    procedure CBProgrClick(Sender: TObject);
    procedure AcReport1BeforePrepare(Sender: TAcReportVCL);
  private
    { Private declarations }
    WPath, Wdb: String;
    st1, st2, st3, st4, st5: TStrings;
    procedure OnItemClick(Sender: TObject);
    procedure SetReportNames;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;


implementation

{$R *.DFM}

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
  with ACReport1 do
  begin
   if FileExists(s) then
      LoadFromFile(s)
   else
   begin
      ACReport1.SetReportFile(''); 
      ACReport1.Clear;
   end;
   // AcReport1.CopyDatasetsToEngine;
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
  with AcReport1 do
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
    Add('ͼ��2');
    Add('��������/�����ӡ');
    Add('��������/ͼ���ֶδ�ӡ');
    Add('��������ӡ');
    Add('���ӱ���');
    Add('���ӱ�ʵ�ֵ����ӱ���');
    Add('���汨��');
    Add('���汨��2');
    Add('���鱨��/���ֶ�');
    Add('���鱨��/������');
    Add('�кϲ�����');
    Add('��̬��Rich�ı�');

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
end;

procedure TForm1.FormCreate(Sender: TObject);
var I: integer;
   aItem: TMenuItem;
begin
  st1 := TStringList.Create;
  st2 := TStringList.Create;
  st3 := TStringList.Create;
  st4 := TStringList.Create;
  st5 := TStringList.Create;
  SetReportNames;
  TabChange(Tab);
  WPath := ExtractFilePath(ParamStr(0));
  Wdb := WPath+'db';
  WPath := WPath + 'rpt\';

  for I := 0 to ComponentCount -1 do
    if Components[I] is TQuery then
    begin
      TQuery(Components[I]).DatabaseName := WDb;
      TQuery(Components[I]).Open;
    end;
  qryGoods.Open;

 // ACReport1.CustCopyDataset := true;
// ACReport1.CopyDatasetsToEngine; //��Dagtasets�е����ݼ�����AC��������
 
 with ACReport1 do
 begin
   AddVariant('����1', VEd1.Text);
   AddVariant('����2', VEd2.Text);
   AddVariant('����3', VEd3.Text);
   AddVariant('����4', VEd4.Text);
   AddVariant('����1', VEd5.Date);
   AddVariant('����2', VEd6.Date);
 end;

end;

procedure doabort;
begin
 
end;

procedure TForm1.qryMasterAfterScroll(DataSet: TDataSet);
begin
  qryDetail.Close;
  qryDetail.ParamByName('sNo').Value := qryMastersNo.Value;
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
  st1.Free;
  st2.Free;
  st3.Free;
  st4.Free;
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
    else st := st5;
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

procedure TForm1.CBProgrClick(Sender: TObject);
begin
  AcReport1.ShowProgress := CBProgr.Checked;
end;

procedure TForm1.AcReport1BeforePrepare(Sender: TAcReportVCL);
begin
 with ACReport1 do
 begin
     AddVariant('����1', VEd1.Text);
     AddVariant('����2', VEd2.Text);
     AddVariant('����3', VEd3.Text);
     AddVariant('����4', VEd4.Text);

     AddVariant('����1', VEd5.Date);
     AddVariant('����2', VEd6.Date);

     AddVariant('ABC', 10);
 end;
end;

end.
