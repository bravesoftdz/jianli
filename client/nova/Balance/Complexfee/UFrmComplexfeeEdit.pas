unit UFrmComplexfeeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls, NovaEdit,
  Buttons, ExtCtrls, ImgList, NovaComboBox, NovaHComboBox,
  NovaHelp , Generics.Collections, NovaPrint ;

type
  TFrmComplexfeeEdit = class(TSimpleEditForm)
    nvedtfee: TNovaEdit;
    jcdsComplexfeeSave: TjsonClientDataSet;
    Label6: TLabel;
    Label7: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtCostomer: TNovaEdit;
    nvtype: TNovaEdit;
    BitBtn1: TBitBtn;
    nvedtRemarks: TNovaEdit;
    Label4: TLabel;
    nvhelpUserid: TNovaHelp;
    lbl6: TLabel;
    Label5: TLabel;
    BitBtnSave: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure BitBtnSaveClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // 输出单变量
    function checkinput(var msg: String):boolean;
  public
    { Public declarations }
    id,orgid,operatorid:Integer;
    createtime,feetype,fee,customer,remarks, templtename:string;
    createby,operatorname:string;
    updatetime,printtime:string;
    isprint :boolean;
  end;

var
  FrmComplexfeeEdit: TFrmComplexfeeEdit;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}



procedure TFrmComplexfeeEdit.BitBtn1Click(Sender: TObject);
begin
  inherited;
  isprint := True ;
  BitBtnSaveClick(Sender);
end;

procedure TFrmComplexfeeEdit.BitBtnSaveClick(Sender: TObject);
  var
  nResult: integer;
  sResult,log,optype,msg: string;
begin
   if (not checkinput(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  with jcdsComplexfeeSave do
  begin
    Close;
    Params.ParamValues['complexfee.customer']:= edtCostomer.Text;
    Params.ParamValues['complexfee.feetype']:= nvtype.Text;
    Params.ParamValues['complexfee.fee']:= nvedtfee.Text;
    Params.ParamValues['complexfee.printtime']:=printtime;
    Params.ParamValues['complexfee.remarks']:=nvedtRemarks.Text;
    Params.ParamValues['complexfee.operator']:=nvhelpUserid.id;
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['complexfee.orgid']:=orgid;
      Params.ParamValues['complexfee.id']:=id;
      Params.ParamByName('complexfee.createby').Value := createby;
      Params.ParamByName('complexfee.createtime').Value := createtime;
       optype :='修改综合收费信息';
      log := SysInfo.LoginUserInfo.OrgName+'的用户:'+SysInfo.LoginUserInfo.UserName
            +'修改了以下信息:';
      if customer <> trim(edtCostomer.Text) then
      begin
       log := log +'将[客户名] 由 '''+ customer+''' 改成 '''+ edtCostomer.Text+''',';
      end;
      if feetype <> trim(nvtype.Text) then
      begin
       log := log + ' 将 [类型] 由 '''+feetype +''' 改成 '''+nvtype.Text+''','
      end;
      if fee <> trim(nvedtfee.Text) then
      begin
        log := log + '将 [金额] 由 '''+fee +''' 改成 '''+nvedtfee.Text+''','
      end;
       if operatorname <> trim(nvhelpUserid.Text) then
      begin
       log := log +'将[操作员] 由 '''+ operatorname+''' 改成 '''+ nvhelpUserid.Text+''',';
      end;
       if remarks <> trim(nvedtRemarks.Text) then
      begin
        log := log + '将 [备注] 由 '''+remarks +''' 改成 '''+nvedtRemarks.Text+''','
      end;

    end
    else
    begin
      Params.ParamValues['complexfee.orgid']:=SysInfo.LoginUserInfo.OrgID;
//      Params.ParamValues['complexfee.orgid']:=SysInfo.LoginUserInfo.OrgID;
      Params.ParamByName('complexfee.updateby').Value := SysInfo.LoginUserInfo.UserID;
      Params.ParamByName('complexfee.updatetime').Value := updatetime;
      optype :='添加综合收费信息';
      log := SysInfo.LoginUserInfo.OrgName+'的用户:'+SysInfo.LoginUserInfo.UserName
            +'，[打印时间]:'+formatdatetime('yyyy-mm-dd',now)
            +'，操作内容有：[操作员]:'+nvhelpUserid.Text
            +'，[客户名]:'+edtCostomer.Text
            +'，[类型]:'+nvtype.Text
            +'，[金额]:'+nvedtfee.Text
            +'，[备注]'+nvedtRemarks.Text
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <> 1) then
      begin
        edtCostomer.SetFocus;
      end
      else
      begin
       if isprint then
       begin
          templtename := TNovaPrint.GetTicketModelName('综合收费信息', '综合收费信息');
          if not Assigned(billPrint) then
            billPrint := TNovaPrint.Create(self, templtename);
          if not Assigned(printValue) then
            printValue := TDictionary<String, String>.Create
          else
              printValue.Clear;
          printValue.Add('orgname',SysInfo.LoginUserInfo.OrgName);
          printValue.Add('customer',edtCostomer.Text);
          printValue.Add('feetype', nvtype.Text);
          printValue.Add('fee', nvedtfee.Text);
          printValue.Add('operator', nvhelpUserid.Text);
          printValue.Add('printtime', formatdatetime('yyyy-mm-dd',now));
          printValue.Add('remarks', nvedtRemarks.Text);
          billPrint.SingleValue := printValue;
          billPrint.Print;
       end;

        id := Params.ParamByName('id').Value;
        SysLog.WriteLog('结算管理->综合收费信息管理', optype, log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('综合收费信息设置失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmComplexfeeEdit.FormCreate(Sender: TObject);
begin
  inherited;
   nvhelpUserid.Text:=SysInfo.LoginUserInfo.UserName;
   nvhelpUserid.Id:=SysInfo.LoginUserInfo.UserID;
end;

function TFrmComplexfeeEdit.checkinput(var msg: String):boolean;
begin
  result := False;
  if trim(edtCostomer.Text)='' then
  begin
    msg := '请填写客户名！';
    edtCostomer.SetFocus;
    exit;
  end;
  if trim(nvtype.Text) =''then
  begin
      msg := '请填写类型!';
      nvtype.SetFocus;
      exit;
  end;
  if trim(nvedtfee.Text)='' then
  begin
      msg := '请填写金额!';
      nvedtfee.SetFocus;
      exit;
  end;
  if (trim(nvhelpUserid.Text)='') or (nvhelpUserid.Id <=0) then
  begin
      msg := '请输入操作员!';
      nvhelpUserid.SetFocus;
      exit;
  end;
    result := True;
end;



end.
