unit UFrmTicketturnoverReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, UFrmTicketturnover,
  ImgList, DB, ADODB,NovaPrint,
  DBClient, jsonClientDataSet, UFrmTicketturnoverEdit, Generics.Collections,AcRptUtilsticketturnover,
  OleServer, AcReport_TLB;

type
  TFrmTicketturnoverreport = class(TSimpleEditForm)
    btn1: TButton;
    ds1: TDataSource;
    jcdsResultTicketturnover: TjsonClientDataSet;
    jcdsResultTurnover: TjsonClientDataSet;
    ds2: TDataSource;
    lbl1: TLabel;
    jcdsResultMoney: TjsonClientDataSet;
    ds3: TDataSource;
    AcRptEngineTotalDeatil: TAcRptEngine;
    jcdsResultTicketreturnAndCancel: TjsonClientDataSet;
    jcdsqryReCelTicketnoByAcReport: TjsonClientDataSet;
    dsReAndCelTcketnos: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    billPrint: TNovaPrint;
    notprintValue: TList<string>; // ����ӡ��Ŀ
    printValue: TDictionary<String, String>; // ���������
    rpt_path:string;
  public
    { Public declarations }
    isturnover : boolean; //�Ƿ����ѽɿ��ѯ��ӡ
    ticketturnoverdetails : string;//Ӫ�սɿ���ϸids����acreport��ӡδӪ�սɿ���ѽɿ�Ӫ��ʹ��

    WPath,startticketno,endticketno,saledate : string;
    sign : Boolean;
    ticketturnoverid : Int64;
    returntno, canceltno, damagedtno,
    returnino, cancelino, damagedino, templtename , turnoverid,
    remarks,orgname,turnovertime, receivername,sellername,sellercode : string;
    preprice,nostationfeemoney,
    bookservicefee,changeservicefee,moneypayable, noncashmoney,
    nonvouchermoneypayable,returnhandcharge,returnmoney,
    sellmoney ,servicefee,money,cancelmoney : Currency;

    startmoneydate,endmoneydate : TDateTime;
    cancelnum, eticketnum,sellnum,noncashnum,returnnum,precount,
    returnprintnum,billdamagednum,sellreturntripnum : Int64;

    billnouse,moneydate:String; //Ʊ֤���ĶΡ�Ʊ������
    lost,lastlost:String;
    modelname,modeltype:String;//ģ�����ƣ�ģ������
    salldate:string;//��Ʊ����
    insurecancelmoney,insurereturnmoney,insuresellmoney,insuremoneypayable:Currency;
    insurecancelnum,insurereturnnum,insuresellnum:Int64;

    stationservicefee, fueladditionfee,computefee,coolairfee,
    additionfee,waterfee,insurefee, otherfee:String;
    var  changenum:LongWord;

    procedure ShowReport;
    procedure PrintTicketturnover;
    procedure PrintTicketturnoverReport(var titlename:string);
    procedure PrintReCelTicketnoByAcReport;//acreport��ӡ��ʾ ͳ����Ʊ�źͷ�Ʊ�� ��δӪ�սɿ�/�ѽɿ�Ӫ�յ���
  end;

var
  FrmTicketturnoverreport: TFrmTicketturnoverreport;

implementation

uses Services, UFrmTicketturnoverQuery,PubFn;
{$R *.dfm}

procedure TFrmTicketturnoverreport.bbtnSaveClick(Sender: TObject);
begin
  inherited;
 { frxrprt1.LoadFromFile(WPath + 'Ticketturnover.fr3');
  frxrprt1.Script.AddVariable('WPath', 'String', WPath);
  frxrprt1.DesignReport;  }
end;

procedure TFrmTicketturnoverreport.btn1Click(Sender: TObject);
begin
  inherited;
  ShowReport;
end;

procedure TFrmTicketturnoverreport.FormCreate(Sender: TObject);
begin
  inherited;
  AcRptEngineTotalDeatil := TAcRptEngine.Create(nil);
end;

procedure TFrmTicketturnoverreport.FormShow(Sender: TObject);
begin
  inherited;
  WPath := ExtractFilePath(Application.ExeName);
  rpt_path := ExtractFilePath(ParamStr(0));
end;

procedure TFrmTicketturnoverreport.ShowReport;
var
 ADataset: TDataset;
begin
//  frxrprt1.LoadFromFile(WPath + 'Ticketturnover.fr3');
//  frxrprt1.Script.AddVariable('WPath', 'String', WPath);
//  frxrprt1.ShowReport;
  //����һ������Ӫ�սɿ�ͳ�Ʊ��ӡӢɽͳ�Ʊ�����ͨ��

  templtename := TNovaPrint.GetTicketModelName('Ӫ�սɿ�', 'Ӫ�սɿ�');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
   // notprintValue:=getNotprintValue(SysInfo.LoginUserInfo.OrgID,vehicleid,templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
    printValue.Clear;
  with jcdsResultTicketturnover do
  begin
    Active := False;
      Params.ParamValues['ticketturnoverid'] := ticketturnoverid;
    Active := True;

  if  (getParametervalue('4038', sysInfo.LoginUserInfo.OrgID)='1') then
  begin
    with jcdsResultTicketreturnAndCancel do
    begin
      try
      Active := False;
      Params.ParamValues['ticketturnoverid'] := ticketturnoverid;
      Active := True;
      except on e:Exception do
        SysLog.WriteErr(e.Message);
      end;
//      if RecordCount>0 then         //RecordCount>0
      begin
        ADataset:=ds3.DataSet;
        AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'ticketturnoverdetail.apt');
        AcRptEngineTotalDeatil.AddGlobalVariable('printName',SysInfo.LoginUserInfo.UserName);
        AcRptEngineTotalDeatil.AddGlobalVariable('ticketnostartandend', jcdsResultTicketturnover.FieldByName('ticketnostartandend').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('preprice', jcdsResultTicketturnover.FieldByName('preprice').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('precount', jcdsResultTicketturnover.FieldByName('precount').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('bookservicefee', jcdsResultTicketturnover.FieldByName('bookservicefee').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('cancelnum', jcdsResultTicketturnover.FieldByName('cancelnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('changeservicefee', jcdsResultTicketturnover.FieldByName('changeservicefee').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('eticketnum', jcdsResultTicketturnover.FieldByName('eticketnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('moneypayable', jcdsResultTicketturnover.FieldByName('moneypayable').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('noncashmoney', jcdsResultTicketturnover.FieldByName('noncashmoney').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('noncashnum', jcdsResultTicketturnover.FieldByName('noncashnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('nonvouchermoneypayable', jcdsResultTicketturnover.FieldByName('nonvouchermoneypayable').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('orgname', jcdsResultTicketturnover.FieldByName('orgname').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('printtime', FormatDateTime('yyyy-mm-dd', now()));
        AcRptEngineTotalDeatil.AddGlobalVariable('receivername', jcdsResultTicketturnover.FieldByName('receivername').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('remarks', jcdsResultTicketturnover.FieldByName('remarks').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnhandcharge', jcdsResultTicketturnover.FieldByName('returnhandcharge').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnmoney', jcdsResultTicketturnover.FieldByName('returnmoney').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnnum', jcdsResultTicketturnover.FieldByName('returnnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellercode', jcdsResultTicketturnover.FieldByName('code').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellername', jcdsResultTicketturnover.FieldByName('sellername').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellmoney', jcdsResultTicketturnover.FieldByName('sellmoney').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellnum', jcdsResultTicketturnover.FieldByName('sellnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('servicefee', jcdsResultTicketturnover.FieldByName('servicefee').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('turnovertime', jcdsResultTicketturnover.FieldByName('turnovertime').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('money', jcdsResultTicketturnover.FieldByName('money').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('cancelmoney', jcdsResultTicketturnover.FieldByName('cancelmoney').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellreturntripnum', jcdsResultTicketturnover.FieldByName('sellreturntripnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnprintnum', jcdsResultTicketturnover.FieldByName('returnprintnum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('billdamagednum', jcdsResultTicketturnover.FieldByName('billdamagednum').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('startticketno', jcdsResultTicketturnover.FieldByName('startticketno').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('endticketno', jcdsResultTicketturnover.FieldByName('endticketno').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('startmoneydate', FormatDateTime('yyyy-mm-dd',jcdsResultTicketturnover.FieldByName('startmoneydate').AsDateTime));
        AcRptEngineTotalDeatil.AddGlobalVariable('endmoneydate', FormatDateTime('yyyy-mm-dd',jcdsResultTicketturnover.FieldByName('endmoneydate').AsDateTime));
        AcRptEngineTotalDeatil.AddGlobalVariable('lastlost', jcdsResultTicketturnover.FieldByName('lastlost').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('lost', jcdsResultTicketturnover.FieldByName('lost').AsString);
        AcRptEngineTotalDeatil.AddGlobalVariable('billnouse', billnouse);
        AcRptEngineTotalDeatil.AddGlobalVariable('moneydate', moneydate);
        AcRptEngineTotalDeatil.AddGlobalVariable('cashmoneypayable', CurrToStr(jcdsResultTicketturnover.FieldByName('moneypayable').AsCurrency-jcdsResultTicketturnover.FieldByName('nonvouchermoneypayable').AsCurrency));
//
//        AcRptEngineTotalDeatil.AddGlobalVariable('insurecancelmoney', jcdsResultTicketturnover.FieldByName('insurecancelmoney').AsString);
//        AcRptEngineTotalDeatil.AddGlobalVariable('insurecancelnum', jcdsResultTicketturnover.FieldByName('insurecancelnum').AsString);
//        AcRptEngineTotalDeatil.AddGlobalVariable('insurereturnmoney', jcdsResultTicketturnover.FieldByName('insurereturnmoney').AsString);
//        AcRptEngineTotalDeatil.AddGlobalVariable('insurereturnnum', jcdsResultTicketturnover.FieldByName('insurereturnnum').AsString);
//        AcRptEngineTotalDeatil.AddGlobalVariable('insuresellmoney', jcdsResultTicketturnover.FieldByName('insuresellmoney').AsString);
//        AcRptEngineTotalDeatil.AddGlobalVariable('insuresellnum', jcdsResultTicketturnover.FieldByName('insuresellnum').AsString);
//        AcRptEngineTotalDeatil.AddGlobalVariable('insuremoneypayable', CurrToStr(jcdsResultTicketturnover.FieldByName('insuresellmoney').AsCurrency
//                                                      -jcdsResultTicketturnover.FieldByName('insurereturnmoney').AsCurrency
//                                                      -jcdsResultTicketturnover.FieldByName('insurecancelmoney').AsCurrency)
//                                         );
   { nostationfeemoney:=FieldByName('moneypayable').AsCurrency-FieldByName('stationservicefee').AsCurrency;
    printValue.Add('nostationfeemoney', CurrToStr(nostationfeemoney));
    printValue.Add('stationservicefee', FieldByName('stationservicefee').AsString);
    printValue.Add('fueladditionfee', FieldByName('fueladditionfee').AsString);
    printValue.Add('computefee', FieldByName('computefee').AsString);
    printValue.Add('coolairfee', FieldByName('coolairfee').AsString);
    printValue.Add('additionfee', FieldByName('additionfee').AsString);
    printValue.Add('waterfee', FieldByName('waterfee').AsString);
    printValue.Add('insurefee', FieldByName('insurefee').AsString);
    printValue.Add('otherfee', FieldByName('otherfee').AsString);
    printValue.Add('ticketoutletsname', Sysinfo.LoginUserInfo.ticketoutletsname);
     //������ƱƱ�ۣ���Ʊ�����Ʊ�����ѣ�
    printValue.Add('returnprice',CurrToStr(FieldByName('returnmoney').AsCurrency
                        +FieldByName('returnhandcharge').AsCurrency));
    printValue.Add('ticketnoOnline',FieldByName('ticketnoOnline').AsString);
    printValue.Add('ticketnoCancel',FieldByName('ticketnoCancel').AsString);
    printValue.Add('changenum',IntToStr(changenum)); }
//            AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
       AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ
//
    end;
    end;
  end
  else
  begin
    printValue.Add('preprice', FieldByName('preprice').AsString);
    printValue.Add('precount', FieldByName('precount').AsString);
    printValue.Add('bookservicefee', FieldByName('bookservicefee').AsString);
    printValue.Add('cancelnum', FieldByName('cancelnum').AsString);
    printValue.Add('changeservicefee', FieldByName('changeservicefee').AsString);
    printValue.Add('eticketnum', FieldByName('eticketnum').AsString);
    printValue.Add('moneypayable', FieldByName('moneypayable').AsString);
    printValue.Add('noncashmoney', FieldByName('noncashmoney').AsString);
    printValue.Add('noncashnum', FieldByName('noncashnum').AsString);
    printValue.Add('nonvouchermoneypayable', FieldByName('nonvouchermoneypayable').AsString);
    printValue.Add('orgname', FieldByName('orgname').AsString);
    printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now()));
    printValue.Add('receivername', FieldByName('receivername').AsString);
    printValue.Add('remarks', FieldByName('remarks').AsString);
    printValue.Add('returnhandcharge', FieldByName('returnhandcharge').AsString);
    printValue.Add('returnmoney', FieldByName('returnmoney').AsString);
    printValue.Add('returnnum', FieldByName('returnnum').AsString);
    printValue.Add('sellercode', FieldByName('code').AsString);
    printValue.Add('sellername', FieldByName('sellername').AsString);
    printValue.Add('sellmoney', FieldByName('sellmoney').AsString);
    printValue.Add('sellnum', FieldByName('sellnum').AsString);
    printValue.Add('servicefee', FieldByName('servicefee').AsString);
    printValue.Add('turnovertime', FieldByName('turnovertime').AsString);
    printValue.Add('money', FieldByName('money').AsString);
    printValue.Add('cancelmoney', FieldByName('cancelmoney').AsString);
    printValue.Add('sellreturntripnum', FieldByName('sellreturntripnum').AsString);
    printValue.Add('returnprintnum', FieldByName('returnprintnum').AsString);
    printValue.Add('billdamagednum', FieldByName('billdamagednum').AsString);
    printValue.Add('startticketno', FieldByName('startticketno').AsString);
    printValue.Add('endticketno', FieldByName('endticketno').AsString);
    printValue.Add('startmoneydate', FormatDateTime('yyyy-mm-dd',FieldByName('startmoneydate').AsDateTime));
    printValue.Add('endmoneydate', FormatDateTime('yyyy-mm-dd',FieldByName('endmoneydate').AsDateTime));
    printValue.Add('lastlost', FieldByName('lastlost').AsString);
    printValue.Add('lost', FieldByName('lost').AsString);
    printValue.Add('billnouse', billnouse);
    printValue.Add('moneydate', moneydate);
    printValue.Add('cashmoneypayable', CurrToStr(FieldByName('moneypayable').AsCurrency-FieldByName('nonvouchermoneypayable').AsCurrency));

    printValue.Add('insurecancelmoney', FieldByName('insurecancelmoney').AsString);
    printValue.Add('insurecancelnum', FieldByName('insurecancelnum').AsString);
    printValue.Add('insurereturnmoney', FieldByName('insurereturnmoney').AsString);
    printValue.Add('insurereturnnum', FieldByName('insurereturnnum').AsString);
    printValue.Add('insuresellmoney', FieldByName('insuresellmoney').AsString);
    printValue.Add('insuresellnum', FieldByName('insuresellnum').AsString);
    printValue.Add('insuremoneypayable', CurrToStr(FieldByName('insuresellmoney').AsCurrency
                                                  -FieldByName('insurereturnmoney').AsCurrency
                                                  -FieldByName('insurecancelmoney').AsCurrency)
                                         );
    nostationfeemoney:=FieldByName('moneypayable').AsCurrency-FieldByName('stationservicefee').AsCurrency;
    printValue.Add('nostationfeemoney', CurrToStr(nostationfeemoney));
    printValue.Add('stationservicefee', FieldByName('stationservicefee').AsString);
    printValue.Add('fueladditionfee', FieldByName('fueladditionfee').AsString);
    printValue.Add('computefee', FieldByName('computefee').AsString);
    printValue.Add('coolairfee', FieldByName('coolairfee').AsString);
    printValue.Add('additionfee', FieldByName('additionfee').AsString);
    printValue.Add('waterfee', FieldByName('waterfee').AsString);
    printValue.Add('insurefee', FieldByName('insurefee').AsString);
    printValue.Add('otherfee', FieldByName('otherfee').AsString);
    printValue.Add('ticketoutletsname', Sysinfo.LoginUserInfo.ticketoutletsname);
     //������ƱƱ�ۣ���Ʊ�����Ʊ�����ѣ�
    printValue.Add('returnprice',CurrToStr(FieldByName('returnmoney').AsCurrency
                        +FieldByName('returnhandcharge').AsCurrency));
    printValue.Add('ticketnoOnline',FieldByName('ticketnoOnline').AsString);
    printValue.Add('ticketnoCancel',FieldByName('ticketnoCancel').AsString);
    printValue.Add('ticketnostartandend',FieldByName('ticketnostartandend').AsString);
    printValue.Add('changenum',IntToStr(changenum));
//    printValue.Add('insurereturnhandcharge', FieldByName('insurereturnhandcharge').AsString);
//    insurechargemoney;
//    insurechargenum;
//    insureeticketnum;
//    insurenonvouchermoneypayable;
  billPrint.SingleValue := printValue;
  //billPrint.MultipleValue := multiplelist;

  billPrint.Print;
  end;
end;
end;


procedure TFrmTicketturnoverreport.PrintTicketturnover;
begin
  Delete(turnoverid, Length(turnoverid), 1);
  if Trim(turnoverid) <> '' then
  begin
    with jcdsResultMoney do
    begin
      Active := False;
        Params.ParamValues['filter_INS_t!id'] := '('+turnoverid+')';
      Active := True;
      money := FieldByName('turnovermoney').AsCurrency;
    end;
  end;
  templtename := TNovaPrint.GetTicketModelName('Ӫ�սɿ�', 'Ӫ�սɿ�');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
  printValue.Clear;
  printValue.Add('preprice', CurrToStr(preprice));
  printValue.Add('precount', IntToStr(precount));
  printValue.Add('bookservicefee', CurrToStr(bookservicefee));
  printValue.Add('cancelnum', IntToStr(cancelnum));
  printValue.Add('changeservicefee', currtostr(changeservicefee));
  printValue.Add('changenum',IntToStr(changenum));
  printValue.Add('eticketnum', IntToStr(eticketnum));
  printValue.Add('moneypayable', currtostr(moneypayable));
  printValue.Add('noncashmoney', currtostr(noncashmoney));
  printValue.Add('noncashnum', IntToStr(noncashnum));
  printValue.Add('nonvouchermoneypayable', currtostr(nonvouchermoneypayable));
  printValue.Add('orgname', orgname);
  printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now()));
  printValue.Add('receivername', receivername);
  printValue.Add('remarks', remarks);
  printValue.Add('returnhandcharge', currtostr(returnhandcharge));
  printValue.Add('returnmoney', currtostr(returnmoney));
  printValue.Add('returnnum', IntToStr(returnnum));
  printValue.Add('sellercode', sellercode);
  printValue.Add('sellername', sellername);
  printValue.Add('sellmoney', currtostr(sellmoney));
  printValue.Add('sellnum', IntToStr(sellnum));
  printValue.Add('servicefee', currtostr(servicefee));
  printValue.Add('turnovertime', turnovertime);
  printValue.Add('money', currtostr(money));
  printValue.Add('cancelmoney', currtostr(cancelmoney));
  printValue.Add('sellreturntripnum', IntToStr(sellreturntripnum));
  printValue.Add('returnprintnum', IntToStr(returnprintnum));
  printValue.Add('billdamagednum', IntToStr(billdamagednum));
  printValue.Add('startticketno', startticketno);
  printValue.Add('endticketno', endticketno);
  printValue.Add('startmoneydate', FormatDateTime('yyyy-mm-dd',startmoneydate));
  printValue.Add('endmoneydate', FormatDateTime('yyyy-mm-dd',endmoneydate));
  printValue.Add('lastlost', lastlost);
  printValue.Add('lost', lost);
  printValue.Add('billnouse', billnouse);
  printValue.Add('moneydate', moneydate);
  printValue.Add('cashmoneypayable', CurrToStr(moneypayable-nonvouchermoneypayable));
  nostationfeemoney:=moneypayable-strtocurr(stationservicefee);
  printValue.Add('nostationfeemoney', CurrToStr(nostationfeemoney));
  printValue.Add('insurecancelmoney', CurrToStr(insurecancelmoney));
  printValue.Add('insurecancelnum', IntToStr(insurecancelnum));
  printValue.Add('insurereturnmoney', CurrToStr(insurereturnmoney));
  printValue.Add('insurereturnnum', IntToStr(insurereturnnum));
  printValue.Add('insuresellmoney', CurrToStr(insuresellmoney));
  printValue.Add('insuresellnum', IntToStr(insuresellnum));
  printValue.Add('insuremoneypayable', CurrToStr(insuremoneypayable));
    printValue.Add('ticketoutletsname', Sysinfo.LoginUserInfo.ticketoutletsname);
    printValue.Add('stationservicefee', stationservicefee);
    printValue.Add('fueladditionfee',fueladditionfee);
    printValue.Add('computefee',computefee);
    printValue.Add('coolairfee',coolairfee);
    printValue.Add('additionfee',additionfee);
    printValue.Add('waterfee', waterfee);
    printValue.Add('insurefee',insurefee);
    printValue.Add('otherfee', otherfee);
  //������ƱƱ�ۣ���Ʊ�����Ʊ�����ѣ�
  printValue.Add('returnprice',CurrToStr(returnmoney+returnhandcharge));
  billPrint.SingleValue := printValue;
  billPrint.Print;

end;


procedure TFrmTicketturnoverreport.PrintTicketturnoverReport(var titlename:string);
begin

  Delete(turnoverid, Length(turnoverid), 1);
  if Trim(turnoverid) <> '' then
  begin
    with jcdsResultMoney do
    begin
      Active := False;
        Params.ParamValues['filter_INS_t!id'] := '('+turnoverid+')';
      Active := True;
      money := FieldByName('turnovermoney').AsCurrency;
    end;
  end;
  templtename := TNovaPrint.GetTicketModelName('��ƱӪ�յ�', '��ƱӪ�յ�');
  if not Assigned(billPrint) then
    billPrint := TNovaPrint.Create(self, templtename);
  if not Assigned(printValue) then
    printValue := TDictionary<String, String>.Create
  else
  printValue.Clear;
  printValue.Add('titlename',titlename);//����
  printValue.Add('orgname', orgname);//��Ʊ����
  printValue.Add('saledate', saledate);//��Ʊ����
  printValue.Add('sellmoney', currtostr(sellmoney));//��Ʊ���
  printValue.Add('sellnum', IntToStr(sellnum));//��Ʊ��
  printValue.Add('returnmoney', currtostr(returnmoney));//��Ʊ���
  printValue.Add('returnnum', IntToStr(returnnum));//��Ʊ��
  printValue.Add('cancelnum', IntToStr(cancelnum));//��Ʊ��
  printValue.Add('cancelmoney', currtostr(cancelmoney));//��Ʊ���
  printValue.Add('eticketnum', IntToStr(eticketnum));//����Ʊ��
  printValue.Add('billdamagednum', IntToStr(billdamagednum));//��Ʊ��
  printValue.Add('returnhandcharge', currtostr(returnhandcharge));//��Ʊ������
  printValue.Add('servicefee', currtostr(servicefee));//��Ʊ��
  printValue.Add('bookservicefee', CurrToStr(bookservicefee));//��Ʊ��
  printValue.Add('changeservicefee', currtostr(changeservicefee));//��ǩ��
  printValue.Add('cashmoneypayable', CurrToStr(moneypayable));//Ӫ��
  printValue.Add('stationservicefee', stationservicefee);//����վ���
  printValue.Add('balancby', receivername);//��ӡ��
  printValue.add('sellername',sellername);//��ƱԱ
  printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now()));//��ӡʱ��
  printValue.Add('remarks', remarks);//��ע
  printValue.Add('ticketoutletsname', Sysinfo.LoginUserInfo.ticketoutletsname);
  billPrint.SingleValue := printValue;
  billPrint.Print;

end;

procedure TFrmTicketturnoverreport.PrintReCelTicketnoByAcReport;//acreport��ӡ��ʾ ͳ����Ʊ�źͷ�Ʊ�� ��δӪ�սɿ�/�ѽɿ�Ӫ�յ���
var ADataset: TDataset;
begin
  if  (getParametervalue('4038', sysInfo.LoginUserInfo.OrgID)='1') then
  begin //4038  Ӫ�սɿ�ͳ�Ʊ��ӡģ�壬0Ӫ�սɿ�ģ�壬1�����˷���ϸ�Ĺ̶�ģ�壬Ĭ��Ϊ0

    with jcdsqryReCelTicketnoByAcReport do
    begin
      try
        Active := False;
          if (ticketturnoverdetails <> '') then
            Params.ParamValues['filter_INS_td!id'] := '(' + ticketturnoverdetails + ')';//Ӫ�սɿ���ϸids����acreport��ӡδӪ�սɿ���ѽɿ�Ӫ��ʹ��

          if isturnover then   //�Ƿ����ѽɿ��ѯ��ӡ
          begin
            Params.ParamValues['filter_EQB_td!isturnover'] := true;
          end
          else
          begin
            Params.ParamValues['filter_EQB_td!isturnover'] := false;
          end;
        Active := True;
      except on e:Exception do
        SysLog.WriteErr(e.Message);
      end;

        ADataset := dsReAndCelTcketnos.DataSet;// //����ticketturnoverdetails��ѯ�õ��� ��Ʊ/��Ʊ �����
        AddCommonDatasetToAcReport(ADataset,AcRptEngineTotalDeatil,'detail');
        AcRptEngineTotalDeatil.SetReportFile(rpt_path+'ticketturnoverdetail.apt');

        AcRptEngineTotalDeatil.AddGlobalVariable('printName',SysInfo.LoginUserInfo.UserName);
        AcRptEngineTotalDeatil.AddGlobalVariable('ticketnostartandend', startticketno + '------' + endticketno);
        AcRptEngineTotalDeatil.AddGlobalVariable('preprice', preprice);
        AcRptEngineTotalDeatil.AddGlobalVariable('precount', precount);
        AcRptEngineTotalDeatil.AddGlobalVariable('bookservicefee', bookservicefee);
        AcRptEngineTotalDeatil.AddGlobalVariable('cancelnum', cancelnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('changeservicefee', changeservicefee);
        AcRptEngineTotalDeatil.AddGlobalVariable('eticketnum', eticketnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('moneypayable', moneypayable);
        AcRptEngineTotalDeatil.AddGlobalVariable('noncashmoney', noncashmoney);
        AcRptEngineTotalDeatil.AddGlobalVariable('noncashnum', noncashnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('nonvouchermoneypayable', nonvouchermoneypayable);
        AcRptEngineTotalDeatil.AddGlobalVariable('orgname', orgname);
        AcRptEngineTotalDeatil.AddGlobalVariable('printtime', FormatDateTime('yyyy-mm-dd', now()));
        AcRptEngineTotalDeatil.AddGlobalVariable('receivername', receivername);
        AcRptEngineTotalDeatil.AddGlobalVariable('remarks', remarks);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnhandcharge', returnhandcharge);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnmoney', returnmoney);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnnum', returnnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellercode', sellercode);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellername', sellername);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellmoney', sellmoney);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellnum', sellnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('servicefee', servicefee);
        AcRptEngineTotalDeatil.AddGlobalVariable('turnovertime', turnovertime);
        AcRptEngineTotalDeatil.AddGlobalVariable('money', money);
        AcRptEngineTotalDeatil.AddGlobalVariable('cancelmoney', cancelmoney);
        AcRptEngineTotalDeatil.AddGlobalVariable('sellreturntripnum', sellreturntripnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('returnprintnum', returnprintnum);
        AcRptEngineTotalDeatil.AddGlobalVariable('billdamagednum', billdamagednum);
        AcRptEngineTotalDeatil.AddGlobalVariable('startticketno', startticketno);
        AcRptEngineTotalDeatil.AddGlobalVariable('endticketno', endticketno);
        AcRptEngineTotalDeatil.AddGlobalVariable('startmoneydate', FormatDateTime('yyyy-mm-dd',startmoneydate));
        AcRptEngineTotalDeatil.AddGlobalVariable('endmoneydate', FormatDateTime('yyyy-mm-dd',endmoneydate));
        AcRptEngineTotalDeatil.AddGlobalVariable('lastlost', lastlost);
        AcRptEngineTotalDeatil.AddGlobalVariable('lost', lost);
        AcRptEngineTotalDeatil.AddGlobalVariable('billnouse', billnouse);
        AcRptEngineTotalDeatil.AddGlobalVariable('moneydate', moneydate);
        AcRptEngineTotalDeatil.AddGlobalVariable('cashmoneypayable', (moneypayable-nonvouchermoneypayable));
        AcRptEngineTotalDeatil.AddGlobalVariable('changenum',IntToStr(changenum));

//        AcRptEngineTotalDeatil.ShowDesigner;  //����ģʽ
        AcRptEngineTotalDeatil.Preview;     //Ԥ��ģʽ

    end;

  end
  else
  begin
    Delete(turnoverid, Length(turnoverid), 1);
    if Trim(turnoverid) <> '' then
    begin
      with jcdsResultMoney do
      begin
        Active := False;
          Params.ParamValues['filter_INS_t!id'] := '('+turnoverid+')';
        Active := True;
        money := FieldByName('turnovermoney').AsCurrency;
      end;
    end;
    templtename := TNovaPrint.GetTicketModelName('Ӫ�սɿ�', 'Ӫ�սɿ�');
    if not Assigned(billPrint) then
      billPrint := TNovaPrint.Create(self, templtename);
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
    printValue.Clear;
    printValue.Add('preprice', CurrToStr(preprice));
    printValue.Add('precount', IntToStr(precount));
    printValue.Add('bookservicefee', CurrToStr(bookservicefee));
    printValue.Add('cancelnum', IntToStr(cancelnum));
    printValue.Add('changeservicefee', currtostr(changeservicefee));
    printValue.Add('changenum',IntToStr(changenum));
    printValue.Add('eticketnum', IntToStr(eticketnum));
    printValue.Add('moneypayable', currtostr(moneypayable));
    printValue.Add('noncashmoney', currtostr(noncashmoney));
    printValue.Add('noncashnum', IntToStr(noncashnum));
    printValue.Add('nonvouchermoneypayable', currtostr(nonvouchermoneypayable));
    printValue.Add('orgname', orgname);
    printValue.Add('printtime', FormatDateTime('yyyy-mm-dd', now()));
    printValue.Add('receivername', receivername);
    printValue.Add('remarks', remarks);
    printValue.Add('returnhandcharge', currtostr(returnhandcharge));
    printValue.Add('returnmoney', currtostr(returnmoney));
    printValue.Add('returnnum', IntToStr(returnnum));
    printValue.Add('sellercode', sellercode);
    printValue.Add('sellername', sellername);
    printValue.Add('sellmoney', currtostr(sellmoney));
    printValue.Add('sellnum', IntToStr(sellnum));
    printValue.Add('servicefee', currtostr(servicefee));
    printValue.Add('turnovertime', turnovertime);
    printValue.Add('money', currtostr(money));
    printValue.Add('cancelmoney', currtostr(cancelmoney));
    printValue.Add('sellreturntripnum', IntToStr(sellreturntripnum));
    printValue.Add('returnprintnum', IntToStr(returnprintnum));
    printValue.Add('billdamagednum', IntToStr(billdamagednum));
    printValue.Add('startticketno', startticketno);
    printValue.Add('endticketno', endticketno);
    printValue.Add('startmoneydate', FormatDateTime('yyyy-mm-dd',startmoneydate));
    printValue.Add('endmoneydate', FormatDateTime('yyyy-mm-dd',endmoneydate));
    printValue.Add('lastlost', lastlost);
    printValue.Add('lost', lost);
    printValue.Add('billnouse', billnouse);
    printValue.Add('moneydate', moneydate);
    printValue.Add('cashmoneypayable', CurrToStr(moneypayable-nonvouchermoneypayable));
    nostationfeemoney:=moneypayable-strtocurr(stationservicefee);
    printValue.Add('nostationfeemoney', CurrToStr(nostationfeemoney));
    printValue.Add('insurecancelmoney', CurrToStr(insurecancelmoney));
    printValue.Add('insurecancelnum', IntToStr(insurecancelnum));
    printValue.Add('insurereturnmoney', CurrToStr(insurereturnmoney));
    printValue.Add('insurereturnnum', IntToStr(insurereturnnum));
    printValue.Add('insuresellmoney', CurrToStr(insuresellmoney));
    printValue.Add('insuresellnum', IntToStr(insuresellnum));
    printValue.Add('insuremoneypayable', CurrToStr(insuremoneypayable));
    printValue.Add('ticketoutletsname', Sysinfo.LoginUserInfo.ticketoutletsname);
    printValue.Add('stationservicefee', stationservicefee);
    printValue.Add('fueladditionfee',fueladditionfee);
    printValue.Add('computefee',computefee);
    printValue.Add('coolairfee',coolairfee);
    printValue.Add('additionfee',additionfee);
    printValue.Add('waterfee', waterfee);
    printValue.Add('insurefee',insurefee);
    printValue.Add('otherfee', otherfee);
    //������ƱƱ�ۣ���Ʊ�����Ʊ�����ѣ�
    printValue.Add('returnprice',CurrToStr(returnmoney+returnhandcharge));
    billPrint.SingleValue := printValue;
    billPrint.Print;

  end;
end;

end.
