unit UFrmOnecardscheduleEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
  DB, DBClient, jsonClientDataSet, USimpleEditForm,
  ToolWin, Generics.Collections, FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox, NovaListView,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh;

type
  TfrmOnecardscheduleEdit = class(TSimpleEditForm)
    lblOrgid: TLabel;
    jsdcSave: TjsonClientDataSet;
    nvcbbSelltype: TNovaComboBox;
    lblSellType: TLabel;
    nvhcbbOrgid: TNovaHComboBox;
    lbl28: TLabel;
    lbl1: TLabel;
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
    lbl2: TLabel;
    lbl6: TLabel;
    dtpStart: TDateTimePicker;
    dtpEnd: TDateTimePicker;
    lbl7: TLabel;
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
    types, days,remarks,typename, orgname,
    createtime,enddate,startdate,schedulename,typeid: string;
    isupdate:Boolean;
    class function getSubFunctionList: TList<TSubfunction>;
  end;

var
  frmOnecardscheduleEdit: TfrmOnecardscheduleEdit;

implementation

uses PubFn, Services;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

procedure TfrmOnecardscheduleEdit.bbtnSaveClick(Sender: TObject);
var
  MResult,optype,log,scheduleids: string;
  FResult: integer;
begin
  inherited;

  if nvhcbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('��ѡ�����');
    nvcbbSelltype.SetFocus;
    exit;
  end;
  if nvcbbSelltype.GetSelectID < 0 then
  begin
    SysDialogs.Warning('��ѡ��������ͣ�');
    nvcbbSelltype.SetFocus;
    exit
  end;
  if (FormatDateTime('yyyymmdd', dtpstart.Date) > FormatDateTime('yyyymmdd',
    dtpEnd.Date) )then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
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


    if (nvcbbSelltype.GetSelectCode<>'0') and (scheduleids='')  then
  begin
    if nvcbbSelltype.GetSelectCode = '1' then // ѡ����·
    begin
        SysDialogs.Warning('��ѡ��Ҫ���Ƶ���·��');
        nvcbbSelltype.Focused;
         Exit;
    end
    else if nvcbbSelltype.GetSelectCode = '2' then // ѡ����
    begin
        if (id<0)  and (nvhlpRoute.Text='') then
        begin
           SysDialogs.Warning('��������·��');
           nvhlpRoute.Focused;
           Exit;
        end;
        SysDialogs.Warning('��ѡ��Ҫ���Ƶİ�Σ�');
        nvcbbSelltype.Focused;
        Exit;

    end;
  end;

  with jsdcSave do
  begin

    Close;
    Params.ParamByName('onecardschedule.id').Value := id;
    if id>0 then
    Params.ParamByName('isupdate').Value :=  'true';

    Params.ParamByName('onecardschedule.orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
    Params.ParamByName('onecardschedule.startdate').Value
                    := FormatDateTime('yyyy-mm-dd',dtpstart.Date);
    Params.ParamByName('onecardschedule.enddate').Value
                    := FormatDateTime('yyyy-mm-dd',dtpEnd.Date);
    Params.ParamByName('onecardschedule.type').Value := nvcbbSelltype.GetSelectCode;
    Params.ParamByName('onecardschedule.createby').Value := createby;
    Params.ParamByName('onecardschedule.createtime').Value := createtime;
    Params.ParamByName('onecardschedule.remarks').Value := mmoMeRemark.Text;
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
        SysDialogs.ShowError(MResult);
        nvhcbbOrgid.SetFocus;
    end
    else
    begin
        if id>0 then
        begin
         optype:='�޸�';

         if startdate <> DateToStr(dtpStart.Date)  then
         begin
            log := '�� ��ʼ���� �� '+startdate+
                  ' �ĳ� '+ DateToStr(dtpStart.Date);
         end;
         if enddate <> DateToStr(dtpEnd.Date)  then
         begin
            log := log+'�� �������� �� '+enddate+
                  ' �ĳ� '+ DateToStr(dtpend.Date);
         end;
         if remarks<> mmoMeRemark.Text then
         begin
           log := log+',�� ��ע �� '+ remarks+' �ĳ�'+ mmoMeRemark.Text;
         end;

            log:= log+',�������İ����У�'+schedulename;
        end
        else
        begin
           optype:='���';
            log := '��������:'+ nvhcbbOrgid.Text +', ��������:'+nvcbbSelltype.Text
            +', ��ʼ���ڣ�'+  DateToStr(dtpStart.Date)
            +',�������ڣ�'+DateToStr(dtpEnd.Date)
            +',�������İ����У�'+schedulename;
        end;
        SysLog.WriteLog('һ��ͨ�����ο���', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage(MResult);
        ModalResult := mrok;
    end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmOnecardscheduleEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvhcbbOrgid.Active := False;
  nvhcbbOrgid.Active := True;
  dtpStart.Date:=Now;
  dtpEnd.Date:= Now;
end;

class function TfrmOnecardscheduleEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

procedure TfrmOnecardscheduleEdit.nvcbbSelltypeChange(Sender: TObject);
begin
  inherited;
  if nvhcbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('����ѡ�����!');
    nvhcbbOrgid.SetFocus;
    exit;
  end;

  if nvcbbSelltype.GetSelectCode <> '2' then //ѡ����·
  begin
    lbl5.Visible:= False;
     nvhlpRoute.Visible:=False;
     lbl28.Visible:= False;
     lbl2.Top:=111;
     lbl2.Left:=29;
     dtpStart.Left:=91;
     dtpStart.Top:=110;
     lbl6.Top:=143;
     lbl6.Left:=29;
     dtpEnd.Left:=91;
     dtpEnd.Top:=142;
     lblRemark.top:=177;
     lblRemark.Left:= 57;
     mmoMeRemark.Top:= 178;
     mmoMeRemark.Left:=91;
  end
  else
  begin   //ѡ����ʱ����ʾ��·�����
    nvhlpRoute.Visible:=True;
    lbl5.Visible:=True;
    lbl28.Visible:=True;
    lbl28.Left := 257;
    lbl2.Top :=147;
    lbl2.Left:=29;
    lbl6.Top :=179;
    lbl6.Left :=29;
    dtpStart.Top:=147;
    dtpStart.Left:=91;
    dtpEnd.Top:=178;
    dtpEnd.Left:=91;
     lblRemark.top:=212;
     lblRemark.Left:= 56;
     mmoMeRemark.Top:= 211;
     mmoMeRemark.Left:=90;
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

procedure TfrmOnecardscheduleEdit.nvhlpRouteIdChange(Sender: TObject);
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

procedure TfrmOnecardscheduleEdit.N1Click(Sender: TObject);
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

procedure TfrmOnecardscheduleEdit.N2Click(Sender: TObject);
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

procedure TfrmOnecardscheduleEdit.N3Click(Sender: TObject);
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

procedure TfrmOnecardscheduleEdit.nvedtIPKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', '.', #8]) then
  begin
    Key := #13;
  end;
end;

procedure TfrmOnecardscheduleEdit.nvhcbbOrgidChange(Sender: TObject);
begin
  inherited;
  // �ı� ���������lv
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvcbbSelltype.Text := '��ѡ��...';
  nvcbbSelltype.ItemIndex := -1;
//  nvlvSchedule.Items.Clear;
//  nvlvRoute.Items.Clear;
//  jcdsSchedule.Refresh;

end;


end.
