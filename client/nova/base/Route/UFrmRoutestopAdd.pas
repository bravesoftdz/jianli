unit UFrmRoutestopAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  DB, DBClient, jsonClientDataSet,UDMPublic, NovaHelp,Services, ImgList,
  ComCtrls, NovaListView;

type
  TFrmRoutestopAdd = class(TSimpleEditForm)
    lblstation: TLabel;
    Label1: TLabel;
    lblbalancedistance: TLabel;
    nvhelpstation: TNovaHelp;
    nvedtdistance: TNovaEdit;
    nvedtbalancedistance: TNovaEdit;
    jcdsroutestop: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    GroupBox1: TGroupBox;
    NovaListSchedule: TNovaListView;
    chksynctoschedule: TCheckBox;
    chkChkIsDepart: TCheckBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvedtdistanceChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chksynctoscheduleClick(Sender: TObject);
    procedure nvhelpstationIdChange(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    id:string;
    routeid:String;
    orderno:String;
    createby:String;
    createtime:String;
    updateby:string;
    updatetime:string;
    isactive:string;
    property operationid:Integer read Foperationid;
  end;

var
  FrmRoutestopAdd: TFrmRoutestopAdd;

implementation

{$R *.dfm}

procedure TFrmRoutestopAdd.bbtnSaveClick(Sender: TObject);
//var nvhelpstationid:Integer;
begin
  inherited;
  if (Trim(nvhelpstation.Text)='') or (nvhelpstation.id<=0) then
  begin
    SysDialogs.ShowMessage('停靠点不能为空!');
    nvhelpstation.SetFocus;
    exit;
  end;
//  if self.edittype=Tedittype.update then
//    nvhelpstationid:=nvhelpstation.id
//  else
//    nvhelpstationid:=nvhelpstation.HelpFieldValue['id'];
  if Trim(nvedtdistance.Text)='' then
  begin
    SysDialogs.ShowMessage('距始发站里程不能为空!');
    nvedtdistance.SetFocus;
    exit;
  end;
  if Trim(nvedtbalancedistance.Text)='' then
  begin
    SysDialogs.ShowMessage('距始发结算里程不能为空!');
    nvedtbalancedistance.SetFocus;
    exit;
  end;

  with jcdsroutestop do
  begin
    if self.edittype=TEdittype.update then
    begin
      Params.ParamValues['routestop.id']:=id;
      Params.ParamValues['routestop.createby']:=createby;
      Params.ParamValues['routestop.createtime']:=createtime;
      Params.ParamValues['routestop.updateby']:=updateby;
      Params.ParamValues['routestop.updatetime']:=updatetime;
      Params.ParamValues['routestop.isactive']:=isactive;
      Params.ParamValues['routestop.orderno']:=orderno;
      Params.ParamValues['routestop.opertype']:=4;

      Params.ParamValues['routestop.stationid']:=nvhelpstation.Id;
    end
    else
    begin
      if chksynctoschedule.Visible and chksynctoschedule.Checked then
      begin
        if (NovaListSchedule.CheckedCount <= 0) then
        begin
          SysDialogs.Warning('请选择班次！');
          NovaListSchedule.SetFocus;
          exit;
        end
        else
        begin
          Params.ParamByName('scheduleids').Value := '(' + NovaListSchedule.GetSelected + ')';
        end;
      end
      else
      begin
        Params.ParamByName('scheduleids').Value := null;
      end;
//      Params.ParamValues['routestop.id']:=null;
//      Params.ParamValues['routestop.createby']:=null;
//      Params.ParamValues['routestop.createtime']:=null;
//      Params.ParamValues['routestop.updateby']:=null;
//      Params.ParamValues['routestop.updatetime']:=null;
//      Params.ParamValues['routestop.isactive']:=null;
//      Params.ParamValues['routestop.orderno']:=null;
      Params.ParamValues['routestop.opertype']:=8;
      Params.ParamValues['routestop.stationid']:=nvhelpstation.HelpFieldValue['id'];
    end;
    Params.ParamValues['routestop.isdepart']:=chkChkIsDepart.Checked;
    Params.ParamValues['routestop.route.id']:=routeid;
    Params.ParamValues['routestop.balancedistance']:=trim(nvedtbalancedistance.Text);
    Params.ParamValues['routestop.distance']:=trim(nvedtdistance.Text);
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;
    Foperationid:=Params.ParamValues['routestopid'];
  end;
end;

procedure TFrmRoutestopAdd.chksynctoscheduleClick(Sender: TObject);
begin
  inherited;
  if (Sender as TCheckBox).Checked then
  begin
    Self.Width:=600;
    GroupBox1.Visible:=true;
  end
  else
  begin
    GroupBox1.Visible:=false;
    self.Width:=400;
  end;
end;

procedure TFrmRoutestopAdd.FormShow(Sender: TObject);
begin
  inherited;
  GroupBox1.Visible:=false;
  self.Width:=400;
  chksynctoschedule.Visible:=(self.edittype=TEdittype.add);
  if self.edittype=TEdittype.add then
  begin
    with NovaListSchedule do
    begin
      active := false;
      Params.ParamValues['filter_EQL_r!id'] := routeid;
      Params.ParamValues['filter_EQB_t!isovertime'] := 'false';
      active := true;
      SelectAll;
    end;
  end;
end;

procedure TFrmRoutestopAdd.nvedtdistanceChange(Sender: TObject);
begin
  inherited;
  nvedtbalancedistance.Text:=nvedtdistance.Text;
end;

procedure TFrmRoutestopAdd.nvhelpstationIdChange(Sender: TObject);
begin
  inherited;
  if nvhelpstation.isactive  then
  begin
    nvedtdistance.Text:= nvhelpstation.HelpFieldValue['distance'];
  end;
end;

end.
