unit UFrmRouteroadAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet, NovaComboBox,Services,UDMPublic, ImgList;

type
  TFrmRouteroadAdd = class(TSimpleEditForm)
    lblname: TLabel;
    lblentrancename: TLabel;
    lblexitname: TLabel;
    lbldistance: TLabel;
    lblroutegrade: TLabel;
    nvedtname: TNovaEdit;
    nvedtentrancename: TNovaEdit;
    nvedtexitname: TNovaEdit;
    nvedtdistance: TNovaEdit;
    nvcbbroutegrade: TNovaComboBox;
    jcdsrouteroad: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    id:string;
    routeid:String;
    orderno:String;
    createby:String;
    createtime:String;
    updateby:string;
    updatetime:string;
    property operationid:Integer read Foperationid;
  end;

var
  FrmRouteroadAdd: TFrmRouteroadAdd;

implementation

{$R *.dfm}

procedure TFrmRouteroadAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if Trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowMessage('公路名称不能为空!');
    nvedtname.SetFocus;
    exit;
  end;
  if Trim(nvedtdistance.Text)='' then
  begin
    SysDialogs.ShowMessage('里程不能为空!');
    nvedtdistance.SetFocus;
    exit;
  end;
  if nvcbbroutegrade.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('公路等级不能为空!');
    nvcbbroutegrade.SetFocus;
    exit;
  end;
  with jcdsrouteroad do
  begin
    if self.edittype=TEdittype.update then
    begin
      Params.ParamValues['routeroad.id']:=id;
      Params.ParamValues['routeroad.createby']:=createby;
      Params.ParamValues['routeroad.createtime']:=createtime;
      Params.ParamValues['routeroad.updateby']:=updateby;
      Params.ParamValues['routeroad.updatetime']:=updatetime;
      Params.ParamValues['routeroad.orderno']:=orderno;
      Params.ParamValues['routeroad.opertype']:=4;
    end
    else
    begin
//      Params.ParamValues['routeroad.id']:=null;
//      Params.ParamValues['routeroad.createby']:=null;
//      Params.ParamValues['routeroad.createtime']:=null;
//      Params.ParamValues['routeroad.updateby']:=null;
//      Params.ParamValues['routeroad.updatetime']:=null;
//      Params.ParamValues['routeroad.orderno']:=null;
      Params.ParamValues['routeroad.opertype']:=8;
    end;
    Params.ParamValues['routeroad.entrancename']:=trim(nvedtentrancename.Text);
    Params.ParamValues['routeroad.exitname']:=trim(nvedtexitname.Text);
    Params.ParamValues['routeroad.name']:=trim(nvedtname.Text);
    Params.ParamValues['routeroad.roadgrade']:=nvcbbroutegrade.GetSelectCode;
    Params.ParamValues['routeroad.distance']:=trim(nvedtdistance.Text);
    Params.ParamValues['routeroad.route.id']:=routeid;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;
    Foperationid:=Params.ParamValues['routeroadid'];
  end;
end;

procedure TFrmRouteroadAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
//  Action
end;

procedure TFrmRouteroadAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbroutegrade.Active:=true;
end;

end.
