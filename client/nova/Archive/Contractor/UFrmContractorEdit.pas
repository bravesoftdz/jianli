unit UFrmContractorEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, NovaHComboBox, DB, DBClient, jsonClientDataSet,Services, NovaHelp,
  ImgList;

type
  TfrmContractorEdt = class(TSimpleEditForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl11: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    nvedtName: TNovaEdit;
    nvedtIDcard: TNovaEdit;
    nvedtContactphone: TNovaEdit;
    nvedtAdress: TNovaEdit;
    grp2: TGroupBox;
    lbl18: TLabel;
    lblWorkn: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbllbvehicleid: TLabel;
    lbl35: TLabel;
    lbl15: TLabel;
    nvhcbbOrg: TNovaHComboBox;
    lbl9: TLabel;
    lbl2: TLabel;
    jcdsSave: TjsonClientDataSet;
    nvedtMonthamount: TNovaEdit;
    nvedtContractno: TNovaEdit;
    dtpEnddate: TDateTimePicker;
    dtpStartdate: TDateTimePicker;
    nvhelpVehicle: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    mem: TMemoryStream;
    memstr: TStringStream;
    function checkInput(var msg: String): boolean;
  public
    { Public declarations }
    isedit:boolean;
   id:Integer;
   createby,orgname,idcard,phone,adress,contractno,contractname,
   amount,starttime,endtime,vehicle,createtime,code: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmContractorEdt: TfrmContractorEdt;

implementation
  uses UDMPublic,PubFn;

{$R *.dfm}

procedure TfrmContractorEdt.bbtnSaveClick(Sender: TObject);
 var  msg,operationtype,log: String;
  nResult: integer;
  sResult,contractorno: String;
begin
  inherited;
   if (not checkInput(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  with jcdsSave do
  begin
    close;
    Params.ParamByName('contractor.id').Value := id;
    Params.ParamByName('contractor.createtime').Value := createtime;
    Params.ParamByName('contractor.createby').Value := createby;
    Params.ParamByName('contractor.name').Value := nvedtName.Text;
    Params.ParamByName('contractor.idcard').Value := nvedtIDcard.Text;
    Params.ParamByName('contractor.contactphone').Value := nvedtContactphone.Text;
    Params.ParamByName('contractor.contactaddress').Value := nvedtAdress.Text;
    Params.ParamByName('contractor.contractno').Value := nvedtContractno.Text;
    if nvedtMonthamount.Text ='' then
      Params.ParamByName('contractor.monthamount').Value :='0'
    else
    Params.ParamByName('contractor.monthamount').Value := nvedtMonthamount.Text;

    Params.ParamByName('contractor.orgid').Value := nvhcbbOrg.HelpFieldValue['id'];
    Params.ParamByName('contractor.vehicleid').Value := nvhelpVehicle.Id;
    Params.ParamByName('contractor.startdate').Value :=formatdatetime('c',dtpStartdate.Date);
    Params.ParamByName('contractor.enddate').Value := formatdatetime('c',dtpEnddate.Date);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      contractorno :='合同编码';
      if (nResult <= 0) then
      begin
       if Pos(contractorno,sResult)>0 then
       begin
        nvedtContractno.SetFocus;
       end
       else
       begin
        nvhelpVehicle.SetFocus;
       end;
      end
      else
      begin
        if id>0 then
        begin
           operationtype:='修改';
           if orgname <> nvhcbbOrg.Text then
           begin
              log := ' 机构名称由'+orgname+'改成'+nvhcbbOrg.Text;
           end;
            if contractname <> nvedtName.Text then
           begin
              log := log+', 承包者名称由'+contractname+'改成'+nvedtName.Text;
           end;
            if idcard <> nvedtIDcard.Text then
           begin
              log := log+', 身份证由'+idcard+'改成'+nvedtIDcard.Text;
           end;
            if phone <> nvedtContactphone.Text then
           begin
              log := log+', 电话由'+phone+'改成'+nvedtContactphone.Text;
           end;
            if adress <> nvedtAdress.Text then
           begin
              log := log+', 地址由'+adress+'改成'+nvedtAdress.Text;
           end;
           if vehicle <> nvhelpVehicle.Text then
           begin
              log := log+', 承包车由'+vehicle+'改成'+nvhelpVehicle.Text;
           end;
           if contractno <> nvedtContractno.Text then
           begin
              log := log+', 承包合同编号由'+contractno+'改成'+nvedtContractno.Text;
           end;
           if amount <> nvedtMonthamount.Text then
           begin
              log := log+', 承包金额由'+amount+'改成'+nvedtMonthamount.Text;
           end;
           if starttime <> DateToStr(dtpStartdate.Date) then
           begin
              log := log+', 承包开始日期由'+starttime+'改成'+DateToStr(dtpStartdate.Date);
           end;
           if endtime <> DateToStr(dtpEnddate.Date) then
           begin
              log := log+', 承包结束日期由'+endtime+'改成'+DateToStr(dtpEnddate.Date);
           end;
        end
        else
        begin
           operationtype:='添加';
            log := '所属机构:'+ nvhcbbOrg.Text +', 承包者名称:'+nvedtName.Text
            +', 身份证:'+nvedtIDcard.Text+', 电话:'+nvedtContactphone.Text
            +', 地址:'+nvedtAdress.Text+', 承包车:'+nvhelpVehicle.Text
            +', 承包合同编号:'+nvedtContractno.Text
            +', 承包金额:'+nvedtMonthamount.Text
            +', 承包开始日期:'+DateToStr(dtpStartdate.Date)
            +', 承包结束日期:'+DateToStr(dtpEnddate.Date);
        end;
        SysLog.WriteLog('承包者档案管理', operationtype, log);
        log:='';
        operationtype:='';
        id := Params.ParamByName('contractorid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('承包者档案添加失败：' + E.Message);
      end;
    end;
  end;


end;

function TfrmContractorEdt.checkInput(var msg: String): boolean;
begin
   result := False;
  if Trim(nvedtName.Text) ='' then
  begin
    msg := '姓名不能为空！';
    nvedtName.SetFocus;
    exit;
  end;
  if trim(nvedtIDcard.Text)='' then
  begin
    msg := '身份证号不能为空！';
    nvedtIDcard.SetFocus;
    exit;
  end;
  if not (ValidatePID(nvedtIDcard.Text) ='') then
    begin
      msg := ValidatePID(nvedtIDcard.Text);
      nvedtIDcard.SetFocus;
      exit;
    end;

  if trim(nvedtContactphone.Text) = '' then
  begin
    msg := '联系人电话！';
    nvedtContactphone.SetFocus;
    exit;
  end;
   if ((Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id<=0) then
  begin
    msg := '请输入承包车辆！';
    nvhelpVehicle.SetFocus;
    exit;
  end;
   if nvedtContractno.Text = ''then
  begin
    msg := '请输入承包合同编号！';
    nvedtContractno.SetFocus;
    exit;
  end;
   result := True;
end;
procedure TfrmContractorEdt.FormCreate(Sender: TObject);
begin
  inherited;
  nvhcbbOrg.Active := False;
  nvhcbbOrg.Active := True;
  dtpStartdate.Date :=Now;
  dtpEnddate.Date := Now;
end;

end.
