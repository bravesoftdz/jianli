unit UFrmStation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh,NovaEdit,Services,UDMPublic,ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NvPrnDbgeh, NvDbgridEh, NovaHComboBox, NovaHelp;

type
  TFrmStation = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    jsonCDSDelStation: TjsonClientDataSet;
    lbl6: TLabel;
    lbl2: TLabel;
    nvhlpdistrictid: TNovaHelp;
    edt_name: TNovaEdit;
    edt_code: TNovaEdit;
    edt_helpcode: TNovaEdit;
    edtjianpin: TNovaEdit;
    chkyes: TCheckBox;
    chkno: TCheckBox;
    chkroundtrip: TCheckBox;
    chknoroundtrip: TCheckBox;
    Label1: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmStation: TFrmStation;

implementation
uses UFrmStationADD,PubFn;
 var districtid:Integer;
{$R *.dfm}

procedure TFrmStation.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg, log: string;
begin
  inherited;
if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDelStation do
  try
    close;
    Params.ParamByName('station.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    flag := Params.ParamByName('flag').Value;
    msg := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(msg);
    if (flag = 1) then
    begin
      log := '站点名称='+jcdsResult.FieldByName('name').AsString+',编码='+
      jcdsResult.FieldByName('code').AsString+',所属区域='+
      jcdsResult.FieldByName('districtname').AsString;
      SysLog.WriteLog('业务管理——>站点管理','删除站点信息',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('站点信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmStation.tbtnEditClick(Sender: TObject);
var i:Integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmStationADD do
  begin
    FrmStationADD := TFrmStationADD.Create(self);
    FrmStationADD.Caption:= '修改站点信息';
    id :=  jcdsResult.FieldByName('id').AsInteger;
    createby:=jcdsResult.FieldByName('createby').AsInteger;
    createtime:=jcdsResult.FieldByName('createtime').AsString;
    orgid:=jcdsResult.FieldByName('orgid').AsInteger;
    isactive:=  jcdsResult.FieldByName('isactive').AsBoolean;
    isroundtrip := jcdsResult.FieldByName('isroundtrip').AsBoolean;
    code:=jcdsResult.FieldByName('code').AsString;
    lbcode.Visible := True;
   // edtcode.Visible := True;
    edtcode.Visible:=false;
    edtcode.Enabled:=false;
    edtcode.Text := jcdsResult.FieldByName('code').AsString;
    nvhlpdistrictid.Id :=jcdsResult.FieldByName('districtid').AsInteger;
    edtsecondname.Text := jcdsResult.FieldByName('secondname').AsString;
    NovaEdtDistance.Text := jcdsResult.FieldByName('distance').AsString;
    edtname.Enabled := False;
    if Services.SysInfo.LoginUserInfo.OrgID = orgid then
    begin
    end else
    begin
      nvhlpdistrictid.Enabled := False;
      cbbgrade.Enabled := False;
      //rb_depart.Enabled := False;
    end;
    edtname.Text:=jcdsResult.FieldByName('name').AsString;
    edthelpcode.Text:=jcdsResult.FieldByName('helpcode').AsString;
    nvhlpdistrictid.Text :=jcdsResult.FieldByName('districtname').AsString;
    mmodes.Text := jcdsResult.FieldByName('description').AsString;
    edtjianpin.Text := jcdsResult.FieldByName('jianpin').AsString;
    for i := 0 to FrmStationADD.cbbgrade.Items.Count - 1 do
    begin
      try
    //TCommInfo(cbbgrade.Items.Objects[i]).Value
        if TCommInfo(cbbgrade.Items.Objects[i]).Value= jcdsResult.FieldByName('grade').AsString then
        begin
           cbbgrade.ItemIndex:=  i;
           break;
        end;
      except

      end;
    end;
    if jcdsResult.FieldByName('isdepart').AsBoolean then
    begin
      FrmStationADD.rb_depart.Checked:=True;
    end else
    begin
       FrmStationADD.rb_nodepart.Checked:=True;
    end;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
   end;
end;

procedure TFrmStation.tbtnFilterClick(Sender: TObject);
begin
  inherited;
 with jcdsResult do
   begin
    Active := false;
    if Trim(edt_name.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_s!name').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_s!name').Value := edt_name.Text;
    end;
    if Trim(edtjianpin.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_s!jianpin').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_s!jianpin').Value := edtjianpin.Text;
    end;
    if Trim(edt_code.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_s!code').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_s!code').Value := edt_code.Text;
    end;
    if Trim(nvhlpdistrictid.Text) = '' then
    begin
      Params.ParamByName('filter_EQL_s!districtid').Value := '';
    end else
    begin
      Params.ParamByName('filter_EQL_s!districtid').Value := nvhlpdistrictid.Id;
    end;
    if ((chkyes.Checked) and (chkno.Checked = false)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isdepart'] := 'true';
    end else if ((chkyes.Checked = false) and (chkno.Checked)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isdepart'] := 'false';
    end else if ((chkyes.Checked) and (chkno.Checked)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isdepart']:=null;
    end else if ((chkyes.Checked = false) and (chkno.Checked = false)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isdepart']:=null;
    end;
    if ((chkroundtrip.Checked) and (chknoroundtrip.Checked = false)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isroundtrip'] := 'true';
    end else if ((chkroundtrip.Checked = false) and (chknoroundtrip.Checked)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isroundtrip'] := 'false';
    end else if ((chkroundtrip.Checked) and (chknoroundtrip.Checked)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isroundtrip']:=null;
    end else if ((chkroundtrip.Checked = false) and (chknoroundtrip.Checked = false)) then
    begin
      jcdsResult.Params.ParamValues['filter_EQB_s!isroundtrip']:=null;
    end;
    if Trim(edt_helpcode.Text) = '' then
    begin
      Params.ParamByName('filter_LIKES_s!helpcode').Value := '';
    end else
    begin
      Params.ParamByName('filter_LIKES_s!helpcode').Value := edt_helpcode.Text;
    end;
   // Params.ParamByName('filter_isdepart').Value := edt_helpcode.Text;
    Active := true;
    end
end;

procedure TFrmStation.tbtnInsertClick(Sender: TObject);
begin
  inherited;
   with FrmStationAdd do
   begin
    FrmStationAdd := TFrmStationAdd.Create(self);
    Caption := '添加站点信息';
    cbbgrade.ItemIndex:=5;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;

   end;
end;

end.
