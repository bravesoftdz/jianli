unit UFrmStationPriceEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, DB, DBClient,Services, jsonClientDataSet, ExtDlgs, Jpeg,
  NovaHComboBox, NovaCheckedComboBox, Menus, NovaHelp, ImgList;

type
  TfrmStationPriceEdt = class(TSimpleEditForm)
    lbl11: TLabel;
    lbl9: TLabel;
    jcdsSave: TjsonClientDataSet;
    lbl5: TLabel;
    lbl8: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    edtNovatFullprice: TNovaEdit;
    edtNovaStudentprice: TNovaEdit;
    lbl6: TLabel;
    lbl7: TLabel;
    edtNovaHalfprice: TNovaEdit;
    lbl10: TLabel;
    lbl12: TLabel;
    nvhlpNovaHStation: TNovaHelp;
    nvHcbbDepartstation: TNovaHComboBox;
    nvHcbbOrgid: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure nvHcbbOrgidChange(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    mem: TMemoryStream;
    memstr: TStringStream;
  public
    { Public declarations }
    isedit:boolean;
   id:Integer;
   orgid:int64;
    code,
   orgname,departstation,departstationid,reachestation,fullprice,halfprice,studentprice: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmStationPriceEdt: TfrmStationPriceEdt;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmStationPriceEdt.FormShow(Sender: TObject);
var oldorgid,userorgname:string;
begin
  inherited;
  nvHcbbOrgid.Active := False;
  nvHcbbOrgid.Active := True;
if not (isedit) then
 begin
  userorgname := Sysinfo.LoginUserInfo.OrgName;
 with nvHcbbDepartstation do
  begin
    Active := false;
    Params.ParamValues['orgids'] := Sysinfo.LoginUserInfo.OrgIDs;
    Active := True;
  end;
 end
 else
 begin
    nvHcbbOrgid.SetItemIndexByField('id',orgid);
    with nvHcbbDepartstation do
  begin
    HelpOptions.AutoSelectFirst:=True;
    active := false;
    oldorgid := nvHcbbOrgid.HelpFieldValue['id'];
    Params.ParamValues['orgids'] := '('+oldorgid+')';
    active := True;
  end;
  nvHcbbOrgid.Enabled := False;
  nvHcbbDepartstation.Enabled := False;
 end
end;

procedure TfrmStationPriceEdt.nvHcbbOrgidChange(Sender: TObject);
var orgid:string;
begin
  inherited;
   with nvHcbbDepartstation do
  begin
    HelpOptions.AutoSelectFirst:=True;
    active := false;
    orgid := nvHcbbOrgid.HelpFieldValue['id'];
    Params.ParamValues['orgids'] := '('+orgid+')';
    active := True;
  end;
  nvhlpNovaHStation.SetFocus;
end;

procedure TfrmStationPriceEdt.bbtnSaveClick(Sender: TObject);
var  msg,log,optype,ids: String;
  nResult: integer;
  sResult: String;
begin
  inherited;
  if nvHcbbOrgid.Text='' then
  begin
     SysDialogs.Warning('��ѡ������������');
    nvHcbbOrgid.SetFocus;
    exit;
  end;
  if (nvhlpNovaHStation.Text='') or ( nvhlpNovaHStation.id<=0) then
  begin
     SysDialogs.Warning('�����뵽��վ��');
    nvhlpNovaHStation.SetFocus;
    exit;
  end;

  with jcdsSave do
  begin
    close;
    Params.ParamByName('stationprice.orgid').Value := nvHcbbOrgid.HelpFieldValue['id'];
    if isedit then
    begin
      Params.ParamByName('stationprice.id').Value := id;
    end;
    Params.ParamByName('stationprice.departstationid').Value := nvHcbbDepartstation.HelpFieldValue['id'];
    Params.ParamByName('stationprice.reachstationid').Value := nvhlpNovaHStation.Id;
    Params.ParamByName('stationprice.fullprice').Value := edtNovatFullprice.Text;
    Params.ParamByName('stationprice.halfprice').Value := edtNovaHalfprice.Text;
    Params.ParamByName('stationprice.studentprice').Value := edtNovaStudentprice.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpNovaHStation.SetFocus;
      end
      else
      begin
      if id>0 then
        begin
           optype:='�޸�';
            log := ' ������������'+orgname+'����վ��'+nvHcbbDepartstation.Text+','
               +' ����վ '+reachestation+',';

           if fullprice <> edtNovatFullprice.Text then
           begin
              log := log+' ȫƱ����'+fullprice+'�ĳ�'+edtNovatFullprice.Text+',';
           end;
             if halfprice <> edtNovaHalfprice.Text then
           begin
              log := log+' ��Ʊ����'+halfprice+'�ĳ�'+edtNovaHalfprice.Text+',';
           end;
            if studentprice <> edtNovaStudentprice.Text then
           begin
              log := log+' ѧ������'+studentprice+'�ĳ�'+edtNovaStudentprice.Text;
           end;
        end
        else
        begin
           optype:='���';
            log := '������������:'+nvHcbbOrgid.Text+', ����վ��'+nvHcbbDepartstation.Text
            +',����վ��'+ nvhlpNovaHStation.Text+',ȫƱ�ۣ�'  +edtNovatFullprice.Text
            +',��Ʊ�ۣ�' +edtNovaHalfprice.Text+',ѧ���ۣ�'  +edtNovaStudentprice.Text;
        end;
        SysLog.WriteLog('Ա����������', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
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

end.
