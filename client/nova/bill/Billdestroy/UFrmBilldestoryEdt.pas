unit UFrmBilldestoryEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet;

type
  TFrmBilldestoryEdt = class(TSimpleEditForm)
    lbllbcode: TLabel;
    cbbbilltype: TNovaHComboBox;        //票据类型
    NovaHBilldestoryer: TNovaHelp;     //废票人
    Label1: TLabel;
    neprice: TNovaEdit;      //金额
    DpDESTROYDATE: TDateTimePicker;  //日期
    lbl6: TLabel;
    jscd: TjsonClientDataSet;
    Label2: TLabel;
    Label3: TLabel;
    NovaCbbOrg: TNovaHComboBox;   //机构

    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag,isedt:boolean;
    id:integer;
    createtime,createby,orgname, billtypename, destroyername : string;
  end;

var
  FrmBilldestoryEdt: TFrmBilldestoryEdt;

implementation

uses UDMPublic, PubFn, Services;
{$R *.dfm}

procedure TFrmBilldestoryEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (NovaHBilldestoryer.Id<=0) or (NovaHBilldestoryer.Text='') then
  begin
    SysDialogs.ShowMessage('废票人不允许为空！');
    NovaHBilldestoryer.SetFocus;
    exit;
  end;

  if (NovaCbbOrg.Text='') then
  begin
     SysDialogs.ShowMessage('机构不允许为空！');
     NovaCbbOrg.SetFocus;
     exit;
  end;

  if (cbbbilltype.Text='') then
  begin
     SysDialogs.ShowMessage('票据类型不允许为空！');
     cbbbilltype.SetFocus;
     exit;
  end;


  with jscd do
  begin
    active := false;
    Params.ParamByName('billdestroy.id').Value := id;
    Params.ParamByName('billdestroy.orgid').Value :=
      NovaCbbOrg.HelpFieldValue['id'];
    Params.ParamByName('billdestroy.billtypeid').Value :=
      cbbbilltype.HelpFieldValue['id'];
    Params.ParamByName('billdestroy.billdestroyer').Value :=
      NovaHBilldestoryer.Id;
    Params.ParamByName('billdestroy.destroydate').Value :=
      DpDESTROYDATE.DateTime;
    Params.ParamByName('billdestroy.destroyprice').Value := neprice.Text;
    Params.ParamByName('billdestroy.createtime').Value  := createtime;

    try
      Execute;
     // nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
       id := Params.ParamByName('id').Value;
      ModalResult := mrok;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('废票信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmBilldestoryEdt.FormCreate(Sender: TObject);

begin
  inherited;

  begin
  cbbbilltype.active := false;
  cbbbilltype.active := true;
  cbbbilltype.ItemIndex := 0;
  NovaCbbOrg.Active := false;
  NovaCbbOrg.Active := true;
  NovaCbbOrg.ItemIndex := 0;
  DpDESTROYDATE.DateTime := now;

  end;
end;

end.
