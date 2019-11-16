unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DB, ADODB, AcReport_TLB, ACRptUtils;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    qryXueLi: TADOQuery;
    qryXueLiCode: TStringField;
    qryXueLiName: TStringField;
    qryDept: TADOQuery;
    qryDeptCode: TStringField;
    qryDeptName: TStringField;
    qryDeptManager: TStringField;
    qryDeptTel: TStringField;
    qryXuLiHz: TADOQuery;
    StringField9: TStringField;
    StringField10: TStringField;
    qryXuLiHzFAmount: TIntegerField;
    qryRptList: TADOQuery;
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
    qryGoods: TADOQuery;
    qryGoodsCode: TStringField;
    qryGoodsUnit: TStringField;
    qryGoodsName: TStringField;
    qryGoodsSpec: TStringField;
    qryGoodsStocks_1: TFloatField;
    qryGoodsStocks_2: TFloatField;
    qryDetail: TADOQuery;
    qryDetailsNo: TStringField;
    qryDetailId: TIntegerField;
    qryDetailCode: TStringField;
    qryDetailName: TStringField;
    qryDetailUnit: TStringField;
    qryDetailSpec: TStringField;
    qryDetailBarCode_1: TStringField;
    qryDetailNum: TFloatField;
    qryDetailPrice_Sale: TFloatField;
    qryDetailPrice: TFloatField;
    qryDetailJe: TFloatField;
    qryMaster: TADOQuery;
    qryMastersNo: TStringField;
    qryMasterDate: TDateTimeField;
    qryMasterHandNo: TStringField;
    qryMasterOperator: TStringField;
    qryMasterEnterMan: TStringField;
    qryMasterpdNo: TStringField;
    qryMasterName: TStringField;
    qryMasterJe: TFloatField;
    qryMasterNote: TStringField;
    qryMasterkindcode: TStringField;
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
    qryEmp: TADOQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    DateTimeField1: TDateTimeField;
    BooleanField1: TBooleanField;
    StringField6: TStringField;
    DateTimeField2: TDateTimeField;
    IntegerField1: TIntegerField;
    DateTimeField3: TDateTimeField;
    StringField7: TStringField;
    DateTimeField4: TDateTimeField;
    StringField8: TStringField;
    qryEmpXueLi: TStringField;
    qryEmpXueLiN: TStringField;
    qryEmpG_email: TStringField;
    qryGzTotal: TADOQuery;
    qryGzTotalEmpID: TIntegerField;
    qryGzTotalCode: TStringField;
    qryGzTotalName: TStringField;
    qryGzTotalSex: TBooleanField;
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
    qryGzTotalG_hsbc: TFloatField;
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
    AdoConn: TADOConnection;
    DataSource1: TDataSource;
    qryRptListFID: TAutoIncField;
    qryRptListFRptName: TWideStringField;
    qryRptDoc: TADOQuery;
    qryRptDocFRptDoc: TBlobField;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    qryRptListFRptDoc: TBlobField;
    Button6: TButton;
    qryRptDocFId: TAutoIncField;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    FAcRptEngine: TAcRptEngine;
    procedure GetRptDoc(AId: integer);
    function GetRptFromDb: boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R XpStyle.RES}

var
  WPath, Wdb: string;
  
procedure TForm1.FormCreate(Sender: TObject);
var
  I: integer;
  AConnStr: string;
begin
  FAcRptEngine := TAcRptEngine.Create(Self);
  FAcRptEngine.ShowPreviewOnPrepare := true;
  
  WPath := ExtractFilePath(ParamStr(0));
  Wdb := WPath+'..\..\..\Data\ReportDemo.mdb';
  WPath := WPath + 'rpt\';

  AConnStr := 'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source='+
  WDb+ ';Mode=Share Deny None;Extended Properties="";Jet OLEDB:System database="";'+
  'Jet OLEDB:Registry Path="";Jet OLEDB:Database Password="";Jet OLEDB:Engine Type=5;'+
  'Jet OLEDB:Database Locking Mode=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk Transactions=1;'+
  'Jet OLEDB:New Database Password="";Jet OLEDB:Create System Database=False;'+
  'Jet OLEDB:Encrypt Database=False;Jet OLEDB:Compact Without Replica Repair=False;Jet OLEDB:SFP=False';
  AdoConn.ConnectionString := AConnStr;
  AdoConn.Connected := true;                               

  //打开所有的数据集，并以ADO专门的方法(AddDataset)将数据传入报表引擎
  for I := 0 to ComponentCount -1 do
  if Components[I] is TADOQuery then
  if Components[I] <> qryRptDoc then
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
end;

procedure TForm1.GetRptDoc(AId: integer);
begin
  qryRptDoc.Close;
  qryRptDoc.Parameters.ParamByName('Id').Value := AId;
  qryRptDoc.Open;
end;

function TForm1.GetRptFromDb: boolean;
begin
  Result := false;
  if qryRptList.IsEmpty then
  begin
    ShowMessage('未定义报表模板');
    Exit;
  end;
  GetRptDoc(qryRptListFId.Value); //取得报表模板到 qryRptDoc 中
  if qryRptDoc.IsEmpty or qryRptDocFRptDoc.IsNull then
  begin
    ShowMessage('未定义报表模板');
    Exit;
  end;
  //AcRptUtils.LoadAcFromCommonBlobField 可以从任何类型的Dataset中装入报表模板，包括BDE、ClientDataset
  AcRptUtils.LoadAcFromCommonBlobField(FAcRptEngine, qryRptDocFRptDoc, qryRptListFRptName.Value);
  Result := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if GetRptFromDb then
    FAcRptEngine.Preview;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  n: integer;
  ws: WideString;
begin
  if GetRptFromDb then
  begin
    FAcRptEngine.DisableSaveToFile := true; //禁止在设计器中保存到文件
    FAcRptEngine.ShowDesigner;
    if Application.MessageBox('是否保存更改到数据库?', '提示', MB_YESNO) = IDYES then
    begin
     qryRptList.Edit;
     if not AcRptUtils.SaveAcToCommonBlobField(FAcRptEngine, qryRptListFRptDoc) then
      begin
        FAcRptEngine.GetLastError(n, ws);
        ShowMessage(ws);
        if qryRptList.State in [dsEdit ,dsInsert] then
        qryRptList.Cancel
      end
      else
       if qryRptList.State in [dsEdit ,dsInsert] then
         qryRptList.Post;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  AName: string;
begin
  if OpenDlg.Execute then
  begin
    AName := ExtractFileName(OpenDlg.FileName);
    if pos('.apt', LowerCase(AName)) > 0 then
      AName := Copy(AName, 1, Length(AName) - 4);
    qryRptList.Append;
    qryRptListFRptName.Value := AName;
    qryRptListFRptDoc.LoadFromFile(OpenDlg.FileName);
    qryRptList.Post;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  if not qryRptList.IsEmpty then
  begin
    SaveDlg.FileName := qryRptListFRptName.Value + '.apt';
    if SaveDlg.Execute then
      qryRptListFRptDoc.SaveToFile(SaveDlg.FileName);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  if not qryRptList.IsEmpty then
  if Application.MessageBox('确定从数据库中删除当前选中的模板吗?', '提示', MB_YESNO) = IDYES then
    qryRptList.Delete; 
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  FAcRptEngine.Init;
end;

end.
