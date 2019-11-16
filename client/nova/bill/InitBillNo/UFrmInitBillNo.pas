unit UFrmInitBillNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls,Services, DB,
  DBClient, jsonClientDataSet,UDMPublic,PubFn, ImgList;

type
  TFrmInitBillNo = class(TSimpleEditForm)
    nvedtbillNo: TNovaEdit;
    nvedtBillNoRepeat: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    jcdscurbillinuse: TjsonClientDataSet;
    jsoncdsbilltype: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function initbillno(auto:boolean):boolean;
  public
    { Public declarations }
    billCode:String;
  end;

var
  FrmInitBillNo: TFrmInitBillNo;

implementation

{$R *.dfm}

procedure TFrmInitBillNo.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(nvedtbillNo.Text)='' then
  begin
    SysDialogs.ShowInfo('������Ʊ��');
    nvedtbillNo.SetFocus;
    exit;
  end;
  if trim(nvedtBillNoRepeat.Text)='' then
  begin
    SysDialogs.ShowInfo('���ظ�����Ʊ��');
    nvedtBillNoRepeat.SetFocus;
    exit;
  end;
  if not SameText(trim(nvedtbillNo.Text),Trim(nvedtBillNoRepeat.Text)) then
  begin
    SysDialogs.ShowError('���������Ʊ�Ų�һ��');
    nvedtbillNo.SetFocus;
    exit;
  end;
  initbillno(false);
end;

procedure TFrmInitBillNo.FormShow(Sender: TObject);
begin
  inherited;
  with jsoncdsbilltype do
  begin
    active:=false;
    Params.ParamValues['filter_EQS_b!code']:=billCode;
    active:=true;
    if recordcount=1 then
    begin
      self.Caption:='����'+FieldByName('name').AsWideString
    end
    else
    begin
      SysDialogs.ShowError('�����Ʊ�����ͱ�������');
      self.Close;
    end;
  end;
  if PubFn.getParametervalue('1005',sysinfo.LoginUserInfo.OrgID)='1' then
  begin
    initbillno(true);
  end;
end;

function TFrmInitBillNo.initbillno(auto: boolean): boolean;
begin
  with jcdscurbillinuse do
  begin
    Params.ParamValues['billtypecode']:=billCode;
    if auto then
      Params.ParamValues['billinuse.nextno']:='-1'
    else
      Params.ParamValues['billinuse.nextno']:=trim(nvedtbillNo.Text);
    Execute;
    if Params.ParamValues['flag']=1 then
    begin
      //���浽��������
      sysinfo.LoginUserInfo.curBillNo.AddOrSetValue(billCode,zerofill(Params.ParamValues['curbillno'],Params.ParamValues['billlength']));
      sysinfo.LoginUserInfo.curBillNum.AddOrSetValue(billCode,Params.ParamValues['curbillnum']);
      self.Close;
    end
    else
    begin
      if auto then
      begin
        if (not Params.ParamByName('curbillno').IsNull) and (Params.ParamByName('curbillno').AsLargeInt>0) then
        begin
          nvedtbillNo.Text:=zerofill(Params.ParamValues['curbillno'],Params.ParamValues['billlength']);
          nvedtBillNoRepeat.Text:=nvedtbillNo.Text;
        end;
      end
      else
      begin
        SysDialogs.Warning(Params.ParamValues['msg']);
      end;
      nvedtbillNo.SetFocus;
      exit;
    end;
  end;
end;

end.
