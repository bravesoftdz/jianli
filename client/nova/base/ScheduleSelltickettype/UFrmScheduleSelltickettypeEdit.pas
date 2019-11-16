unit UFrmScheduleSelltickettypeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
  DB, DBClient, jsonClientDataSet, USimpleEditForm,
  ToolWin, Generics.Collections, FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox, NovaListView,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaCheckedComboBox;

type
  TfrmScheduleSelltickettypeEdit = class(TSimpleEditForm)
    lbltype: TLabel;
    lblOrgid: TLabel;
    jsdcSave: TjsonClientDataSet;
    nvcbbSelltype: TNovaComboBox;
    lblSellType: TLabel;
    lbl28: TLabel;
    lbl2: TLabel;
    mmoMeRemark: TMemo;
    lblRemark: TLabel;
    lbl3: TLabel;
    nvHcbbOrg: TNovaHComboBox;
    nvdbgrdhRouteSchedule: TNvDbgridEh;
    pnl1: TPanel;
    bvl1: TBevel;
    lblroute: TLabel;
    lblschedule: TLabel;
    Label1: TLabel;
    lbl4: TLabel;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    grp2: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    grp1: TGroupBox;
    nvdbgrdh3: TNvDbgridEh;
    Panel1: TPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lbl1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    NovaComboBox1: TNovaComboBox;
    nvhcbbOrgid: TNovaHComboBox;
    edtSellDays: TNovaEdit;
    Memo1: TMemo;
    NvDbgridEh1: TNvDbgridEh;
    Panel2: TPanel;
    Bevel3: TBevel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NovaEdit1: TNovaEdit;
    NovaEdit2: TNovaEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    GroupBox1: TGroupBox;
    NvDbgridEh2: TNvDbgridEh;
    GroupBox2: TGroupBox;
    NvDbgridEh3: TNvDbgridEh;
    pmMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    jcdsSchedule: TjsonClientDataSet;
    dsScheduleResult: TDataSource;
    lbl5: TLabel;
    nvhlpRoute: TNovaHelp;
    nvcbbTickettypes: TNovaCheckedComboBox;
    labtype: TLabel;
    nvcbbtype: TNovaComboBox;
    labvalue: TLabel;
    nvedtvalue: TNovaEdit;
    lbl12: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvcbbSelltypeChange(Sender: TObject);
    procedure nvhcbbOrgidChange(Sender: TObject);
    procedure nvHcbbOrgTypeChange(Sender: TObject);
    procedure nvhlpRouteIdChange(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure nvhlpRouteChange(Sender: TObject);
    procedure nvcbbtypeChange(Sender: TObject);
    procedure nvedtvalueChange(Sender: TObject);
  private
    { Private declarations }
    ischecks: TDictionary<int64, boolean>;
  public
    { Public declarations }
    id: Int64;
    createby:Int64;
    types,remarks,typename, orgname,createtime,orgid,typeid: string;
    tid,tname :string;
    class function getSubFunctionList: TList<TSubfunction>;
  end;

var
  frmScheduleSelltickettypeEdit: TfrmScheduleSelltickettypeEdit;

implementation

uses PubFn, Services;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

class function TfrmScheduleSelltickettypeEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;



procedure TfrmScheduleSelltickettypeEdit.bbtnSaveClick(Sender: TObject);
var
  MResult,optype,log,scheduleids,schedulename,schedulecode: string;
  FResult: integer;
begin

  if nvHcbbOrg.ItemIndex < 0 then
  begin
    SysDialogs.Warning('机构不能为空');
    nvcbbSelltype.SetFocus;
    exit;
  end;
  if nvcbbSelltype.GetSelectID < 0 then
  begin
    SysDialogs.Warning('请选择班线类型！');
    nvcbbSelltype.SetFocus;
    exit
  end;

   scheduleids := '';
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        if FieldByName('checked').AsBoolean then
        begin
          scheduleids := scheduleids + FieldByName('id').AsString + ',';
          schedulename := schedulename+  FieldByName('name').AsString + ',';
          schedulecode := schedulecode+  FieldByName('code').AsString + ',';
        end;
        Next;
      end;
      EnableControls;
    end;
  end;
  if scheduleids = '' then
    scheduleids := inttostr(edtschedule.Id) + ',';

     if (nvcbbSelltype.GetSelectCode<>'0') and (schedulename='')  then
  begin
    if nvcbbSelltype.GetSelectCode = '1' then // 选择线路
    begin
        SysDialogs.Warning('请选择要控制的线路！');
        nvcbbSelltype.Focused;
         Exit;
    end
    else if nvcbbSelltype.GetSelectCode = '2' then // 选择班次
    begin
        if nvhlpRoute.Text='' then
        begin
           SysDialogs.Warning('请输入线路！');
           nvhlpRoute.Focused;
           Exit;
        end;
        SysDialogs.Warning('请选择要控制的班次！');
        nvcbbSelltype.Focused;
        Exit;

    end;
  end;

   if Trim(nvcbbTickettypes.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择车票票种！');
    nvcbbTickettypes.Focused ;
    Exit;
  end;
//  if nvcbbtype.ItemIndex<0 then
//  begin
//     SysDialogs.ShowMessage('请选择张数类型！');
//    nvcbbtype.Focused ;
//    Exit;
//  end;
  with jsdcSave do
  begin
    Close;
    Params.ParamByName('selltickettype.id').Value := id;
    if id>0 then
    begin
      Params.ParamByName('isupdate').Value :=  'true';
      Params.ParamByName('selltickettype.typeid').Value :=typeid;
    Params.ParamByName('selltickettype.tickettypeid').Value := tid;
    end;

    Params.ParamByName('selltickettype.orgid').Value := nvHcbbOrg.HelpFieldValue['id'];


    Params.ParamValues['tickettypes'] := nvcbbTickettypes.GetSelectID;

    Params.ParamByName('selltickettype.type').Value := nvcbbSelltype.GetSelectCode;
    Params.ParamByName('selltickettype.createby').Value := createby;
    Params.ParamByName('selltickettype.createtime').Value := createtime;
    Params.ParamByName('selltickettype.updateby').Value := SysInfo.LoginUserInfo.UserID;
    Params.ParamByName('selltickettype.remarks').Value := mmoMeRemark.Text;
    Params.ParamByName('typeids').Value :=  scheduleids;
    if (nvcbbtype.ItemIndex<0) or (nvedtvalue.Text='0') then
    begin
      Params.ParamByName('selltickettype.canselltype').Value := '-1';
      Params.ParamByName('selltickettype.cansellvalue').Value := '0';
    end
    else
    begin
      Params.ParamByName('selltickettype.canselltype').Value := nvcbbtype.GetSelectCode;
      Params.ParamByName('selltickettype.cansellvalue').Value := nvedtvalue.Text;
    end;

    try
      Execute;
      FResult := Params.ParamByName('flag').Value;
      MResult := Params.ParamByName('msg').Value;

      if (FResult <= 0) then
      begin
        SysDialogs.ShowError(MResult);
        nvHcbbOrg.SetFocus;
      end
      else
      begin
        if id>0 then
        begin
           optype:='修改';
            if typename <> nvcbbSelltype.Text then
           begin
              log := '将班次预售票种控制的 班线类型由 '+typename+
                    ' 改成 '+nvcbbSelltype.Text;
           end;
             if tname <> nvcbbTickettypes.Text then
           begin
             log := log+'。车票票种 由'+tname+' 改成:'+ nvcbbTickettypes.Text+', ';
           end;

            log:= log+'。操作到的班线有：'+schedulename;
        end
        else
        begin
           optype:='添加';
            log := '所属机构:'+ nvHcbbOrg.Text +', 班线类型:'+nvcbbSelltype.Text+', 票种:'+
                nvcbbTickettypes.Text+' ，操作到的班线有：'+schedulename;
        end;
        SysLog.WriteLog('班次预售票种控制', optype, log);
        log:='';
        optype:='';

        SysDialogs.ShowMessage(MResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('操作失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmScheduleSelltickettypeEdit.FormCreate(Sender: TObject);
begin
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;

  nvHcbbOrg.Active := False;
  nvHcbbOrg.Active := True;
  nvcbbTickettypes.Active:= False;
  nvcbbTickettypes.Active := True;

  nvcbbtype.Active :=False;
  nvcbbtype.Active :=True;

end;

procedure TfrmScheduleSelltickettypeEdit.nvcbbSelltypeChange(Sender: TObject);
begin
  if nvHcbbOrg.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请先选择机构!');
    nvHcbbOrg.SetFocus;
    exit;
  end;


  if nvcbbSelltype.GetSelectCode <> '2' then
  begin
    lbl5.Visible:= False;
    lbl5.Left := 29;
    lbl5.Top :=107;
     nvhlpRoute.Visible:=False;
     nvcbbTickettypes.Top := 106;
     nvcbbTickettypes.Left := 91;
     edtSellDays.Top:= 114;
     edtSellDays.Left:=91;
     lbl2.Top := 107;
     lbl2.Left:= 241;


     labtype.Top :=142;
     labtype.Left :=29;
     nvcbbtype.Top :=138;
     nvcbbtype.Left :=91;

     labvalue.Top :=175;
     labvalue.Left :=71;
     nvedtvalue.Top :=170;
     nvedtvalue.Left :=91;

     lblRemark.top:=208;
     lblRemark.Left:= 57;
     mmoMeRemark.Top:= 208;
     mmoMeRemark.Left:=91;
     lbltype.Left:=29;
     lbltype.Top := 110;
     lbl12.Top := 107;
     lbl12.Left:= 241;
  end
  else
  begin
    nvhlpRoute.Visible:=True;
    lbl5.Visible:=True;
    lbl5.Left := 29;
    lbl5.Top :=109;
    nvhlpRoute.Top:=107 ;
    nvhlpRoute.Left :=91;
    nvcbbTickettypes.Top := 142;
     nvcbbTickettypes.Left := 91;
     edtSellDays.Top:= 142;
     edtSellDays.Left:=91;
     lbl2.Top := 107;
     lbl2.Left:= 241;

      labtype.Top :=183;
     labtype.Left :=29;
     nvcbbtype.Top :=179;
     nvcbbtype.Left :=91;

     labvalue.Top :=216;
     labvalue.Left :=71;
     nvedtvalue.Top :=213;
     nvedtvalue.Left :=91;

     lblRemark.top:=249;
     lblRemark.Left:= 57;
     mmoMeRemark.Top:= 249;
     mmoMeRemark.Left:=91;
     lbltype.Left:=29;
     lbltype.Top := 144;
     lbl12.Top := 143;
     lbl12.Left:= 241;
  end;
   orgid := nvHcbbOrg.HelpFieldValue['id'];
  ischecks := TDictionary<int64, boolean>.create();
    with jcdsSchedule do
    begin
      if nvcbbSelltype.GetSelectCode <>'1' then
      begin
        Active := false;
        Params.ParamByName('type').Value := '1';
        Params.ParamByName('orgid').Value :='0';
        Active := true;
      end
      else
      begin
        Active := false;
        Params.ParamByName('orgid').Value := nvHcbbOrg.HelpFieldValue['id'];
        Params.ParamValues['type'] := nvcbbSelltype.GetSelectCode;
        Active := true;
      end;
    end;
end;

procedure TfrmScheduleSelltickettypeEdit.nvcbbtypeChange(Sender: TObject);
begin
  inherited;
 if nvcbbtype.GetSelectCode='0' then
   begin
       nvedtvalue.ValueType :=ssTicket;
       nvedtvalue.Text :='1';
       nvedtvalue.MaxLength :=3;
   end;

   if nvcbbtype.GetSelectCode='1' then
   begin
       nvedtvalue.ValueType :=ssNumber;
       nvedtvalue.MaxLength :=4;
       nvedtvalue.Text :='0.1';
   end;
end;

procedure TfrmScheduleSelltickettypeEdit.nvedtvalueChange(Sender: TObject);
begin
  inherited;

  if (nvcbbtype.GetSelectCode='1') and (StrToFloat(nvedtvalue.Text)>1) then
   begin
       nvedtvalue.Text :='1';
   end;
end;

procedure TfrmScheduleSelltickettypeEdit.nvhlpRouteIdChange(Sender: TObject);
begin
  inherited;
  if nvhlproute.Id>0 then
  begin
    ischecks := TDictionary<int64, boolean>.create();
    with jcdsSchedule do
    begin
      Active := false;
        Params.ParamValues['orgid'] := orgid;
        Params.ParamValues['type'] := nvcbbSelltype.GetSelectCode;
        Params.ParamValues['routeid'] := nvhlpRoute.Id;
      Active := true;
    end;
  end;
end;

procedure TfrmScheduleSelltickettypeEdit.nvHcbbOrgTypeChange(
  Sender: TObject);
begin
  inherited;
  if nvHcbbOrg.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择机构！');
    nvHcbbOrg.SetFocus;
    exit;
  end;

end;

procedure TfrmScheduleSelltickettypeEdit.nvhcbbOrgidChange(Sender: TObject);
begin
  // 改变 机构，清除lv
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvcbbSelltype.Text := '请选择...';
  nvcbbSelltype.ItemIndex := -1;
//  nvlvSchedule.Items.Clear;
//  nvlvRoute.Items.Clear;

end;


procedure TfrmScheduleSelltickettypeEdit.nvhlpRouteChange(Sender: TObject);
begin
  inherited;
  if nvhlproute.Id>0 then
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
  end;
end;


procedure TfrmScheduleSelltickettypeEdit.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('checked').Value := true;
        Next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TfrmScheduleSelltickettypeEdit.N2Click(Sender: TObject);
begin
  inherited;
   with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('checked').Value := not FieldByName('checked').AsBoolean;
        Next;
      end;
      EnableControls;
    end;
  end;
end;


procedure TfrmScheduleSelltickettypeEdit.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsSchedule do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        edit;
        FieldByName('checked').Value := false;
        Next;
      end;
      EnableControls;
    end;
  end;
end;


end.
