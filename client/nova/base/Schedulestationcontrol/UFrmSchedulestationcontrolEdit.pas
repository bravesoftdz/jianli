unit UFrmSchedulestationcontrolEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
  DB, DBClient, jsonClientDataSet, USimpleEditForm,
  ToolWin, Generics.Collections, FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox, NovaListView,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaCheckedComboBox;

type
  TfrmSchedulestationcontrolEdit = class(TSimpleEditForm)
    lblOrgid: TLabel;
    lbl28: TLabel;
    lbl3: TLabel;
    nvHcbbOrg: TNovaHComboBox;
    pmMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    lbl5: TLabel;
    nvhlpRoute: TNovaHelp;
    nvdbgrdh1: TNvDbgridEh;
    jsonSchedulestationcontrol: TjsonClientDataSet;
    DsTicketprices: TDataSource;
    jsonSchedulestationcontrolid: TLargeintField;
    jsonSchedulestationcontrolstationid: TLargeintField;
    jsonSchedulestationcontrolstationname: TWideStringField;
    jsonSchedulestationcontrolcansellnum: TIntegerField;
    jsonSchedulestationcontrolcanselltime: TIntegerField;
    jsonSchedulestationcontrolisselect: TBooleanField;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhcbbOrgidChange(Sender: TObject);
    procedure nvhlpRouteIdChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure nvhlpRouteChange(Sender: TObject);
    procedure nvHcbbOrgChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ischecks: TDictionary<int64, boolean>;
  public
    { Public declarations }
    routeid,id: Int64;
    createby:Int64;
    types,remarks,typename, orgname,createtime,
    orgid,typeid,isupdate,oldcontorlmsg: string;
    tid,tname :string;
    class function getSubFunctionList: TList<TSubfunction>;
  end;

var
  frmSchedulestationcontrolEdit: TfrmSchedulestationcontrolEdit;

implementation

uses PubFn, Services;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

class function TfrmSchedulestationcontrolEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;



procedure TfrmSchedulestationcontrolEdit.bbtnSaveClick(Sender: TObject);
var
  sResult,optmsg,optype,log,stationids: string;
  nResult: integer;
begin

  if nvHcbbOrg.ItemIndex < 0 then
  begin
    SysDialogs.Warning('机构不能为空');
    nvHcbbOrg.SetFocus;
    exit;
  end;
  if nvhlpRoute.Id <= 0 then
  begin
    SysDialogs.Warning('请选择线路');
    nvhlpRoute.SetFocus;
    exit;
  end;

  stationids := '';
  with jsonSchedulestationcontrol do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
       if (FieldByName('cansellnum').AsInteger < 0)
         or (FieldByName('canselltime').AsInteger < 0  ) then
       begin
          SysDialogs.Warning('不能输入负数!');
           EnableControls;
          Exit;
       end;
        if FieldByName('isselect').AsBoolean then
        begin
          stationids := stationids + FieldByName('stationid').AsString + ',';
        end;
        if (FieldByName('cansellnum').AsString <>'' )
          or (FieldByName('canselltime').AsString <>'' )then
        begin
          optmsg := optmsg + ''+FieldByName('stationname').AsString
                +'('+FieldByName('cansellnum').AsString
                +'；'+FieldByName('canselltime').AsString+'）。';
        end;
        Next;
      end;
      EnableControls;
    end;
  end;
  if stationids = '' then
  begin
     SysDialogs.Warning('请选择要控制的站点！');
     nvdbgrdh1.Focused;
     Exit;
  end;

  with jsonSchedulestationcontrol do
  begin
    try
      Params.ParamByName('schedulestationcontrol.departorgid').Value := nvHcbbOrg.HelpFieldValue['id'];
      Params.ParamByName('schedulestationcontrol.routeid').Value :=nvhlpRoute.Id;
      Params.ParamByName('schedulestationcontrol.createby').Value := createby;
      Params.ParamByName('schedulestationcontrol.id').Value :=id;
      Params.ParamByName('isupdate').Value := isupdate;
      ApplyUpdates(-1);
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if nResult=0 then
      begin
          SysDialogs.ShowMessage('数据未做任何修改！');
          exit;
      end
      else
      begin
          SysDialogs.ShowMessage(sResult);
      end;
      if (nResult = 1) then
      begin
        ModalResult := mrok;
        routeid := nvhlpRoute.Id;
        if id>0 then
        begin
           optype:='修改';
            log:= log+'线路：'+nvhlpRoute.Text+' 。修改前的所有站点控制内容为'
            +oldcontorlmsg+'。修改后的所有站点控制内容为'+optmsg;
        end
        else
        begin
           optype:='添加';
            log := '所属机构:'+ nvHcbbOrg.Text
                  +' ,线路:'+nvhlpRoute.Text+','+optmsg;
        end;
        SysLog.WriteLog('业务管理->班次站点售票控制', optype, log);
        log:='';
        optype:='';
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('操作失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmSchedulestationcontrolEdit.FormCreate(Sender: TObject);
begin

  nvHcbbOrg.Active := False;
  nvHcbbOrg.Active := True;
end;

procedure TfrmSchedulestationcontrolEdit.FormShow(Sender: TObject);
begin
  inherited;
  if isupdate='true' then
  begin
    with jsonSchedulestationcontrol do
    begin
       if Active and (recordcount > 0) then
        begin
        DisableControls;
        First;
        while (not eof) do
        begin
          if (FieldByName('cansellnum').AsString <>'' )
            or (FieldByName('canselltime').AsString <>'' )then
          begin
          //修改前的站点控制记录
            oldcontorlmsg := oldcontorlmsg + '站点:'+FieldByName('stationname').AsString
                  +',可售数：'+FieldByName('cansellnum').AsString
                  +',提前发车时间分钟数:'+FieldByName('canselltime').AsString+'。';
          end;
          Next;
        end;
        EnableControls;
      end;
    end;
  end;
end;

procedure TfrmSchedulestationcontrolEdit.nvhlpRouteIdChange(Sender: TObject);
begin
  inherited;
  if nvhlproute.Id>0 then
  begin
    ischecks := TDictionary<int64, boolean>.create();
    with jsonSchedulestationcontrol do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_o!id'] := nvHcbbOrg.HelpFieldValue['id'];
      Params.ParamValues['filter_EQL_r!id'] := nvhlpRoute.Id;

      Active := true;
    end;
  end;
end;

procedure TfrmSchedulestationcontrolEdit.nvHcbbOrgChange(Sender: TObject);
begin
  inherited;
   nvhlpRoute.Text:= '';
     with jsonSchedulestationcontrol do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_o!id'] := '0';
      Params.ParamValues['filter_EQL_r!id'] := '0';
      Active := true;
    end;
end;

procedure TfrmSchedulestationcontrolEdit.nvhcbbOrgidChange(Sender: TObject);
begin
  // 改变 机构，清除lv
   nvhlpRoute.Text:= '';
     with jsonSchedulestationcontrol do
    begin
      Active := false;
      Params.ParamValues['filter_EQL_o!id'] := '0';
      Params.ParamValues['filter_EQL_r!id'] := '0';
      Active := true;
    end;
//  nvlvSchedule.Items.Clear;
//  nvlvRoute.Items.Clear;

end;


procedure TfrmSchedulestationcontrolEdit.nvhlpRouteChange(Sender: TObject);
begin
  inherited;
  {if nvhlproute.Id>0 then
  begin
    ischecks := TDictionary<int64, boolean>.create();
    with jcdsSchedule do
    begin
      Active := false;
        Params.ParamByName('orgid').Value := nvHcbbOrg.HelpFieldValue['id'];
        Params.ParamValues['type'] := nvcbbSelltype.GetSelectCode;
        Params.ParamValues['routeid'] := nvhlpRoute.Id;
      Active := true;
    end;
  end; }
end;


procedure TfrmSchedulestationcontrolEdit.N1Click(Sender: TObject);
begin
  inherited;
  with jsonSchedulestationcontrol do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('isselect').Value := true;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TfrmSchedulestationcontrolEdit.N2Click(Sender: TObject);
begin
  inherited;
   with jsonSchedulestationcontrol do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('isselect').Value := not FieldByName('isselect').AsBoolean;
        Next;
      end;
      EnableControls;
    end;
  end;
end;


procedure TfrmSchedulestationcontrolEdit.N3Click(Sender: TObject);
begin
  inherited;
  with jsonSchedulestationcontrol do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('isselect').Value := false;
        Next;
      end;
      EnableControls;
    end;
  end;
end;


end.
