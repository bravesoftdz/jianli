unit UFrmBillupmoneyEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Services, Buttons, ExtCtrls, NovaEdit,USimpleEditForm, Mask, DB,
  DBClient, NovaHComboBox, ImgList, jsonClientDataSet, NovaHelp, ComCtrls;

type
  TFrmBillupmoneyEdit = class(TSimpleEditForm)
    jsonBillupmoneySave: TjsonClientDataSet;
    cbbbilltypeid: TNovaHComboBox;
    lblbilltype: TLabel;
    lblupuser: TLabel;
    lblprice: TLabel;
    edtprice: TNovaEdit;
    lblupmoneydate: TLabel;
    Dateupmoney: TDateTimePicker;
    lbl8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nvhlpupuser: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
     public
      id,billtypeid,upuserid,orgid,createby : Int64;
      createtime:String;
  end;

var
  FrmBillupmoneyEdit: TFrmBillupmoneyEdit;

implementation

 uses PubFn;
{$R *.dfm}

procedure TFrmBillupmoneyEdit.bbtnSaveClick(Sender: TObject);
  var nResult: integer;
  sResult:string;
begin
  inherited;
  if cbbbilltypeid.Text = '' then
    begin
      SysDialogs.ShowMessage('��ѡ��Ʊ������');
      cbbbilltypeid.SetFocus;
      exit;
    end;
  if nvhlpupuser.Text='' then
    begin
      SysDialogs.ShowMessage('�ɿ��˲���Ϊ��');
      nvhlpupuser.SetFocus;
      exit;
    end;
    if edtprice.Text='' then
    begin
      SysDialogs.ShowMessage('�ɿ����Ϊ��');
      edtprice.SetFocus;
       exit;
    end;

    with jsonBillupmoneySave do
     begin
     if cbbbilltypeid.ItemIndex = -1 then
    begin
      billtypeid := billtypeid;
    end else
    begin
      billtypeid := cbbbilltypeid.HelpFieldValue['id'];
    end;
    if nvhlpupuser.id = 0 then
    begin
      upuserid := upuserid;
    end else
    begin
      upuserid := nvhlpupuser.id;
    end;
    Params.ParamByName('billupmoney.id').Value :=id ;
    Params.ParamByName('billupmoney.billtypeid').Value := billtypeid;
    Params.ParamByName('billupmoney.upuserid').Value := upuserid;
    Params.ParamByName('billupmoney.price').Value :=edtprice.Text ;
    Params.ParamByName('billupmoney.upmoneydate').Value := FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
    Params.ParamByName('billupmoney.orgid').Value := orgid;
    Params.ParamByName('billupmoney.createby').Value := createby;
    Params.ParamByName('billupmoney.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
       SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpupuser.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '�޸Ķ���Ʊ�ɿƱ������='+cbbbilltypeid.Text+',�ɿ���='+nvhlpupuser.Text+
          ',�ɿ���='+edtprice.Text+',�ɿ�����='+FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
          SysLog.WriteLog('Ʊ�ݹ�����>����Ʊ�ɿ�','�޸�',log);
        end else
        begin
          log := '��Ӷ���Ʊ�ɿƱ������='+cbbbilltypeid.Text+',�ɿ���='+nvhlpupuser.Text+
          ',�ɿ���='+edtprice.Text+',�ɿ�����='+FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
          SysLog.WriteLog('Ʊ�ݹ�����>����Ʊ�ɿ�','���',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����Ʊ�ɿ�����ʧ�ܣ�' + E.Message);
      end;


     end;

    end

end;

procedure TFrmBillupmoneyEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbbilltypeid.Active:=false;
  cbbbilltypeid.Active:=True;
  Dateupmoney.Date:=now;
end;

end.
