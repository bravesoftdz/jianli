unit UFrmRouteAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet,UDMPublic,Services,
  NovaHComboBox, ImgList;

type
  TFrmRouteAdd = class(TSimpleEditForm)
    nvedtname: TNovaEdit;
    lblname: TLabel;
    lbldistricttype: TLabel;
    NvCbbdistricttype: TNovaComboBox;
    lblendstation: TLabel;
    nvhelpendstation: TNovaHelp;
    lblstartstation: TLabel;
    nvhelpstartstation: TNovaHelp;
    lbltype: TLabel;
    nvcbbtype: TNovaComboBox;
    lblgrade: TLabel;
    nvcbbgrade: TNovaComboBox;
    lbldirection: TLabel;
    nvcbbdirection: TNovaComboBox;
    jcdsroutesave: TjsonClientDataSet;
    lblremarks: TLabel;
    memremarks: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    nvedtdistance: TNovaEdit;
    nvedtjianpin: TNovaEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    lbldays: TLabel;
    lbl9: TLabel;
    nvedtdays: TNovaEdit;
    lbl8: TLabel;
    nvedtReportinterval: TNovaEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    chkisRealnameticketing: TCheckBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhelpstartstationIdChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
//    routeid:Integer;
    routecode:string;
    routejianpin:string;
    routedistance:string;
    routehighdistance:string;
    routeisaudited:string;
    routeisauditpass:string;
    routeisactive:string;
    routecreatetime:string;
    routecreateby:string;
    routeupdatetime:string;
    routeupdateby:string;
    synccode:String;
    ischkisRealnameticketingroute: boolean;
    property operationid:Integer read Foperationid;
  end;

var
  FrmRouteAdd: TFrmRouteAdd;

implementation

{$R *.dfm}

procedure TFrmRouteAdd.bbtnSaveClick(Sender: TObject);
var nvhelpstartstationid:Integer;
    nvhelpendstationid:Integer;
begin
  inherited;
  if NovaCbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择班次所属机构！');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if Trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowMessage('线路名称不能为空!');
    nvedtname.SetFocus;
    exit;
  end;
  if (Trim(nvhelpstartstation.Text)='') or (nvhelpstartstation.id<=0) then
  begin
    SysDialogs.ShowMessage('始发站不能为空!');
    nvhelpstartstation.SetFocus;
    exit;
  end;
  if self.edittype=Tedittype.update then
    nvhelpstartstationid:=nvhelpstartstation.id
  else
    nvhelpstartstationid:=nvhelpstartstation.HelpFieldValue['id'];
  if (Trim(nvhelpendstation.Text)='') or (nvhelpendstation.id<=0) then
  begin
    SysDialogs.ShowMessage('终点站不能为空!');
    nvhelpendstation.SetFocus;
    exit;
  end;
  if self.edittype=Tedittype.update then
    nvhelpendstationid:=nvhelpendstation.id
  else
    nvhelpendstationid:=nvhelpendstation.HelpFieldValue['id'];
  if nvhelpstartstationid=nvhelpendstationid then
  begin
    SysDialogs.ShowMessage('起点站不能与终点站相同!');
    nvhelpendstation.SetFocus;
    exit;
  end;
  if NvCbbdistricttype.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('区域类别不能为空!');
    NvCbbdistricttype.SetFocus;
    exit;
  end;
  if nvcbbtype.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('线路类型不能为空!');
    nvcbbtype.SetFocus;
    exit;
  end;
  if nvcbbgrade.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('线路等级不能为空!');
    nvcbbgrade.SetFocus;
    exit;
  end;
  if nvcbbdirection.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('线路方向不能为空!');
    nvcbbdirection.SetFocus;
    exit;
  end;
  if trim(nvedtdistance.Text)='' then
  begin
    SysDialogs.ShowMessage('线路里程不能为空!');
    nvedtdistance.Text:='0';
    nvedtdistance.SetFocus;
    exit;
  end;
  if trim(nvedtdays.Text)='' then
  begin
    SysDialogs.ShowMessage('回程票有效天数不能为空!');
    nvedtdays.Text:='0';
    nvedtdays.SetFocus;
    exit;
  end;
  if trim(nvedtjianpin.Text)<>''  then
  begin
   if Length(nvedtjianpin.Text)>10 then
   begin
     SysDialogs.ShowMessage('简拼长度超过10个字符，请修改!');
     nvedtjianpin.SetFocus;
     Exit;
   end;
  end;

  with jcdsroutesave do
  begin
    Params.ParamValues['route.orgid']:=NovaCbbOrg.HelpFieldValue['id'];
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['route.id']:=nvedtname.Id;
      Params.ParamValues['route.code']:=routecode;
//      Params.ParamValues['route.jianpin']:=routejianpin;
//      Params.ParamValues['route.distance']:=routedistance;
      Params.ParamValues['route.highdistance']:=routehighdistance;
      Params.ParamValues['route.isaudited']:=routeisaudited;
      Params.ParamValues['route.isauditpass']:=routeisauditpass;
      Params.ParamValues['route.isactive']:=routeisactive;
      Params.ParamValues['route.createtime']:=routecreatetime;
      Params.ParamValues['route.createby']:=routecreateby;
      Params.ParamValues['route.updatetime']:=routeupdatetime;
      Params.ParamValues['route.updateby']:=routeupdateby;
      Params.ParamValues['route.startstationid']:=nvhelpstartstation.id;
      Params.ParamValues['route.endstationid']:=nvhelpendstation.id;
      Params.ParamValues['route.synccode']:=synccode;
    end
    else
    begin
//      Params.ParamValues['route.id']:=Null;
//      Params.ParamValues['route.code']:=Null;
//      Params.ParamValues['route.jianpin']:=Null;
//      Params.ParamValues['route.distance']:=Null;
//      Params.ParamValues['route.highdistance']:=Null;
//      Params.ParamValues['route.orgid']:=Null;
//      Params.ParamValues['route.isaudited']:=Null;
//      Params.ParamValues['route.isauditpass']:=Null;
//      Params.ParamValues['route.isactive']:=Null;
//      Params.ParamValues['route.createtime']:=Null;
//      Params.ParamValues['route.createby']:=Null;
//      Params.ParamValues['route.updatetime']:=Null;
//      Params.ParamValues['route.updateby']:=Null;
      Params.ParamValues['route.startstationid']:=nvhelpstartstation.HelpFieldValue['id'];
      Params.ParamValues['route.endstationid']:=nvhelpendstation.HelpFieldValue['id'];
    end;
    Params.ParamValues['route.name']:=Trim(nvedtname.Text);
    Params.ParamValues['route.districttype']:=NvCbbdistricttype.GetSelectCode;
    Params.ParamValues['route.type']:=nvcbbtype.GetSelectCode;
    Params.ParamValues['route.grade']:=nvcbbgrade.GetSelectCode;
    Params.ParamValues['route.direction']:=nvcbbdirection.GetSelectCode;
    Params.ParamValues['route.remarks']:=memremarks.Text;
    Params.ParamValues['route.jianpin']:=nvedtjianpin.Text;
    Params.ParamValues['route.distance']:=nvedtdistance.Text;
    Params.ParamValues['route.returntripvaliddays']:=nvedtdays.Text;
    Params.ParamValues['route.reportinterval']:=nvedtReportinterval.Text;
     if chkisRealnameticketing.Checked then
      begin
          Params.ParamValues['route.isrealnameticket']:=true;
      end
      else
      begin
        Params.ParamValues['route.isrealnameticket']:=false;
      end;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;
    Foperationid:=Params.ParamValues['routeid'];
  end;
end;

procedure TFrmRouteAdd.FormCreate(Sender: TObject);
begin
  inherited;
  NvCbbdistricttype.Active:=true;
  nvcbbtype.Active:=true;
  nvcbbgrade.Active:=true;
  nvcbbdirection.Active:=true;

  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] :=SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] :='(1,2)'; //车站、配客点
    Active := True;
    if Items.Count>0 then
    begin
      ItemIndex:=0;
    end;
  end;
end;

procedure TFrmRouteAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype=Tedittype.update then
    nvedtname.SetFocus
  else
//    nvhelpstartstation.SetFocus;
    NovaCbbOrg.SetFocus;
end;

procedure TFrmRouteAdd.nvhelpstartstationIdChange(Sender: TObject);
begin
  inherited;
  if nvhelpstartstation.Id<=0 then
  begin
    nvedtname.Text:='';
    nvedtjianpin.Text:='';
  end
  else
  begin
    nvedtname.Text:=nvhelpstartstation.HelpFieldValue['name'];
    nvedtjianpin.Text:=nvhelpstartstation.HelpFieldValue['jianpin'];
  end;
  if nvhelpendstation.Id<=0 then
  begin
    nvedtname.Text:=nvedtname.Text+'-'+'';
    nvedtjianpin.Text:=nvedtjianpin.Text+'';
  end
  else
  begin
    nvedtname.Text:=nvedtname.Text+'-'+nvhelpendstation.HelpFieldValue['name'];
    nvedtjianpin.Text:=nvedtjianpin.Text+nvhelpendstation.HelpFieldValue['jianpin'];
    nvedtdistance.Text:=nvhelpendstation.HelpFieldValue['distance'];
  end;
end;

end.
