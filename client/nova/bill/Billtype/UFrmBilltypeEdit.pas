unit UFrmBilltypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Services, Buttons, ExtCtrls, NovaEdit,USimpleEditForm, Mask, DB,
  DBClient, jsonClientDataSet, NovaComboBox, ImgList;

type
  TFrmBilltypeEdit = class(TSimpleEditForm)
    lbllbcode: TLabel;
    lblname: TLabel;
    edtcode: TNovaEdit;
    edtname: TNovaEdit;
    lbl8: TLabel;
    lbl1: TLabel;
    jsonBilltypeSave: TjsonClientDataSet;
    lblparvalue: TLabel;
    lblnumperbox: TLabel;
    lblticketnolength: TLabel;
    edtparvalue: TNovaEdit;
    edtnumperbox: TNovaEdit;
    edtticketnolength: TNovaEdit;
    mmodes: TMemo;
    lbldes: TLabel;
    lbl7: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lblmedium: TLabel;
    lblpringname: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    edtprintname: TNovaEdit;
    cbbmedium: TNovaComboBox;
    lbl2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
     public
    id,createby:Int64;
    createtime:String;
    isactive:Boolean;
  end;

var
  FrmBilltypeEdit: TFrmBilltypeEdit;

implementation

 uses PubFn;
{$R *.dfm}

procedure TFrmBilltypeEdit.bbtnSaveClick(Sender: TObject);
  var nResult: integer;
  sResult:string;
begin
  inherited;
  if StrToInt(edtnumperbox.Text) = 0 then
  begin
    SysDialogs.ShowMessage('Ʊ�ݵ�ÿ����������С��1�ţ�����������!');
    edtnumperbox.SetFocus;
    Exit;
  end;
  if edtcode.Text='' then
    begin
      SysDialogs.ShowMessage('Ʊ�����ͱ��벻��Ϊ��');
      edtcode.SetFocus;
       exit;
    end;
    if edtname.Text='' then
    begin
      SysDialogs.ShowMessage('Ʊ�����Ʋ���Ϊ��');
      edtname.SetFocus;
       exit;
    end;
     if cbbmedium.ItemIndex<0 then
    begin
      SysDialogs.ShowMessage('��ѡ�����');
      cbbmedium.SetFocus;
       exit;
    end;
     if edtprintname.Text='' then
    begin
      SysDialogs.ShowMessage('��ӡ���Ʋ���Ϊ��');
      edtprintname.SetFocus;
       exit;
    end;
     if edtparvalue.Text='' then
    begin
      SysDialogs.ShowMessage('Ʊ���ֵ����Ϊ��');
      edtparvalue.SetFocus;
       exit;
    end;
     if edtnumperbox.Text='' then
    begin
      SysDialogs.ShowMessage('ÿ��Ʊ��������Ϊ��');
      edtnumperbox.SetFocus;
       exit;
    end;
     if edtticketnolength.Text='' then
    begin
      SysDialogs.ShowMessage('Ʊ�ų��Ȳ���Ϊ��');
      edtticketnolength.SetFocus;
       exit;
    end ;
    if StrToInt(edtticketnolength.Text)>20 then
    begin
      SysDialogs.ShowMessage('Ʊ�ų��Ȳ��ܴ���20');
      edtticketnolength.SetFocus;
       exit;
    end;
    if StrToInt(edtticketnolength.Text)=0 then
    begin
      SysDialogs.ShowMessage('Ʊ�ų��Ȳ���Ϊ0');
      edtticketnolength.SetFocus;
      exit;
    end;
    if StrToInt(edtticketnolength.Text)< length(trim(edtnumperbox.Text)) then
    begin
      SysDialogs.ShowMessage('Ʊ�ų���Ӧ����ÿ��������λ��');
      edtticketnolength.SetFocus;
      exit;
    end;


 with jsonBilltypeSave do
  begin

   Params.ParamByName('billtype.id').Value :=id ;
   Params.ParamByName('billtype.code').Value :=edtcode.Text ;
   Params.ParamByName('billtype.name').Value :=edtname.Text ;
   Params.ParamByName('billtype.printname').Value :=edtprintname.Text ;
   Params.ParamByName('billtype.parvalue').Value :=edtparvalue.Text ;
   Params.ParamByName('billtype.description').Value :=mmodes.Text ;
   Params.ParamByName('billtype.numperbox').Value :=edtnumperbox.Text ;
   Params.ParamByName('billtype.ticketnolength').Value :=edtticketnolength.Text ;
   Params.ParamByName('billtype.medium').Value :=cbbmedium.GetSelectCode;
   Params.ParamByName('billtype.createby').Value :=  createby;
   Params.ParamByName('billtype.createtime').Value :=  createtime;
   Params.ParamByName('billtype.isactive').Value :=  isactive;

   try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
       SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtname.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '�޸�Ʊ�����ͣ�����='+edtcode.Text+',����='+cbbmedium.Text+',����='
          +edtname.Text+',��ӡ����='+edtprintname.Text+',Ʊ���ֵ='+edtparvalue.Text+
          ',ÿ������='+edtnumperbox.Text+',Ʊ�ų���='+edtticketnolength.Text+',����='+
          mmodes.Text;
          SysLog.WriteLog('Ʊ�����͡���>Ʊ������','�޸�',log);
        end else
        begin
          log := '���Ʊ�����ͣ�����='+edtcode.Text+',����='+cbbmedium.Text+',����='
          +edtname.Text+',��ӡ����='+edtprintname.Text+',Ʊ���ֵ='+edtparvalue.Text+
          ',ÿ������='+edtnumperbox.Text+',Ʊ�ų���='+edtticketnolength.Text+',����='+
          mmodes.Text;
          SysLog.WriteLog('Ʊ�����͡���>Ʊ������','���',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ʊ����������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmBilltypeEdit.FormCreate(Sender: TObject);
begin
  inherited;
  isactive:=True;

 cbbmedium.Active:=false;
  cbbmedium.Active:=true;
end;

end.
