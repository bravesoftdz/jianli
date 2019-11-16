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
    printValue: TDictionary<String, String>; // ���������
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
       optype :='�޸��ۺ��շ���Ϣ';
      log := SysInfo.LoginUserInfo.OrgName+'���û�:'+SysInfo.LoginUserInfo.UserName
            +'�޸���������Ϣ:';
      if customer <> trim(edtCostomer.Text) then
      begin
       log := log +'��[�ͻ���] �� '''+ customer+''' �ĳ� '''+ edtCostomer.Text+''',';
      end;
      if feetype <> trim(nvtype.Text) then
      begin
       log := log + ' �� [����] �� '''+feetype +''' �ĳ� '''+nvtype.Text+''','
      end;
      if fee <> trim(nvedtfee.Text) then
      begin
        log := log + '�� [���] �� '''+fee +''' �ĳ� '''+nvedtfee.Text+''','
      end;
       if operatorname <> trim(nvhelpUserid.Text) then
      begin
       log := log +'��[����Ա] �� '''+ operatorname+''' �ĳ� '''+ nvhelpUserid.Text+''',';
      end;
       if remarks <> trim(nvedtRemarks.Text) then
      begin
        log := log + '�� [��ע] �� '''+remarks +''' �ĳ� '''+nvedtRemarks.Text+''','
      end;

    end
    else
    begin
      Params.ParamValues['complexfee.orgid']:=SysInfo.LoginUserInfo.OrgID;
//      Params.ParamValues['complexfee.orgid']:=SysInfo.LoginUserInfo.OrgID;
      Params.ParamByName('complexfee.updateby').Value := SysInfo.LoginUserInfo.UserID;
      Params.ParamByName('complexfee.updatetime').Value := updatetime;
      optype :='����ۺ��շ���Ϣ';
      log := SysInfo.LoginUserInfo.OrgName+'���û�:'+SysInfo.LoginUserInfo.UserName
            +'��[��ӡʱ��]:'+formatdatetime('yyyy-mm-dd',now)
            +'�����������У�[����Ա]:'+nvhelpUserid.Text
            +'��[�ͻ���]:'+edtCostomer.Text
            +'��[����]:'+nvtype.Text
            +'��[���]:'+nvedtfee.Text
            +'��[��ע]'+nvedtRemarks.Text
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
          templtename := TNovaPrint.GetTicketModelName('�ۺ��շ���Ϣ', '�ۺ��շ���Ϣ');
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
        SysLog.WriteLog('�������->�ۺ��շ���Ϣ����', optype, log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�ۺ��շ���Ϣ����ʧ�ܣ�' + E.Message);
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
    msg := '����д�ͻ�����';
    edtCostomer.SetFocus;
    exit;
  end;
  if trim(nvtype.Text) =''then
  begin
      msg := '����д����!';
      nvtype.SetFocus;
      exit;
  end;
  if trim(nvedtfee.Text)='' then
  begin
      msg := '����д���!';
      nvedtfee.SetFocus;
      exit;
  end;
  if (trim(nvhelpUserid.Text)='') or (nvhelpUserid.Id <=0) then
  begin
      msg := '���������Ա!';
      nvhelpUserid.SetFocus;
      exit;
  end;
    result := True;
end;



end.
