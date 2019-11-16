unit UFrmDeductItemEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaComboBox,
  NovaHComboBox, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmDeductItemEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    NovaHCobParent: TNovaHComboBox;
    Label6: TLabel;
    NovaCobType: TNovaComboBox;
    NovaEdtName: TNovaEdit;
    ChbIsPrintDeduct: TCheckBox;
    LabRemark: TLabel;
    MeRemark: TMemo;
    jcdsSavebalancedeductitem: TjsonClientDataSet;
    NovaEdtdeductmoney: TNovaEdit;
    LabDeduct: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    Nvhcbbtemplatetype: TNovaHComboBox;
    ChkAddPrint: TCheckBox;
    lbltemplatetype: TLabel;
    NovaEdtFormula: TNovaEdit;
    ChkForma: TCheckBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ChbIsPrintDeductClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHCobParentSelect(Sender: TObject);
    procedure ChkAddPrintClick(Sender: TObject);
    procedure NovaHCobParentChange(Sender: TObject);
    procedure ChkFormaClick(Sender: TObject);
  private
    { Private declarations }
    log: string;
  public
    { Public declarations }
    balancedeductitemid, aboutid, orgid,parentid: int64;
    createtime,code: String;
    isauditpass, isaudited: boolean;
  end;

var
  FrmDeductItemEdt: TFrmDeductItemEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDeductItemEdt.bbtnSaveClick(Sender: TObject);
var
  nResult, leftcount, rightcount, i: integer;
  sResult, str,result: String;
  nextitem, item: widechar;
begin
  inherited;
  if trim(NovaEdtName.Text) = '' then
  begin
    SysDialogs.Warning('������۷���Ŀ���ƣ�');
    NovaEdtName.SetFocus;
    exit;
  end;
  if NovaCobType.ItemIndex < 0 then
  begin
    SysDialogs.Warning('������ѡ��۷����ͣ�');
    NovaCobType.SetFocus;
    exit;
  end;
  if trim(NovaEdtdeductmoney.Text) = '' then
  begin
    SysDialogs.Warning('������۷ѽ�');
    NovaEdtdeductmoney.SetFocus;
    exit;
  end;
  if (balancedeductitemid > 0) and (NovaHCobParent.ItemIndex > 0) and
    (balancedeductitemid = NovaHCobParent.HelpFieldValue['id']) then
  begin
    SysDialogs.Warning('�����۷���Ŀ����Ϊ����');
    NovaHCobParent.SetFocus;
    exit;
  end;
  if ChkForma.Checked  then
  begin
    if length(NovaEdtFormula.Text) > 1 then
    begin
      str := NovaEdtFormula.Text;
      for i := 1 to length(str) do
      begin
        item := str[i];
        if i < length(str) then
        begin
          nextitem := str[i + 1];
          if SysUtils.CharInSet(item, ['A' .. 'Z']) and SysUtils.CharInSet
            (nextitem, ['A' .. 'Z']) then
          begin
            SysDialogs.Warning('������ļ��㹫ʽ�������������Ƿ���ȷ��');
            NovaEdtFormula.SetFocus;
            exit;
          end;
        end;
        if item = '(' then
          leftcount := leftcount + 1;
        if item = ')' then
          rightcount := rightcount + 1;

      end;
      if leftcount <> rightcount then
      begin
        SysDialogs.Warning('��ʽ�����������ԣ����������Ƿ���ȷ��');
        NovaEdtFormula.SetFocus;
        exit;
      end;
    end;
  end;

  if (self.ChkAddPrint.Checked) and (Nvhcbbtemplatetype.Enabled) and
    (Nvhcbbtemplatetype.ItemIndex < 0) then
  begin
    SysDialogs.Warning('��ѡ�����Ĵ�ӡģ�棡');
    Nvhcbbtemplatetype.SetFocus;
    exit;
  end;

  { if (NovaCobType.ItemIndex >= 1)  and (ChbIsPrintDeduct.Checked) then
    begin
    SysDialogs.Warning(NovaCobType.text+'�������ڴ�ʱ�۷�');
    ChbIsPrintDeduct.SetFocus;
    exit;
    end; }

  try
    with jcdsSavebalancedeductitem do
    begin
      active := false;
      Params.ParamValues['balancedeductitem.id'] := balancedeductitemid;
      //if(balancedeductitemid>0) then
      Params.ParamValues['balancedeductitem.code'] := code;
      Params.ParamValues['balancedeductitem.createby'] :=
        Sysinfo.LoginUserInfo.UserID;
      Params.ParamValues['balancedeductitem.createtime'] := createtime;
      Params.ParamValues['balancedeductitem.deductmoney'] := trim
        (NovaEdtdeductmoney.Text);
      Params.ParamValues['balancedeductitem.deducttype'] :=
        NovaCobType.GetSelectCode;
      Params.ParamValues['balancedeductitem.description'] := trim
        (MeRemark.Text);
      Params.ParamValues['balancedeductitem.isdeductbeforebalance'] :=
        ChbIsPrintDeduct.Checked;
      Params.ParamValues['balancedeductitem.name'] := trim(NovaEdtName.Text);
      Params.ParamValues['balancedeductitem.orgid'] := orgid;
      if NovaHCobParent.ItemIndex >= 0 then
        Params.ParamValues['balancedeductitem.parentid'] :=
          NovaHCobParent.HelpFieldValue['id']
      else
        Params.ParamValues['balancedeductitem.parentid'] := 0;
      Params.ParamValues['balancedeductitem.isaddprintitem'] :=  ChkAddPrint.Checked;
      if ChkAddPrint.Checked then
      begin
        Params.ParamValues['balancedeductitem.printtemplatetypeitemid'] :=  Nvhcbbtemplatetype.HelpFieldValue['id'];
      end;
      Params.ParamValues['balancedeductitem.isticketpriceitem'] := ChbIsPrintDeduct.Checked;
      Params.ParamValues['balancedeductitem.isaudited'] := isaudited;
      Params.ParamValues['balancedeductitem.isauditpass'] := isauditpass;
      if ChkForma.Checked  then
      begin
          Params.ParamValues['balancedeductitem.isexpress'] :=true;
          Params.ParamValues['balancedeductitem.formula'] :=NovaEdtFormula.Text;
      end
      else
      begin
          Params.ParamValues['balancedeductitem.isexpress'] :=false;
          Params.ParamValues['balancedeductitem.formula'] :=null;
      end;

      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if balancedeductitemid > 0 then
          result := '�޸�'
        else
          result := '���';
        log := result + '����̶��۷���Ŀ���۷���Ŀ=' + NovaEdtName.Text + ',�۷�����=' +
          NovaCobType.Text + ',�����۷���Ŀ=' + NovaHCobParent.Text + ',�۷ѽ��=' +
          NovaEdtdeductmoney.Text;
        if ChbIsPrintDeduct.Checked then
          log := log + '�������ʱ�۷�';
        SysLog.WriteLog('�������->����̶��۷���Ŀ', result, log);
        balancedeductitemid := Params.ParamByName('balancedeductitemid').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtName.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�������۷���Ŀ����ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmDeductItemEdt.ChbIsPrintDeductClick(Sender: TObject);
begin
  inherited;
  if (balancedeductitemid=0) and (ChbIsPrintDeduct.Checked) then
    NovaCobType.ItemIndex := 0;

end;

procedure TFrmDeductItemEdt.ChkAddPrintClick(Sender: TObject);
begin
  inherited;
  if ChkAddPrint.Checked then
    Nvhcbbtemplatetype.Enabled := true
  else
    Nvhcbbtemplatetype.Enabled := false;
end;

procedure TFrmDeductItemEdt.ChkFormaClick(Sender: TObject);
begin
  inherited;
  if ChkForma.Checked then
  begin
    NovaEdtFormula.Enabled:=true;
  end
  else
  begin
    NovaEdtFormula.Enabled:=false;
  end;
end;

procedure TFrmDeductItemEdt.FormCreate(Sender: TObject);
begin
  inherited;
  // self.Width := 580;
  NovaCobType.active := false;
  NovaCobType.active := true;
  Nvhcbbtemplatetype.active := false;
  Nvhcbbtemplatetype.active := true;
end;

procedure TFrmDeductItemEdt.FormShow(Sender: TObject);
begin
  inherited;
  with NovaHCobParent do
  begin
    active := false;
    Params.ParamValues['filter_EQL_t!orgid'] := orgid;
    active := true;
  end;
  NovaHCobParent.SetItemIndexByField('id',parentid);
end;

procedure TFrmDeductItemEdt.NovaHCobParentChange(Sender: TObject);
begin
  inherited;
  if NovaHCobParent.active then
  begin
    if (NovaHCobParent.ItemIndex >= 0) and (NovaHCobParent.Text <> '') and
      (NovaHCobParent.HelpFieldValue['isticketpriceitem']) then
    begin
      ChbIsPrintDeduct.Checked := true;
      ChbIsPrintDeduct.Enabled := true;
    end
    else
    begin
      ChbIsPrintDeduct.Checked := NovaHCobParent.HelpFieldValue['isticketpriceitem'];
      ChbIsPrintDeduct.Enabled := true;
    end;
  end
  else
  begin
    ChbIsPrintDeduct.Checked := NovaHCobParent.HelpFieldValue['isticketpriceitem'];
    ChbIsPrintDeduct.Enabled := false;
  end;
end;

procedure TFrmDeductItemEdt.NovaHCobParentSelect(Sender: TObject);
begin
  inherited;
  if NovaHCobParent.active then
  begin
    if (NovaHCobParent.ItemIndex >= 0) and (NovaHCobParent.Text <> '') and
      (NovaHCobParent.HelpFieldValue['isticketpriceitem']) then
    begin
      ChbIsPrintDeduct.Checked := true;
      ChbIsPrintDeduct.Enabled := True;
    end
    else
    begin
      ChbIsPrintDeduct.Checked := NovaHCobParent.HelpFieldValue['isticketpriceitem'];
      ChbIsPrintDeduct.Enabled := True;
    end;
  end
  else
  begin
    ChbIsPrintDeduct.Checked := NovaHCobParent.HelpFieldValue['isticketpriceitem'];
    ChbIsPrintDeduct.Enabled := false;
  end;
end;

end.
