unit Ufrmbookticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,DateUtils,
  Dialogs, DBCtrls, ComCtrls, StdCtrls, NovaEdit, Mask, NovaComboBox, DB,Math,
  DBClient, jsonClientDataSet, DBCtrlsEh, ExtCtrls,SellWayEnd,Generics.Collections,
  Buttons,Ufrmsellwayend,services,UDMPublic,PubFn;

type
  Tfrmbookticketend = class(Tfrmsellwayend)
    dsEducation: TDataSource;
    jsoncdsEducation: TjsonClientDataSet;
    jsoncdsCustom: TjsonClientDataSet;
    gbadvanced: TGroupBox;
    lbl6: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl5: TLabel;
    lbl10: TLabel;
    dbedtMOBILEPHONE: TDBEdit;
    dbedtFamilyPhone: TDBEdit;
    dbedtAdress: TDBEdit;
    dbmmoRemark: TDBMemo;
    dblkcbbEDUCATION: TDBLookupComboBox;
    Label1: TLabel;
    dbedtNAME: TDBEdit;
    Label2: TLabel;
    dbedtCERTIFICATENO: TDBEdit;
    Label3: TLabel;
    dblkcbbCERTIFICATETYPE: TDBLookupComboBox;
    lbl7: TLabel;
    lbl4: TLabel;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    dbehdtedtbirthday: TDBDateTimeEditEh;
    dsCERTIFICATETYPE: TDataSource;
    jsoncdsCERTIFICATETYPE: TjsonClientDataSet;
    dscustom: TDataSource;
    bvl1: TBevel;
    lblpassword: TLabel;
    nvedtpassword: TNovaEdit;
    chkautocancel: TCheckBox;
    dtpautocanceldate: TDateTimePicker;
    jsoncdsseatreserve: TjsonClientDataSet;
    jsoncdsquerycustomer: TjsonClientDataSet;
    pnlservicefee: TPanel;
    lblservicefee_: TLabel;
    lblservicefee: TLabel;
    nvedtservicefee: TNovaEdit;
    lblserviceprice: TLabel;
    lblpropotion: TLabel;
    dtpautocanceltime: TDateTimePicker;
    jcdsquerybookunsellcount: TjsonClientDataSet;
    jcdsVipBooktime: TjsonClientDataSet;
    procedure dscustomDataChange(Sender: TObject; Field: TField);
    procedure chkautocancelClick(Sender: TObject);
  private
    { Private declarations }
    vipbooktime:integer;
    ispropotion:boolean; //������Ƿ񰴱�����ȡ
    defaultserviceprice:Currency;  //Ĭ�Ϸ����
    autoCancelHours:double;//�Զ�ȡ����λСʱ��
    autoCancelHoursBeforeDepart_in:Double; //20111128 ��λ��Сʱ��Ϊ����
    autoCancelHoursBeforeDepart_out:Double; //20111128 ��λ��Сʱ��Ϊ����
    nosellcounthint:Integer; //1306 ����N�ζ�Ʊ��ȡƱ���ٶ�ʱ��ʾ��ƱԱ�Ƿ�����Ʊ
    function saveCustomer():Int64;
    procedure setsexinputenable(isIDCard:boolean);
    function getLastautocanceldate():TDateTime;
    function getdeparttime():TDateTime;
    function getAutoCancelTime():TDateTime;
    function getcustomnosellcount(customid:Int64): Integer; //���˿Ͳ�ѯ��Ʊδȡ����
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    function getfullThroughControl():TList<TWinControl>;override;
    function getdefaultThroughControl():TList<TWinControl>;override;
    function getSellWayreceivablenum:Currency;override;
    function show():boolean;override;
    function execute(cdsticketbuffer:TjsonClientDataSet):boolean;override;
    function reset():boolean;override;
    function checkreceipt(needpay:Currency):boolean;override;
    function getContextHint(winControl: TWinControl):String;override;
    function getServicefee(cdsticketbuffer:TjsonClientDataSet):Currency;override;
  end;

implementation

const defaultcustomername='�ÿ�';

{$R *.dfm}

{ Tfrmbookticketend }

function Tfrmbookticketend.checkreceipt(needpay: Currency): boolean;
begin
  result:=true;
end;

procedure Tfrmbookticketend.chkautocancelClick(Sender: TObject);
begin
  inherited;
  dtpautocanceldate.Enabled:=(Sender as TCheckBox).Checked;
  dtpautocanceltime.Enabled:=(Sender as TCheckBox).Checked;
  if (Sender as TCheckBox).Checked then
  begin
    dtpautocanceldate.DateTime:=getLastautocanceldate();
    dtpautocanceltime.DateTime:=getLastautocanceldate();
    if (assigned(defaultThroughControl)) then
    begin
      if not defaultThroughControl.Contains(dtpautocanceldate) then
      begin
        defaultThroughControl.Add(dtpautocanceldate);
      end;
      if not defaultThroughControl.Contains(dtpautocanceltime) then
      begin
        defaultThroughControl.Add(dtpautocanceltime);
      end;
    end
    else
    begin
      if defaultThroughControl.Contains(dtpautocanceldate) then
      begin
        defaultThroughControl.Remove(dtpautocanceldate);
      end;
      if defaultThroughControl.Contains(dtpautocanceltime) then
      begin
        defaultThroughControl.Remove(dtpautocanceltime);
      end;
    end;
  end;
end;

constructor Tfrmbookticketend.Create(AOwner: TComponent);
begin
  inherited;
  jsoncdsCERTIFICATETYPE.Active:=true;
  jsoncdsEducation.Active:=true;
  ispropotion:=getParametervalue('1301',sysinfo.LoginUserInfo.OrgID)='1';
  autoCancelHours:=StrToFloatDef(getParametervalue('1303',sysinfo.LoginUserInfo.OrgID),24);
  autoCancelHoursBeforeDepart_in:=StrToFloatDef(getParametervalue('1304',sysinfo.LoginUserInfo.OrgID),6);
  autoCancelHoursBeforeDepart_out:=StrToFloatDef(getParametervalue('1305',sysinfo.LoginUserInfo.OrgID),6);
  lblpropotion.Visible:=ispropotion;
  defaultserviceprice:=StrToCurrDef(getParametervalue('1302',sysinfo.LoginUserInfo.OrgID),0);
  nvedtservicefee.Text:=currtostr(defaultserviceprice);
  nosellcounthint:=StrToIntDef(getParametervalue('1306',sysinfo.LoginUserInfo.OrgID),0);
end;

procedure Tfrmbookticketend.dscustomDataChange(Sender: TObject; Field: TField);
var exist:boolean;
    oldOnDataChange:TDataChangeEvent;
    vipgardename : string;
begin
  inherited;
  exist:=false;
  if (Field=nil) then exit;
  if (Field.FieldName='certificatetype') or (Field.FieldName='certificateno') then
  begin
    if (not Field.DataSet.FieldByName('certificatetype').IsNull)
      and (not Field.DataSet.FieldByName('certificateno').IsNull) then
    begin
      with jsoncdsquerycustomer do
      begin
        Active:=false;
        Params.ParamValues['filter_EQS_c!certificatetype']:=Field.DataSet.FieldValues['certificatetype'];
        Params.ParamValues['filter_EQS_c!certificateno']:=Field.DataSet.FieldValues['certificateno'];
        active:=true;
        if RecordCount=1 then
        begin
          exist:=true;
          oldOnDataChange:=(sender as TDataSource).OnDataChange;
          (sender as TDataSource).OnDataChange:=nil;
          Field.DataSet.edit;
          Field.DataSet.FieldValues['id']:=FieldValues['id'];
          Field.DataSet.FieldValues['education']:=FieldValues['education'];
          Field.DataSet.FieldValues['familyaddress']:=FieldValues['familyaddress'];
          Field.DataSet.FieldValues['familyphone']:=FieldValues['familyphone'];
          Field.DataSet.FieldValues['mobilephone']:=FieldValues['mobilephone'];
          Field.DataSet.FieldValues['name']:=FieldValues['name'];
          Field.DataSet.FieldValues['remarks']:=FieldValues['remarks'];
          Field.DataSet.post;
          vipgardename := FieldByName('vipgradename').AsString;  
          (sender as TDataSource).OnDataChange:=oldOnDataChange;
        end;
      end;
      if (not exist) and (not Field.DataSet.FieldByName('id').IsNull) and (Field.DataSet.FieldByName('id').AsLargeInt>0) then
      begin
        oldOnDataChange:=(sender as TDataSource).OnDataChange;
        (sender as TDataSource).OnDataChange:=nil;
        Field.DataSet.edit;
        Field.DataSet.FieldValues['id']:=0;
        Field.DataSet.FieldValues['education']:=null;
        Field.DataSet.FieldValues['familyaddress']:=null;
        Field.DataSet.FieldValues['familyphone']:=null;
        Field.DataSet.FieldValues['mobilephone']:=null;
        Field.DataSet.FieldValues['name']:=defaultcustomername;
        Field.DataSet.FieldValues['remarks']:=null;
        Field.DataSet.post;
        (sender as TDataSource).OnDataChange:=oldOnDataChange;
      end;
    end;
    dbedtNAME.Enabled:=not exist;
    dbehdtedtbirthday.Enabled:=not exist;
    dblkcbbEDUCATION.Enabled:=not exist;
    dbedtFamilyPhone.Enabled:=not exist;
    dbedtMOBILEPHONE.Enabled:=not exist;
    dbedtAdress.Enabled:=not exist;
    dbmmoRemark.Enabled:=not exist;
    if vipgardename <>'' then //�ǻ�Ա
    begin
      jcdsVipBooktime.Active := false;
      jcdsVipBooktime.Params.ParamValues['filter_EQL_vb!orgid'] := SysInfo.LoginUserInfo.OrgID;
      jcdsVipBooktime.Params.ParamValues['filter_EQS_vb!vipgrade'] := vipgardename;
      jcdsVipBooktime.Active := true;
      if (jcdsVipBooktime.Active) and (jcdsVipBooktime.RecNo>0) then
      begin
         chkautocancel.Checked:=true;
         chkautocancelClick(chkautocancel);   
      end;            
    end;

    if (Field.FieldName='certificatetype') then
    begin
      setsexinputenable((not Field.DataSet.FieldByName('certificatetype').IsNull)
                        and (Field.DataSet.FieldValues['certificatetype']='0')
                        );
    end;
  end;
end;

function Tfrmbookticketend.execute(cdsticketbuffer:TjsonClientDataSet): boolean;
var
     customerid:int64;
    _bookunsellcount:integer;
begin
  result:=false;
  if chkautocancel.Checked then
  begin
    if getAutoCancelTime-now<=0 then
    begin
      SysDialogs.Warning('���ȡƱʱ�䲻�����ڵ�ǰʱ��');
      Exit;
    end
    else if getAutoCancelTime-getLastautocanceldate>0 then
    begin
      SysDialogs.Warning('���ȡƱʱ�䲻�ܳ���ϵͳ���õ���ٷ���ʱ��');
      Exit;
    end
    else if getAutoCancelTime-getdeparttime()>=2/24/60 then
    begin
      SysDialogs.Warning('���ȡƱʱ�䲻�ܳ��ڷ���ʱ��');
      Exit;
    end;
  end;

  //�ȱ��տͻ���Ϣ
  customerid:=saveCustomer;
  if customerid>0 then
  begin
    //�����û���Ʊδȡ��¼������ʾ��Ʊ������Ա�Ƿ�����Ʊ
    if (customerid<>1) and (nosellcounthint>0) then
    begin
      _bookunsellcount:=getcustomnosellcount(customerid);
      if (_bookunsellcount>=nosellcounthint)  then
        if not SysDialogs.Ask('����','�ó˿��Ѿ�'+inttostr(_bookunsellcount)+'�ζ�ƱδȡƱ��ȷ��Ҫ������Ʊ��') then
        begin
          FrmSellTicket.reset;
          exit;
        end;
    end;
  //�ٱ�����Ʊ��Ϣ
    jsoncdsseatreserve.Active:=false;
    jsoncdsseatreserve.Active:=true;
    jcdsVipBooktime.Active := false;
    with cdsticketbuffer do
    begin
      DisableControls;
      first;
      while not eof do
      begin
        jsoncdsseatreserve.Append;
        jsoncdsseatreserve.FieldValues['id']:=null;
        jsoncdsseatreserve.FieldValues['scheduleplanid']:=FieldValues['scheduleplanid'];
        jsoncdsseatreserve.FieldValues['orgid']:=FieldValues['orgid'];
        jsoncdsseatreserve.FieldValues['departdate']:=FieldValues['departdate'];
        jsoncdsseatreserve.FieldValues['scheduleid']:=FieldValues['scheduleid'];
        jsoncdsseatreserve.FieldValues['departtime']:=FieldValues['departtime'];
        jsoncdsseatreserve.FieldValues['departstationid']:=FieldValues['departstationid'];
        jsoncdsseatreserve.FieldValues['reachstationid']:=FieldValues['reachstationid'];
        jsoncdsseatreserve.FieldValues['fullprice']:=FieldValues['price'];
        jsoncdsseatreserve.FieldValues['tickettype']:=FieldValues['tickettype'];
        jsoncdsseatreserve.FieldValues['seatno']:=FieldValues['seatno'];
        if ispropotion then
          jsoncdsseatreserve.FieldValues['serviceprice']:=Round(defaultserviceprice*FieldValues['fullprice']/100)
        else
          jsoncdsseatreserve.FieldValues['serviceprice']:=defaultserviceprice;
//        jsoncdsseatreserve.FieldValues['serviceprice']:=FieldValues['serviceprice'];
        jsoncdsseatreserve.FieldValues['password']:=trim(nvedtpassword.Text);
        jsoncdsseatreserve.FieldValues['carrychildnum']:=FieldValues['carrychildnum'];
        jsoncdsseatreserve.FieldByName('isautocancel').AsBoolean:=chkautocancel.Checked;
        if chkautocancel.Checked then
          jsoncdsseatreserve.FieldValues['autocanceltime']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',getAutoCancelTime)
        else
          jsoncdsseatreserve.FieldValues['autocanceltime']:=null;
        jsoncdsseatreserve.FieldValues['customerid']:=customerid;
        jsoncdsseatreserve.FieldValues['reservetime']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',now);
        jsoncdsseatreserve.FieldValues['reserveip']:=sysinfo.LocalHostAddress;
        jsoncdsseatreserve.FieldValues['ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
        jsoncdsseatreserve.FieldValues['reserveby']:=sysinfo.LoginUserInfo.UserID;
        jsoncdsseatreserve.FieldValues['reserveway']:='1';
        jsoncdsseatreserve.FieldValues['remarks']:=null;
        jsoncdsseatreserve.FieldValues['sellstate']:='R';
        jsoncdsseatreserve.FieldValues['turnoverdetailid']:=null;
//        jsoncdsseatreserve.FieldValues['cancelbyid']:=sysinfo.LoginUserInfo.UserID;
        jsoncdsseatreserve.FieldValues['canceltime']:=null;
        jsoncdsseatreserve.FieldValues['createtime']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',now);;
        jsoncdsseatreserve.FieldValues['createby']:=sysinfo.LoginUserInfo.UserID;;
        jsoncdsseatreserve.FieldValues['updatetime']:=FormatDateTime('yyyy-mm-dd hh:nn:ss',now);;
        jsoncdsseatreserve.FieldValues['updateby']:=sysinfo.LoginUserInfo.UserID;;
        jsoncdsseatreserve.Post;
        next;
      end;
      EnableControls;
    end;
    with jsoncdsseatreserve do
    begin
      try
        if (ApplyUpdates(-1) <> 0) then
        begin
          SysDialogs.Warning('��Ʊʧ��:δ֪����');
        end;
        if Params.ParamValues['flag']=1 then
        begin
          result:=true;
          if Params.ParamByName('msg').IsNull then
            SysDialogs.ShowMessage('��Ʊ�ɹ�����֪ͨ�˿��ڹ涨ʱ������ǰȡƱ��')
          else
            SysDialogs.ShowMessage(Params.ParamValues['msg']);
        end
        else
        begin
          if Params.ParamByName('msg').IsNull then
            SysDialogs.ShowError('��Ʊʧ��:δ֪����')
          else
            SysDialogs.Warning(Params.ParamValues['msg']);
        end;
      except on E: Exception do
        SysDialogs.Warning('��Ʊʧ��:'+e.Message);
      end;
    end;
  end;
end;

function Tfrmbookticketend.getAutoCancelTime: TDateTime;
begin
//  dtpautocanceldate.Kind:=dtkDate;
//  result:=Trunc(dtpautocanceldate.Date);
//  dtpautocanceldate.Kind:=dtkTime;
//  result:=result+dtpautocanceldate.Time-trunc(dtpautocanceldate.Time);
  Result:=dtpautocanceldate.DateTime;
  ReplaceTime(Result,dtpautocanceltime.DateTime);
end;

function Tfrmbookticketend.getContextHint(winControl: TWinControl): String;
begin
  result:='';
end;

function Tfrmbookticketend.getcustomnosellcount(customid: Int64): Integer;
begin
  Result:=0;
  with jcdsquerybookunsellcount do
  begin
    Close;
    Params.ParamValues['customerid']:=customid;
    try
      Execute;
      if Params.ParamValues['flag']='1' then
      begin
        Result:=Params.ParamValues['bookunsellcount'];
      end
      else
      begin
        if Params.ParamValues['msg']=null then
          SysDialogs.ShowError('��ѯ��Ʊδȡ����ʧ��,δ֪ԭ��')
        else
          SysDialogs.ShowError(Params.ParamValues['msg']);
      end;
    except
      on e:Exception do
      SysDialogs.ShowError(e.Message);
    end;
  end;
end;

function Tfrmbookticketend.getdefaultThroughControl: TList<TWinControl>;
begin
  result:=inherited;
  result.Add(dbedtCERTIFICATENO);
  result.Add(dblkcbbCERTIFICATETYPE);
  result.Add(dbedtNAME);
  result.Add(chkautocancel);
  if nvedtpassword.Visible then
  begin
    result.Add(nvedtpassword);
  end;
end;

function Tfrmbookticketend.getdeparttime: TDateTime;
begin
  Result:=trunc(cdsSchedule.FieldByName('departdate').AsDateTime);
  result:=IncHour(result,StrToInt(Copy(cdsSchedule.FieldByName('departtime').AsString,1,2)));
  result:=IncMinute(result,StrToInt(Copy(cdsSchedule.FieldByName('departtime').AsString,4,2)));
end;

function Tfrmbookticketend.getfullThroughControl: TList<TWinControl>;
begin
  result:=inherited;
  result.Add(dbedtCERTIFICATENO);
  result.Add(dblkcbbCERTIFICATETYPE);
  result.Add(dbedtNAME);
  result.Add(rbMan);
  result.Add(rbGrile);
  result.Add(dbehdtedtbirthday);
  result.Add(dblkcbbEDUCATION);
  result.Add(dbedtMOBILEPHONE);
  result.Add(dbedtFamilyPhone);
  result.Add(dbedtAdress);
  result.Add(dbmmoRemark);
  result.Add(chkautocancel);
  result.Add(dtpautocanceldate);
  result.Add(dtpautocanceltime);
  if nvedtpassword.Visible then
  begin
    result.Add(nvedtpassword);
  end;
end;

function Tfrmbookticketend.getLastautocanceldate: TDateTime;
begin
  //����ʱ��ǰ
  Result:=getdeparttime();
//  if cdsSchedule.FieldByName('districttype').AsInteger<3 then
//    result:=IncHour(result,Trunc(autoCancelHoursBeforeDepart_in)*-1)
//  else
//    result:=IncHour(result,Trunc(autoCancelHoursBeforeDepart_out)*-1);
//  //��Ʊʱ���
//  Result:=min(Result,IncHour(now,trunc(autoCancelHours)));
  if cdsSchedule.FieldByName('districttype').AsInteger<3 then
    result:=IncMinute(result,Trunc(autoCancelHoursBeforeDepart_in)*-1)
  else
    result:=IncMinute(result,Trunc(autoCancelHoursBeforeDepart_out)*-1);
    
  if (jcdsVipBooktime.Active) and (jcdsVipBooktime.RecNo>0) then
  begin
     vipbooktime := jcdsVipBooktime.FieldByName('booktime').AsInteger;     
     result:= max(result,IncMinute(getdeparttime(),-vipbooktime));    
  end;        
  //��Ʊʱ���
  Result:=min(Result,IncMinute(now,trunc(autoCancelHours*60)));

end;

function Tfrmbookticketend.getSellWayreceivablenum: Currency;
begin
  if ispropotion then
    result:=Round(defaultserviceprice*(StrToCurr(nvedtticketreceivablenum.Text))/100)
  else
    result:=defaultserviceprice*getCurTicketNum;
end;

function Tfrmbookticketend.getServicefee(
  cdsticketbuffer: TjsonClientDataSet): Currency;
begin
  if ispropotion then
    result:=Round(defaultserviceprice*cdsticketbuffer.FieldByName('price').AsCurrency/100)
  else
    result:=defaultserviceprice;
end;

function Tfrmbookticketend.reset: boolean;
begin
  dbedtNAME.Enabled:=true;
  dbehdtedtbirthday.Enabled:=true;
  dblkcbbEDUCATION.Enabled:=true;
  dbedtFamilyPhone.Enabled:=true;
  dbedtMOBILEPHONE.Enabled:=true;
  dbedtAdress.Enabled:=true;
  dbmmoRemark.Enabled:=true;
end;

function Tfrmbookticketend.saveCustomer: Int64;
var certificateno:String;
    PIDErrMsg:String;
    mobilephoneErrMsg:String;
begin
  inherited;
  result:=0;
  with jsoncdsCustom do
  begin

  try
    DisableControls;
    if (not FieldByName('id').IsNull) and (FieldByName('id').AsLargeInt>0) then
    begin
      result:=FieldByName('id').AsLargeInt;
    end
    else
    begin
       //����
      if FieldByName('name').IsNull or FieldByName('certificatetype').IsNull or FieldByName('certificateno').IsNull then
      begin
        SysDialogs.ShowInfo('�����붩Ʊ�ͻ�������Ϣ!');
        if not (State in [dsEdit,dsInsert]) then
        begin
          edit;
        end;
        exit;
      end;
      edit;
      if (FieldValues['certificatetype']='0') then  //���֤
      begin
        certificateno:=FieldValues['certificateno'];
        PIDErrMsg:=ValidatePID(certificateno);
        if trim(PIDErrMsg)='' then
        begin
          if length(certificateno)=15 then
          begin
            jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint('19'+copy(certificateno,7,2)),
                                                                    strtoint(copy(certificateno,9,2)),
                                                                    strtoint(copy(certificateno,11,2)));
            if odd(strtoint(copy(certificateno,15,1))) then
              jsoncdsCustom.FieldByName('sex').Value:='��'
            else
              jsoncdsCustom.FieldByName('sex').Value:='Ů';
          end
          else if length(certificateno)=18 then
          begin
            jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint(copy(certificateno,7,4)),
                                                                    strtoint(copy(certificateno,11,2)),
                                                                    strtoint(copy(certificateno,13,2)));
            if odd(strtoint(copy(certificateno,17,1))) then
              jsoncdsCustom.FieldByName('sex').Value:='��'
            else
              jsoncdsCustom.FieldByName('sex').Value:='Ů';
          end;
        end
        else
        begin
          SysDialogs.ShowInfo('"'+FieldValues['name']+'"'+PIDErrMsg);
          if not (State in [dsEdit,dsInsert]) then
          begin
            edit;
          end;
          exit;
        end;
      end
      else
      begin
        FieldByName('sex').Value:='��';
        FieldByName('birthday').Value:=null;
        if (FieldValues['certificatetype']='4') then  //�ֻ���
        begin
           certificateno:=FieldValues['certificateno'];
           mobilephoneErrMsg:=ValidateMobilephone(certificateno);
           if trim(mobilephoneErrMsg)='' then
           begin
               jsoncdsCustom.FieldByName('mobilephone').Value:=certificateno;
           end
           else
           begin
               SysDialogs.ShowInfo('"'+FieldValues['name']+'"'+mobilephoneErrMsg);
               if not (State in [dsEdit,dsInsert]) then
               begin
                  edit;
               end;
               exit;
           end;

        end;
      end;

      FieldByName('orgid').Value:=SysInfo.LoginUserInfo.OrgID; // jsoncdsInsurance.FieldValues['orgid'];
      FieldByName('ticketoutletsid').Value:=SysInfo.LoginUserInfo.ticketoutletsid;
      FieldByName('inputway').Value:='3';
      FieldByName('lastbuytickettime').Value:=now;
      FieldByName('remarks').Value:=FieldValues['remarks'];
      post;
      try
        if (ApplyUpdates(-1) <> 0) then
        begin
          SysDialogs.Warning('����ͻ���Ϣʧ��:δ֪����');
          if not (State in [dsEdit,dsInsert]) then
          begin
            edit;
          end;
          exit;
        end;
      except on E: Exception do
        begin
          SysDialogs.Warning('����ͻ���Ϣʧ��:'+e.Message);
          if not (State in [dsEdit,dsInsert]) then
          begin
            edit;
          end;
          exit;
        end;
      end;
      if Params.ParamValues['flag']=1 then
      begin
        result:=FieldByName('id').Value;
      end
      else
      begin
        if Params.ParamByName('msg').IsNull then
        begin
          SysDialogs.Warning('����ͻ���Ϣʧ��:δ֪����');
          if not (State in [dsEdit,dsInsert]) then
          begin
            edit;
          end;
        end
        else
          SysDialogs.Warning(Params.ParamValues['msg']);
      end;
    end;
  finally
    EnableControls;
  end;

  end;
end;



procedure Tfrmbookticketend.setsexinputenable(isIDCard: boolean);
begin
  rbMan.Enabled:=not isIDCard;
  rbGrile.Enabled:=not isIDCard;
  dbehdtedtbirthday.Enabled:=not isIDCard;
end;

function Tfrmbookticketend.show: boolean;
begin
  result:=inherited;
  lblservicefee.Caption:=currtostr(getSellWayreceivablenum);
  jsoncdsCustom.Active:=false;
  jsoncdsCustom.Active:=true;
  jsoncdsCustom.Append;
  jsoncdsCustom.FieldByName('certificatetype').AsString:='4';
//  dblkcbbCERTIFICATETYPE.KeyValue:='4';
  jsoncdsCustom.FieldByName('name').AsString:=defaultcustomername;
  jcdsVipBooktime.Active := false;
  chkautocancel.Checked:=true;
  chkautocancelClick(chkautocancel);
end;

end.
