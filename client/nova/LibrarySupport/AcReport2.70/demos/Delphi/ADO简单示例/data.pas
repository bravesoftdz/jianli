unit data;
                             
interface                      

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    MainConn: TADOConnection;
    qryAnimals: TADOQuery;
    qryBiolife: TADOQuery;
    qryContry: TADOQuery;
    qryEmployee: TADOQuery;
    qryEmployeeEmpNo: TIntegerField;
    qryEmployeeLastName: TWideStringField;
    qryEmployeeFirstName: TWideStringField;
    qryEmployeePhoneExt: TWideStringField;
    qryEmployeeHireDate: TDateTimeField;
    qryEmployeeSalary: TFloatField;
    qryCustomer: TADOQuery;
    qryCustomerCustNo: TFloatField;
    qryCustomerCompany: TWideStringField;
    qryCustomerAddr1: TWideStringField;
    qryCustomerAddr2: TWideStringField;
    qryCustomerCity: TWideStringField;
    qryCustomerState: TWideStringField;
    qryCustomerZip: TWideStringField;
    qryCustomerCountry: TWideStringField;
    qryCustomerPhone: TWideStringField;
    qryCustomerFAX: TWideStringField;
    qryCustomerTaxRate: TFloatField;
    qryCustomerContact: TWideStringField;
    qryCustomerLastInvoiceDate: TDateTimeField;
    qryOrders: TADOQuery;
    qryOrdersOrderNo: TFloatField;
    qryOrdersCustNo: TFloatField;
    qryOrdersSaleDate: TDateTimeField;
    qryOrdersShipDate: TDateTimeField;
    qryOrdersEmpNo: TIntegerField;
    qryOrdersShipToContact: TWideStringField;
    qryOrdersShipToAddr1: TWideStringField;
    qryOrdersShipToAddr2: TWideStringField;
    qryOrdersShipToCity: TWideStringField;
    qryOrdersShipToState: TWideStringField;
    qryOrdersShipToZip: TWideStringField;
    qryOrdersShipToCountry: TWideStringField;
    qryOrdersShipToPhone: TWideStringField;
    qryOrdersShipVIA: TWideStringField;
    qryOrdersPO: TWideStringField;
    qryOrdersTerms: TWideStringField;
    qryOrdersPaymentMethod: TWideStringField;
    qryOrdersItemsTotal: TFloatField;
    qryOrdersTaxRate: TFloatField;
    qryOrdersFreight: TFloatField;
    qryOrdersAmountPaid: TFloatField;
    qryParts: TADOQuery;
    qryPartsPartNo: TFloatField;
    qryPartsVendorNo: TFloatField;
    qryPartsDescription: TWideStringField;
    qryPartsOnHand: TFloatField;
    qryPartsOnOrder: TFloatField;
    qryPartsCost: TFloatField;
    qryPartsListPrice: TFloatField;
    qryVendors: TADOQuery;
    qryVendorsVendorNo: TFloatField;
    qryVendorsVendorName: TWideStringField;
    qryVendorsAddress1: TWideStringField;
    qryVendorsAddress2: TWideStringField;
    qryVendorsCity: TWideStringField;
    qryVendorsState: TWideStringField;
    qryVendorsZip: TWideStringField;
    qryVendorsCountry: TWideStringField;
    qryVendorsPhone: TWideStringField;
    qryVendorsFAX: TWideStringField;
    qryVendorsPreferred: TBooleanField;
    qryzlEmployee: TADOQuery;
    qryzlEmployeeID: TIntegerField;
    qryzlEmployeeDept: TWideStringField;
    qryzlEmployeeCode: TWideStringField;
    qryzlEmployeeCardNo: TWideStringField;
    qryzlEmployeeName: TWideStringField;
    qryzlEmployeeSfz: TWideStringField;
    qryzlEmployeeBornDate: TDateTimeField;
    qryzlEmployeeSex: TBooleanField;
    qryzlEmployeePyDate: TDateTimeField;
    qryzlEmployeeSyMonths: TIntegerField;
    qryzlEmployeeZzDate: TDateTimeField;
    qryzlEmployeeRoomBed: TWideStringField;
    qryzlEmployeeIfDaKa: TBooleanField;
    qryzlEmployeeState: TSmallintField;
    qryzlEmployeeLzDate: TDateTimeField;
    qryzlEmployeeLzCause: TWideStringField;
    qryzlEmployeeMemo: TWideStringField;
    qryzlEmployeeZhiJi: TWideStringField;
    qryzlEmployeeZhiWu: TWideStringField;
    qryzlEmployeeXueLi: TWideStringField;
    qryzlEmployeeHunYin: TWideStringField;
    qryzlEmployeeJiGuan: TWideStringField;
    qryzlEmployeeNation: TWideStringField;
    qryzlEmployeeG_jtdh: TWideStringField;
    qryzlEmployeeG_xzdz: TWideStringField;
    qryzlEmployeeG_lxdh: TWideStringField;
    qryzlEmployeeG_email: TWideStringField;
    qryzlEmployeeG_bysj: TDateTimeField;
    qryzlEmployeeG_jtzz: TWideStringField;
    qryzlEmployeeG_yb: TFloatField;
    qryzlEmployeeG_http: TWideStringField;
    qryzlEmployeeJxfs: TWideStringField;
    qryzlEmployeeG_bsw: TWideStringField;
    qryzlEmployeeG_sxzy: TWideStringField;
    qryzlEmployeeG_zzzz: TWideStringField;
    qryItems: TADOQuery;
    qryItemsOrderNo: TFloatField;
    qryItemsItemNo: TFloatField;
    qryItemsPartNo: TFloatField;
    qryItemsQty: TIntegerField;
    qryItemsDiscount: TFloatField;
    qryzlEmployeexueliName: TWideStringField;
    qryItemsPartName: TStringField;
    qryXueli: TADOQuery;
    qryPhoto: TADOQuery;
    qryXueliCode: TWideStringField;
    qryXueliName: TWideStringField;
    qryPhotoID: TIntegerField;
    qryPhotoDept: TWideStringField;
    qryPhotoCode: TWideStringField;
    qryPhotoCardNo: TWideStringField;
    qryPhotoName: TWideStringField;
    qryPhotoSfz: TWideStringField;
    qryPhotoBornDate: TDateTimeField;
    qryPhotoSex: TBooleanField;
    qryPhotoPyDate: TDateTimeField;
    qryPhotoSyMonths: TIntegerField;
    qryPhotoZzDate: TDateTimeField;
    qryPhotoRoomBed: TWideStringField;
    qryPhotoIfDaKa: TBooleanField;
    qryPhotoState: TSmallintField;
    qryPhotoLzDate: TDateTimeField;
    qryPhotoLzCause: TWideStringField;
    qryPhotoMemo: TWideStringField;
    qryPhotoPhoto: TBlobField;
    qryPhotoZhiJi: TWideStringField;
    qryPhotoZhiWu: TWideStringField;
    qryPhotoXueLi: TWideStringField;
    qryPhotoHunYin: TWideStringField;
    qryPhotoJiGuan: TWideStringField;
    qryPhotoNation: TWideStringField;
    qryPhotoJxfs: TWideStringField;
    qryPhotoLzTc: TIntegerField;
    qryPhotoGongZhong: TWideStringField;
    qryPhotoDeBz: TWideStringField;
    qryPhotoG_gwh: TWideStringField;
    qryPhotoCy: TBooleanField;
    qryPhotoEName: TWideStringField;
    qryXueLiEmp: TADOQuery;
    qryXueLiEmpCode: TWideStringField;
    qryXueLiEmpName: TWideStringField;
    qryXueLiEmpNum: TIntegerField;
    qryItemsPrice: TFloatField;
    qryItemsTotal: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
var
  i: integer;
begin        
  mainConn.connected := false;
  mainConn.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=admin;'+
    'Data Source= ' + ExtractFilePath(ParamStr(0)) + '..\..\data\ReportDemo.mdb'+';'+
    'Mode=Share Deny None;Extended Properties="";'+
    'Persist Security Info=False;Jet OLEDB:System database="";'+
    'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;'+
    'Jet OLEDB:Database Locking Mode=0;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
    'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;Jet OLEDB:Encrypt Database=False; Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
 mainConn.Connected := true;
 for i := 0 to ComponentCount -1 do
  if Components[i] is TADOQuery then
    TADOQuery(Components[i]).Open;
end;

end.
