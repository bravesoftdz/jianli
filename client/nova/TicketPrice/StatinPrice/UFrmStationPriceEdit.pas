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
     SysDialogs.Warning('请选择所属机构！');
    nvHcbbOrgid.SetFocus;
    exit;
  end;
  if (nvhlpNovaHStation.Text='') or ( nvhlpNovaHStation.id<=0) then
  begin
     SysDialogs.Warning('请输入到达站！');
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
           optype:='修改';
            log := ' 所属机构名称'+orgname+'发车站；'+nvHcbbDepartstation.Text+','
               +' 到达站 '+reachestation+',';

           if fullprice <> edtNovatFullprice.Text then
           begin
              log := log+' 全票价由'+fullprice+'改成'+edtNovatFullprice.Text+',';
           end;
             if halfprice <> edtNovaHalfprice.Text then
           begin
              log := log+' 半票价由'+halfprice+'改成'+edtNovaHalfprice.Text+',';
           end;
            if studentprice <> edtNovaStudentprice.Text then
           begin
              log := log+' 学生价由'+studentprice+'改成'+edtNovaStudentprice.Text;
           end;
        end
        else
        begin
           optype:='添加';
            log := '所属机构名称:'+nvHcbbOrgid.Text+', 发车站：'+nvHcbbDepartstation.Text
            +',到达站：'+ nvhlpNovaHStation.Text+',全票价：'  +edtNovatFullprice.Text
            +',半票价：' +edtNovaHalfprice.Text+',学生价：'  +edtNovaStudentprice.Text;
        end;
        SysLog.WriteLog('员工档案管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保存失败：' + E.Message);
      end;
    end;
  end;
 end;

end.
