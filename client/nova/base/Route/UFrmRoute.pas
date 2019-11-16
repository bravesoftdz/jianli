unit UFrmRoute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, UFrmRouteAdd,Services,UDMPublic,
  UFrmRouteroadAdd, UFrmRoutestopAdd, NvPrnDbgeh, NvDbgridEh,NovaCheckedComboBox;

type
  TFrmRoute = class(TSimpleCRUDForm)
    edtname: TEdit;
    Label1: TLabel;
    NvCbbdistricttype: TNovaComboBox;
    lbldistricttype: TLabel;
    lblendstation: TLabel;
    NvHpendstation: TNovaHelp;
    jcdsdistricttype: TjsonClientDataSet;
    jcdsroutetype: TjsonClientDataSet;
    jcdsroutegrade: TjsonClientDataSet;
    jcdsroutedirection: TjsonClientDataSet;
    jcdsroutedelete: TjsonClientDataSet;
    jcdsroutestop: TjsonClientDataSet;
    dsroutestop: TDataSource;
    dsrouteroad: TDataSource;
    jcdsrouteroad: TjsonClientDataSet;
    jcdsroadgrade: TjsonClientDataSet;
    pnlright: TPanel;
    gbroutestop: TGroupBox;
    gbrouteroad: TGroupBox;
    dbgrdhroutestop: TNvDbgridEh;
    dbgrdhrouteroad: TNvDbgridEh;

    jcdsResultid: TLargeintField;
    jcdsResultORGID: TLargeintField;
    jcdsResultorgname: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsResultNAME: TWideStringField;
    jcdsResultSTARTSTATIONNAME: TWideStringField;
    jcdsResultENDSTATIONNAME: TWideStringField;
    jcdsResultDISTANCE: TIntegerField;
    jcdsResulthighdistance: TIntegerField;
    jcdsResultdistricttype: TWideStringField;
    jcdsResultdistricttypename: TWideStringField;
    jcdsResultTYPE: TWideStringField;
    jcdsResulttypename: TWideStringField;
    jcdsResultGRADE: TWideStringField;
    jcdsResultgradename: TWideStringField;
    jcdsResultDIRECTION: TWideStringField;
    jcdsResultdirectionname: TWideStringField;
    jcdsResultISAUDITED: TBooleanField;
    jcdsResultISAUDITPASS: TBooleanField;
    jcdsResultISACTIVE: TBooleanField;
    jcdsResultjianpin: TWideStringField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultremarks: TWideStringField;
    jcdsrouteroadid: TLargeintField;
    jcdsrouteroadrouteid: TLargeintField;
    jcdsrouteroadORDERNO: TIntegerField;
    jcdsrouteroadNAME: TWideStringField;
    jcdsrouteroadENTRANCENAME: TWideStringField;
    jcdsrouteroadEXITNAME: TWideStringField;
    jcdsrouteroadDISTANCE: TIntegerField;
    jcdsrouteroadroadgrade: TWideStringField;
    jcdsrouteroadroadgradename: TWideStringField;
    jcdsrouteroadroadupdateby: TLargeintField;
    jcdsrouteroadroadcreateby: TLargeintField;


    tlbstop: TToolBar;
    tbtn2: TToolButton;
    tbtnaddstop: TToolButton;
    tbtn7: TToolButton;
    tbtnUpdatestop: TToolButton;
    tbtn8: TToolButton;
    tbtndelstop: TToolButton;
    ilsmalltools: TImageList;
    tlbroad: TToolBar;
    tbtn9: TToolButton;
    tbtnaddroad: TToolButton;
    tbtn11: TToolButton;
    tbtnupdateroad: TToolButton;
    tbtn13: TToolButton;
    tbtndelroad: TToolButton;
    splmid: TSplitter;
    jcdsroutestopdel: TjsonClientDataSet;
    jcdsrouteroaddel: TjsonClientDataSet;
    tbtndownstop: TToolButton;
    tbtnupstop: TToolButton;
    jcdsswapstoporderno: TjsonClientDataSet;
    jcdsswaproadorderno: TjsonClientDataSet;
    tbtn10: TToolButton;
    tbtndownroad: TToolButton;
    tbtn12: TToolButton;
    tbtnuproad: TToolButton;
    tbtn14: TToolButton;
    tbtn15: TToolButton;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsrouteroadcreatetime: TDateTimeField;
    jcdsrouteroadupdatetime: TDateTimeField;
    wdstrngfldResultcreatebyname: TWideStringField;
    wdstrngfldResultupdatebyname: TWideStringField;
    jcdsResultsynccode: TWideStringField;
    Label2: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    jcdsResultreturntripvaliddays: TIntegerField;
    jscdRouteUsed: TjsonClientDataSet;
    jcdsResultreportinterval: TIntegerField;
    jcdsResultisrealnameticket: TBooleanField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnaddstopClick(Sender: TObject);
    procedure tbtnaddroadClick(Sender: TObject);
    procedure tbtnUpdatestopClick(Sender: TObject);
    procedure tbtnupdateroadClick(Sender: TObject);
    procedure tbtndelstopClick(Sender: TObject);
    procedure tbtndelroadClick(Sender: TObject);
    procedure tbtndownstopClick(Sender: TObject);
    procedure tbtnupstopClick(Sender: TObject);
    procedure tbtndownroadClick(Sender: TObject);
    procedure tbtnuproadClick(Sender: TObject);
    procedure jcdsResultAfterClose(DataSet: TDataSet);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure refreshRoutestop;
    procedure refreshRouteroad;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmRoute: TFrmRoute;

implementation

{$R *.dfm}

procedure TFrmRoute.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmRoute.FormShow(Sender: TObject);
begin
  inherited;
  NvCbbdistricttype.Active:=true;
  jcdsdistricttype.Active:=true;
  jcdsroutetype.Active:=true;
  jcdsroutegrade.Active:=true;
  jcdsroutedirection.Active:=true;
  jcdsroadgrade.Active:=true;
  NovaCkbOrg.Active := true;
end;

procedure TFrmRoute.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{382188D4-99AC-4BE8-93D0-A2BC9A5A2AD0}' then //添加线路
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{5A1165D0-5C91-4C4C-8725-EC3DEF4EA97C}' then //修改线路
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{0AA83E50-2D2A-4F48-A558-EBDE726A16FB}' then //删除线路
  begin
    tbtnDelete.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{AB3BCB15-8DAA-41EB-8AE1-F36CC5D6BD77}' then //添加线路停靠点
  begin
    tbtnaddstop.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{9DA8BFAE-3BB0-49EB-AC91-D89D565406F1}' then //修改线路停靠点
  begin
    tbtnUpdatestop.Enabled:=aEnable;
    tbtndownstop.Enabled:=aEnable;
    tbtnupstop.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{763073CF-8B57-4C88-8641-0680A6FBC848}' then //删除线路停靠点
  begin
    tbtndelstop.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{65893F02-7EE2-4F79-B22A-3C106871C77D}' then //添加线路路段
  begin
    tbtnaddroad.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{937F634E-5A02-4F48-90E3-1FAD34B8194E}' then //修改线路路段
  begin
    tbtnupdateroad.Enabled:=aEnable;
    tbtndownroad.Enabled:=aEnable;
    tbtnuproad.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{BC475BD7-3786-4A62-8F45-76098A25DF95}' then //删除线路路段
  begin
    tbtndelroad.Enabled:=aEnable;
  end;
end;

procedure TFrmRoute.jcdsResultAfterClose(DataSet: TDataSet);
begin
  inherited;
  jcdsroutestop.Close;
  jcdsrouteroad.Close;
end;

procedure TFrmRoute.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dataset.RecordCount=0 then
  begin
    jcdsroutestop.Close;
    jcdsrouteroad.Close;
  end;
end;

procedure TFrmRoute.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  refreshRoutestop;
  refreshRouteroad;
end;

procedure TFrmRoute.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key=#13 then
    tbtnFilterClick(sender);
end;

procedure TFrmRoute.refreshRouteroad;
begin
  {with jcdsrouteroad do
  begin
    Active:=False;
    Params.ParamValues['routeid']:=jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end; }
end;

procedure TFrmRoute.refreshRoutestop;
begin
  with jcdsroutestop do
  begin
    Active:=False;
    Params.ParamValues['routeid']:=jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end;
end;

procedure TFrmRoute.tbtnaddroadClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsResult.Active=false) or (jcdsResult.RecNo<=0) then exit;
  FrmRouteroadAdd:=TFrmRouteroadAdd.Create(self,self.functionItem);
  try
    with FrmRouteroadAdd do
    begin
      Caption:='添加线路路段';
      edittype:=Tedittype.add;
      routeid:=jcdsResult.FieldByName('id').AsString;
    end;
    if SysMainForm.showFormModal(FrmRouteroadAdd,false)=mrOk then
    begin
      id := FrmRouteroadAdd.operationid;
      refreshRouteroad;
      jcdsrouteroad.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmRouteroadAdd);
  end;
end;

procedure TFrmRoute.tbtnaddstopClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsResult.Active=false) or (jcdsResult.RecNo<=0) then exit;
  FrmRoutestopAdd:=TFrmRoutestopAdd.Create(self,self.functionItem);
  try
    with FrmRoutestopAdd do
    begin
      Caption:='添加线路停靠点';
      edittype:=Tedittype.add;
      routeid:=jcdsResult.FieldByName('id').AsString;
      nvhelpstation.Enabled:=True;
    end;
    if SysMainForm.showFormModal(FrmRoutestopAdd,false)=mrOk then
    begin
      id := FrmRoutestopAdd.operationid;
      refreshRoutestop;
      jcdsroutestop.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmRoutestopAdd);
  end;
end;

procedure TFrmRoute.tbtnDeleteClick(Sender: TObject);
var
  used:String;
begin
  inherited;
  if (jcdsResult.Active) and (jcdsResult.RecordCount>0) then
  begin
    with jscdRouteUsed do
    begin
       Active:=false;
       Params.ParamValues['route.id']:=jcdsResult.FieldByName('id').AsString;
       Execute;
       used:=Params.ParamValues['used'];
    end;
    if used='1' then
    begin
      if not SysDialogs.Confirm('提示','该线路已经被使用，你确定要删除该线路吗？') then
      begin
        exit;
      end;
    end
    else
    begin
      if not SysDialogs.Confirm('提示','确定要删除该线路吗？') then
      begin
        exit;
      end;
    end;
    with jcdsroutedelete do
    begin
      Params.ParamValues['route.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        tbtnFilter.Click;
      end;
    end;
//    jcdsResult.Delete;
//    jcdsResult.ApplyUpdates(0);
  end;
end;

procedure TFrmRoute.tbtndelroadClick(Sender: TObject);
begin
  inherited;
  if (jcdsrouteroad.Active=True) and (jcdsrouteroad.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该路段吗？') then
    begin
      exit;
    end;
//      Delete;
//      ApplyUpdates(-1);
    jcdsrouteroaddel.Params.ParamValues['routeroad.id']:=jcdsrouteroad.FieldByName('id').AsString;
    jcdsrouteroaddel.Execute;
    if jcdsrouteroaddel.Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(jcdsrouteroaddel.Params.ParamValues['msg']);
    end;
    if jcdsrouteroaddel.Params.ParamValues['flag']=1 then
    begin
      jcdsrouteroad.Delete;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;
end;

procedure TFrmRoute.tbtndelstopClick(Sender: TObject);
begin
  inherited;
  if (jcdsroutestop.Active=True) and (jcdsroutestop.RecNo>0) then
  begin
    if jcdsroutestop.FieldByName('stationid').AsString=jcdsResult.FieldByName('startstationid').AsString then
    begin
      SysDialogs.ShowInfo('不能删除始发站点！');
      exit;
    end;
    if jcdsroutestop.FieldByName('stationid').AsString=jcdsResult.FieldByName('endstationid').AsString then
    begin
      SysDialogs.ShowInfo('不能删除终到站点！');
      exit;
    end;
    if not SysDialogs.Confirm('提示','确定要删除该停靠点吗？') then
    begin
      exit;
    end;
//      Delete;
//      ApplyUpdates(0);
    jcdsroutestopdel.Params.ParamValues['routestop.id']:=jcdsroutestop.FieldByName('id').AsString;
    jcdsroutestopdel.Execute;
    if jcdsroutestopdel.Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(jcdsroutestopdel.Params.ParamValues['msg']);
    end;
    if jcdsroutestopdel.Params.ParamValues['flag']=1 then
    begin
      jcdsroutestop.Delete;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;
end;

procedure TFrmRoute.tbtndownroadClick(Sender: TObject);
var id:String;
begin
  inherited;
//  if jcdsrouteroad.RecNo=1 then
//  begin
//    SysDialogs.ShowError('起始路段不能下移！');
//    exit;
//  end
//  else if jcdsrouteroad.RecNo=jcdsrouteroad.RecordCount-1 then
//  begin
//    SysDialogs.ShowError('不能下移为末尾路段！');
//    exit;
//  end
//  else
  if jcdsrouteroad.RecNo=jcdsrouteroad.RecordCount then
  begin
    SysDialogs.ShowInfo('末尾路段不能下移！');
    exit;
   end;
  with jcdsswaproadorderno do
  begin
    id:=jcdsrouteroad.FieldByName('id').AsString;
    Params.ParamValues['swapid1']:=id;
    jcdsrouteroad.next;
    Params.ParamValues['swapid2']:=jcdsrouteroad.FieldByName('id').AsString;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      refreshRouteroad;
      jcdsrouteroad.Locate('id',id,[]);
    end;
  end;
end;

procedure TFrmRoute.tbtndownstopClick(Sender: TObject);
var id:String;
begin
  inherited;
  if jcdsroutestop.RecNo=1 then
  begin
    SysDialogs.ShowInfo('始发站点不能下移！');
    exit;
  end
  else if jcdsroutestop.RecNo=jcdsroutestop.RecordCount-1 then
  begin
    SysDialogs.ShowInfo('不能下移为终到站点！');
    exit;
  end
  else if jcdsroutestop.RecNo=jcdsroutestop.RecordCount then
  begin
    SysDialogs.ShowInfo('终到站点不能下移！');
    exit;
  end;
  with jcdsswapstoporderno do
  begin
    id:=jcdsroutestop.FieldByName('id').AsString;
    Params.ParamValues['swapid1']:=id;
    jcdsroutestop.next;
    Params.ParamValues['swapid2']:=jcdsroutestop.FieldByName('id').AsString;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      refreshRoutestop;
      jcdsroutestop.Locate('id',id,[]);
    end;
  end;
end;

procedure TFrmRoute.tbtnEditClick(Sender: TObject);
var id:Integer;
    OnIdChange_old:TNotifyEvent;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmRouteAdd:=TFrmRouteAdd.Create(self,self.functionItem);
    try
      with FrmRouteAdd do
      begin
        Caption:='修改线路';
        edittype:=Tedittype.update;
        nvedtname.Text:=self.jcdsResult.FieldByName('NAME').AsString;
        nvedtname.Id:=self.jcdsResult.FieldByName('id').AsInteger;
        OnIdChange_old:=nvhelpstartstation.OnIdChange;
        nvhelpstartstation.OnIdChange:=nil;
        try
          nvhelpstartstation.Id:=self.jcdsResult.FieldByName('startstationid').AsInteger;
          nvhelpstartstation.Text:=self.jcdsResult.FieldByName('startstationname').AsString;
          nvhelpstartstation.Enabled:=false;
        finally
          nvhelpstartstation.OnIdChange:=OnIdChange_old;
        end;
        OnIdChange_old:=nvhelpendstation.OnIdChange;
        nvhelpendstation.OnIdChange:=nil;
        try
          nvhelpendstation.id:=self.jcdsResult.FieldByName('endstationid').AsInteger;
          nvhelpendstation.Text:=self.jcdsResult.FieldByName('endstationname').AsString;
          nvhelpendstation.Enabled:=false;
        finally
          nvhelpendstation.OnIdChange:=OnIdChange_old;
        end;
        NvCbbdistricttype.SetItemIndexByCode(self.jcdsResult.FieldByName('districttype').AsString);
        nvcbbtype.SetItemIndexByCode(self.jcdsResult.FieldByName('type').AsString);
        nvcbbgrade.SetItemIndexByCode(self.jcdsResult.FieldByName('grade').AsString);
        nvcbbdirection.SetItemIndexByCode(self.jcdsResult.FieldByName('direction').AsString);
        memremarks.Text:=self.jcdsResult.FieldByName('remarks').AsString;

        routecode:=self.jcdsResult.FieldByName('code').AsString;
        routejianpin:=self.jcdsResult.FieldByName('jianpin').AsString;
        routedistance:=self.jcdsResult.FieldByName('distance').AsString;
        routehighdistance:=self.jcdsResult.FieldByName('highdistance').AsString;
        NovaCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
        routeisaudited:=self.jcdsResult.FieldByName('isaudited').AsString;
        routeisauditpass:=self.jcdsResult.FieldByName('isauditpass').AsString;
        routeisactive:=self.jcdsResult.FieldByName('isactive').AsString;
        routecreatetime:=self.jcdsResult.FieldByName('createtime').AsString;
        routecreateby:=self.jcdsResult.FieldByName('createby').AsString;
        routeupdatetime:=self.jcdsResult.FieldByName('updatetime').AsString;
        routeupdateby:=self.jcdsResult.FieldByName('updateby').AsString;
        synccode:=self.jcdsResult.FieldByName('synccode').AsString;
        nvedtdistance.Text:=self.jcdsResult.FieldByName('distance').AsString;
        nvedtdistance.Enabled:=false;
        NovaCbbOrg.Enabled:=false;
        nvedtjianpin.Text:=self.jcdsResult.FieldByName('jianpin').AsString;
        nvedtdays.Text:=self.jcdsResult.FieldByName('returntripvaliddays').AsString;
        nvedtReportinterval.Text:=Self.jcdsResult.FieldByName('reportinterval').AsString;
       // sysdialogs.ShowMessage(self.jcdsResult.FieldByName('isaudited').AsString);
     //   sysdialogs.ShowMessage(Self.jcdsResult.FieldByName('isrealnameticket').AsString);
        ischkisRealnameticketingroute:=Self.jcdsResult.FieldByName('isrealnameticket').AsBoolean;
        chkisRealnameticketing.Checked  := ischkisRealnameticketingroute;
      end;
      if SysMainForm.showFormModal(FrmRouteAdd,false)=mrok then
      begin
        id := FrmRouteAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmRouteAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmRoute.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount=0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    NovaCkbOrg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_LIKES_r!name_OR_r!code_OR_r!jianpin']:=trim(edtname.Text);
    if NvHpendstation.Id>0 then
    begin
      Params.ParamValues['filter_EQL_ste!id']:=NvHpendstation.Id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_ste!id']:='';
    end;
    if NvCbbdistricttype.ItemIndex>0 then
    begin
      Params.ParamValues['filter_EQS_r!districttype']:=NvCbbdistricttype.GetSelectCode;
    end
    else
    begin
      Params.ParamValues['filter_EQS_r!districttype']:='';
    end;
    jcdsResult.AfterScroll:=nil;
    try
      Active:=true;
      if recordcount>0 then
      begin
        jcdsResultAfterScroll(nil);
      end;
    finally
      jcdsResult.AfterScroll:=jcdsResultAfterScroll;
    end;
  end;
end;

procedure TFrmRoute.tbtnInsertClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  FrmRouteAdd:=TFrmRouteAdd.Create(self,self.functionItem);
  try
    FrmRouteAdd.Caption:='添加线路';
    FrmRouteAdd.edittype:=Tedittype.add;
    if SysMainForm.showFormModal(FrmRouteAdd,false)=mrOk then
    begin
      id := FrmRouteAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmRouteAdd);
  end;
end;

procedure TFrmRoute.tbtnupdateroadClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsrouteroad.Active=True) and (jcdsrouteroad.RecNo>0) then
  begin
    FrmRouteroadAdd:=TFrmRouteroadAdd.Create(self,self.functionItem);
    try
      with FrmRouteroadAdd do
      begin
        Caption:='修改线路路段';
        edittype:=Tedittype.update;
        nvedtdistance.Text:=self.jcdsrouteroad.FieldByName('distance').AsString;
        nvedtentrancename.Text:=self.jcdsrouteroad.FieldByName('entrancename').AsString;
        nvedtname.Text:=self.jcdsrouteroad.FieldByName('name').AsString;
        nvedtexitname.Text:=self.jcdsrouteroad.FieldByName('exitname').AsString;
        nvcbbroutegrade.SetItemIndexByCode(self.jcdsrouteroad.FieldByName('roadgrade').AsString);

        id:=self.jcdsrouteroad.FieldByName('id').AsString;
        routeid:=self.jcdsrouteroad.FieldByName('routeid').AsString;
        orderno:=self.jcdsrouteroad.FieldByName('orderno').AsString;
        createby:=self.jcdsrouteroad.FieldByName('createby').AsString;
        createtime:=self.jcdsrouteroad.FieldByName('createtime').AsString;
        updateby:=self.jcdsrouteroad.FieldByName('updateby').AsString;
        updatetime:=self.jcdsrouteroad.FieldByName('updatetime').AsString;
      end;
      if SysMainForm.showFormModal(FrmRouteroadAdd,False)=mrok then
      begin
        id := FrmRouteroadAdd.operationid;
        refreshRouteroad;
        jcdsrouteroad.Locate('id',id,[]);
      end;
    finally
      FreeAndNil(FrmRouteroadAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmRoute.tbtnUpdatestopClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsroutestop.Active=True) and (jcdsroutestop.RecNo>0) then
  begin
    FrmRoutestopAdd:=TFrmRoutestopAdd.Create(self,self.functionItem);
    try
      with FrmRoutestopAdd do
      begin
        Caption:='修改线路停靠点';
        edittype:=Tedittype.update;
        nvedtbalancedistance.Text:=self.jcdsroutestop.FieldByName('balancedistance').AsString;
        nvedtdistance.Text:=self.jcdsroutestop.FieldByName('distance').AsString;
        nvhelpstation.Id:=self.jcdsroutestop.FieldByName('stationid').AsInteger;
        nvhelpstation.Text:=self.jcdsroutestop.FieldByName('stationname').AsString;
        if (self.jcdsroutestop.FieldByName('stationid').AsString=self.jcdsResult.FieldByName('startstationid').AsString)
           or (self.jcdsroutestop.FieldByName('stationid').AsString=self.jcdsResult.FieldByName('endstationid').AsString) then
        begin
          nvhelpstation.Enabled:=False;
        end
        else
        begin
          nvhelpstation.Enabled:=True;
        end;
        id:=self.jcdsroutestop.FieldByName('id').AsString;
        routeid:=self.jcdsroutestop.FieldByName('routeid').AsString;
        orderno:=self.jcdsroutestop.FieldByName('orderno').AsString;
        createby:=self.jcdsroutestop.FieldByName('createby').AsString;
        chkChkIsDepart.Checked:=self.jcdsroutestop.FieldByName('isdepart').AsBoolean;
        createtime:=self.jcdsroutestop.FieldByName('createtime').AsString;
        updateby:=self.jcdsroutestop.FieldByName('updateby').AsString;
        updatetime:=self.jcdsroutestop.FieldByName('updatetime').AsString;
        isactive:=self.jcdsroutestop.FieldByName('isactive').AsString;
      end;
      if SysMainForm.showFormModal(FrmRoutestopAdd,False)=mrok then
      begin
        id := FrmRoutestopAdd.operationid;
        refreshRoutestop;
        jcdsroutestop.Locate('id',id,[]);
        if jcdsroutestop.RecNo=jcdsroutestop.RecordCount then
        begin
          jcdsResult.Edit;
          jcdsResult.FieldByName('DISTANCE').AsInteger:=jcdsroutestop.FieldByName('DISTANCE').AsInteger;
//          jcdsResult.FieldByName('highdistance').AsInteger:=jcdsroutestop.FieldByName('highdistance').AsInteger;
        end;
      end;
    finally
      FreeAndNil(FrmRoutestopAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmRoute.tbtnuproadClick(Sender: TObject);
var id:String;
begin
  inherited;
  if jcdsrouteroad.RecNo=1 then
  begin
    SysDialogs.ShowInfo('起始路段不能上移！');
    exit;
  end
//  else if jcdsrouteroad.RecNo=2 then
//  begin
//    SysDialogs.ShowError('不能上移为起始路段！');
//    exit;
//  end
//  else if jcdsrouteroad.RecNo=jcdsrouteroad.RecordCount then
//  begin
//    SysDialogs.ShowError('末尾路段不能上移！');
//    exit;
//  end
  ;
  with jcdsswaproadorderno do
  begin
    id:=jcdsrouteroad.FieldByName('id').AsString;
    Params.ParamValues['swapid1']:=id;
    jcdsrouteroad.Prior;
    Params.ParamValues['swapid2']:=jcdsrouteroad.FieldByName('id').AsString;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      refreshRouteroad;
      jcdsrouteroad.Locate('id',id,[]);
    end;
  end;
end;

procedure TFrmRoute.tbtnupstopClick(Sender: TObject);
var id:String;
begin
  inherited;
  if jcdsroutestop.RecNo=1 then
  begin
    SysDialogs.ShowInfo('始发站点不能上移！');
    exit;
  end
  else if jcdsroutestop.RecNo=2 then
  begin
    SysDialogs.ShowInfo('不能上移为始发站点！');
    exit;
  end
  else if jcdsroutestop.RecNo=jcdsroutestop.RecordCount then
  begin
    SysDialogs.ShowInfo('终到站点不能上移！');
    exit;
  end;
  with jcdsswapstoporderno do
  begin
    id:=jcdsroutestop.FieldByName('id').AsString;
    Params.ParamValues['swapid1']:=id;
    jcdsroutestop.Prior;
    Params.ParamValues['swapid2']:=jcdsroutestop.FieldByName('id').AsString;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      refreshRoutestop;
      jcdsroutestop.Locate('id',id,[]);
    end;
  end;
end;

end.