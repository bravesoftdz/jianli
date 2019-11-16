unit UFrmInsureReturn;
{
  作者：代金岩
  增加退废保险模块
  2016年3月1日
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  ExtDlgs,UDMPublic ;

type
  TFrmInsureReturn = class(TSimpleCRUDForm)
    jcdsstatus: TjsonClientDataSet;
    jcdspaymethod: TjsonClientDataSet;
    jcdssellway: TjsonClientDataSet;
    wdstrngfldResultticketname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultendname: TWideStringField;
    wdstrngfldResultinsuranceno: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultcertificateno: TWideStringField;
    wdstrngfldResultinsurername: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    wdstrngfldResultinsurancestatus: TWideStringField;
    wdstrngfldResultinsurancestatusname: TWideStringField;
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultselltime: TWideStringField;
    wdstrngfldResultpaymethod: TWideStringField;
    wdstrngfldResultpaymethodname: TWideStringField;
    wdstrngfldResultsellway: TWideStringField;
    wdstrngfldResultsellwayname: TWideStringField;
    wdstrngfldResultpolnumber: TWideStringField;
    dtfldResultdepartdate: TDateField;
    fltfldResultpremium: TFloatField;
    fltfldResultinsureamount: TFloatField;
    jcdsResultsellip: TWideStringField;
    fltfldResultywmoney: TFloatField;
    fltfldResultshmoney: TFloatField;
    fltfldResultemoney: TFloatField;
    fltfldResultemmoney: TFloatField;
    wdstrngfldResultreprintnum: TWideStringField;
    wdstrngfldResultoutletsaddress: TWideStringField;
    wdstrngfldResultreturnorcancelby: TWideStringField;
    wdstrngfldResultreturnorcanceltime: TWideStringField;
    wdstrngfldResultinsurersbankcode: TWideStringField;
    wdstrngfldResultstartname: TWideStringField;
    wdstrngfldResultinsuretypecode: TWideStringField;
    wdstrngfldResultinsuranceprintdatetime: TWideStringField;
    dlg1: TSaveTextFileDialog;
    blnfldResultislinework: TBooleanField;
    wdstrngfldResultseatno: TWideStringField;
    wdstrngfldResultsellby: TWideStringField;
    wdstrngfldResultorgcode: TWideStringField;
    jcdscertificatetypename: TjsonClientDataSet;
    wdstrngfldResultcertificatetype: TWideStringField;
    wdstrngfldResultcertificatetypename: TWideStringField;
    rbticketno: TRadioButton;
    nvedtticketnos: TNovaEdit;
    rbschedule: TRadioButton;
    dtpdepartdate: TDateTimePicker;
    lblschedule: TLabel;
    nvhelpschedule: TNovaHelp;
    lblseatno: TLabel;
    nvedtseatno: TNovaEdit;
    rbinsureno: TRadioButton;
    nvedtInsurenos: TNovaEdit;
    jcdsResultisreturninsure: TBooleanField;
    jcdsResultischecked: TBooleanField;
    jcdsResultisdepartinvoices: TBooleanField;
    jcdsResultisuranceid: TLargeintField;
    jsoncdsticketreturn: TjsonClientDataSet;
    jsoncdsticketcancel: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure nvedtInsurenosKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);



  private
     function insureretrunByInterface: boolean; //通过接口退保险
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInsureReturn: TFrmInsureReturn;

implementation

uses Services, PubFn,strUtils, UFrmInsureReturnend,UFrmInsureCancelend;
{$R *.dfm}



procedure TFrmInsureReturn.FormCreate(Sender: TObject);
begin
  inherited;
  dtpdepartdate.Date := Date();
end;



procedure TFrmInsureReturn.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  
  with jcdsResult do
  begin
    Active := False;
    params.ParamValues['filter_EQS_t!ticketno'] := null;
    params.ParamValues['filter_LIKES_i!insuranceno'] := null;
    params.ParamValues['filter_EQR_t!seatno'] := null;
    params.ParamValues['filter_EQD_t!departdate'] := null;
    params.ParamValues['scheduleid'] := null;
    

    if rbticketno.Checked then
    begin
      if Trim(nvedtticketnos.Text)<>'' then
        params.ParamValues['filter_EQS_t!ticketno'] := nvedtticketnos.Text
      else
      begin
        SysDialogs.ShowInfo('请输入要查询的票号！') ;
        exit;
      end;
    end
    else if rbinsureno.Checked then
    begin
      if Trim(nvedtInsurenos.Text)='' then
      begin
        SysDialogs.ShowInfo('请输入要查询的保单号！') ;
        exit;
      end
      else
      	Params.ParamValues['filter_LIKES_i!insuranceno'] := nvedtInsurenos.Text;
    end
    else
    begin
      if nvhelpschedule.Id <= 0 then
      begin
        SysDialogs.ShowInfo('请输入要查询的班次');
        nvhelpschedule.SetFocus;
        exit;
      end;
      if StrToIntDef(nvedtseatno.text, 0) > 0 then
      begin
        params.ParamValues['filter_EQR_t!seatno'] := nvedtseatno.text;
      end;
      //按日期查询
      params.ParamValues['filter_EQD_t!departdate'] := FormatDateTime
        ('yyyy-mm-dd hh:nn:ss',trunc(dtpdepartdate.Date));
      params.ParamValues['scheduleid']:= nvhelpschedule.Id;
    end;

    Active := True;
  end;
end;

procedure TFrmInsureReturn.tbtnEditClick(Sender: TObject);
var
	totalinsurancenum,insurancesellby:Integer;
	totalpremium : Currency;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
  begin
    exit;
  end;
  totalpremium := 0;
  totalinsurancenum := 0;
  insurancesellby:=0;
  jsoncdsticketcancel.Active := false;
 // returntovipcard := false;
  // 判断选中的记录数
  with jcdsResult do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      if FieldByName('isreturninsure').AsBoolean then
      begin
        if FieldByName('ischecked').AsBoolean then
        begin
          SysDialogs.Warning('该车票已经检票，不允许退保险！');
          EnableControls;
          exit;
        end;
        if FieldByName('isdepartinvoices').AsBoolean then
        begin
          SysDialogs.Warning('该车票已经发班，不允许退保险！');
          EnableControls;
          exit;
        end;

        if (FieldByName('sellby').AsInteger)<>(Sysinfo.LoginUserInfo.UserID) then
        begin
          SysDialogs.Warning('废保险只能废自己售出的保险!');
          EnableControls;
          exit;
        end;

        inc(totalinsurancenum);
        totalpremium := totalpremium + FieldValues['premium'];

        if not jsoncdsticketcancel.Active then
        begin
          jsoncdsticketcancel.Active := true;
        end;
        jsoncdsticketcancel.Append;

        jsoncdsticketcancel.FieldValues['cancelway'] := '0';
        jsoncdsticketcancel.FieldValues['cancelinsureid'] := FieldValues['insuranceid'];
        jsoncdsticketcancel.FieldValues['iscancelinsure'] := FieldValues['isreturninsure'];
        jsoncdsticketcancel.FieldValues['insurancesellby'] := FieldValues['sellby'];

        jsoncdsticketcancel.post;

       end;
      next;
    end;
    EnableControls;
  end;
  if jsoncdsticketcancel.Active and (jsoncdsticketcancel.RecordCount > 0) then
  begin
    FrmInsureCancelend := TFrmInsureCancelend.Create(self);
    try
      FrmInsureCancelend.lblinsurenum.Caption := IntToStr(totalinsurancenum);
      FrmInsureCancelend.lblinsuretotalnum.Caption := CurrToStr(totalpremium);

      if SysMainForm.showFormModal(FrmInsureCancelend, false) = mrok then
      begin
        with jsoncdsticketcancel do
        begin
          if trim(FrmInsureCancelend.mmoreason.text) <> '' then
          begin
            First;
            while not eof do
            begin
              edit;
              jsoncdsticketcancel.FieldValues['remarks'] :=
                FrmInsureCancelend.mmoreason.text;
              post;
              next;
            end;
          end;
          try
            if (ApplyUpdates(-1) <> 0) then
            begin
              SysDialogs.Warning('废保险失败:未知错误！');
            end;
            if params.ParamValues['flag']=1  then
            begin
                SysDialogs.Warning(params.ParamValues['msg']);
            end;
          except
            on E: Exception do
              SysDialogs.ShowError('废保险失败:' + E.Message);
          end;
        end;
      end;
    finally
      tbtnFilterClick(Sender);
      freeandnil(FrmInsureReturnend);
    end;
  end;
end;

procedure TFrmInsureReturn.tbtnInsertClick(Sender: TObject);
var
	totalinsurancenum:Integer;
	totalpremium : Currency;
  insurereturnStr:TStringBuilder;
  interfaceflag :Boolean;
begin
  inherited;
  if (not jcdsResult.Active) or (jcdsResult.RecordCount = 0) then
  begin
    exit;
  end;
  
  totalpremium := 0;
  totalinsurancenum := 0;

  jsoncdsticketreturn.Active := false;
 // returntovipcard := false;
  // 判断选中的记录数
  with jcdsResult do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      if FieldByName('isreturninsure').AsBoolean then
      begin
        if FieldByName('ischecked').AsBoolean then
        begin
          SysDialogs.Warning('该车票已经检票，不允许退保险！');
          EnableControls;
          exit;
        end;
        if FieldByName('isdepartinvoices').AsBoolean then
        begin
          SysDialogs.Warning('该车票已经发班，不允许退保险！');
          EnableControls;
          exit;
        end;
       
        inc(totalinsurancenum);
        totalpremium := totalpremium + FieldValues['premium'];

        if not jsoncdsticketreturn.Active then
        begin
          jsoncdsticketreturn.Active := true;
        end;
        jsoncdsticketreturn.Append;

        jsoncdsticketreturn.FieldValues['returnway'] := '0';
        jsoncdsticketreturn.FieldValues['returninsureid'] := FieldValues['insuranceid'];
        jsoncdsticketreturn.FieldValues['isreturninsure'] := FieldValues['isreturninsure'];

        jsoncdsticketreturn.post;

       end;
      next;
    end;
    EnableControls;
  end;
  if jsoncdsticketreturn.Active and (jsoncdsticketreturn.RecordCount > 0) then
  begin
    FrmInsureReturnend := TFrmInsureReturnend.Create(self);

    try

      FrmInsureReturnend.lblinsurenum.Caption := IntToStr(totalinsurancenum);
      FrmInsureReturnend.lblinsurereceivablenum.Caption := CurrToStr
        (totalpremium);
      FrmInsureReturnend.lblinsuretotalnum.Caption := CurrToStr(totalpremium);

      if SysMainForm.showFormModal(FrmInsureReturnend, false) = mrok then
      begin
        with jsoncdsticketreturn do
        begin
          if trim(FrmInsureReturnend.mmoreason.text) <> '' then
          begin
            First;
            while not eof do
            begin
              edit;
              jsoncdsticketreturn.FieldValues['remarks'] :=
                FrmInsureReturnend.mmoreason.text;
              post;
              next;
            end;
          end;
          try
            if (ApplyUpdates(-1) <> 0) then
            begin
              SysDialogs.Warning('退保险失败:未知错误！');
            end;
            if params.ParamValues['flag']=1  then
            begin
                //调用退保接口。
//               interfaceflag := insureretrunByInterface;
//               if interfaceflag then
                SysDialogs.Warning(params.ParamValues['msg'])
//               else
//                SysDialogs.Warning('调用退保接口失败！');
            end
            else
            begin
               SysDialogs.Warning(params.ParamValues['msg']);
            end;
          except
            on E: Exception do
              SysDialogs.ShowError('退保险失败:' + E.Message);
          end;
        end;
      end;
    finally
      tbtnFilterClick(Sender);
      freeandnil(FrmInsureReturnend);
    end;
  end;
end;

procedure TFrmInsureReturn.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  nvedtticketnos.SetFocus;
end;

function TFrmInsureReturn.insureretrunByInterface: boolean;
//var
//  insureStr:TStringBuilder;
//  bxInstance:TIDisurance;
//  i:Integer;
begin
//    try
//    insureStr := TStringBuilder.Create;
//    with jcdsResult do
//    begin
//      First;
//      while not eof do
//      begin
//        if not FieldByName('isreturninsure').AsBoolean then
//        begin
//          Next;
//          Continue;
//        end;
//        insureStr.Append(FieldByName('insuranceno').AsString).Append('|');//保险单号
//        insureStr.Append(FieldByName('ticketno').AsString).Append('|'); //客票号
//        insureStr.Append(FieldByName('sellby').AsString).Append('|');
//        insureStr.Append(FieldByName('selltime').AsString).Append('|'); //售票时间
//
//
//         if Pos('太平洋',FieldByName('insurername').AsString)>0 then //保险票调用太保接口
//         begin
//            bxInstance.BackInsuranceData(Trim(insureStr.ToString),'T');    //太保调用 退保
//         end
//         else if Pos('人寿',FieldByName('insurername').AsString)>0 then
//         begin
//           bxInstance.BackInsuranceData(Trim(insureStr.ToString));   //人寿调用 退保
//         end;
//
//        insureStr.Clear;
//        Next;
//      end;
//    end;
//    finally
//       insureStr.Free;
//    end;
end;


procedure TFrmInsureReturn.nvedtInsurenosKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=13 then
  begin
    tbtnFilterClick(sender);
    key:=0;
  end;
end;


end.
