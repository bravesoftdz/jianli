unit UFrmPCcontrolEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
  DB, DBClient, jsonClientDataSet, USimpleEditForm,
  ToolWin, Generics.Collections, FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox, NovaListView;

type
  TfrmPCcontrolEdit = class(TSimpleEditForm)
    lblIP: TLabel;
    lblOrgid: TLabel;
    jsdcSave: TjsonClientDataSet;
    nvedtIP: TNovaEdit;
    nvcbbSelltype: TNovaComboBox;
    lblSellType: TLabel;
    nvlvSchedule: TNovaListView;
    nvlvRoute: TNovaListView;
    nvhcbbOrgid: TNovaHComboBox;
    lbl28: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    nvhlpRoute: TNovaHelp;
    lbl3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvcbbSelltypeChange(Sender: TObject);
    procedure nvhcbbOrgidChange(Sender: TObject);
    procedure nvedtIPKeyPress(Sender: TObject; var Key: Char);
    procedure nvhlpRouteIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id: Int64;
    createby:Int64;
    types, typename, orgname,createtime: string;
    class function getSubFunctionList: TList<TSubfunction>;
  end;

var
  frmPCcontrolEdit: TfrmPCcontrolEdit;

implementation

uses PubFn, Services;

var
  FSubFunctionList: TList<TSubfunction>;
{$R *.dfm}

procedure TfrmPCcontrolEdit.bbtnSaveClick(Sender: TObject);
var
  MResult,optype,log: string;
  FResult: integer;
begin
  inherited;

  if nvhcbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('��������Ϊ��');
    nvcbbSelltype.SetFocus;
    exit;
  end;
  if Trim(nvedtIP.Text) = '' then
  begin
    SysDialogs.Warning('����IP����Ϊ�գ�');
    nvedtIP.SetFocus;
    exit;
  end;
  if not checkip(nvedtIP.Text) then
  begin
    SysDialogs.Warning('������Ļ���IP���ԣ�');
    if (nvedtIP.Enabled) then
      nvedtIP.SetFocus;
    exit;
  end;
  if nvcbbSelltype.GetSelectID < 0 then
  begin
    SysDialogs.Warning('��ѡ��������ͣ�');
    nvcbbSelltype.SetFocus;
    exit
  end;

  if nvcbbSelltype.GetSelectCode = '1' then // ѡ����·
  begin
    if nvlvRoute.GetSelected = '' then
    begin
      SysDialogs.Warning('��ѡ��Ҫ���Ƶ���·��');
      nvlvRoute.SetFocus;
      exit;
    end;
  end
  else if nvcbbSelltype.GetSelectCode = '2' then // ѡ����
  begin
    if nvlvSchedule.GetSelected = '' then
    begin
      SysDialogs.Warning('��ѡ��Ҫ���Ƶİ�Σ�');
      nvlvSchedule.SetFocus;
      exit;
    end;
  end;

  with jsdcSave do
  begin
    Close;
    if edittype=add then
      Params.ParamByName('isupdate').Value := False
    else
      Params.ParamByName('isupdate').Value := True;

    Params.ParamByName('pcsellschedule.orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
    Params.ParamByName('pcsellschedule.ip').Value := nvedtIP.Text;
    Params.ParamByName('pcsellschedule.type').Value := nvcbbSelltype.GetSelectCode;
    Params.ParamByName('pcsellschedule.createby').Value := createby;
    Params.ParamByName('pcsellschedule.createtime').Value := createtime;
    Params.ParamByName('pcsellschedule.updateby').Value := SysInfo.LoginUserInfo.UserID;

    if nvcbbSelltype.GetSelectCode = '1' then // ѡ����·
    begin
      Params.ParamByName('typeids').Value := nvlvRoute.GetSelected;
    end
    else if nvcbbSelltype.GetSelectCode = '2' then // ѡ����
    begin
      Params.ParamByName('typeids').Value := nvlvSchedule.GetSelected;
    end
    else
    begin
      Params.ParamByName('typeids').Value := '0'
    end;

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
        SysDialogs.ShowMessage(MResult);
        ModalResult := mrok;

//        if id>0 then
//        begin
//           optype:='�޸�';
//            if typename <> nvcbbSelltype.Text then
//           begin
//              log := '����Ʊ����IP:'+nvedtIP.Text+'�� ���������� "'+typename+
//                    '" �ĳ� "'+nvcbbSelltype.Text+'"';
//           end;
//
////              log := log+' ��·/�������:'+nvlvSchedule.GetSelected
////                      +',,'+nvlvRoute.GetSelected;
//
//        end
//        else
//        begin
//           optype:='���';
//            log := '��������:'+ nvhcbbOrgid.Text +', ��������:'+nvcbbSelltype.Text+', ��Ʊ����IP:'+
//                nvedtIP.Text;
////                +', ����:'+nvlvSchedule.GetSelected+',2��'+nvlvRoute.Items.Item[2].ToString
////                + ',0��'+nvlvRoute.Items.Item[0].ToString +',1��'+nvlvRoute.Items.Item[1].ToString
//        end;
//        SysLog.WriteLog('��Ʊ���Կ��ƹ���', optype, log);
//        log:='';
//        optype:='';

      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmPCcontrolEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvhcbbOrgid.Active := False;
  nvhcbbOrgid.Active := True;
end;

class function TfrmPCcontrolEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result := FSubFunctionList;
end;

procedure TfrmPCcontrolEdit.nvcbbSelltypeChange(Sender: TObject);
begin
  inherited;
  if nvhcbbOrgid.ItemIndex < 0 then
  begin
    SysDialogs.Warning('����ѡ�����!');
    nvhcbbOrgid.SetFocus;
    exit;
  end;
  if nvcbbSelltype.GetSelectCode = '2' then // ѡ����
  begin
      nvhlpRoute.Visible := True;
      lbl3.Visible := True;
//    nvlvSchedule.Params[0].Value := nvhcbbOrgid.HelpFieldValue['id'];
//    nvlvSchedule.Params[1].Value := nvcbbSelltype.GetSelectCode;
//    nvlvSchedule.Active := False;
//    nvlvSchedule.Active := True;
    nvlvSchedule.Visible := True;
    nvlvRoute.Visible := False;
  end
  else if nvcbbSelltype.GetSelectCode = '1' then // ѡ����·
  begin
    nvhlpRoute.Visible := False;
    lbl3.Visible := False;
    nvlvRoute.Params[0].Value := nvhcbbOrgid.HelpFieldValue['id'];
    nvlvRoute.Params[1].Value := nvcbbSelltype.GetSelectCode;
    nvlvRoute.Params[2].Value := False;
    nvlvRoute.Active := False;
    nvlvRoute.Active := True;
    nvlvSchedule.Visible := False;
    nvlvRoute.Visible := True;
  end
  else if nvcbbSelltype.GetSelectCode = '0' then
  begin
    nvhlpRoute.Visible := False;
    lbl3.Visible := False;
    nvlvSchedule.Items.Clear;
    nvlvRoute.Items.Clear;
  end;
end;

procedure TfrmPCcontrolEdit.nvedtIPKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['0' .. '9', '.', #8]) then
  begin
    Key := #13;
  end;
end;

procedure TfrmPCcontrolEdit.nvhcbbOrgidChange(Sender: TObject);
begin
  inherited;
  // �ı� ���������lv
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
  nvcbbSelltype.Text := '��ѡ��...';
  nvcbbSelltype.ItemIndex := -1;
  nvlvSchedule.Items.Clear;
  nvlvRoute.Items.Clear;

end;

procedure TfrmPCcontrolEdit.nvhlpRouteIdChange(Sender: TObject);
begin
  inherited;
    nvlvSchedule.Active := False;
    nvlvSchedule.Params[0].Value := nvhcbbOrgid.HelpFieldValue['id'];
    nvlvSchedule.Params[1].Value := nvcbbSelltype.GetSelectCode;
    nvlvSchedule.Params[2].Value := nvhlpRoute.Id;
    nvlvSchedule.Params[3].Value := False;
    nvlvSchedule.Active := True;
end;

end.
