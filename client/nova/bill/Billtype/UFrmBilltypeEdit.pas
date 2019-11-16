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
    SysDialogs.ShowMessage('票据的每本张数不得小于1张，请重新输入!');
    edtnumperbox.SetFocus;
    Exit;
  end;
  if edtcode.Text='' then
    begin
      SysDialogs.ShowMessage('票据类型编码不能为空');
      edtcode.SetFocus;
       exit;
    end;
    if edtname.Text='' then
    begin
      SysDialogs.ShowMessage('票据名称不能为空');
      edtname.SetFocus;
       exit;
    end;
     if cbbmedium.ItemIndex<0 then
    begin
      SysDialogs.ShowMessage('请选择介质');
      cbbmedium.SetFocus;
       exit;
    end;
     if edtprintname.Text='' then
    begin
      SysDialogs.ShowMessage('打印名称不能为空');
      edtprintname.SetFocus;
       exit;
    end;
     if edtparvalue.Text='' then
    begin
      SysDialogs.ShowMessage('票面价值不能为空');
      edtparvalue.SetFocus;
       exit;
    end;
     if edtnumperbox.Text='' then
    begin
      SysDialogs.ShowMessage('每本票据数不能为空');
      edtnumperbox.SetFocus;
       exit;
    end;
     if edtticketnolength.Text='' then
    begin
      SysDialogs.ShowMessage('票号长度不能为空');
      edtticketnolength.SetFocus;
       exit;
    end ;
    if StrToInt(edtticketnolength.Text)>20 then
    begin
      SysDialogs.ShowMessage('票号长度不能大于20');
      edtticketnolength.SetFocus;
       exit;
    end;
    if StrToInt(edtticketnolength.Text)=0 then
    begin
      SysDialogs.ShowMessage('票号长度不能为0');
      edtticketnolength.SetFocus;
      exit;
    end;
    if StrToInt(edtticketnolength.Text)< length(trim(edtnumperbox.Text)) then
    begin
      SysDialogs.ShowMessage('票号长度应大于每本张数的位数');
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
          log := '修改票据类型：编码='+edtcode.Text+',类型='+cbbmedium.Text+',名称='
          +edtname.Text+',打印名称='+edtprintname.Text+',票面价值='+edtparvalue.Text+
          ',每本张数='+edtnumperbox.Text+',票号长度='+edtticketnolength.Text+',描述='+
          mmodes.Text;
          SysLog.WriteLog('票据类型——>票据类型','修改',log);
        end else
        begin
          log := '添加票据类型：编码='+edtcode.Text+',类型='+cbbmedium.Text+',名称='
          +edtname.Text+',打印名称='+edtprintname.Text+',票面价值='+edtparvalue.Text+
          ',每本张数='+edtnumperbox.Text+',票号长度='+edtticketnolength.Text+',描述='+
          mmodes.Text;
          SysLog.WriteLog('票据类型——>票据类型','添加',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据类型增加失败：' + E.Message);
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
