unit UFrmOrgEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, StdCtrls,
  NovaComboBox, NovaEdit, Buttons, ExtCtrls, NovaHComboBox, NovaHelp, ImgList;

type
  TFrmOrgEdit = class(TSimpleEditForm)
    lbl9: TLabel;
    lbl4: TLabel;
    Label4: TLabel;
    jsonCDSOrgSave: TjsonClientDataSet;
    cbbComboxParentOrg: TNovaHComboBox;
    edtCode: TNovaEdit;
    lbl1: TLabel;
    lbl10: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    Label9: TLabel;
    Label2: TLabel;
    edtname: TNovaEdit;
    edtaddress: TNovaEdit;
    cbbCobOrgType: TNovaComboBox;
    edtSaleAddress: TNovaEdit;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    edtContactPerson: TNovaEdit;
    edtPhone: TNovaEdit;
    edtServiceAddress: TNovaEdit;
    edtdistrict: TNovaHelp;
    mmoDescribe: TMemo;
    lbl8: TLabel;
    lbl11: TLabel;
    NovaHelpObjectID: TNovaHelp;
    lbl16: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure cbbCobOrgTypeChange(Sender: TObject);
    procedure edtCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure NovaHelpObjectIDIdChange(Sender: TObject);
    procedure edtServiceAddressKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
    flag, islocal: boolean;
    id, parentid, createby, districtid: Int64;
    createtime,cursynccode: string;
  end;

var
  FrmOrgEdit: TFrmOrgEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmOrgEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  ip, port: String;
begin
  if (Trim(cbbCobOrgType.Text) = '') then
  begin
    SysDialogs.Warning('请选择机构类型');
    cbbCobOrgType.SetFocus;
    exit;
  end;
  if ((cbbCobOrgType.ItemIndex = 1) or (cbbCobOrgType.ItemIndex = 2)) and
    ((NovaHelpObjectID.Text = '') or (NovaHelpObjectID.id = 0)) then // 配客点
  begin
    SysDialogs.Warning('请输入对应站点！');
    NovaHelpObjectID.SetFocus;
    exit;
  end
  else if (cbbCobOrgType.ItemIndex = 3) then // 车队
  begin
    if ((NovaHelpObjectID.Text = '') or (NovaHelpObjectID.id = 0)) then
    begin
      SysDialogs.Warning('请输入对应车属单位！');
      NovaHelpObjectID.SetFocus;
      exit;
    end;
  end;

  if (Trim(edtname.Text) = '') then
  begin
    SysDialogs.Warning('请填写机构名称');
    edtname.SetFocus;
    exit;
  end;
  if (Trim(edtCode.Text) = '') then
  begin
    SysDialogs.Warning('请填写机构编码');
    edtCode.SetFocus;
    exit;
  end;

  if (Trim(edtServiceAddress.Text) = '') then
  begin
    SysDialogs.Warning('请输入应用服务器地址！');
    edtServiceAddress.SetFocus;
    exit;
  end
  else
  begin
    if Pos(':', edtServiceAddress.Text) > 0 then
    begin
      ip := Copy(edtServiceAddress.Text, 1,
        Pos(':', edtServiceAddress.Text) - 1);
      port := Copy(edtServiceAddress.Text, Pos(':',
          edtServiceAddress.Text) + 1, Length(edtServiceAddress.Text));
      if Length(port) > 0 then
      begin
        try
          StrToInt(port);
          if (StrToInt(port) < 1024) then
          begin
            SysDialogs.Warning('端口号必须大于1024！');
            edtServiceAddress.SetFocus;
            exit;
          end;
        except
          SysDialogs.Warning('你输入的IP地址端口号不合法，请重新输入！');
          edtServiceAddress.SetFocus;
          exit;
        end;
      end
      else
      begin
        SysDialogs.Warning('请输入的IP地址端口号！');
        edtServiceAddress.SetFocus;
        exit;
      end;
    end
    else
      ip := edtServiceAddress.Text;

    if (Length(ip) > 0) and (not checkip(ip)) then
    begin
      SysDialogs.Warning('你输入的IP地址不合法，请重新输入！');
      edtServiceAddress.SetFocus;
      exit;
    end;

  end;

  { if (Trim(edtdistrict.Text) = '') then
    begin
    SysDialogs.Warning('请填写所属区域');
    edtdistrict.SetFocus;
    exit;
    end; }

  with jsonCDSOrgSave do
  begin
    Close;
    Params.ParamByName('organization.id').Value := id;
//  if cbbComboxParentOrg.ItemIndex >= 0 then
//    begin
//      parentid := cbbComboxParentOrg.HelpFieldValue['id'];
//      Params.ParamByName('organization.organ.id').Value := parentid;
//    end
//    else
//    Params.ParamByName('organization.organ.id').Value := parentid;
    Params.ParamByName('organization.organ.id').Value :=
       cbbComboxParentOrg.HelpFieldValue['id'];
    Params.ParamByName('organization.name').Value := edtname.Text;
    Params.ParamByName('organization.code').Value := edtCode.Text;
    Params.ParamByName('organization.type').Value := cbbCobOrgType.ItemIndex;
    if (Trim(edtdistrict.Text) <> '') and (edtdistrict.id > 0) then
      Params.ParamByName('organization.district.id').Value := edtdistrict.id;

    if (cbbCobOrgType.ItemIndex = 1) or (cbbCobOrgType.ItemIndex = 2) then
    begin
      Params.ParamByName('organization.station.id').Value :=
        NovaHelpObjectID.id;
    end
    else if (cbbCobOrgType.ItemIndex = 3) then
    begin
      Params.ParamByName('organization.unit.id').Value := NovaHelpObjectID.id;
    end;
    //
    Params.ParamByName('organization.contactperson').Value :=
      edtContactPerson.Text;
    Params.ParamByName('organization.contactphone').Value := edtPhone.Text;

    Params.ParamByName('organization.serversaddress').Value :=
      edtServiceAddress.Text;
    Params.ParamByName('organization.ticketserversaddress').Value :=
      edtSaleAddress.Text;

    Params.ParamByName('organization.createby').Value := createby;
    Params.ParamByName('organization.createtime').Value := createtime;
    Params.ParamByName('organization.address').Value := edtaddress.Text;

    Params.ParamByName('organization.describe').Value := mmoDescribe.Text;

    Params.ParamByName('organization.isactive').Value := true;
    Params.ParamByName('organization.islocal').Value := true;
    if id>0 then
      Params.ParamByName('organization.synccode').Value := cursynccode
    else
      Params.ParamByName('organization.synccode').Value := null;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        if Pos('编码', sResult) > 0 then
          edtCode.SetFocus
        else if Pos('名称', sResult) > 0 then
          edtname.SetFocus;
        exit;
      end
      else
      begin
        id := Params.ParamByName('orgid').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('机构信息添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmOrgEdit.cbbCobOrgTypeChange(Sender: TObject);
begin
  inherited;
  NovaHelpObjectID.Clear;
  cbbComboxParentOrg.Enabled := true;
  edtSaleAddress.Enabled := false;
  NovaHelpObjectID.Enabled := false;
  lbl16.Visible := false;
  if (cbbCobOrgType.ItemIndex = 0) then
  begin

    with cbbComboxParentOrg do
    begin
      Active := false;
      Params.ParamValues['filter_INS_t!type'] := '(1,2,4,5)';
      Active := true;
    end
  end
  else if (cbbCobOrgType.ItemIndex = 1) or (cbbCobOrgType.ItemIndex = 2) then
  begin
    lbl16.Visible := true;
    if (cbbCobOrgType.ItemIndex = 2) then // 车站
      with cbbComboxParentOrg do
      begin
        Active := false;
        Params.ParamValues['filter_INS_t!type'] := '(4,5)';
        Active := true;
      end
      else
      begin
        cbbComboxParentOrg.Active := false;
        cbbComboxParentOrg.Params.ParamValues['filter_INS_t!type'] := '(2)';
        cbbComboxParentOrg.Active := true;
      end;
    NovaHelpObjectID.HelpOptions.HelpType := 'StationDHelp';
    lbl14.Caption := '对应站点';
    edtServiceAddress.Enabled := true;
    // Label4.Visible:=True;//*
    NovaHelpObjectID.Enabled := true;
  end
  else if cbbCobOrgType.ItemIndex = 3 then
  begin
    lbl16.Visible := true;
    with cbbComboxParentOrg do
    begin
      Active := false;
      Params.ParamValues['filter_INS_t!type'] := '(4,5)';
      Active := true;
    end;
    NovaHelpObjectID.HelpOptions.HelpType := 'UnitDHelp';
    lbl14.Caption := '对应车属单位';
    edtServiceAddress.Enabled := true;
    edtSaleAddress.Enabled := false;
    // Label4.Visible:=True;//*
    NovaHelpObjectID.Enabled := true;
  end
  else if (cbbCobOrgType.ItemIndex = 4) then
    with cbbComboxParentOrg do
    begin
      Active := false;
      Params.ParamValues['filter_INS_t!type'] := '(5)';
      Active := true;
    end
    else if (cbbCobOrgType.ItemIndex = 5) then
      with cbbComboxParentOrg do
      begin
        Active := false;
        Params.ParamValues['filter_INS_t!type'] := '(6)';
        Active := true;
      end
      else if (cbbCobOrgType.ItemIndex = 6) then
        with cbbComboxParentOrg do
        begin
          Active := false;
          Params.ParamValues['filter_INS_t!type'] := '(7)';
          Active := true;
        end
        else if (cbbCobOrgType.ItemIndex = 7) then
          with cbbComboxParentOrg do
          begin
            Active := false;
            cbbComboxParentOrg.Clear;
            cbbComboxParentOrg.Enabled := false;
          end
          else
          begin
            edtSaleAddress.Enabled := true;
            // Label4.Visible:=false;//*
          end;

end;

procedure TFrmOrgEdit.edtCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not Key in [65 .. 90, 96 .. 105, 8, 46] then
  begin
    Key := 0;
  end;
end;

procedure TFrmOrgEdit.edtServiceAddressKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', #8, #13, '.', ':']) then
  begin
    Key := #0;
  end;
end;

procedure TFrmOrgEdit.FormCreate(Sender: TObject);
begin
  inherited;
  with cbbComboxParentOrg do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!type'] := '(1,2,4,5)';
    Active := true;
  end;
  cbbCobOrgType.Active := false;
  cbbCobOrgType.Active := true;
  cbbComboxParentOrg.Enabled:=false;
end;

procedure TFrmOrgEdit.NovaHelpObjectIDIdChange(Sender: TObject);
begin
  inherited;
  if (cbbCobOrgType.ItemIndex = 1) or (cbbCobOrgType.ItemIndex = 2) then
  begin
    if ((NovaHelpObjectID.isactive) and (NovaHelpObjectID.id > 0)) then
    begin
      edtdistrict.Text := NovaHelpObjectID.HelpFieldValue['districtname'];
      edtdistrict.id := NovaHelpObjectID.HelpFieldValue['districtid'];
    end;
  end
  else if (cbbCobOrgType.ItemIndex = 3) then
  begin
    if ((NovaHelpObjectID.isactive) and (NovaHelpObjectID.id > 0)) then
    begin
      edtdistrict.Text := NovaHelpObjectID.HelpFieldValue['districtname'];
      edtdistrict.id := NovaHelpObjectID.HelpFieldValue['districtid'];
    end;
  end;
end;

end.
