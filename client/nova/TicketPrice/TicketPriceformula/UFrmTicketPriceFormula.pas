unit UFrmTicketPriceFormula;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmTicketPriceFormula = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    Label1: TLabel;
    ChKIsdefault: TCheckBox;
    ChkNotDefault: TCheckBox;
    NovaHCbbTicketType: TNovaHComboBox;
    jcdsTicketPriceItem: TjsonClientDataSet;
    DataSource1: TDataSource;
    NvDbgridEh1: TNvDbgridEh;
    Splitter1: TSplitter;
    jcdsRelatetype: TjsonClientDataSet;
    jcdsTicketPriceItemorgid: TLargeintField;
    jcdsTicketPriceItemcode: TWideStringField;
    jcdsTicketPriceItemisticketpriceitem: TBooleanField;
    jcdsTicketPriceItemisautoadjust: TBooleanField;
    jcdsTicketPriceItemisdefault: TBooleanField;
    jcdsTicketPriceItemname: TWideStringField;
    jcdsTicketPriceItemrelatetype: TWideStringField;
    jcdsTicketPriceItemrelatetypename: TWideStringField;
    jcdsDelFormula: TjsonClientDataSet;
    jcdsgenerateTicketprice: TjsonClientDataSet;
    msginfo: TLabel;
    Label3: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure NovaHCbbOrgChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmTicketPriceFormula: TFrmTicketPriceFormula;

implementation
uses PubFn, Services,UFrmTicketPriceFormulaEdt,UDMPublic, UFrmLogInfo;
{$R *.dfm}

procedure TFrmTicketPriceFormula.FormShow(Sender: TObject);
begin
  inherited;
  NovaHCbbTicketType.Active:=false;
  NovaHCbbTicketType.Active:=true;
  jcdsRelatetype.Active:=false;
  jcdsRelatetype.Active:=true;

  NovaHCbbOrg.Active:=false;
  NovaHCbbOrg.Active:=true;
  NovaHCbbOrg.SetItemIndexByField('id',sysinfo.LoginUserInfo.OrgID);

end;

procedure TFrmTicketPriceFormula.NovaHCbbOrgChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

procedure TFrmTicketPriceFormula.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult,scheduleid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if (jcdsResult.FieldByName('isdefault').AsBoolean) then
  begin
    SysDialogs.Warning('系统默认的票价公式不允许删除！');
    exit;
  end;


  scheduleid:= jcdsResult.FieldByName('id').AsInteger;
  if SysDialogs.Confirm('南凌客运信息管理系统','确认要删除该票价公式信息吗？') then
  with jcdsDelFormula do
  begin
    Active := false;
    Params.ParamValues['ticketpriceformula.id'] := jcdsResult.FieldByName('id')
      .AsInteger;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
      log := '删除票价公式：票种='+jcdsResult.FieldByName('ticketypename').AsString+
      ',票价公式='+jcdsResult.FieldByName('formula').AsString+
      ',开始日期='+jcdsResult.FieldByName('startdate').AsString+
      ',结束日期='+jcdsResult.FieldByName('enddate').AsString;
      SysLog.WriteLog('票价管理——>票价公式管理','删除',log);
      tbtnFilterClick(sender) ;
  end;

end;

procedure TFrmTicketPriceFormula.tbtnEditClick(Sender: TObject);
var
  curid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  FrmTicketPriceFormulaEdt := TFrmTicketPriceFormulaEdt.Create(self);
  with FrmTicketPriceFormulaEdt do
  begin
    Caption := '修改票价公式';
    createby := SysInfo.LoginUserInfo.UserID;
    id := jcdsResult.FieldByName('id').AsInteger;
    curid:=id;
    orgid:= jcdsResult.FieldByName('orgid').AsInteger;
    MeRemark.Text := jcdsResult.FieldByName('remarks').AsString;
    NovaEdtFormula.Text := jcdsResult.FieldByName('formula').AsString;
    NovaHCbbTicketType.Enabled:=false;
    if jcdsResult.FieldByName('code').AsString ='Q' then
    begin
      labIsFullType.Visible:=false;
    end;
    tickettypename := jcdsResult.FieldByName('ticketypename').AsString;
    DateTpFromDate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
    DateTpEndDate.Date := jcdsResult.FieldByName('enddate').AsDateTime;
    createtime:= jcdsResult.FieldByName('createtime').AsString;
    edittype := Tedittype.update;
    if SysMainForm.showFormModal(FrmTicketPriceFormulaEdt) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmTicketPriceFormula.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  { if NovaCkbOrg.GetSelectID='' then
   begin
     NovaCkbOrg.SetFocus;
     SysDialogs.Warning('请选择机构！');
     exit;
   end;   }

  jcdsTicketPriceItem.Active:=false;
  jcdsTicketPriceItem.Params.ParamValues['orgids'] := '('+ inttostr(NovaHCbbOrg.HelpFieldValue['id'])+')';
  jcdsTicketPriceItem.Active:=true;

  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_t!orgid'] :=  NovaHCbbOrg.HelpFieldValue['id'];
    if NovaHCbbTicketType.ItemIndex>0 then
       Params.ParamValues['filter_EQL_t!tickettypeid'] := NovaHCbbTicketType.HelpFieldValue['id']
    else
       Params.ParamValues['filter_EQL_t!tickettypeid'] :=null;
    if (ChKIsdefault.Checked) and not (ChkNotDefault.Checked) then
       Params.ParamValues['filter_EQB_t!isdefault'] := true
    else  if not (ChKIsdefault.Checked) and (ChkNotDefault.Checked)  then
       Params.ParamValues['filter_EQB_t!isdefault'] := false
    else if not (ChKIsdefault.Checked) and not (ChkNotDefault.Checked)   then
    begin
      close;
      exit;
    end
    else
      Params.ParamValues['filter_EQB_t!isdefault'] := null;
    Active := true;
  end;
end;

procedure TFrmTicketPriceFormula.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmTicketPriceFormulaEdt := TFrmTicketPriceFormulaEdt.Create(self);
  with FrmTicketPriceFormulaEdt do
  begin
    Caption := '添加票价公式';
    createby := SysInfo.LoginUserInfo.UserID;
    edittype := add;
    if SysMainForm.showFormModal(FrmTicketPriceFormulaEdt) = mrok then
    begin
       tbtnFilterClick(Sender);
    end;
  end;
end;

procedure TFrmTicketPriceFormula.tbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  screen.Cursor:=crHourGlass;
  msginfo.Caption:='系统正在生成公式票价信息，请稍等……';
  pnlQuery.Refresh;
  self.Enabled:=false;
  with jcdsgenerateTicketprice do
  begin
    close;
    Params.ParamByName('ticketpriceformula.orgid').Value := SysInfo.LoginUserInfo.OrgID;
    try
      active:=true;
      nResult := Params.ParamByName('flag').Value;
      if nResult=1 then
      begin
        first;
        FrmLogInfo := TFrmLogInfo.Create(self);
        with FrmLogInfo do
        begin
          Memo1.Clear;
          if RecordCount <= 0 then
          begin
             Memo1.lines.Add('执行成功，没有发生错误！');
          end
          else
          begin
            Memo1.lines.Add('执行过程中产生了' + IntToStr(RecordCount) + '条错误：');
            while not eof do
            begin
                Memo1.lines.Add(trim(fieldbyname('errorInfo').asstring)+#13);
                next;
            end;
          end;
          ShowModal;
        end;
      end;
      close;
    except
      on E: Exception do
      begin
        self.Enabled:=true;
        msginfo.Caption:='';
        pnlQuery.Refresh;
        screen.Cursor:=crDefault;
        SysLog.WriteErr('生成公式票价失败：' + E.Message);
      end;
    end;
  end;
  self.Enabled:=true;
  msginfo.Caption:='';
  pnlQuery.Refresh;
  screen.Cursor:=crDefault;
end;

end.
