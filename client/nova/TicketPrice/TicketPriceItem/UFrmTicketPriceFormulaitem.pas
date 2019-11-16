unit UFrmTicketPriceFormulaitem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, ExtCtrls, NvPrnDbgeh, DB,
  DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, ToolWin, NovaEdit, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmTicketPriceFormulaitem = class(TSimpleCRUDForm)
    Panel2: TPanel;
    ImageList1: TImageList;
    GroupBox3: TGroupBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    TbtnAdd: TToolButton;
    ToolButton3: TToolButton;
    TbtnUpdate: TToolButton;
    ToolButton5: TToolButton;
    TbtnDel: TToolButton;
    NvgridAbout: TNvDbgridEh;
    Splitter1: TSplitter;
    DsTicketPriceItemAbout: TDataSource;
    jscdTicketPriceItemAbout: TjsonClientDataSet;
    Label1: TLabel;
    NovaEdtName: TNovaEdit;
    NovaEdtCode: TNovaEdit;
    Label2: TLabel;
    jcdsResultid: TLargeintField;
    jcdsResultorgid: TLargeintField;
    jcdsResultcode: TWideStringField;
    jcdsResultisticketpriceitem: TBooleanField;
    jcdsResultisautoadjust: TBooleanField;
    jcdsResultisdefault: TBooleanField;
    jcdsResultusername: TWideStringField;
    jcdsRelatetype: TjsonClientDataSet;
    jcdsResultname: TWideStringField;
    jcdsResultrelatetype: TWideStringField;
    jcdsResultrelatetypename: TWideStringField;
    jcdsDelTicketPriceItem: TjsonClientDataSet;
    jscdDelAboutVehclie: TjsonClientDataSet;
    jscdDelAboutRoute: TjsonClientDataSet;
    jscdDelAboutRouteStop: TjsonClientDataSet;
    jcdsDelDistanceAbout: TjsonClientDataSet;
    jcdsDelAboutPrice: TjsonClientDataSet;
    jcdsDelAboutStation: TjsonClientDataSet;
    jcdsDelAboutRoadGrade: TjsonClientDataSet;
    jcdsAboutVchRoadGrade: TjsonClientDataSet;
    jcdsDelSchdeuleAbout: TjsonClientDataSet;
    jcdsDelAboutScheduleUnit: TjsonClientDataSet;
    jcdsResultisfreight: TBooleanField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultorgname: TWideStringField;
    Label3: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure TbtnAddClick(Sender: TObject);
    procedure TbtnDelClick(Sender: TObject);
    procedure TbtnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaHCbbOrgChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
    procedure qryFormulaitem(item:String;formulaitemid:integer);
    procedure addVehcileabout();
    procedure updateVehcileabout();
    procedure delVehcileabout();
    procedure addRouteabout();
    procedure updateRouteabout();
    procedure delRouteabout();
    //
    procedure addRouteStopabout();
    procedure updateRouteStopabout();
    procedure delRouteStopabout();
    //
    procedure addDistanceabout();
    procedure updateDistanceabout();
    procedure delDistanceabout();
    //
    procedure addPriceabout();
    procedure updatePriceabout();
    procedure delPriceabout();
    //
    procedure addStationabout();
    procedure updateStationabout();
    procedure delStationabout();
    //
    procedure addRoadGradeabout();
    procedure updateRoadGradeabout();
    procedure delRoadGradeabout();
    //
    procedure addVchRoadGradeabout();
    procedure updateVchRoadGradeabout();
    procedure delVchRoadGradeabout();
    //
    procedure addScheduleabout();
    procedure updateScheduleabout();
    procedure delScheduleabout();

  public
    { Public declarations }
  end;

var
  FrmTicketPriceFormulaitem: TFrmTicketPriceFormulaitem;

implementation

uses PubFn, Services, UFrmAboutRouteStop,UDMPublic, UFrmTicketPriceItem, UFrmAboutVehcile,
  UFrmAboutRoute,UAboutPrice, UFrmAboutDistance, UAboutStationGrade,
  UAboutRoadGrade, UAboutVehcileGrade, UAboutSchedule;
{$R *.dfm}



procedure TFrmTicketPriceFormulaitem.addDistanceabout;
begin
  FrmAboutDistance := TFrmAboutDistance.Create(self);
  with FrmAboutDistance do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutDistance) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addPriceabout;
begin
  FrmAboutPrice := TFrmAboutPrice.Create(self);
  with FrmAboutPrice do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutPrice) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addRoadGradeabout;
begin
  FrmAboutRoadGrade := TFrmAboutRoadGrade.Create(self);
  with FrmAboutRoadGrade do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutRoadGrade) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addRouteabout;
begin
  FrmAboutRoute := TFrmAboutRoute.Create(self);
  with FrmAboutRoute do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutRoute) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addRouteStopabout;
begin
  FrmAboutRouteStop := TFrmAboutRouteStop.Create(self);
  with FrmAboutRouteStop do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutRouteStop) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addScheduleabout;
begin
  FrmAboutSchedule := TFrmAboutSchedule.Create(self);
  with FrmAboutSchedule do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    //item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutSchedule) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;


procedure TFrmTicketPriceFormulaitem.addStationabout;
begin
  FrmAboutStationGrade := TFrmAboutStationGrade.Create(self);
  with FrmAboutStationGrade do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutStationGrade) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addVchRoadGradeabout;
begin
  FrmAboutVehcilGrade := TFrmAboutVehcilGrade.Create(self);
  with FrmAboutVehcilGrade do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutVehcilGrade) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.addVehcileabout;
begin
  FrmAboutVehcile := TFrmAboutVehcile.Create(self);
  with FrmAboutVehcile do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '添加'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=add;
    if SysMainForm.showFormModal(FrmAboutVehcile) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.delDistanceabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jcdsDelDistanceAbout do
  begin
    Active := false;
    Params.ParamValues['formulaitemdistance.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;
end;

procedure TFrmTicketPriceFormulaitem.delPriceabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jcdsDelAboutPrice do
  begin
    Active := false;
    Params.ParamValues['formulaitemprice.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;
end;

procedure TFrmTicketPriceFormulaitem.delRoadGradeabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jcdsDelAboutRoadGrade do
  begin
    Active := false;
    Params.ParamValues['formulaitemroadgrade.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;

end;

procedure TFrmTicketPriceFormulaitem.delRouteabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jscdDelAboutRoute do
  begin
    Active := false;
    Params.ParamValues['formulaitemroute.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;

end;

procedure TFrmTicketPriceFormulaitem.delRouteStopabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jscdDelAboutRouteStop do
  begin
    Active := false;
    Params.ParamValues['formulaitemroutestop.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;
end;

procedure TFrmTicketPriceFormulaitem.delScheduleabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jcdsDelSchdeuleAbout do
  begin
    Active := false;
    Params.ParamValues['formulaitemschedule.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;

end;


procedure TFrmTicketPriceFormulaitem.delStationabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jcdsDelAboutStation do
  begin
    Active := false;
    Params.ParamValues['formulaitemorggrade.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;

end;

procedure TFrmTicketPriceFormulaitem.delVchRoadGradeabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jcdsAboutVchRoadGrade do
  begin
    Active := false;
    Params.ParamValues['formulaitemvehcileroadgrad.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;

end;

procedure TFrmTicketPriceFormulaitem.delVehcileabout;
var
  sResult,relatetype: string;
  nResult,id:integer;
begin
  relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
  id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该'+relatetype+'吗') then

  with jscdDelAboutVehclie do
  begin
    Active := false;
    Params.ParamValues['formulaitemvehcile.id'] := id;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       SysDialogs.ShowMessage(sResult);
    end
    else
       SysDialogs.ShowError(sResult);
  end;
end;

procedure TFrmTicketPriceFormulaitem.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active := false;
  NovaHCbbOrg.Active := true;
  NovaHCbbOrg.SetItemIndexByField('id',sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmTicketPriceFormulaitem.FormShow(Sender: TObject);
begin
  inherited;
  jcdsRelatetype.Active := false;
  jcdsRelatetype.Active := true;
  tbtnFilterClick(sender);
end;

procedure TFrmTicketPriceFormulaitem.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
  begin
    jscdTicketPriceItemAbout.Close;
    exit;
  end;
  qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
  ToolBar1.Enabled:=true;
  TbtnAdd.Enabled:=true;
  if (jcdsResult.FieldByName('relatetype').AsString='0') then
  begin
      //jscdTicketPriceItemAbout.First;
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='vehiclename';
        NvgridAbout.Columns[0].Width:=140;
        NvgridAbout.Columns[0].Title.caption:='车型';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='VALUE';
        NvgridAbout.Columns[1].Width:=60;
        NvgridAbout.Columns[1].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='1') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='roadgradename';
        NvgridAbout.Columns[0].Width:=120;
        NvgridAbout.Columns[0].Title.caption:='公路等级';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='VALUE';
        NvgridAbout.Columns[1].Width:=60;
        NvgridAbout.Columns[1].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='2') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='vehiclename';
        NvgridAbout.Columns[0].Width:=140;
        NvgridAbout.Columns[0].Title.caption:='车型';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='roadgradename';
        NvgridAbout.Columns[1].Width:=120;
        NvgridAbout.Columns[1].Title.caption:='公路等级';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[2].FieldName:='VALUE';
        NvgridAbout.Columns[2].Width:=60;
        NvgridAbout.Columns[2].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='3') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='stationgradename';
        NvgridAbout.Columns[0].Width:=120;
        NvgridAbout.Columns[0].Title.caption:='客运站等级';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='VALUE';
        NvgridAbout.Columns[1].Width:=60;
        NvgridAbout.Columns[1].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='4') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='routename';
        NvgridAbout.Columns[0].Width:=100;
        NvgridAbout.Columns[0].Title.caption:='营运线路';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='code';
        NvgridAbout.Columns[1].Width:=50;
        NvgridAbout.Columns[1].Title.caption:='班次号';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[2].FieldName:='starttime';
        NvgridAbout.Columns[2].Width:=70;
        NvgridAbout.Columns[2].Title.caption:='发车时间';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[3].FieldName:='VALUE';
        NvgridAbout.Columns[3].Width:=50;
        NvgridAbout.Columns[3].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='5') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='routename';
        NvgridAbout.Columns[0].Width:=140;
        NvgridAbout.Columns[0].Title.caption:='线路名称';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='VALUE';
        NvgridAbout.Columns[1].Width:=60;
        NvgridAbout.Columns[1].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='6') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='routename';
        NvgridAbout.Columns[0].Width:=140;
        NvgridAbout.Columns[0].Title.caption:='线路名称';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='stationname';
        NvgridAbout.Columns[1].Width:=100;
        NvgridAbout.Columns[1].Title.caption:='停靠站点';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[2].FieldName:='VALUE';
        NvgridAbout.Columns[2].Width:=60;
        NvgridAbout.Columns[2].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='7') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='fromprice';
        NvgridAbout.Columns[0].Width:=80;
        NvgridAbout.Columns[0].Title.caption:='起始票价';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='endprice';
        NvgridAbout.Columns[1].Width:=80;
        NvgridAbout.Columns[1].Title.caption:='结束票价';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[2].FieldName:='VALUE';
        NvgridAbout.Columns[2].Width:=60;
        NvgridAbout.Columns[2].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='8') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='fromdistance';
        NvgridAbout.Columns[0].Width:=80;
        NvgridAbout.Columns[0].Title.caption:='起始里程';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[1].FieldName:='enddistance';
        NvgridAbout.Columns[1].Width:=80;
        NvgridAbout.Columns[1].Title.caption:='结束里程';
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[2].FieldName:='VALUE';
        NvgridAbout.Columns[2].Width:=60;
        NvgridAbout.Columns[2].Title.caption:='计算值';
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='9') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='value';
        NvgridAbout.Columns[0].Width:=80;
        NvgridAbout.Columns[0].Title.caption:='计算值';
        ToolBar1.Enabled:=false;
  end
  else if (jcdsResult.FieldByName('relatetype').AsString='10') then
  begin
        NvgridAbout.Columns.Clear;
        NvgridAbout.Columns.Add;
        NvgridAbout.Columns[0].FieldName:='itemformula';
        NvgridAbout.Columns[0].Width:=100;
        NvgridAbout.Columns[0].Title.caption:='表达式';
        ToolBar1.Enabled:=false;
  end
  else
  begin
     jscdTicketPriceItemAbout.Close;
     NvgridAbout.Columns.Clear;
     ToolBar1.Enabled:=false;
  end;

end;

procedure TFrmTicketPriceFormulaitem.NovaHCbbOrgChange(Sender: TObject);
begin
  inherited;
 tbtnFilterClick(sender);
end;

procedure TFrmTicketPriceFormulaitem.qryFormulaitem(item: String;
  formulaitemid: integer);
begin
  with jscdTicketPriceItemAbout do
  begin
    active:=false;
    Params.ParamValues['item'] := item;
    Params.ParamValues['ticketpriceformulaitem.id'] := formulaitemid;
    active:=true;
  end;
end;

procedure TFrmTicketPriceFormulaitem.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult,scheduleid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('isdefault').AsBoolean) then
  begin
    SysDialogs.Warning('系统默认的票价公式组成项目不允许删除！');
    exit;
  end;


  scheduleid:= jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('删除操作','确认要删除该票价公式项目信息吗？') then
  with jcdsDelTicketPriceItem do
  begin
    Active := false;
    Params.ParamValues['ticketpriceformulaitem.id'] := jcdsResult.FieldByName('id')
      .AsInteger;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
      log := '删除票价公式：机构='+jcdsResult.FieldByName('orgname').AsString+
      ',项目名称='+jcdsResult.FieldByName('name').AsString+',项目代码='+
      jcdsResult.FieldByName('code').AsString+',费用相关='+
      jcdsResult.FieldByName('relatetypename').AsString+',是否基础运价='+
      jcdsResult.FieldByName('isfreight').AsString;
      SysLog.WriteLog('票价管理->票价公式组成项','删除',log);
      tbtnFilterClick(sender) ;
  end;

end;

procedure TFrmTicketPriceFormulaitem.tbtnEditClick(Sender: TObject);
var
  curid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('isdefault').AsBoolean) then
  begin
    SysDialogs.Warning('默认的票价公式组成项目不允许修改');
    exit;
  end;


  FrmTicketPriceItem := TFrmTicketPriceItem.Create(self);
  with FrmTicketPriceItem do
  begin
    Caption := '修改票价公式组成项目';
    createby := SysInfo.LoginUserInfo.UserID;
    id := jcdsResult.FieldByName('id').AsInteger;
    curid:=id;
    orgid:=jcdsResult.FieldByName('orgid').AsLargeInt;
    NovaEdtCode.ItemIndex := NovaEdtCode.Items.IndexOf( jcdsResult.FieldByName('code').AsString);
    NovaEdtCode.Enabled:=false;
    NovaEdtName.Text := jcdsResult.FieldByName('name').AsString;
    NovaEdtName.Enabled:=false;
    relatetypename := jcdsResult.FieldByName('relatetypename').AsString;
    cbISTICKETPRICEITEM.Checked := jcdsResult.FieldByName('ISTICKETPRICEITEM')
      .AsBoolean;
    if jcdsResult.FieldByName('isfreight').AsBoolean then
       chkisfreight.Enabled:=true;
    chkisfreight.Checked := jcdsResult.FieldByName('isfreight').AsBoolean;
    CbISAUTOADJUST.Checked := jcdsResult.FieldByName('ISAUTOADJUST').AsBoolean;
    createtime:= jcdsResult.FieldByName('createtime').AsString;
    if (jcdsResult.FieldByName('relatetype').AsString='9')
     and (jscdTicketPriceItemAbout.Active) and (jscdTicketPriceItemAbout.RecordCount>0) then
    NovaEdtValue.Text:=jscdTicketPriceItemAbout.FieldByName('value').AsString;
    if (jcdsResult.FieldByName('relatetype').AsString='10')
     and (jscdTicketPriceItemAbout.Active) and (jscdTicketPriceItemAbout.RecordCount>0) then
    begin
      NovaEdtItemFormula.Text:=jscdTicketPriceItemAbout.FieldByName('ItemFormula').AsString;
    end
    else
    begin
      NovaEdtItemFormula.Enabled:=false;
    end;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmTicketPriceItem) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  {if (NovaCkbOrg.CheckedCount=0) then
  begin
     SysDialogs.ShowMessage('请选择机构！');
     NovaCkbOrg.SetFocus;
     exit;
  end; }
  jcdsResult.AfterScroll:=nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!orgid'] := NovaHCbbOrg.HelpFieldValue['id'];//
    //SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_LIKES_t!name'] := trim(NovaEdtName.Text);
    Params.ParamValues['filter_LIKES_t!code'] := trim(NovaEdtCode.Text);
    Active := true;
    if RecordCount <= 0 then
    begin
      jscdTicketPriceItemAbout.Close;
    end;
  end;
  jcdsResult.AfterScroll:=jcdsResultAfterScroll;
end;

procedure TFrmTicketPriceFormulaitem.tbtnInsertClick(Sender: TObject);
var
 curid:Int64;
begin
  inherited;
  FrmTicketPriceItem := TFrmTicketPriceItem.Create(self);
  curid:=0;
  with FrmTicketPriceItem do
  begin
    Caption := '添加票价公式组成项目';
    createby := SysInfo.LoginUserInfo.UserID;
    edittype := add;
    //orgid:=sysinfo.LoginUserInfo.OrgID;
    if SysMainForm.showFormModal(FrmTicketPriceItem,false) = mrok then
    begin
      curid:=id;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.TbtnAddClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('relatetype').AsString='0') then
    addVehcileabout
  else if (jcdsResult.FieldByName('relatetype').AsString='1') then
     addRoadGradeabout
  else if (jcdsResult.FieldByName('relatetype').AsString='2') then
     addVchRoadGradeabout
  else if (jcdsResult.FieldByName('relatetype').AsString='3') then
     addStationabout
  else if (jcdsResult.FieldByName('relatetype').AsString='4') then
     addScheduleabout
  else if (jcdsResult.FieldByName('relatetype').AsString='5') then
     addRouteabout
  else if (jcdsResult.FieldByName('relatetype').AsString='6') then
     addRouteStopabout
  else if (jcdsResult.FieldByName('relatetype').AsString='8') then
     addDistanceabout
  else if (jcdsResult.FieldByName('relatetype').AsString='7') then
     addPriceabout
  else
    //固定项
end;

procedure TFrmTicketPriceFormulaitem.TbtnUpdateClick(Sender: TObject);
begin
  inherited;
    if not jscdTicketPriceItemAbout.Active then
    exit;
  if jscdTicketPriceItemAbout.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('relatetype').AsString='0') then
    updateVehcileabout
  else if (jcdsResult.FieldByName('relatetype').AsString='1') then
     updateRoadGradeabout
  else if (jcdsResult.FieldByName('relatetype').AsString='2') then
     updateVchRoadGradeabout
  else if (jcdsResult.FieldByName('relatetype').AsString='3') then
     updateStationabout
  else if (jcdsResult.FieldByName('relatetype').AsString='4') then
     updateScheduleabout
  else if (jcdsResult.FieldByName('relatetype').AsString='5') then
     updateRouteabout
  else if (jcdsResult.FieldByName('relatetype').AsString='6') then
     updateRouteStopabout
  else if (jcdsResult.FieldByName('relatetype').AsString='7') then
     updatepriceabout
  else if (jcdsResult.FieldByName('relatetype').AsString='8') then
     updateDistanceabout
end;

procedure TFrmTicketPriceFormulaitem.TbtnDelClick(Sender: TObject);
begin
  inherited;
  if not jscdTicketPriceItemAbout.Active then
    exit;
  if jscdTicketPriceItemAbout.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('relatetype').AsString='0') then
    delVehcileabout
  else if (jcdsResult.FieldByName('relatetype').AsString='1') then
     delRoadGradeabout
  else if (jcdsResult.FieldByName('relatetype').AsString='2') then
     delVchRoadGradeabout
  else if (jcdsResult.FieldByName('relatetype').AsString='3') then
     delStationabout
  else if (jcdsResult.FieldByName('relatetype').AsString='4') then
    delScheduleabout
  else if (jcdsResult.FieldByName('relatetype').AsString='5') then
    delRouteabout
  else if (jcdsResult.FieldByName('relatetype').AsString='6')then
    delRouteStopabout
  else if (jcdsResult.FieldByName('relatetype').AsString='7')then
    delPriceabout
  else if (jcdsResult.FieldByName('relatetype').AsString='8')then
    delDistanceabout
end;

procedure TFrmTicketPriceFormulaitem.updateDistanceabout;
var
  curid:integer;
begin
  FrmAboutDistance := TFrmAboutDistance.Create(self);
  with FrmAboutDistance do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaEdtFromDistance.Text:= jscdTicketPriceItemAbout.FieldByName('FromDistance').AsString;
    NovaEdtEndDistance.Text:= jscdTicketPriceItemAbout.FieldByName('enddistance').AsString;
    NovaEdtValue.Text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    createby := SysInfo.LoginUserInfo.UserID;
    id:=jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createtime:= jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    edittype:=tedittype.update;
    if SysMainForm.showFormModal(FrmAboutDistance) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmTicketPriceFormulaitem.updatePriceabout;
var
  curid:integer;
begin
  FrmAboutPrice := TFrmAboutPrice.Create(self);
  with FrmAboutPrice do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaEdtFromPrice.Text:= jscdTicketPriceItemAbout.FieldByName('Fromprice').AsString;
    NovaEdtEndPrice.Text:= jscdTicketPriceItemAbout.FieldByName('endprice').AsString;
    NovaEdtValue.Text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    createby := SysInfo.LoginUserInfo.UserID;
    id:=jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createtime:= jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    edittype:=tedittype.update;
    if SysMainForm.showFormModal(FrmAboutPrice) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmTicketPriceFormulaitem.updateRoadGradeabout;
var
  curid:integer;
begin
  FrmAboutRoadGrade := TFrmAboutRoadGrade.Create(self);
  with FrmAboutRoadGrade do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    roadgradename:= jscdTicketPriceItemAbout.FieldByName('roadgradename').AsString;
    NovaEdtValue.Text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    createby := SysInfo.LoginUserInfo.UserID;
    id:=jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createtime:= jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    edittype:=tedittype.update;
    if SysMainForm.showFormModal(FrmAboutRoadGrade) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmTicketPriceFormulaitem.updateRouteabout;
var
  curid:integer;
begin
  FrmAboutRoute := TFrmAboutRoute.Create(self);
  with FrmAboutRoute do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaHelpRoute.Text:= jscdTicketPriceItemAbout.FieldByName('routename').AsString;
    NovaHelpRoute.Id:=jscdTicketPriceItemAbout.FieldByName('routeid').AsInteger;
    NovaEdtValue.Text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    createby := SysInfo.LoginUserInfo.UserID;
    id:=jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createtime:= jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    edittype:=tedittype.update;
    if SysMainForm.showFormModal(FrmAboutRoute) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.updateRouteStopabout;
var
  curid:integer;
begin
  FrmAboutRouteStop := TFrmAboutRouteStop.Create(self);
  with FrmAboutRouteStop do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaHelpRoute.Text:= jscdTicketPriceItemAbout.FieldByName('routename').AsString;
    NovaHelpRoute.Id:=jscdTicketPriceItemAbout.FieldByName('routeid').AsInteger;
    NovaEdtValue.Text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    createby := SysInfo.LoginUserInfo.UserID;
    stationname:= jscdTicketPriceItemAbout.FieldByName('stationname').AsString;
    id:=jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createtime:= jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    edittype:=tedittype.update;
    if SysMainForm.showFormModal(FrmAboutRouteStop) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmTicketPriceFormulaitem.updateScheduleabout;
var
  curid:integer;
begin
  FrmAboutSchedule := TFrmAboutSchedule.Create(self);
  with FrmAboutSchedule do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
//    item := jcdsResult.FieldByName('relatetype').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaHSchdule.Text:= jscdTicketPriceItemAbout.FieldByName('code').AsString;
    NovaHSchdule.Id:=jscdTicketPriceItemAbout.FieldByName('scheduleid').AsInteger;
    NovaEdtValue.Text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    createby := SysInfo.LoginUserInfo.UserID;
    id:=jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createtime:= jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    edittype:=tedittype.update;
    if SysMainForm.showFormModal(FrmAboutSchedule) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmTicketPriceFormulaitem.updateStationabout;
var
  curid:integer;
begin
  FrmAboutStationGrade := TFrmAboutStationGrade.Create(self);
  with FrmAboutStationGrade do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaEdtValue.text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=Tedittype.update;
    stationgradename := jscdTicketPriceItemAbout.FieldByName('stationgradename').AsString;
    createtime := jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    createby := jscdTicketPriceItemAbout.FieldByName('createby').AsInteger;
    if SysMainForm.showFormModal(FrmAboutStationGrade) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmTicketPriceFormulaitem.updateVchRoadGradeabout;
var
  curid:integer;
begin
  FrmAboutVehcilGrade := TFrmAboutVehcilGrade.Create(self);
  with FrmAboutVehcilGrade do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaEdtValue.text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=Tedittype.update;
    vchcilename := jscdTicketPriceItemAbout.FieldByName('vehiclename').AsString;
    roadgradename := jscdTicketPriceItemAbout.FieldByName('roadgradename').AsString;
    createtime := jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    createby := jscdTicketPriceItemAbout.FieldByName('createby').AsInteger;
    if SysMainForm.showFormModal(FrmAboutVehcilGrade) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;

end;

procedure TFrmTicketPriceFormulaitem.updateVehcileabout;
var
  curid:integer;
begin
  FrmAboutVehcile := TFrmAboutVehcile.Create(self);
  with FrmAboutVehcile do
  begin
    relatetype:= jcdsResult.FieldByName('relatetypename').AsString;
    Caption := '修改'+relatetype+'信息';
    NovaEdtName.Text:= jcdsResult.FieldByName('name').AsString;
    ticketpriceformulaitemid:= jcdsResult.FieldByName('id').AsInteger;
    NovaEdtValue.text:= jscdTicketPriceItemAbout.FieldByName('value').AsString;
    id:= jscdTicketPriceItemAbout.FieldByName('id').AsInteger;
    curid:=id;
    createby := SysInfo.LoginUserInfo.UserID;
    edittype:=Tedittype.update;
    vchcilename := jscdTicketPriceItemAbout.FieldByName('vehiclename').AsString;
    createtime := jscdTicketPriceItemAbout.FieldByName('createtime').AsString;
    createby := jscdTicketPriceItemAbout.FieldByName('createby').AsInteger;
    if SysMainForm.showFormModal(FrmAboutVehcile) = mrok then
    begin
       qryFormulaitem(jcdsResult.FieldByName('relatetype').AsString,jcdsResult.FieldByName('id').AsInteger);
       jscdTicketPriceItemAbout.Locate('id',curid,[]);
    end;
  end;
end;

end.
