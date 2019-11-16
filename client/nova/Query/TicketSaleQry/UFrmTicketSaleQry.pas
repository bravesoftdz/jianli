unit UFrmTicketSaleQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmTicketSaleQry = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    dtpEdepartdate: TDateTimePicker;
    lbl1: TLabel;
    nvhelpendstation: TNovaHelp;
    nvhelpUserid: TNovaHelp;
    wdstrngfldResultreachname: TWideStringField;
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultschedulecode: TWideStringField;
    blnfldResultischecked: TBooleanField;
    blnfldResultisdepartinvoices: TBooleanField;
    nvcbbticketstatus: TNovaComboBox;
    nvcbbSellway: TNovaComboBox;
    nvcbbPaymethod: TNovaComboBox;
    lbl16: TLabel;
    nvhcbbTickettype: TNovaHComboBox;
    nvhelpTicketoutlets: TNovaHelp;
    chkIsnotline: TCheckBox;
    chkIsline: TCheckBox;
    chkIsnotcheck: TCheckBox;
    chkIscheck: TCheckBox;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    chkIsnotlocal: TCheckBox;
    chkIslocal: TCheckBox;
    blnfldResultislocal: TBooleanField;
    chkIsovertime: TCheckBox;
    chkIsnotovertime: TCheckBox;
    lbl4: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl7: TLabel;
    dtpBselldate: TDateTimePicker;
    lbl14: TLabel;
    dtpEselldate: TDateTimePicker;
    jcdsPaymethod: TjsonClientDataSet;
    wdstrngfldResultpaymethod: TWideStringField;
    wdstrngfldResultpaymethodname: TWideStringField;
    jcdsTicketstatus: TjsonClientDataSet;
    wdstrngfldResultticketstatus: TWideStringField;
    wdstrngfldResultticketstatusname: TWideStringField;
    jcdsSellway: TjsonClientDataSet;
    wdstrngfldResultsellway: TWideStringField;
    wdstrngfldResultsellwayname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    dtfldResultdepartdate: TDateField;
    wdstrngfldResultdeparttime: TWideStringField;
    intgrfldResultseatno: TIntegerField;
    blnfldResultislinework: TBooleanField;
    intgrfldResultcarrychildnum: TIntegerField;
    lrgntfldResultdistance: TLargeintField;
    fltfldResultfullprice: TFloatField;
    fltfldResultfueladditionfee: TFloatField;
    fltfldResultstationservicefee: TFloatField;
    fltfldResultprice: TFloatField;
    wdstrngfldResultticketentrance: TWideStringField;
    wdstrngfldResultbuspark: TWideStringField;
    wdstrngfldResultticketoutletname: TWideStringField;
    wdstrngfldResultsellip: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResulthticketoutlesname: TWideStringField;
    wdstrngfldResulthoutletsaddress: TWideStringField;
    nvhelpRoute: TNovaHelp;
    Label1: TLabel;
    wdstrngfldResultcheckedname: TWideStringField;
    wdstrngfldResultcheckstationname: TWideStringField;
    wdstrngfldResultdepartinvoicesbyname: TWideStringField;
    wdstrngfldResultdepartinvoicesno: TWideStringField;
    fltfldResultotherfee: TFloatField;
    jcdsResultvehiclebrandmodelname: TWideStringField;
    dtmfldResultchecktime: TDateTimeField;
    wdstrngfldResulttickettypename: TWideStringField;
    dtmfldResultdepartinvoicestime: TDateTimeField;
    jcdsResultcomputefee: TFloatField;
    jcdsResultcoolairfee: TFloatField;
    jcdsResultadditionfee: TFloatField;
    wdstrngfldResultroutename: TWideStringField;
    blnfldResultisovertime: TBooleanField;
    nvhlpReturnby: TNovaHelp;
    wdstrngfldResultvehicletypename: TWideStringField;
    fltfldResultticketprice: TFloatField;
    fltfldResultreturnamount: TFloatField;
    wdstrngfldResultreturnbyname: TWideStringField;
    dtmfldResultreturntime: TDateTimeField;
    wdstrngfldResultreturnway: TWideStringField;
    jcdsReturnway: TjsonClientDataSet;
    wdstrngfldResultreturnwayname: TWideStringField;
    nvhlpschedule: TNovaHelp;
    jcdsResultmoreprice: TFloatField;
    jcdsResultselltime: TDateTimeField;
    nvcbbOrgid: TNovaCheckedComboBox;
    fltfldResultservicefee: TFloatField;
    fltfldResultwaterfee: TFloatField;
    fltfldResultinsurefee: TFloatField;
    fltfldResultserviceprice: TFloatField;
    fltfldResultsubtotal: TFloatField;
    nvhlpDeparts: TNovaHelp;
    Label2: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    jcdsResultprintorgname: TWideStringField;
    jcdsResultprintname: TWideStringField;
    Nvehicleno: TNovaHelp;
    Label3: TLabel;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultolddepartdate: TDateField;
    CheckBox1: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  frmTicketSaleQry: TfrmTicketSaleQry;
implementation
    uses SystemInstance,SysInfoIntf,PubFn, UFrmChangeCustomerInfo;
{$R *.dfm}

procedure TfrmTicketSaleQry.dtpEselldateChange(Sender: TObject);
begin
  inherited;
   if dtpEselldate.Checked = True  then
    begin
       dtpBselldate.Checked := True;
    end;
   if  dtpEselldate.Checked =False then
    begin
       dtpBselldate.Checked := False;
    end;
end;


procedure TfrmTicketSaleQry.dtpBselldateChange(Sender: TObject);
begin
  inherited;
   if dtpBselldate.Checked = True  then
    begin
       dtpEselldate.Checked := True;
    end;
   if  dtpBselldate.Checked =False then
    begin
       dtpEselldate.Checked := False;
    end;
end;

procedure TfrmTicketSaleQry.FormCreate(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  NovachkPorg.SetCheck(0,true);
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active:= True;
  nvcbbticketstatus.ItemIndex:=0;
  nvcbbSellway.Active := False;
  nvcbbSellway.Active:=True;
  nvcbbSellway.ItemIndex:=0;
  nvcbbPaymethod.Active := False;
  nvcbbPaymethod.Active := True;
  nvcbbPaymethod.ItemIndex:=0;
  nvhcbbTickettype.Active := False;
  nvhcbbTickettype.Active := True;
  nvhcbbTickettype.ItemIndex:=0;
  dtpBdepartdate.Date :=Now;
  dtpEdepartdate.Date :=Now;
  dtpBselldate.Date := Now ;
  dtpEselldate.Date :=Now;
  jcdsPaymethod.Active := False;
  jcdsPaymethod.Active := True;
  jcdsTicketstatus.Active := False;
  jcdsTicketstatus.Active := True;
  jcdsSellway.Active :=False;
  jcdsSellway.Active := True;
  dtpBselldate.Checked := True;
  dtpEselldate.Checked := True;
end;

procedure TfrmTicketSaleQry.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{ED973E13-5A4F-43DD-9C21-351C3A7303D2}' then //查询其它售票员的售票记录
  begin
//    nvhelpUserid.Visible:=aEnable;
//    lbl6.Visible:=aEnable;
    nvhelpUserid.Enabled:=aEnable;
    if not aEnable then
    begin
      nvhelpUserid.Text:=SysInfo.LoginUserInfo.UserName;
      nvhelpUserid.Id:=SysInfo.LoginUserInfo.UserID;
    end;
  end ;

  //是否有合计功能
  if GUIDToString(key)='{21D4BAF1-A599-4864-BD87-C7C604DF1A0C}' then
  begin
    if not aEnable then
    begin
       dbgrdhResult.SumList.Active:=false;
    end;
  end


end;

procedure TfrmTicketSaleQry.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    nvcbbOrgid.Active := False;
    nvcbbOrgid.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    nvcbbOrgid.Active := True;
    nvcbbOrgid.CheckAll(true);
  end;
end;

procedure TfrmTicketSaleQry.tbtnFilterClick(Sender: TObject);
var
 num:Tdatetime;
begin
  inherited;
   if (nvcbbOrgid.GetCount = 0) or (nvcbbOrgid.Text = '')then
  begin
    SysDialogs.ShowMessage('请选择售票机构！');
    exit;
  end;
  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date) )then
  begin
    SysDialogs.ShowMessage('售票开始日期不能大于结束日期！');
    exit;
  end;

  if (FormatDateTime('yyyymmdd', dtpBdepartdate.Date) > FormatDateTime('yyyymmdd',
    dtpEdepartdate.Date) )then
  begin
    SysDialogs.ShowMessage('发车开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
       <=trunc(dtpEdepartdate.Date-dtpBdepartdate.Date))
    then
  begin
      SysDialogs.Warning('选择发车日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
    exit;
  end;

  if ((StrToInt(getParametervalue('0026', Sysinfo.LoginUserInfo.OrgID))
        <=trunc(dtpEselldate.Date-dtpBselldate.Date))) then
  begin
    SysDialogs.Warning('选择售票日期的天数差超过系统设置的最大可查询天数('
      +getParametervalue('0026', Sysinfo.LoginUserInfo.OrgID)+'),请重新选择');
    exit;
  end;

  with jcdsResult do
  begin
    Active:=False;
    log := '查询条件有：';
    if (Trim(nvedtTicketno.Text) = '') and (Trim(nvhlpschedule.Text) = '')
       and (Trim(nvhelpRoute.Text)='') and (Trim(nvhlpDeparts.Text)='')
       and (Trim(nvhelpendstation.Text)='')  and (Trim(nvhelpUserid.Text)='')
       and (Trim(nvhlpReturnby.Text) = '') and (Trim(nvedtTicketno.Text)='')
       and (nvcbbticketstatus.GetSelectCode <> '1') and (nvcbbticketstatus.GetSelectCode <> '2')//退票，废票

    then
    begin

      if (StrToInt(getParametervalue('0006', Sysinfo.LoginUserInfo.OrgID))
                >=trunc(dtpEdepartdate.Date-dtpBdepartdate.Date)) then
      begin
        if ((StrToInt(getParametervalue('0026', Sysinfo.LoginUserInfo.OrgID))
                <=trunc(dtpEselldate.Date-dtpBselldate.Date))) then
        begin
          Showmessage('没有输入查询条件，只查询一个月的数据');
          exit;
        end;
      end;

//      if (formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date) <>
//            formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date)) then
//      begin
//        if (not dtpBselldate.Checked) or ((formatdatetime('yyyy-mm-dd',dtpBselldate.Date) <>
//            formatdatetime('yyyy-mm-dd',dtpEselldate.Date))) then
//        begin
//          Showmessage('没有输入查询条件，只查询一天的数据');
//          exit;
//        end;
//      end;
    end;

      Params.ParamValues['qp.departSdate'] :=  formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
      Params.ParamValues['qp.departEdate'] :=  formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
      Params.ParamValues['qp.isolddate'] := CheckBox1.Checked;
      log := ' [发车日期]从'+DateToStr(dtpBdepartdate.DateTime)+'到'+DateToStr(dtpEdepartdate.DateTime)+', ';


    if dtpBselldate.Checked then //售票日期
    begin

      Params.ParamValues['qp.sellSdate'] :=  formatdatetime('yyyy-mm-dd',dtpBselldate.DateTime);
      Params.ParamValues['qp.sellEdate'] :=  formatdatetime('yyyy-mm-dd',dtpEselldate.DateTime);
      log :=' [售票日期]从'+DateToStr(dtpBselldate.DateTime)+'到'+DateToStr(dtpEselldate.DateTime)+', ';
    end
    else
    begin
       Params.ParamValues['qp.sellSdate'] :=null;
       Params.ParamValues['qp.sellEdate'] :=null;
    end;


    if not (Trim(nvhlpschedule.Text) = '') then      //班次
      begin
        Params.ParamValues['qp.schcode']:= nvhlpschedule.Text;
        log := log +',[班次号]:'+nvhlpschedule.Text;
      end
    else
      begin
        Params.ParamValues['qp.schcode']:=null;
      end;

    if not (Trim(nvedtTicketno.Text) = '') then      //票号
      begin
        Params.ParamValues['qp.ticketno']:= nvedtTicketno.Text;
        log := log+ ',[票号]:'+nvedtTicketno.Text;
      end
    else
      begin
        Params.ParamValues['qp.ticketno']:=null;
      end;

    if (Trim(nvhlpDeparts.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['qp.departstationid']:= nvhlpDeparts.id;
      log := log +',[发车站]:'+ nvhlpDeparts.Text;
    end
    else
      Params.ParamValues['qp.departstationid']:= null;

    if (Trim(nvhelpendstation.Text)<>'') then //or (nvhelpendstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['qp.reachstationid']:= nvhelpendstation.id;//HelpFieldValue['id'];
      log := log+',[到达站]:'+nvhelpendstation.Text;
    end
    else
    Params.ParamValues['qp.reachstationid']:=null;

    if (not nvhelpUserid.Enabled) or (not nvhelpUserid.Visible) then   //售票员
    begin
      Params.ParamValues['qp.sellby']:= SysInfo.LoginUserInfo.UserID;
      log := log+',[售票员]:'+  nvhelpUserid.Text;
    end
    else if (nvhelpUserid.Id>0) or ((nvhelpUserid.Id=0) and (Trim(nvhelpUserid.Text)='异站用户')) then
    begin
      Params.ParamValues['qp.sellby']:= nvhelpUserid.id;
      log := log+',[售票员]:'+  nvhelpUserid.Text;
    end
    else if Trim(nvhelpUserid.Text)='' then
       Params.ParamValues['qp.sellby']:=null;

    if not (Trim(nvhlpReturnby.Text) = '') and (nvhlpReturnby.Id>=0) then      //退票员
    begin
      Params.ParamValues['qp.returnby']:= nvhlpReturnby.Id;//HelpFieldValue['id'];
      log := log+',[退票员]:'+  nvhlpReturnby.Text;
    end
    else
      begin
        Params.ParamValues['qp.returnby']:=null;
      end;
     if nvcbbticketstatus.ItemIndex >= 0 then
      begin
        Params.ParamValues['qp.ticketstatus']:= nvcbbticketstatus.GetSelectCode;
        log := log+',[车票状态]:'+  nvcbbticketstatus.Text;
      end
       else
      begin
        Params.ParamValues['qp.ticketstatus']:=null;
      end;

      if nvcbbSellway.ItemIndex >= 0 then
      begin
        Params.ParamValues['qp.sellway']:= nvcbbSellway.GetSelectCode;
        log := log+',[售票方式]:'+nvcbbSellway.Text;
      end
       else
      begin
        Params.ParamValues['qp.sellway']:=null;
      end;

      if nvcbbPaymethod.ItemIndex >= 0 then
      begin
        Params.ParamValues['qp.paymethod']:= nvcbbPaymethod.GetSelectCode;
        log := log+ ',[支付方式]:'+  nvcbbPaymethod.Text;
      end
       else
      begin
        Params.ParamValues['qp.paymethod']:=null;
      end;

      if nvhcbbTickettype.ItemIndex >=0 then
      begin
        Params.ParamByName('qp.tickettype').Value := nvhcbbTickettype.HelpFieldValue['code'];
        log := log+',[车票类型]:'+ nvhcbbTickettype.Text;
      end
       else
        Params.ParamByName('qp.tickettype').Value :=null;

      if nvhelpTicketoutlets.Id>0 then            //售票点
      begin
        Params.ParamValues['qp.ticketoutletsid']:=nvhelpTicketoutlets.Id;
        log := log+ '[售票点]:'+nvhelpTicketoutlets.Text;
      end
      else
      begin
         Params.ParamValues['qp.ticketoutletsid']:='';
      end;


    if not chkIsnotline.Checked  and chkIsline.Checked  then    //是否流水班
      begin
         Params.ParamValues['qp.islinework']:=1;
         log := log+' ,[流水班]';
      end
      else if not chkIsline.Checked  and chkIsnotline.Checked then
      begin
         Params.ParamValues['qp.islinework']:=0;
         log := log+',[非流水班]';
      end
      else
      begin
         Params.ParamValues['qp.islinework']:=null;
      end;

       if not chkIsnotcheck.Checked  and chkIscheck.Checked  then    //是否已检
      begin
         Params.ParamValues['qp.ischecked']:='1';
         log := log+',[车票已检]';
      end
      else if not chkIscheck.Checked  and chkIsnotcheck.Checked then
      begin
         Params.ParamValues['qp.ischecked']:='0';
         log := log+',[车票未检]';
      end
      else
      begin
         Params.ParamValues['qp.ischecked']:=null;
      end;

      if not chkIsnotovertime.Checked  and chkIsovertime.Checked  then     //是否加班班次
      begin
         Params.ParamValues['qp.isovertime']:='1';
         log := log+',[加班]';
      end
      else if not chkIsovertime.Checked  and chkIsnotovertime.Checked then
      begin
         Params.ParamValues['qp.isovertime']:='0';
         log := log+',[正班]';
      end
      else
      begin
         Params.ParamValues['qp.isovertime']:=null;
      end;

     if not chkIsnotlocal.Checked  and chkIslocal.Checked  then    //是否异站票
      begin
         Params.ParamValues['qp.islocalticket']:='1';
         log := log+',[本站票]';
      end
      else if not chkIslocal.Checked  and chkIsnotlocal.Checked then
      begin
         Params.ParamValues['qp.islocalticket']:='0';
         //Params.ParamValues['isovertime']:='';
         //Params.ParamValues['ischecked']:='';
         log := log+',[异站票]';
      end
      else
      begin
         Params.ParamValues['qp.islocalticket']:=null;
      end;

    if (Trim(nvhelpRoute.Text)<>'')  then //or (nvhelpstartstation.HelpFieldValue['id']>0) then
    begin
      Params.ParamValues['qp.routeid']:= nvhelpRoute.id;
      Params.ParamValues['qp.islocalticket']:='1';
      log := log+',[线路]:'+nvhelpRoute.Text;
    end
    else
    begin
       Params.ParamValues['qp.routeid']:= null;
    end;
    Params.ParamValues['qp.saleorgids']:= nvcbbOrgid.GetSelectID;

    if (Trim(Nvehicleno.Text)<>'')  then
    begin
      Params.ParamValues['qp.vehicleid']:= Nvehicleno.id;
      log := log+',[车牌号]:'+Nvehicleno.Text;
    end
    else
    begin
       Params.ParamValues['qp.vehicleid']:= null;
    end;



    Params.ParamValues['qp.saleorgids']:= nvcbbOrgid.GetSelectID;

    Active:=true;
    log := log+',[售票机构]:'+ nvcbbOrgid.Text;
    //保存操作日志
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('综合查询->售票情况查询', '查询', log);
    log := '';

     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
     if dtpBdepartdate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEdepartdate.Date);
     end;
     if dtpBselldate.Checked =True  then
     begin
      dbgrdhResult.PrintInfo.PageTopRight:='售票日期：'+ formatdatetime('yyyy-mm-dd',dtpBselldate.Date)
       +' 至'+formatdatetime('yyyy-mm-dd',dtpEselldate.Date);
     end;
  end;
end;
procedure TfrmTicketSaleQry.tbtnInsertClick(Sender: TObject);
var
  ticketno : string;
begin
  inherited;
  if jcdsResult.FieldByName('customerid').AsString = '' then
  begin
    SysDialogs.Warning('该票未进行实名制,无法修改乘车人信息!');
    exit;
  end;

  with FrmChangeCustomerInfo do
  begin
    FrmChangeCustomerInfo := TFrmChangeCustomerInfo.Create(Self);
    nvedtName.Text := jcdsResult.FieldByName('customername').AsString;
    nvedtIDcard.Text :=  jcdsResult.FieldByName('certificateno').AsString;
    NovaDepartdate.Text :=  jcdsResult.FieldByName('departdate').AsString;
    NovaDeparttime.Text :=  jcdsResult.FieldByName('departtime').AsString;
    NovaResearchStation.Text :=  jcdsResult.FieldByName('reachname').AsString;
    NovaSeatno.text :=  jcdsResult.FieldByName('seatno').AsString;
    NovaSchCode.Text :=  jcdsResult.FieldByName('schedulecode').AsString;
    NovaSelltime.Text :=  jcdsResult.FieldByName('selltime').AsString;
    customerid := jcdsResult.FieldByName('customerid').AsLargeInt;
    ticketno :=  jcdsResult.FieldByName('ticketno').AsString;
    if SysMainForm.showFormModal(FrmChangeCustomerInfo, false) = mrok then
    begin
      tbtnFilterClick(Self);
    end;
  end;

end;

end.
