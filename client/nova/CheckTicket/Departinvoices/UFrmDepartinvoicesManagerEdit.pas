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
    notprintValue: TList<string>; // ����ӡ��Ŀ
    printValue: TDictionary<String, String>; // ���������
    multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
    procedure refreshBill; // ˢ��Ʊ��
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
    SysDialogs.ShowMessage('û��δ�������������������ý��в�����');
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
      templtename := TNovaPrint.GetTicketModelName('���㵥', 'Ĭ�Ͻ��㵥');
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
          printValue.Add('reopen','����');
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
          printValue.Add('balanceunitfullname', FieldByName('balanceunitfullname').AsString);   //20160422 ���㵥λȫ��
          // �۷���ϸ��Ϊ�����ݼ�����
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
          // �۷���ϸ��Ϊ�����ݼ�����
          printValue.Add('stationfee', FieldByName('stationfee').AsString);

          totalfee := FieldByName('totalamount').AsFloat - FieldByName
            ('agentfee').AsFloat - FieldByName('balanceamount').AsFloat;
          noagentbalanceprice := FieldByName('agentfee').AsFloat + FieldByName
            ('balanceamount').AsFloat;

          //��������վ��ѵĽ�����
            nostationbalanceprice:= (FieldByName('totalamount').AsFloat -
            FieldByName('stationfee').AsFloat)/(FieldByName('ticketnum').AsInteger);
            nostationtotalbalanceprice:= (FieldByName('totalamount').AsFloat -
            FieldByName('stationfee').AsFloat);

            //end
           printValue.Add('nostationbalanceprice',FloatToStr(nostationbalanceprice));//��������Դ����վ��ѵĽ�����
           printValue.Add('nostationtotalbalanceprice',FloatToStr(nostationtotalbalanceprice));//��������Դ����վ��ѵĽ����ܽ��

          printValue.Add('noagentbalanceprice',
            floattostr(noagentbalanceprice));
          printValue.Add('totalfee', floattostr(totalfee));
          printValue.Add('reprint', '����');
          printValue.Add('agentfee', FieldByName('agentfee').AsString);
          printValue.Add('fueladditionfee',
            FieldByName('fueladditionfee').AsString);

          printValue.Add('otherfee', FieldByName('otherfee').AsString);
          printValue.Add('totalamount', FieldByName('totalamount').AsString);
          printValue.Add('balanceamount',
            FieldByName('balanceamount').AsString);
          if FieldByName('isovertime').AsBoolean then
            printValue.Add('isovertime', '�Ӱ�')
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
          // ��������ID �������ڻ�ȡ��վ��Ʊ���
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
      log := '�������㵥����������=' + edtstartdate.Text + ',ʼ��վ=' +
        edtstartstation.Text + ',�յ�վ=' + edtendstation.Text + ',������λ=' +
        edtunit.Text + ',��������=' + edtplanvehicle.Text + ',���=' +
        edtschedule.Text + ',����ʱ��=' + edtstarttime.Text + ',����λ��=' +
        edtseatnum.Text + ',�۳�=' + edtsoldeatnum.Text + ',��Ʊ��=' +
        edtbuspart.Text + ',�ϳ���λ=' + edtticketentrance.Text + ',�ѿ���������=' +
        edtyeschecked.Text + ',������������=' + edtnochecked.Text;
      SysLog.WriteLog('��Ʊ������>���㵥', '�������㵥', log);
      SysDialogs.ShowMessage('�����ɹ���');
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
    SysDialogs.Warning('�����ý��㵥�ţ�');
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
