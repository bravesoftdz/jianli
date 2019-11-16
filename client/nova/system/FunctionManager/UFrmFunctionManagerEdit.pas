unit UFrmFunctionManagerEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet,UDMPublic, NovaEdit, ImgList;

type
  TFrmFunctionManagerEdit = class(TSimpleEditForm)
    lblname: TLabel;
    lblkey: TLabel;
    lbldescribe: TLabel;
    lblparamdescribe: TLabel;
    mmodescribe: TMemo;
    mmoParamdescribe: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    jcdsFunctionSave: TjsonClientDataSet;
    nvedtname: TNovaEdit;
    nvedtkey: TNovaEdit;
    lbl9: TLabel;
    lblpackagename: TLabel;
    btnpackagename: TButton;
    lbl3: TLabel;
    fopdlgpackage: TFileOpenDialog;
    dlgOpenPackage: TOpenDialog;
    procedure bbtnSaveClick(Sender: TObject);
    procedure btnpackagenameClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    operationid:int64;
    createtime,createby,updatetime,updateby:String;
  end;

var
  FrmFunctionManagerEdit: TFrmFunctionManagerEdit;

implementation
uses services;

{$R *.dfm}

procedure TFrmFunctionManagerEdit.bbtnSaveClick(Sender: TObject);
var result : String;
begin
  inherited;
  if Trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowMessage('�������Ʋ���Ϊ��!');
    nvedtname.SetFocus;
    exit;
  end;
  if Trim(lblpackagename.Caption)='' then
  begin
    SysDialogs.ShowMessage('��������Ϊ��!');
    btnpackagename.SetFocus;
    exit;
  end;
  if Trim(nvedtkey.Text)='' then
  begin
    SysDialogs.ShowMessage('����GUID����Ϊ��!');
    nvedtkey.SetFocus;
    exit;
  end;
  try
    StringToGUID(Trim(nvedtkey.Text));
  except
    SysDialogs.ShowMessage('����GUID����ȷ!');
    nvedtkey.SetFocus;
    exit;
  end;
  with jcdsFunctionSave do
  begin
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['functionreg.id']:=operationid;
      Params.ParamValues['functionreg.createtime']:=createtime;
      Params.ParamValues['functionreg.createby']:=createby;
      Params.ParamValues['functionreg.updatetime']:=updatetime;
      Params.ParamValues['functionreg.updateby']:=updateby;
    end;
    Params.ParamValues['functionreg.packagename']:=lblpackagename.Caption;
    Params.ParamValues['functionreg.name']:=Trim(nvedtname.Text);
    Params.ParamValues['functionreg.functionkey']:=trim(nvedtkey.Text);
    Params.ParamValues['functionreg.functiondescribe']:=mmodescribe.Text;
    Params.ParamValues['functionreg.parameterdescribe']:=mmoParamdescribe.Text;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      if operationid > 0then
        result := '�޸�'
      else
        result := '���';
      log := result + '���ܹ�����������='+nvedtname.Text+',����='+
      lblpackagename.Caption+',GUID='+nvedtkey.Text+',��������='+mmodescribe.Text+
      ',��������='+mmoParamdescribe.Text;
      SysLog.WriteLog('ϵͳ����->���ܹ���',result,log);
      self.ModalResult:=mrOk;
    end;
    operationid:=Params.ParamValues['functionregid'];
  end;
end;

procedure TFrmFunctionManagerEdit.btnpackagenameClick(Sender: TObject);
begin
  inherited;
//  if fopdlgpackage.Execute(Self.Handle) then
//  begin
//    lblpackagename.Caption:=ExtractRelativePath(
//                            ExtractFilePath(Application.ExeName),
//                            fopdlgpackage.FileName);
//  end;
  if dlgOpenPackage.Execute(Self.Handle) then
  begin
    lblpackagename.Caption:=ExtractRelativePath(
                            ExtractFilePath(Application.ExeName),
                            dlgOpenPackage.FileName);
  end;
end;

procedure TFrmFunctionManagerEdit.FormShow(Sender: TObject);
begin
  inherited;
  if trim(lblpackagename.Caption)='' then
  begin
//    fopdlgpackage.DefaultFolder:=ExtractFilePath(Application.ExeName);
    dlgOpenPackage.InitialDir:=ExtractFilePath(Application.ExeName);
  end
  else
  begin
    ExtractFilePath(lblpackagename.Caption);
  end;
end;

end.
