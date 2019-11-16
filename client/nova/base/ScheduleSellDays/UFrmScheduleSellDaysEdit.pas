unit UFrmScheduleSellDaysEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
  DB, DBClient, jsonClientDataSet, USimpleEditForm,
  ToolWin, Generics.Collections, FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox, NovaListView,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh;

type
  TfrmScheduleSellDaysEdit = class(TSimpleEditForm)
    lblDay: TLabel;
    lblOrgid: TLabel;
    jsdcSave: TjsonClientDataSet;
    nvcbbSelltype: TNovaComboBox;
    lblSellType: TLabel;
    nvhcbbOrgid: TNovaHComboBox;
    lbl28: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    edtSellDays: TNovaEdit;
    mmoMeRemark: TMemo;
    lblRemark: TLabel;
    nvdbgrdhRouteSchedule: TNvDbgridEh;
    pnl1: TPanel;
    bvl1: TBevel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    grp2: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    grp1: TGroupBox;
    nvdbgrdh3: TNvDbgridEh;
    dsScheduleResult: TDataSource;
    jcdsSchedule: TjsonClientDataSet;
    pmMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    lbl5: TLabel;
    nvhlpRoute: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvcbbSelltypeChange(Sender: TObject);
    procedure nvhcbbOrgidChange(Sender: TObject);
    procedure nvedtIPKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure nvhlpRouteIdChange(Sender: TObject);
  private
    { Private declarations }
    ischecks: TDictionary<int64, boolean>;
  public
    { Public declarations }
    id: Int64;
    createby:Int64;
    types, days,remarks,typename,schedulename, orgname,createtime: string;
    isupdate:Boolean;
    class function getSubFunctionList: TList<TSubfunction>;
  end;

var
  frmScheduleSellDaysEdit: TfrmScheduleSellDaysEdit;

implementation

uses PubFn, Services;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

procedure TfrmScheduleSellDaysEdit.bbtnSaveClick(Sender: TObject);
var
  MResult,optype,log,scheduleids: string;
  FResult: integer;
begin
  inherited;

  if nvhcbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择机构');
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
        end;
        Next;
      end;
      EnableControls;
    end;
  end;


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
        if (id<0)  and (nvhlpRoute.Text='') then
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

  if edtSellDays.Text='' then
  begin
    SysDialogs.Warning('请输入预售天数！');
    edtSellDays.SetFocus;
    exit;
  end;



  with jsdcSave do
  begin

    Close;
    Params.ParamByName('scheduleperselldays.id').Value := id;
    if id>0 then
    Params.ParamByName('isupdate').Value :=  'true';

    Params.ParamByName('scheduleperselldays.orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
    Params.ParamByName('scheduleperselldays.perserlldays').Value := edtSellDays.Text;
    Params.ParamByName('scheduleperselldays.type').Value := nvcbbSelltype.GetSelectCode;
    Params.ParamByName('scheduleperselldays.createby').Value := createby;
    Params.ParamByName('scheduleperselldays.createtime').Value := createtime;
    Params.ParamByName('scheduleperselldays.remarks').Value := mmoMeRemark.Text;
    if not( nvcbbSelltype.Text='' )then
    begin
      types:= nvcbbSelltype.GetSelectCode;
    end;
        Params.ParamByName('typeids').Value :=  scheduleids;
   try
     Execute;
    FResult := Params.ParamByName('flag').Value;
    MResult := Params.ParamByName('msg').Value;

    if (FResult <= 0) then
    begin
        SysDialogs.Warning(MResult);
        nvhcbbOrgid.SetFocus;
    end
    else
    begin
        if id>0 then
        begin
           optype:='修改';
            if typename <> nvcbbSelltype.Text then
           begin
              log := '将班次预售天数控制的 班线类型由 '+typename+
                    ' 改成 '+nvcbbSelltype.Text;
           end;
             if days <> edtSellDays.Text then
           begin
              log := '将预售天数由 '+days+
                    ' 改成 '+ edtSellDays.Text;
           end;
            log:= log+'。操作到的班线有：'+schedulename;

        end
        else
        begin
           optype:='添加';
            log := '所属机构:'+ nvhcbbOrgid.Text +', 班线类型:'+nvcbbSelltype.Text+', 预售天数'+
                edtSellDays.Text +'。操作到的班线有：'+schedulename;
        end;
        SysLog.WriteLog('班次预售天数控制', optype, log);
        log:='';
        optype:='';

        id := Params.ParamByName('id').Value;
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

procedure TfrmScheduleSellDaysEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvhcbbOrgid.Active := False;
  nvhcbbOrgid.Active := True;
end;

class function TfrmScheduleSellDaysEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

procedure TfrmScheduleSellDaysEdit.nvcbbSelltypeChange(Sender: TObject);
begin
  inherited;
  if nvhcbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请先选择机构!');
    nvhcbbOrgid.SetFocus;
    exit;
  end;

  if nvcbbSelltype.GetSelectCode <> '2' then
  begin
    lbl5.Visible:= False;
     nvhlpRoute.Visible:=False;
     lblDay.Top := 117;
     lblDay.Left := 29;
     edtSellDays.Top:= 114;
     edtSellDays.Left:=91;
     lbl2.Top := 117;
     lbl2.Left:= 154;
     lblRemark.top:=153;
     lblRemark.Left:= 57;
     mmoMeRemark.Top:= 150;
     mmoMeRemark.Left:=91;
  end
  else
  begin
    nvhlpRoute.Visible:=True;
    lbl5.Visible:=True;
    lblDay.Top := 145;
     lblDay.Left := 29;
     edtSellDays.Top:= 142;
     edtSellDays.Left:=91;
     lbl2.Top := 143;
     lbl2.Left:= 154;
     lblRemark.top:=176;
     lblRemark.Left:= 57;
     mmoMeRemark.Top:= 175;
     mmoMeRemark.Left:=91;
  end;

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
        Params.ParamByName('orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
        Params.ParamValues['type'] := nvcbbSelltype.GetSelectCode;
        Active := true;
      end;
    end;
end;

procedure TfrmScheduleSellDaysEdit.nvhlpRouteIdChange(Sender: TObject);
begin
  inherited;
  if nvhlproute.Id>0 then
  begin
    ischecks := TDictionary<int64, boolean>.create();
    with jcdsSchedule do
    begin
      Active := false;
        Params.ParamByName('orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
        Params.ParamValues['type'] := nvcbbSelltype.GetSelectCode;
        Params.ParamValues['routeid'] := nvhlpRoute.Id;
      Active := true;
    end;
  end;
end;

procedure TfrmScheduleSellDaysEdit.N1Click(Sender: TObject);
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

procedure TfrmScheduleSellDaysEdit.N2Click(Sender: TObject);
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

procedure TfrmScheduleSellDaysEdit.N3Click(Sender: TObject);
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

procedure TfrmScheduleSellDaysEdit.nvedtIPKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', '.', #8]) then
  begin
    Key := #13;
  end;
end;

procedure TfrmScheduleSellDaysEdit.nvhcbbOrgidChange(Sender: TObject);
begin
  inherited;
  // 改变 机构，清除lv
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvcbbSelltype.Text := '请选择...';
  nvcbbSelltype.ItemIndex := -1;
//  nvlvSchedule.Items.Clear;
//  nvlvRoute.Items.Clear;
//  jcdsSchedule.Refresh;

end;


end.
