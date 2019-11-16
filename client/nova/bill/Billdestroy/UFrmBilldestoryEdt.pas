unit UFrmBilldestoryEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet;

type
  TFrmBilldestoryEdt = class(TSimpleEditForm)
    lbllbcode: TLabel;
    cbbbilltype: TNovaHComboBox;        //Ʊ������
    NovaHBilldestoryer: TNovaHelp;     //��Ʊ��
    Label1: TLabel;
    neprice: TNovaEdit;      //���
    DpDESTROYDATE: TDateTimePicker;  //����
    lbl6: TLabel;
    jscd: TjsonClientDataSet;
    Label2: TLabel;
    Label3: TLabel;
    NovaCbbOrg: TNovaHComboBox;   //����

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
    SysDialogs.ShowMessage('��Ʊ�˲�����Ϊ�գ�');
    NovaHBilldestoryer.SetFocus;
    exit;
  end;

  if (NovaCbbOrg.Text='') then
  begin
     SysDialogs.ShowMessage('����������Ϊ�գ�');
     NovaCbbOrg.SetFocus;
     exit;
  end;

  if (cbbbilltype.Text='') then
  begin
     SysDialogs.ShowMessage('Ʊ�����Ͳ�����Ϊ�գ�');
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
        SysLog.WriteErr('��Ʊ��Ϣ���ʧ�ܣ�' + E.Message);
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
