unit UFrmBillStorageEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Services, Buttons, ExtCtrls, NovaEdit,USimpleEditForm, Mask, DB,
  DBClient, jsonClientDataSet, NovaHComboBox, ImgList;

type
  TFrmBillStorageEdit = class(TSimpleEditForm)
    lbllbcode: TLabel;
    lblname: TLabel;
    lblorgid: TLabel;
    lblfunctionary: TLabel;
    edtcode: TNovaEdit;
    Label1: TLabel;
    jsonBillStorageSave: TjsonClientDataSet;
    lbl8: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtname: TNovaEdit;
    cbborgid: TNovaHComboBox;
    edtfunctionary: TNovaEdit;
    mmodes: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
     public
    id, orgid : Int64;
    createby, createtime:String;
    isactive:Boolean;
  end;

var
  FrmBillStorageEdit: TFrmBillStorageEdit;

implementation

 uses PubFn;
{$R *.dfm}

procedure TFrmBillStorageEdit.bbtnSaveClick(Sender: TObject);
  var nResult: integer;
  sResult:string;
begin
  inherited;
    if edtcode.Text='' then
    begin
      SysDialogs.ShowMessage('票库编码不能为空');
      edtcode.SetFocus;
      exit;
    end;
    if edtname.Text='' then
    begin
      SysDialogs.ShowMessage('票库名称不能为空');
      edtname.SetFocus;
       exit;
    end;
    if cbborgid.Text = '' then
    begin
      SysDialogs.ShowMessage('请选择机构');
      cbborgid.SetFocus;
      exit;
    end;

 with jsonBillStorageSave do
  begin
    if cbborgid.ItemIndex = -1 then
    begin
      orgid := orgid;
    end else
    begin
      orgid := cbborgid.HelpFieldValue['id'];
    end;
    Params.ParamByName('billstorage.orgid').Value := orgid;
    Params.ParamByName('billstorage.id').Value :=id ;
    Params.ParamByName('billstorage.code').Value :=edtcode.Text ;
    Params.ParamByName('billstorage.name').Value :=edtname.Text ;

    Params.ParamByName('billstorage.functionary').Value :=edtfunctionary.Text ;
    Params.ParamByName('billstorage.description').Value :=mmodes.Text ;
    Params.ParamByName('billstorage.createby').Value := createby;
    Params.ParamByName('billstorage.createtime').Value := createtime;
    Params.ParamByName('billstorage.isactive').Value :=  isactive;
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
          log := '修改票据库存：票据编码='+edtcode.Text+',票据名称='+edtname.Text+
          ',所属机构='+cbborgid.Text+',负责人='+edtfunctionary.Text+',描述='+mmodes.Text;
          SysLog.WriteLog('票据管理——>票据库存','修改',log);
        end else
        begin
          log := '添加票据库存：票据编码='+edtcode.Text+',票据名称='+edtname.Text+
          ',所属机构='+cbborgid.Text+',负责人='+edtfunctionary.Text+',描述='+mmodes.Text;
          SysLog.WriteLog('票据管理——>票据库存','添加',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票库增加失败：' + E.Message);
      end;
    end;
  // Params.ParamByName('station.isactive').Value :=id ;
  end

end;

procedure TFrmBillStorageEdit.FormCreate(Sender: TObject);
begin
  inherited;
  isactive:=True;
  cbborgid.Active:=false;
  cbborgid.Active:=True;
end;

end.
