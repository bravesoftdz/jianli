unit UFrmMenuAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet,UDMPublic, ImgList;

type
  TFrmMenuAdd = class(TSimpleEditForm)
    lblparentmenu: TLabel;
    lbltype: TLabel;
    lblfunction: TLabel;
    lblparam: TLabel;
    Label1: TLabel;
    rbfolder: TRadioButton;
    rbfunction: TRadioButton;
    nvhelpfunction: TNovaHelp;
    Label2: TLabel;
    lblfunctiondescribe: TLabel;
    mmofunctiondescribe: TMemo;
    nvedtname: TNovaEdit;
    nvedtparam: TNovaEdit;
    lblparameterdescribe: TLabel;
    mmoparameterdescribe: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
    procedure rbfunctionClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvhelpfunctionIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    operationid,parentid:int64;
    createtime,createby,updatetime,updateby:String;
    grade:integer;
    orderno:Single;
  end;

var
  FrmMenuAdd: TFrmMenuAdd;

implementation
uses services, UFrmMenus;

{$R *.dfm}

procedure TFrmMenuAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowInfo('请输入菜单名称！');
    nvedtname.SetFocus;
    exit;
  end;
  if (not rbfolder.Checked) and (not rbfunction.Checked) then
  begin
    SysDialogs.ShowInfo('请选择菜单类型！');
    rbfolder.SetFocus;
    exit;
  end;
  if rbfunction.Checked and (nvhelpfunction.Id<=0) then
  begin
    SysDialogs.ShowInfo('请选择功能！');
    nvhelpfunction.SetFocus;
    exit;
  end;
  with FrmMenus.jcdsMenuSave do
  begin
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['menu.id']:=operationid;
      Params.ParamValues['menu.createtime']:=createtime;
      Params.ParamValues['menu.createby']:=createby;
//      Params.ParamValues['menu.updatetime']:=updatetime;
//      Params.ParamValues['menu.updateby']:=updateby;
    end
    else
    begin
      Params.ParamValues['menu.id']:=0;
      createtime:=FormatDateTime('yyyy-mm-dd hh:nn:ss',now);
      createby:=inttostr(SysInfo.LoginUserInfo.UserID);
    end;
    if rbfunction.Checked then
    begin
      Params.ParamValues['menu.functionregid']:=nvhelpfunction.id;
    end
    else
    begin
      Params.ParamValues['menu.functionregid']:=null;
    end;
    Params.ParamValues['menu.name']:=Trim(nvedtname.Text);
    Params.ParamValues['menu.parentid']:=parentid;
    Params.ParamValues['menu.parameter']:=nvedtparam.Text;
    Params.ParamValues['menu.grade']:=grade;
    Params.ParamValues['menu.orderno']:=orderno;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;
    operationid:=Params.ParamValues['menuid'];
  end;
end;

procedure TFrmMenuAdd.FormCreate(Sender: TObject);
begin
  inherited;
  if rbfunction.Checked then
  begin
    rbfunction.Checked:=true;
  end
  else
  begin
    rbfunctionClick(rbfunction);
  end;
end;

procedure TFrmMenuAdd.FormShow(Sender: TObject);
begin
  inherited;
  nvedtname.SetFocus;
end;

procedure TFrmMenuAdd.nvhelpfunctionIdChange(Sender: TObject);
begin
  inherited;
  if nvhelpfunction.Id>0 then
  begin
    if nvhelpfunction.isactive then
    begin
      if nvhelpfunction.HelpFieldValue['functiondescribe']=null then
        mmofunctiondescribe.Text:=''
      else
        mmofunctiondescribe.Text:=nvhelpfunction.HelpFieldValue['functiondescribe'];
      if nvhelpfunction.HelpFieldValue['parameterdescribe']=null then
        mmoparameterdescribe.Text:=''
      else
        mmoparameterdescribe.Text:=nvhelpfunction.HelpFieldValue['parameterdescribe'];
    end;
  end
  else
  begin
    mmofunctiondescribe.Text:='';
    mmoparameterdescribe.Text:='';
  end;
end;

procedure TFrmMenuAdd.rbfunctionClick(Sender: TObject);
begin
  inherited;
  if Sender=rbfunction then
  begin
    nvhelpfunction.Enabled:=true;
    nvedtparam.Enabled:=true;
  end
  else if Sender=rbfolder then
  begin
    nvhelpfunction.Enabled:=false;
    nvedtparam.Enabled:=false;
  end;
end;

end.
