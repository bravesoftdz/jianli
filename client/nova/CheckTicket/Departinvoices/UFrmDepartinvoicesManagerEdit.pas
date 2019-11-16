unit UFrmDepartinvoicesManagerEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList, Generics.Collections, NovaPrint, NovaHelp;

type
  TFrmDepartinvoicesManagerEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    edtschedule: TNovaEdit;
    edtvehicletype: TNovaEdit;
    edtstartstation: TNovaEdit;
    edtendstation: TNovaEdit;
    edtstartdate: TNovaEdit;
    edtstarttime: TNovaEdit;
    edtseatnum: TNovaEdit;
    edtsoldeatnum: TNovaEdit;
    edtyeschecked: TNovaEdit;
    edtnochecked: TNovaEdit;
    edtbuspart: TNovaEdit;
    edtticketentrance: TNovaEdit;
    lbl11: TLabel;
    lbl12: TLabel;
    jcdsQryDetail: TjsonClientDataSet;
    dsResult: TDataSource;
    jcdsResult1: TjsonClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    edtunit: TNovaEdit;
    edtplanvehicle: TNovaEdit;
    jcdsOthersells: TjsonClientDataSet;
    jcdsResultSave: TjsonClientDataSet;
    jscdQryDeductfees: TjsonClientDataSet;
    nvhlpseller: TNovaHelp;
    Label3: TLabel;
    jcdssaveseller: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    log: String;
    billPrint: TNovaPrint;
    notprintValue: TList<string>; // 不打印项目
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
    procedure refreshBill; // 刷新票号
    { Private declarations }
  public
    { Public declarations }
    sign: Boolean;
    scheduleplanid, reportvehicleid, isdepartinvoices,
      templtename: string;
    vehicleno, brandname, typename, routename, balanceunitname, checkedname,
      departtime, departstation, endstation, code, unitname, d1name, d2name, d3name,
      d4name, s1name, seatnum, distance, departdate: string;
    vehicleid, newdepartinvoicesid,departinvoicesid: Int64;
  end;

var
  FrmDepartinvoicesManagerEdit: TFrmDepartinvoicesManagerEdit;

implementation

uses Services, PubFn, UFrmDepartinvoicesManager;
{$R *.dfm}

procedure TFrmDepartinvoicesManagerEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: LongWord;
  sResult: string;
  multipleValueValue: TDictionary<String, String>;
  totalpeople, psdistance: Integer;
  fulls, halfs, students, discounts, totalpsdistance: Integer;
  totalfee, noagentbalanceprice,nostationbalanceprice,nostationtotalbalanceprice: double;
begin
  inherited;
  if (edtnochecked.Text = '') or (StrToInt(edtnochecked.Text) = 0) then
  begin
    SysDialogs.ShowMessage('没有未开运量单的人数，不用进行补开！');
    Exit;
  end;
  if not checkBillno('BalanceBill') then
    Exit;
  with jcdsResultSave do
  begin
    Active := false;
    Params.ParamValues['departstationid'] := SysInfo.LoginUserInfo.StationID;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    Params.ParamValues['ip'] := SysInfo.LocalHostAddress;
    Params.ParamValues['departinvoicesno'] :=
      SysInfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    Params.ParamValues['vehiclereportid'] := reportvehicleid;

    Active := true;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;

    if nResult = 1 then
    begin
      templtename := TNovaPrint.GetTicketModelName('结算单', '默认结算单');
      if not Assigned(billPrint) then
        billPrint := TNovaPrint.Create(self, templtename);
      if RecordCount > 0 then
      begin
        with jcdssaveseller do
        begin
          Active := false;
          Params.ParamValues['departinvoicesid'] := jcdsResultSave.FieldByName('id').AsLargeInt;
          Params.ParamByName('sellerid').Value := nvhlpseller.Id;
            Execute;
        end;
        while not Eof do
        begin
          if not Assigned(printValue) then
            printValue := TDictionary<String, String>.Create
          else
            printValue.Clear;
          printValue.Add('reopen','补开');
          printValue.Add('seller', nvhlpseller.Text);
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
          printValue.Add('ticketoutletshort', FieldByName('ticketoutshort').AsString);
          printValue.Add('balanceunit', FieldByName('balanceunit').AsString);
          printValue.Add('unitfullname', FieldByName('fullname').AsString);
          printValue.Add('balanceunitfullname', FieldByName('balanceunitfullname').AsString);   //20160422 结算单位全称
          // 扣费明细改为由数据集返回
          with jscdQryDeductfees do
          begin
            Active := false;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Active := true;
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

          //新增不算站务费的结算金额
            nostationbalanceprice:= (FieldByName('totalamount').AsFloat -
            FieldByName('stationfee').AsFloat)/(FieldByName('ticketnum').AsInteger);
            nostationtotalbalanceprice:= (FieldByName('totalamount').AsFloat -
            FieldByName('stationfee').AsFloat);

            //end
           printValue.Add('nostationbalanceprice',FloatToStr(nostationbalanceprice));//新增数据源不含站务费的结算金额
           printValue.Add('nostationtotalbalanceprice',FloatToStr(nostationtotalbalanceprice));//新增数据源不含站务费的结算总金额

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
            formatdatetime('yyyy-mm-dd hh:mm', now));

          if not Assigned(multiplelist) then
            multiplelist := TList < TDictionary < String, String >> .Create
          else
            multiplelist.Clear;
          with jcdsQryDetail do
          begin
            Active := false;
            Params.ParamValues['departinvoicesid'] := departinvoicesid;
            Active := true;
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
                multipleValueValue.Add('noservicestationfee',
                    FieldByName('noservicestationfee').AsString);
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
            Active := false;
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
          refreshBill;
          next;
        end;
      end;
      log := '补开结算单：发车日期=' + edtstartdate.Text + ',始发站=' +
        edtstartstation.Text + ',终点站=' + edtendstation.Text + ',车属单位=' +
        edtunit.Text + ',报到车辆=' + edtplanvehicle.Text + ',班次=' +
        edtschedule.Text + ',发车时间=' + edtstarttime.Text + ',总座位数=' +
        edtseatnum.Text + ',售出=' + edtsoldeatnum.Text + ',检票口=' +
        edtbuspart.Text + ',上车卡位=' + edtticketentrance.Text + ',已开运量人数=' +
        edtyeschecked.Text + ',补开运量人数=' + edtnochecked.Text;
      SysLog.WriteLog('检票管理——>结算单', '补开结算单', log);
      SysDialogs.ShowMessage('补开成功！');
      ModalResult := mrOk;
    end
    else
    begin
      SysDialogs.ShowMessage(sResult);
    end;
  end;
end;

procedure TFrmDepartinvoicesManagerEdit.refreshBill;
begin
  if SysInfo.LoginUserInfo.curBillNo.ContainsKey('BalanceBill')
    and SysInfo.LoginUserInfo.curBillNum.ContainsKey('BalanceBill') and
    (SysInfo.LoginUserInfo.curBillNum.Items['BalanceBill'] > 0) then
  begin
    // lblBillno.Caption := Sysinfo.LoginUserInfo.curBillNo.Items['BalanceBill'];
    // lblBillnum.Caption := inttostr(Sysinfo.LoginUserInfo.curBillNum.Items
    // ['BalanceBill']);
    // ToolButton53.Enabled := true;
    // tbtnPrinter.Enabled := true;
  end
  else
  begin
    // lblBillno.Caption := '';
    // lblBillnum.Caption := '0';
    // ToolButton53.Enabled := false;
    // tbtnPrinter.Enabled := false;
    SysDialogs.Warning('请重置结算单号！');
    // self.Close;
  end;
end;

procedure TFrmDepartinvoicesManagerEdit.FormShow(Sender: TObject);
begin
  inherited;
  SysInfo.curBillLength.Items['Ticket'];
  with jcdsResult1 do
  begin
    Active := false;
    Params.ParamValues['scheduleplanid'] := scheduleplanid;
    Params.ParamValues['isdepartinvoices'] := isdepartinvoices;
    Params.ParamValues['departinvoicesid'] := departinvoicesid;
    Params.ParamValues['vehiclereportid'] := reportvehicleid;

    Active := true;
  end;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount > 0 then
  begin

    balanceunitname := jcdsResult1.FieldByName('balanceunitname').AsString;
    vehicleno := jcdsResult1.FieldByName('vehicleno').AsString;
    seatnum := jcdsResult1.FieldByName('seatnum').AsString;
    brandname := jcdsResult1.FieldByName('brandname').AsString;
    typename := jcdsResult1.FieldByName('typename').AsString;
    routename := jcdsResult1.FieldByName('routename').AsString;
    distance := jcdsResult1.FieldByName('distance').AsString;
    code := jcdsResult1.FieldByName('code').AsString;
    departdate := jcdsResult1.FieldByName('departdate').AsString;
    // departtime := jcdsResult1.FieldByName('starttime').AsString;
    departstation := jcdsResult1.FieldByName('startname').AsString;
    endstation := jcdsResult1.FieldByName('endname').AsString;
    unitname := jcdsResult1.FieldByName('unitname').AsString;
    d1name := jcdsResult1.FieldByName('d1name').AsString;
    d2name := jcdsResult1.FieldByName('d2name').AsString;
    d3name := jcdsResult1.FieldByName('d3name').AsString;
    d4name := jcdsResult1.FieldByName('d4name').AsString;
    s1name := jcdsResult1.FieldByName('s1name').AsString;
    checkedname := jcdsResult1.FieldByName('checkedname').AsString;

    edtunit.Text := unitname;
    edtplanvehicle.Text := vehicleno;
    edtschedule.Text := code;
    edtvehicletype.Text := typename;
    edtstartstation.Text := departstation;
    edtendstation.Text := endstation;
    edtstartdate.Text := departdate;
    edtseatnum.Text := seatnum;
    // edtstarttime.Text := jcdsResult1.FieldByName('starttime').AsString;
    edtsoldeatnum.Text := jcdsResult1.FieldByName('soldeatnum').AsString;
    edtyeschecked.Text := jcdsResult1.FieldByName('yeschecked').AsString;
    edtnochecked.Text := jcdsResult1.FieldByName('nochecked').AsString;
    edtbuspart.Text := jcdsResult1.FieldByName('buspark').AsString;
    edtticketentrance.Text := jcdsResult1.FieldByName('ticketentrance')
      .AsString;

  end;
end;

end.
