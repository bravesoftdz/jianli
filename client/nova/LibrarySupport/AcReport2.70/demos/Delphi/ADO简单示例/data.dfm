object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 409
  Top = 102
  Height = 334
  Width = 321
  object MainConn: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=admin;Data Source=D:\bf' +
      '\ACreport\ActiveX\data\ReportDemo.mdb;Mode=Share Deny None;Exten' +
      'ded Properties="";Persist Security Info=False;Jet OLEDB:System d' +
      'atabase="";Jet OLEDB:Registry Path="";Jet OLEDB:Database Passwor' +
      'd="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mode=0;J' +
      'et OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transac' +
      'tions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Create Syst' +
      'em Database=False;Jet OLEDB:Encrypt Database=False;Jet OLEDB:Don' +
      #39't Copy Locale on Compact=False;Jet OLEDB:Compact Without Replic' +
      'a Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 32
    Top = 16
  end
  object qryAnimals: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'Select * from animals '
      'order by name')
    Left = 108
    Top = 16
  end
  object qryBiolife: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'select * from biolife')
    Left = 176
    Top = 16
  end
  object qryContry: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'select * from country')
    Left = 240
    Top = 16
  end
  object qryEmployee: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'Select * from Employee order by EmpNo')
    Left = 35
    Top = 80
    object qryEmployeeEmpNo: TIntegerField
      FieldName = 'EmpNo'
    end
    object qryEmployeeLastName: TWideStringField
      FieldName = 'LastName'
    end
    object qryEmployeeFirstName: TWideStringField
      FieldName = 'FirstName'
      Size = 15
    end
    object qryEmployeePhoneExt: TWideStringField
      FieldName = 'PhoneExt'
      Size = 4
    end
    object qryEmployeeHireDate: TDateTimeField
      FieldName = 'HireDate'
    end
    object qryEmployeeSalary: TFloatField
      FieldName = 'Salary'
    end
  end
  object qryCustomer: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'select * from customer order by custNo')
    Left = 112
    Top = 80
    object qryCustomerCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object qryCustomerCompany: TWideStringField
      FieldName = 'Company'
      Size = 30
    end
    object qryCustomerAddr1: TWideStringField
      FieldName = 'Addr1'
      Size = 30
    end
    object qryCustomerAddr2: TWideStringField
      FieldName = 'Addr2'
      Size = 30
    end
    object qryCustomerCity: TWideStringField
      FieldName = 'City'
      Size = 15
    end
    object qryCustomerState: TWideStringField
      FieldName = 'State'
    end
    object qryCustomerZip: TWideStringField
      FieldName = 'Zip'
      Size = 10
    end
    object qryCustomerCountry: TWideStringField
      FieldName = 'Country'
    end
    object qryCustomerPhone: TWideStringField
      FieldName = 'Phone'
      Size = 15
    end
    object qryCustomerFAX: TWideStringField
      FieldName = 'FAX'
      Size = 15
    end
    object qryCustomerTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object qryCustomerContact: TWideStringField
      FieldName = 'Contact'
    end
    object qryCustomerLastInvoiceDate: TDateTimeField
      FieldName = 'LastInvoiceDate'
    end
  end
  object qryOrders: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'Select * from Orders order by OrderNo')
    Left = 180
    Top = 80
    object qryOrdersOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object qryOrdersCustNo: TFloatField
      FieldName = 'CustNo'
    end
    object qryOrdersSaleDate: TDateTimeField
      FieldName = 'SaleDate'
    end
    object qryOrdersShipDate: TDateTimeField
      FieldName = 'ShipDate'
    end
    object qryOrdersEmpNo: TIntegerField
      FieldName = 'EmpNo'
    end
    object qryOrdersShipToContact: TWideStringField
      FieldName = 'ShipToContact'
    end
    object qryOrdersShipToAddr1: TWideStringField
      FieldName = 'ShipToAddr1'
      Size = 30
    end
    object qryOrdersShipToAddr2: TWideStringField
      FieldName = 'ShipToAddr2'
      Size = 30
    end
    object qryOrdersShipToCity: TWideStringField
      FieldName = 'ShipToCity'
      Size = 15
    end
    object qryOrdersShipToState: TWideStringField
      FieldName = 'ShipToState'
    end
    object qryOrdersShipToZip: TWideStringField
      FieldName = 'ShipToZip'
      Size = 10
    end
    object qryOrdersShipToCountry: TWideStringField
      FieldName = 'ShipToCountry'
    end
    object qryOrdersShipToPhone: TWideStringField
      FieldName = 'ShipToPhone'
      Size = 15
    end
    object qryOrdersShipVIA: TWideStringField
      FieldName = 'ShipVIA'
      Size = 7
    end
    object qryOrdersPO: TWideStringField
      FieldName = 'PO'
      Size = 15
    end
    object qryOrdersTerms: TWideStringField
      FieldName = 'Terms'
      Size = 6
    end
    object qryOrdersPaymentMethod: TWideStringField
      FieldName = 'PaymentMethod'
      Size = 7
    end
    object qryOrdersItemsTotal: TFloatField
      FieldName = 'ItemsTotal'
    end
    object qryOrdersTaxRate: TFloatField
      FieldName = 'TaxRate'
    end
    object qryOrdersFreight: TFloatField
      FieldName = 'Freight'
    end
    object qryOrdersAmountPaid: TFloatField
      FieldName = 'AmountPaid'
    end
  end
  object qryParts: TADOQuery
    Connection = MainConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from Parts order by PartNo')
    Left = 240
    Top = 80
    object qryPartsPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object qryPartsVendorNo: TFloatField
      FieldName = 'VendorNo'
    end
    object qryPartsDescription: TWideStringField
      FieldName = 'Description'
      Size = 30
    end
    object qryPartsOnHand: TFloatField
      FieldName = 'OnHand'
    end
    object qryPartsOnOrder: TFloatField
      FieldName = 'OnOrder'
    end
    object qryPartsCost: TFloatField
      FieldName = 'Cost'
    end
    object qryPartsListPrice: TFloatField
      FieldName = 'ListPrice'
    end
  end
  object qryVendors: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'select * from vendors order by vendorNo')
    Left = 32
    Top = 144
    object qryVendorsVendorNo: TFloatField
      FieldName = 'VendorNo'
    end
    object qryVendorsVendorName: TWideStringField
      FieldName = 'VendorName'
      Size = 30
    end
    object qryVendorsAddress1: TWideStringField
      FieldName = 'Address1'
      Size = 30
    end
    object qryVendorsAddress2: TWideStringField
      FieldName = 'Address2'
      Size = 30
    end
    object qryVendorsCity: TWideStringField
      FieldName = 'City'
    end
    object qryVendorsState: TWideStringField
      FieldName = 'State'
    end
    object qryVendorsZip: TWideStringField
      FieldName = 'Zip'
      Size = 10
    end
    object qryVendorsCountry: TWideStringField
      FieldName = 'Country'
      Size = 15
    end
    object qryVendorsPhone: TWideStringField
      FieldName = 'Phone'
      Size = 15
    end
    object qryVendorsFAX: TWideStringField
      FieldName = 'FAX'
      Size = 15
    end
    object qryVendorsPreferred: TBooleanField
      FieldName = 'Preferred'
    end
  end
  object qryzlEmployee: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'select m.*, x.Name as xueliName'
      ' from '
      ' zlemployee m left join xueli x on m.xueli = x.code'
      'order by Id')
    Left = 112
    Top = 144
    object qryzlEmployeeID: TIntegerField
      FieldName = 'ID'
    end
    object qryzlEmployeeDept: TWideStringField
      FieldName = 'Dept'
      Size = 10
    end
    object qryzlEmployeeCode: TWideStringField
      FieldName = 'Code'
      Size = 8
    end
    object qryzlEmployeeCardNo: TWideStringField
      FieldName = 'CardNo'
      Size = 8
    end
    object qryzlEmployeeName: TWideStringField
      FieldName = 'Name'
      Size = 8
    end
    object qryzlEmployeeSfz: TWideStringField
      FieldName = 'Sfz'
      Size = 18
    end
    object qryzlEmployeeBornDate: TDateTimeField
      FieldName = 'BornDate'
    end
    object qryzlEmployeeSex: TBooleanField
      FieldName = 'Sex'
    end
    object qryzlEmployeePyDate: TDateTimeField
      FieldName = 'PyDate'
    end
    object qryzlEmployeeSyMonths: TIntegerField
      FieldName = 'SyMonths'
    end
    object qryzlEmployeeZzDate: TDateTimeField
      FieldName = 'ZzDate'
    end
    object qryzlEmployeeRoomBed: TWideStringField
      FieldName = 'RoomBed'
      Size = 9
    end
    object qryzlEmployeeIfDaKa: TBooleanField
      FieldName = 'IfDaKa'
    end
    object qryzlEmployeeState: TSmallintField
      FieldName = 'State'
    end
    object qryzlEmployeeLzDate: TDateTimeField
      FieldName = 'LzDate'
    end
    object qryzlEmployeeLzCause: TWideStringField
      FieldName = 'LzCause'
      Size = 2
    end
    object qryzlEmployeeMemo: TWideStringField
      FieldName = 'Memo'
      Size = 60
    end
    object qryzlEmployeeZhiJi: TWideStringField
      FieldName = 'ZhiJi'
      Size = 2
    end
    object qryzlEmployeeZhiWu: TWideStringField
      FieldName = 'ZhiWu'
      Size = 6
    end
    object qryzlEmployeeXueLi: TWideStringField
      FieldName = 'XueLi'
      Size = 2
    end
    object qryzlEmployeeHunYin: TWideStringField
      FieldName = 'HunYin'
      Size = 2
    end
    object qryzlEmployeeJiGuan: TWideStringField
      FieldName = 'JiGuan'
      Size = 6
    end
    object qryzlEmployeeNation: TWideStringField
      FieldName = 'Nation'
      Size = 2
    end
    object qryzlEmployeeG_jtdh: TWideStringField
      FieldName = 'G_jtdh'
      Size = 15
    end
    object qryzlEmployeeG_xzdz: TWideStringField
      FieldName = 'G_xzdz'
      Size = 100
    end
    object qryzlEmployeeG_lxdh: TWideStringField
      FieldName = 'G_lxdh'
      Size = 15
    end
    object qryzlEmployeeG_email: TWideStringField
      FieldName = 'G_email'
      Size = 30
    end
    object qryzlEmployeeG_bysj: TDateTimeField
      FieldName = 'G_bysj'
    end
    object qryzlEmployeeG_jtzz: TWideStringField
      FieldName = 'G_jtzz'
      Size = 100
    end
    object qryzlEmployeeG_yb: TFloatField
      FieldName = 'G_yb'
    end
    object qryzlEmployeeG_http: TWideStringField
      FieldName = 'G_http'
      Size = 40
    end
    object qryzlEmployeeJxfs: TWideStringField
      FieldName = 'Jxfs'
      Size = 2
    end
    object qryzlEmployeeG_bsw: TWideStringField
      FieldName = 'G_bsw'
      Size = 6
    end
    object qryzlEmployeeG_sxzy: TWideStringField
      FieldName = 'G_sxzy'
      Size = 24
    end
    object qryzlEmployeeG_zzzz: TWideStringField
      FieldName = 'G_zzzz'
      Size = 10
    end
    object qryzlEmployeexueliName: TWideStringField
      FieldName = 'xueliName'
      Size = 12
    end
  end
  object qryItems: TADOQuery
    Connection = MainConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select i.*, Description as PartName, ListPrice as Price,'
      '            i.Qty * p.ListPrice as Total'
      ' from items i Left Join Parts p On i.PartNo= p.PartNo'
      'order by ItemNo')
    Left = 184
    Top = 144
    object qryItemsOrderNo: TFloatField
      FieldName = 'OrderNo'
    end
    object qryItemsItemNo: TFloatField
      FieldName = 'ItemNo'
    end
    object qryItemsPartNo: TFloatField
      FieldName = 'PartNo'
    end
    object qryItemsQty: TIntegerField
      FieldName = 'Qty'
    end
    object qryItemsDiscount: TFloatField
      FieldName = 'Discount'
    end
    object qryItemsPartName: TStringField
      FieldName = 'PartName'
      LookupDataSet = qryParts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'Description'
      KeyFields = 'PartNo'
      Size = 30
    end
    object qryItemsPrice: TFloatField
      FieldName = 'Price'
      LookupDataSet = qryParts
      LookupKeyFields = 'PartNo'
      LookupResultField = 'ListPrice'
      KeyFields = 'PartNo'
    end
    object qryItemsTotal: TFloatField
      FieldName = 'Total'
    end
  end
  object qryXueli: TADOQuery
    Connection = MainConn
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'Select * from XueLi'
      'Order by Code')
    Left = 240
    Top = 144
    object qryXueliCode: TWideStringField
      FieldName = 'Code'
      Size = 2
    end
    object qryXueliName: TWideStringField
      FieldName = 'Name'
      Size = 12
    end
  end
  object qryPhoto: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'Select * from photo')
    Left = 32
    Top = 208
    object qryPhotoID: TIntegerField
      FieldName = 'ID'
    end
    object qryPhotoDept: TWideStringField
      FieldName = 'Dept'
      Size = 10
    end
    object qryPhotoCode: TWideStringField
      FieldName = 'Code'
      Size = 8
    end
    object qryPhotoCardNo: TWideStringField
      FieldName = 'CardNo'
      Size = 12
    end
    object qryPhotoName: TWideStringField
      FieldName = 'Name'
      Size = 8
    end
    object qryPhotoSfz: TWideStringField
      FieldName = 'Sfz'
      Size = 18
    end
    object qryPhotoBornDate: TDateTimeField
      FieldName = 'BornDate'
    end
    object qryPhotoSex: TBooleanField
      FieldName = 'Sex'
    end
    object qryPhotoPyDate: TDateTimeField
      FieldName = 'PyDate'
    end
    object qryPhotoSyMonths: TIntegerField
      FieldName = 'SyMonths'
    end
    object qryPhotoZzDate: TDateTimeField
      FieldName = 'ZzDate'
    end
    object qryPhotoRoomBed: TWideStringField
      FieldName = 'RoomBed'
      Size = 9
    end
    object qryPhotoIfDaKa: TBooleanField
      FieldName = 'IfDaKa'
    end
    object qryPhotoState: TSmallintField
      FieldName = 'State'
    end
    object qryPhotoLzDate: TDateTimeField
      FieldName = 'LzDate'
    end
    object qryPhotoLzCause: TWideStringField
      FieldName = 'LzCause'
      Size = 2
    end
    object qryPhotoMemo: TWideStringField
      FieldName = 'Memo'
      Size = 60
    end
    object qryPhotoPhoto: TBlobField
      FieldName = 'Photo'
    end
    object qryPhotoZhiJi: TWideStringField
      FieldName = 'ZhiJi'
      Size = 2
    end
    object qryPhotoZhiWu: TWideStringField
      FieldName = 'ZhiWu'
      Size = 3
    end
    object qryPhotoXueLi: TWideStringField
      FieldName = 'XueLi'
      Size = 2
    end
    object qryPhotoHunYin: TWideStringField
      FieldName = 'HunYin'
      Size = 2
    end
    object qryPhotoJiGuan: TWideStringField
      FieldName = 'JiGuan'
      Size = 6
    end
    object qryPhotoNation: TWideStringField
      FieldName = 'Nation'
      Size = 2
    end
    object qryPhotoJxfs: TWideStringField
      FieldName = 'Jxfs'
      Size = 2
    end
    object qryPhotoLzTc: TIntegerField
      FieldName = 'LzTc'
    end
    object qryPhotoGongZhong: TWideStringField
      FieldName = 'GongZhong'
      Size = 5
    end
    object qryPhotoDeBz: TWideStringField
      FieldName = 'DeBz'
      Size = 4
    end
    object qryPhotoG_gwh: TWideStringField
      FieldName = 'G_gwh'
      Size = 10
    end
    object qryPhotoCy: TBooleanField
      FieldName = 'Cy'
    end
    object qryPhotoEName: TWideStringField
      FieldName = 'EName'
      Size = 40
    end
  end
  object qryXueLiEmp: TADOQuery
    Connection = MainConn
    Parameters = <>
    SQL.Strings = (
      'Select X.Code, X.Name, Count(*) As Num'
      '  From zlemployee z inner join Xueli X'
      '      On z.XueLi = X.Code'
      'Group By X.Code, X.Name')
    Left = 112
    Top = 208
    object qryXueLiEmpCode: TWideStringField
      FieldName = 'Code'
      Size = 2
    end
    object qryXueLiEmpName: TWideStringField
      FieldName = 'Name'
      Size = 12
    end
    object qryXueLiEmpNum: TIntegerField
      FieldName = 'Num'
    end
  end
end
