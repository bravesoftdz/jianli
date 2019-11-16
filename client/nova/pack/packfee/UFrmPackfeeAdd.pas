unit UFrmPackfeeAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  NovaComboBox, DB, DBClient, jsonClientDataSet, UDMPublic, Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox;

type
  TFrmPackfeeAdd = class(TSimpleEditForm)
    nvedtfeekg: TNovaEdit;
    lblname: TLabel;
    lbldistricttype: TLabel;
    lblendstation: TLabel;
    lblstartstation: TLabel;
    lbltype: TLabel;
    lblgrade: TLabel;
    jcdspackfeesave: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    nvedtfromdistance: TNovaEdit;
    nvedttodistance: TNovaEdit;
    nvedtfromweight: TNovaEdit;
    nvedttoweight: TNovaEdit;
    nvedtfee: TNovaEdit;
    Label2: TLabel;
    Label4: TLabel;
    NovaHelpPricetype: TNovaHComboBox;
    Label1: TLabel;
    Label6: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Foperationid: Integer;
    log : String;
  public
    { Public declarations }
    packfeeid: Integer;
    createby:Integer;
    createtime:TDateTime;
    property operationid: Integer read Foperationid;
  end;

var
  FrmPackfeeAdd: TFrmPackfeeAdd;

implementation

{$R *.dfm}

procedure TFrmPackfeeAdd.bbtnSaveClick(Sender: TObject);
var
  nvhelpstartstationid: Integer;
  nvhelpendstationid: Integer;
  result : string;
begin
  inherited;
  if NovaCbbOrg.ItemIndex < 0 then
  begin
    SysDialogs.ShowMessage('请选择所属机构！');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if Trim(nvedtfromdistance.Text) = '' then
  begin
    SysDialogs.ShowMessage('起始里程不能为空!');
    nvedtfromdistance.SetFocus;
    exit;
  end;
  if (Trim(nvedttodistance.Text) = '') then
  begin
    SysDialogs.ShowMessage('截止里程不能为空!');
    nvedttodistance.SetFocus;
    exit;
  end;

  if (StrToInt(Trim(nvedttodistance.Text)) <= StrToInt
      (Trim(nvedtfromdistance.Text))) then
  begin
    SysDialogs.ShowMessage('截止里程不能小于等于起始里程!');
    nvedttodistance.SetFocus;
    exit;
  end;

  if Trim(nvedtfromweight.Text) = '' then
  begin
    SysDialogs.ShowMessage('起始重量不能为空!');
    nvedtfromweight.SetFocus;
    exit;
  end;

  {if StrToInt(Trim(nvedtfromweight.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('起始重量值超出范围(0~9999.99)!');
    nvedtfromweight.SetFocus;
    exit;
  end;}

  if (Trim(nvedttoweight.Text) = '') then
  begin
    SysDialogs.ShowMessage('截止重量不能为空!');
    nvedttoweight.SetFocus;
    exit;
 end;

 {if StrToInt(Trim(nvedttoweight.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('截止重量值超出范围(0~9999.99)!');
    nvedttoweight.SetFocus;
    exit;
  end;}

  if (StrToFloat(Trim(nvedttoweight.Text)) <= StrToFloat
      (Trim(nvedtfromweight.Text))) then
  begin
    SysDialogs.ShowMessage('截止重量不能小于等于起始重量!');
    nvedttoweight.SetFocus;
    exit;
  end;

  if (Trim(nvedtfee.Text)='') then
  begin
    SysDialogs.ShowMessage('最低价不能为空!');
    nvedtfee.SetFocus;
    exit;
  end;

  if StrToFloat(Trim(nvedtfee.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('最低价值超出范围(0~9999.99)!');
    nvedtfee.SetFocus;
    exit;
  end;

  if (Trim(nvedtfeekg.Text)='') then
  begin
    SysDialogs.ShowMessage('超重每千克单价不能为空!');
    nvedtfeekg.SetFocus;
    exit;
  end;

  if StrToFloat(Trim(nvedtfeekg.Text))>=10000  then
  begin
    SysDialogs.ShowMessage('超重每千克单价值超出范围(0~9999.99)!');
    nvedtfeekg.SetFocus;
    exit;
  end;

  with jcdspackfeesave do
  begin
    Params.ParamValues['packfee.packfeetypeid'] := NovaHelpPricetype.HelpFieldValue['id'];
    Params.ParamValues['packfee.orgid'] := NovaCbbOrg.HelpFieldValue['id'];
    if self.edittype = Tedittype.update then
    begin
    Params.ParamValues['packfee.id'] := IntToStr(packfeeid);
    Params.ParamValues['packfee.createby']:= IntToStr(createby);
    Params.ParamValues['packfee.createtime']:= FormatDateTime('yyyy-mm-dd', createtime);
    end ;

    Params.ParamValues['packfee.fromdistance'] := Trim(nvedtfromdistance.Text);
    Params.ParamValues['packfee.todistance']:= Trim(nvedttodistance.Text);
    Params.ParamValues['packfee.fromweight']:= Trim(nvedtfromweight.Text);
    Params.ParamValues['packfee.toweight']:= Trim(nvedttoweight.Text);
    Params.ParamValues['packfee.fee']:= Trim(nvedtfee.Text);
    Params.ParamValues['packfee.feekg']:= Trim(nvedtfeekg.Text);
    bbtnSave.Enabled :=false;
    Execute;
    bbtnSave.Enabled :=true;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      bbtnSave.Enabled :=false;
      if packfeeid > 0 then
        result := '修改'
      else
        result := '添加';
      log := result +Params.ParamValues['packfeeid']+ '行包收费标准：所属机构='+NovaCbbOrg.HelpFieldValue['name']+',起始里程='+
      nvedtfromdistance.Text+',截止里程='+nvedttodistance.Text+',起始重量='+nvedtfromweight.Text+
      ',截止重量='+nvedttoweight.Text+',每件最低价='+nvedtfee.Text+',超每千克单价='+nvedtfeekg.Text;
      SysLog.WriteLog('行包管理->收费标准设置',result,log);
      self.ModalResult := mrOk;
    end;
    Foperationid := Params.ParamValues['packfeeid'];
  end;
end;

procedure TFrmPackfeeAdd.FormCreate(Sender: TObject);
begin
  inherited;
  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] := '(1,2)'; // 车站、配客点
    Active := True;
    if Items.Count > 0 then
    begin
      ItemIndex := 0;
    end;
  end;
  //NovaHelpPricetype
  with NovaHelpPricetype do
  begin
    Active := False;
    Active := True;
    if Items.Count > 0 then
    begin
      ItemIndex := 0;
    end;
  end;
end;

procedure TFrmPackfeeAdd.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.update then
    NovaCbbOrg.SetFocus
  else
    // nvhelpstartstation.SetFocus;
    NovaCbbOrg.SetFocus;
end;

end.
