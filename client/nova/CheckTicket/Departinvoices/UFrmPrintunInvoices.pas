unit UFrmPrintunInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp,NovaPrint, Generics.Collections, UDMPublic;

type
  TFrmPrintunInvoices = class(TSimpleCRUDForm)
    Label2: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    nvhlpcode: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    jcdsResultSave: TjsonClientDataSet;
    jcdsQryDetail: TjsonClientDataSet;
    jcdsOthersells: TjsonClientDataSet;
    jscdQryDeductfees: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvhlpcodeChange(Sender: TObject);
    procedure nvhlpcodeIdChange(Sender: TObject);
  private
   { Private declarations }
    log,templtename: String;
    billPrint: TNovaPrint;
    selidx:integer;
    notprintValue: TList<string>; // 不打印项目
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集

  public
    { Public declarations }
  end;

var
  FrmPrintunInvoices: TFrmPrintunInvoices;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmPrintunInvoices.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime:=now;
  nvhlpschedule.SetFocus;
end;


procedure TFrmPrintunInvoices.nvhlpcodeChange(Sender: TObject);
begin
  inherited;
  if (nvhlpcode.Id > 0) then
  begin
    tbtnFilterClick(sender);
  end;
end;

procedure TFrmPrintunInvoices.nvhlpcodeIdChange(Sender: TObject);
begin
  inherited;

  if (nvhlpcode.Id > 0) and (nvhlpschedule.Id> 0) then
  begin
    tbtnFilterClick(sender);
  end;
end;

procedure TFrmPrintunInvoices.tbtnFilterClick(Sender: TObject);
begin
  inherited;

  if (nvhlpschedule.Text = '') or (nvhlpschedule.Id = 0) then
  begin
    SysDialogs.Warning('请输入要打印的班次！');
    exit;
  end;
  if (nvhlpcode.Text = '') or (nvhlpcode.Id = 0) then
  begin
    SysDialogs.Warning('请输入要打印的营运车辆！');
    exit;
  end;
   selidx:=0;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['departdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.DateTime);
    Params.ParamValues['vehicleid'] :=nvhlpcode.id;
    Params.ParamValues['scheduleid'] :=nvhlpschedule.Id ;
    Active := True;
    nvhlpschedule.SetFocus;
  end;
end;

procedure TFrmPrintunInvoices.tbtnInsertClick(Sender: TObject);
var
  nResult: LongWord;
  sResult,idxs,endstation: string;
  multipleValueValue: TDictionary<String, String>;
  totalpeople, psdistance,tickets: Integer;
  fulls, halfs, students, discounts, totalpsdistance: Integer;
  totalfee, noagentbalanceprice: double;
  scheduleplanid,reportvehicleid,departinvoicesid:int64;
  routename,code,departdate,departtime,departstation:string;
begin
  inherited;
  if not jcdsResult.Active then exit;
  if jcdsResult.RecordCount=0 then exit;
   tickets:=0;
  with jcdsResult do
  begin
     first;
     while(not eof)do
     begin
       if fieldbyname('isselect').AsBoolean then
       begin
          idxs:=idxs+fieldbyname('id').AsString+',';
          scheduleplanid:=fieldbyname('scheduleplanid').AsLargeInt;
          reportvehicleid:=fieldbyname('reportid').AsLargeInt;
          routename:=fieldbyname('routename').AsString;
          departdate:=fieldbyname('departdate').AsString;
          code:=fieldbyname('code').AsString;
          departtime:=fieldbyname('departtime').AsString;
          tickets:=tickets+1;
       end;
       next;
     end;
  end;
  if idxs='' then
  begin
    SysDialogs.Warning('请选择要打印的车票！');
    exit;
  end
  else
  begin
    idxs:=copy(idxs,0,length(idxs)-1);
  end;
  departstation:=SysInfo.LoginUserInfo.OrgName;
  if not checkBillno('BalanceBill') then
    exit;

 if not SysDialogs.Confirm('信息提示', '当前选中票数：'+inttostr(tickets)+' 张，确认要补打吗？') then
    exit;

  with jcdsResultSave do
  begin
    Active := False;
    Params.ParamValues['ticketids'] := idxs;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    //Params.ParamValues['ip'] := SysInfo.LocalHostAddress;
    Params.ParamValues['departinvoicesno'] :=
      SysInfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    Params.ParamValues['vehiclereportid'] := reportvehicleid;

    Active := True;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;

    if nResult = 1 then
    begin
      templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
      if not Assigned(billPrint) then
        billPrint := TNovaPrint.Create(self, templtename);
      if RecordCount > 0 then
      begin
        while not Eof do
        begin
          if not Assigned(printValue) then
            printValue := TDictionary<String, String>.Create
          else
            printValue.Clear;
          printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
          printValue.Add('seats', FieldByName('seatnum').AsString);
          printValue.Add('brandmodel', FieldByName('brandname').AsString);
          printValue.Add('vehicletype', FieldByName('vehicletype').AsString);
          printValue.Add('route', routename);
          printValue.Add('routedistance', FieldByName('distance').AsString);
          printValue.Add('schedulecode', code);
          printValue.Add('departdate', departdate);
          printValue.Add('departtime', departtime);
          printValue.Add('departstation', departstation);
          printValue.Add('checkedname', FieldByName('checkedname').AsString);
          printValue.Add('endstation', endstation);
          printValue.Add('freetickets', FieldByName('freetickets').AsString);
          printValue.Add('armtickets', FieldByName('armtickets').AsString);

          departinvoicesid := FieldByName('id').AsLargeInt;
          printValue.Add('invoicesno', FieldByName('invoicesno').AsString);
          printValue.Add('unit', FieldByName('unit').AsString);
          printValue.Add('ticketnum', FieldByName('ticketnum').AsString);
          printValue.Add('driver1', FieldByName('driver1').AsString);
          printValue.Add('driver2', FieldByName('driver2').AsString);
          printValue.Add('driver3', FieldByName('driver3').AsString);
          printValue.Add('driver4', FieldByName('driver4').AsString);
          printValue.Add('steward', FieldByName('steward').AsString);
          printValue.Add('remarks', FieldByName('remarks').AsString);
          printValue.Add('ticketoutlet', FieldByName('ticketoutname').AsString);
          printValue.Add('ticketoutletshort',
            FieldByName('ticketoutshort').AsString);
          printValue.Add('balanceunit', FieldByName('balanceunit').AsString);
          printValue.Add('unitfullname', FieldByName('fullname').AsString);
          // 扣费明细改为由数据集返回
          with jscdQryDeductfees do
          begin
            Active := False;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Active := True;
            if RecordCount > 0 then
            begin
              first;
              while (not Eof) do
              begin
                printValue.Add(FieldByName('code').AsString,
                  FieldByName('deductmoney').AsString);
                next;
              end;
            end;
          end;
          // 扣费明细改为由数据集返回
          printValue.Add('stationfee', FieldByName('stationfee').AsString);

          totalfee := FieldByName('totalamount').AsFloat - FieldByName
            ('agentfee').AsFloat - FieldByName('balanceamount').AsFloat;
          noagentbalanceprice := FieldByName('agentfee').AsFloat + FieldByName
            ('balanceamount').AsFloat;
          printValue.Add('noagentbalanceprice',
            floattostr(noagentbalanceprice));
          printValue.Add('totalfee', floattostr(totalfee));
          printValue.Add('reprint', '补开');
          printValue.Add('agentfee', FieldByName('agentfee').AsString);
          printValue.Add('fueladditionfee',
            FieldByName('fueladditionfee').AsString);

          printValue.Add('otherfee', FieldByName('otherfee').AsString);
          printValue.Add('totalamount', FieldByName('totalamount').AsString);
          printValue.Add('balanceamount',
            FieldByName('balanceamount').AsString);
          if FieldByName('isovertime').AsBoolean then
            printValue.Add('isovertime', '加班')
          else
            printValue.Add('isovertime', '');
          printValue.Add('printby', SysInfo.LoginUserInfo.UserName);
          printValue.Add('printstation', SysInfo.LoginUserInfo.OrgName);
          printValue.Add('printertime',
            FormatDateTime('yyyy-mm-dd hh:mm', now));

          if not Assigned(multiplelist) then
            multiplelist := TList < TDictionary < String, String >> .Create
          else
            multiplelist.Clear;
          with jcdsQryDetail do
          begin
            Active := False;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Active := True;
            if RecordCount > 0 then
            begin
              first;

              while (not Eof) do
              begin
                multipleValueValue := TDictionary<String, String>.Create;
                multipleValueValue.Add('fromstation',
                  FieldByName('fromstation').AsString);
                multipleValueValue.Add('reachstation',
                  FieldByName('reachstation').AsString);
                multipleValueValue.Add('fullpeople',
                  FieldByName('fullpeople').AsString);
                multipleValueValue.Add('price', FieldByName('price').AsString);
                multipleValueValue.Add('halfpeople',
                  FieldByName('halfpeople').AsString);
                multipleValueValue.Add('studentpeople', '0');
                multipleValueValue.Add('discountpeople',
                  FieldByName('discountpeople').AsString);
                multipleValueValue.Add('distance',
                  FieldByName('distance').AsString);
                totalpeople := FieldByName('fullpeople').AsInteger + FieldByName
                  ('halfpeople').AsInteger;
                psdistance := FieldByName('distance').AsInteger * totalpeople;
                multipleValueValue.Add('psdistance', inttostr(psdistance));
                multipleValueValue.Add('totalamount',
                  FieldByName('totalamount').AsString);
                multipleValueValue.Add('balanceprice',
                  FieldByName('balanceprice').AsString);
                multiplelist.Add(multipleValueValue);
                multipleValueValue.Add('balanceamount',
                  FieldByName('balanceamount').AsString);
                multipleValueValue.Add('noagentbalanceamount',
                  FieldByName('noagentbalanceamount').AsString);
                fulls := fulls + FieldByName('fullpeople').AsInteger;
                halfs := halfs + FieldByName('halfpeople').AsInteger;
                students := 0;
                discounts := 0;
                totalpsdistance := totalpsdistance + psdistance;
                next;
              end;
            end;
          end;
          // 根据运量ID 发车日期获取他站售票情况
          with jcdsOthersells do
          begin
            Active := False;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Params.ParamValues['departdate'] := departdate;
            execute;
            printValue.Add('othersell', Params.ParamByName('othersells').Value);
          end;
          printValue.Add('fulls', inttostr(fulls));
          printValue.Add('halfs', inttostr(halfs));
          printValue.Add('students', inttostr(students));
          printValue.Add('discounts', inttostr(discounts));
          printValue.Add('totalpsdistance', inttostr(totalpsdistance));

          billPrint.SingleValue := printValue;
          billPrint.MultipleValue := multiplelist;

          billPrint.Print;
          with SysInfo.LoginUserInfo do
          begin
            curBillNo.AddOrSetValue('BalanceBill',
              zerofill(inttostr(strtoint64(curBillNo.Items['BalanceBill'])
                    + 1), length(curBillNo.Items['BalanceBill'])));
            curBillNum.AddOrSetValue('BalanceBill',
              curBillNum.Items['BalanceBill'] - 1);
          end;
          //refreshBill;
          next;
        end;
      end;
      SysDialogs.ShowMessage('补开成功！');
      tbtnFilterClick(sender);
    end
    else
    begin
      SysDialogs.ShowMessage(sResult);
    end;
  end;

end;

end.
