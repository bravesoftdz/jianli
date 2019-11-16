unit UFrmTickettypepermissionEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaCheckedComboBox, NovaComboBox, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmTickettypepermissionEdit = class(TSimpleEditForm)
    cbbtype: TNovaComboBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbbtypeid: TNovaHComboBox;
    cbbtickettype: TNovaHComboBox;
    jcdsResultTickettypepermissionSave: TjsonClientDataSet;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    procedure cbbtypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    sign : Boolean;
    createby, typeid, tickettypeid, createtime : string;
    id : Int64;

  end;

var
  FrmTickettypepermissionEdit: TFrmTickettypepermissionEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTickettypepermissionEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if Trim(cbbtickettype.Text) = '' then
  begin
    SysDialogs.Warning('��ѡ��Ʊ����');
    cbbtickettype.SetFocus;
    exit;
  end;
  if Trim(cbbtypeid.Text) = '' then
  begin
    SysDialogs.Warning('��ѡ����������Ӧ�����ƣ�');
    cbbtypeid.SetFocus;
    exit;
  end;

  with jcdsResultTickettypepermissionSave do
  begin
    Close;
    Params.ParamByName('tickettypepermission.id').Value := id ;
    Params.ParamByName('tickettypepermission.createby').Value := createby;
    Params.ParamByName('tickettypepermission.createtime').Value := createtime;
    Params.ParamByName('tickettypepermission.type').Value := cbbtype.ItemIndex;
//    if cbbtype.ItemIndex = 0 then
//    begin
//      if cbbtypeuser.ItemIndex > 0 then
//      begin
//        typeid := cbbtypeuser.HelpFieldValue['id'];
//      end;
//    end else
//    if cbbtype.ItemIndex = 1 then
//    begin
//      if cbbtyperole.ItemIndex > 0 then
//      begin
//        typeid := cbbtyperole.HelpFieldValue['id'];
//      end;
//    end else
//    if cbbtype.ItemIndex = 2 then
//    begin
//      if cbbticketoutlets.ItemIndex >= 0 then
//      begin
//        typeid := cbbticketoutlets.HelpFieldValue['id'];
//      end;
//    end else
//    if cbbtype.ItemIndex = 3 then
//    begin
//      if cbborg.ItemIndex >= 0 then
//      begin
//        typeid := cbborg.HelpFieldValue['id'];
//      end;
//    end;
    if cbbtypeid.ItemIndex = -1 then
    begin
      typeid := typeid;
    end else
    begin
      typeid := cbbtypeid.HelpFieldValue['id'];
    end;
    Params.ParamByName('tickettypepermission.typeid').Value := typeid;

    if cbbtickettype.ItemIndex >= 0 then
    begin
      tickettypeid := cbbtickettype.HelpFieldValue['id'];
    end;
    Params.ParamByName('tickettypepermission.tickettypeid').Value := tickettypeid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbtype.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '�޸ĳ�Ʊ���Ϳ���Ȩ�ޣ�����='+cbbtype.Text+',Ȩ�޷�Χ='+cbbtypeid.Text
          +',��Ʊ����='+cbbtickettype.Text;
          SysLog.WriteLog('�޸ĳ�Ʊ���Ϳ���Ȩ��','�޸�',log);
        end else
        begin
          log := '��ӳ�Ʊ���Ϳ���Ȩ�ޣ�����='+cbbtype.Text+',Ȩ�޷�Χ='+cbbtypeid.Text
          +',��Ʊ����='+cbbtickettype.Text;
          SysLog.WriteLog('ҵ�������>��Ʊ���Ϳ���Ȩ��','���',log);
        end;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��Ʊ���Ϳ���Ȩ�����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTickettypepermissionEdit.cbbtypeChange(Sender: TObject);
begin
  inherited;
  if cbbtype.ItemIndex = 0 then
  begin
    cbbtypeid.Text := '';
    lbl2.Caption := '��ƱԱ';
    cbbtypeid.Params.ParamValues['helpType'] := 'UserHelp';
    cbbtypeid.Active := False;
    cbbtypeid.Active := True;
  end else
  if cbbtype.ItemIndex = 1 then
  begin
    cbbtypeid.Text := '';
    lbl2.Caption := '��ɫ';
    cbbtypeid.Params.ParamValues['helpType'] := 'RoleHelp';
    cbbtypeid.Active := False;
    cbbtypeid.Active := True;
  end else
  if cbbtype.ItemIndex = 2 then
  begin
    cbbtypeid.Text := '';
    lbl2.Caption := '��Ʊ��';
    cbbtypeid.Params.ParamValues['helpType'] := 'TicketoutletHelp';
    cbbtypeid.Active := False;
    cbbtypeid.Active := True;
  end else
  if cbbtype.ItemIndex = 3 then
  begin
    cbbtypeid.Text := '';
    lbl2.Caption := '����';
    cbbtypeid.Params.ParamValues['helpType'] := 'OrgHelp';
    cbbtypeid.Active := False;
    cbbtypeid.Active := True;
  end;
end;

procedure TFrmTickettypepermissionEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtickettype.Active := False;
  cbbtickettype.Active := True;
end;

procedure TFrmTickettypepermissionEdit.FormShow(Sender: TObject);
begin
  inherited;
  if cbbtype.ItemIndex = 0 then
  begin
    cbbtypeid.Active := False;
    cbbtypeid.Params.ParamValues['helpType'] := 'UserHelp';
    cbbtypeid.Active := True;
  end else
  if cbbtype.ItemIndex = 1 then
  begin
    cbbtypeid.Active := False;
    cbbtypeid.Params.ParamValues['helpType'] := 'RoleHelp';
    cbbtypeid.Active := True;
  end else
  if cbbtype.ItemIndex = 2 then
  begin
    cbbtypeid.Active := False;
    cbbtypeid.Params.ParamValues['helpType'] := 'TicketoutletHelp';
    cbbtypeid.Active := True;
  end else
  if cbbtype.ItemIndex = 3 then
  begin
    cbbtypeid.Active := False;
    cbbtypeid.Params.ParamValues['helpType'] := 'OrgHelp';
    cbbtypeid.Active := True;
  end;
end;

end.
