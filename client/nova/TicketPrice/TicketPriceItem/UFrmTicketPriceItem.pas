unit UFrmTicketPriceItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  DB, DBClient, jsonClientDataSet, ImgList, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmTicketPriceItem = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    cbISTICKETPRICEITEM: TCheckBox;
    NovaEdtName: TNovaEdit;
    CbISAUTOADJUST: TCheckBox;
    NovaCbbItemAbout: TNovaComboBox;
    Label3: TLabel;
    Label15: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    jscdSaveTicketPriceItem: TjsonClientDataSet;
    Label7: TLabel;
    NovaEdtValue: TNovaEdit;
    Label8: TLabel;
    NovaEdtItemFormula: TNovaEdit;
    chkisfreight: TCheckBox;
    NovaEdtCode: TComboBox;
    Label9: TLabel;
    Label10: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    procedure NovaEdtCodeKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure cbISTICKETPRICEITEMClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaCbbItemAboutChange(Sender: TObject);
    procedure NovaEdtItemFormulaKeyPress(Sender: TObject; var Key: Char);
    procedure chkisfreightClick(Sender: TObject);
    procedure NovaEdtCodeChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    id, createby: integer;
    orgid:int64;
    createtime,relatetypename:string;
  end;

var
  FrmTicketPriceItem: TFrmTicketPriceItem;

implementation

uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmTicketPriceItem.bbtnSaveClick(Sender: TObject);
var
  msg,str: String;
  nResult,codecount,i: integer;
  sResult,result: string;
  item,preitem,code:Char;
begin
  inherited;

  if NovaCbbItemAbout.ItemIndex<0 then
  begin
    NovaCbbItemAbout.SetFocus;
    SysDialogs.Warning('请选择费用相关类型！');
    exit;
  end;

  if trim(NovaEdtCode.text)='' then
  begin
    NovaEdtCode.SetFocus;
    SysDialogs.Warning('请填写项目代码！');
    exit;
  end;
  if trim(NovaEdtCode.text)='Q' then
  begin
    NovaEdtCode.SetFocus;
    SysDialogs.Warning('项目代码不允许使用Q表示！');
    exit;
  end;
  if (NovaCbbItemAbout.ItemIndex=9) and (trim(NovaEdtValue.Text) = '') then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('请输入计算值！');
    exit;
  end;
  if (NovaCbbItemAbout.ItemIndex=10) and (trim(NovaEdtItemFormula.Text) = '') then
  begin
    NovaEdtItemFormula.SetFocus;
    SysDialogs.Warning('请输入计算表达式！');
    exit;
  end;
  codecount:=0;
  code:= (NovaEdtCode.Text)[1];
  str:=  trim(NovaEdtItemFormula.text);
  for I := 1 to length(str) do
  begin
    item:=str[i];
    if item=code then
    begin
      codecount:=codecount+1;
      if codecount>0 then
      begin
        NovaEdtValue.SetFocus;
        SysDialogs.Warning('表达式中的项目'+NovaEdtCode.Text+'代码不能重复！');
        exit;
      end;
    end;
  end;


  with jscdSaveTicketPriceItem do
  begin
    close;
    Params.ParamByName('ticketpriceformulaitem.id').Value := id;

    Params.ParamByName('ticketpriceformulaitem.orgid').Value := NovaHCbbOrg.HelpFieldValue
      ['id'];
    Params.ParamByName('ticketpriceformulaitem.code').Value := trim(NovaEdtCode.text);
    Params.ParamByName('ticketpriceformulaitem.name').Value := trim(NovaEdtName.text);
    Params.ParamByName('ticketpriceformulaitem.relatetype').Value := NovaCbbItemAbout.GetSelectCode;
    Params.ParamByName('ticketpriceformulaitem.isdefault').Value := false;
    Params.ParamByName('ticketpriceformulaitem.itemformula').Value := NovaEdtItemFormula.Text;
    Params.ParamByName('ticketpriceformulaitem.isfreight').Value := chkisfreight.Checked  ;
    Params.ParamByName('ticketpriceformulaitem.isticketpriceitem').Value := cbISTICKETPRICEITEM.Checked;
    Params.ParamByName('ticketpriceformulaitem.isautoadjust').Value := CbISAUTOADJUST.Checked;
    Params.ParamByName('ticketpriceformulaitem.isactive').Value := true;
    if trim(NovaEdtValue.text)='' then
      Params.ParamByName('ticketpriceformulaitem.value').Value := null
    else
      Params.ParamByName('ticketpriceformulaitem.value').Value := trim(NovaEdtValue.text);
    Params.ParamByName('ticketpriceformulaitem.createby').Value := createby;
    Params.ParamByName('ticketpriceformulaitem.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaEdtCode.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result +'票价公式组成项：费用项目相关='+NovaCbbItemAbout.Text+',项目代码='+
        NovaEdtCode.Text+',项目名称='+NovaEdtName.Text+',计算表达式='+
        NovaEdtItemFormula.Text+',计算值='+NovaEdtValue.Text;
        if cbISTICKETPRICEITEM.Checked then
          log := log + ',票价分项';
        if CbISAUTOADJUST.Checked then
          log := log + ',调整票价时自动调整';
        if chkisfreight.Checked then
          log := log + ',基础运价';
        SysLog.WriteLog('票价管理——>票价公式组成项',result,log);
        id:= Params.ParamByName('formulaitemid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票价公式组成项增加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTicketPriceItem.cbISTICKETPRICEITEMClick(Sender: TObject);
begin
  inherited;
  if cbISTICKETPRICEITEM.Checked then
  begin
    //CbISAUTOADJUST.Enabled := true;
  end
  else
  begin
    CbISAUTOADJUST.Enabled := false;
    CbISAUTOADJUST.Checked:=false;
  end;
end;

procedure TFrmTicketPriceItem.chkisfreightClick(Sender: TObject);
begin
  inherited;
  if chkisfreight.Checked then
  begin
    CbISAUTOADJUST.Checked := true;
    CbISAUTOADJUST.Enabled:=false;
    cbISTICKETPRICEITEM.Checked:=true;
    cbISTICKETPRICEITEM.Enabled:=false
  end
  else
  begin
    CbISAUTOADJUST.Enabled:=true;
    cbISTICKETPRICEITEM.Enabled:=true
  end;
end;

procedure TFrmTicketPriceItem.FormShow(Sender: TObject);
begin
  inherited;
  NovaCbbItemAbout.Active := false;
  NovaCbbItemAbout.Active := true;
  NovaHCbbOrg.Active := false;
  NovaHCbbOrg.Active := true;
  NovaEdtValue.Enabled:=false;
  if edittype=Tedittype.update then
  begin
    NovaHCbbOrg.SetItemIndexByField('id',orgid);
    NovaHCbbOrg.Enabled:=false;
    NovaCbbItemAbout.ItemIndex:=NovaCbbItemAbout.Items.IndexOf(relatetypename);
    if NovaCbbItemAbout.ItemIndex=9 then
       NovaEdtValue.Enabled:=true
    else
    begin
       NovaEdtValue.Enabled:=false;
     //  NovaEdtValue.Clear;
    end;
  end;

end;

procedure TFrmTicketPriceItem.NovaCbbItemAboutChange(Sender: TObject);
begin
  inherited;

  chkisfreight.Enabled:=false;
  if NovaCbbItemAbout.ItemIndex=9 then
  begin
     chkisfreight.Checked:=false;
     NovaEdtValue.Enabled:=true;
     NovaEdtItemFormula.Enabled:=false;
     NovaEdtItemFormula.Clear;
  end
  else if NovaCbbItemAbout.ItemIndex=10 then
  begin
     chkisfreight.Enabled:=true;
     NovaEdtItemFormula.Enabled:=true;
     NovaEdtValue.Enabled:=false;
     NovaEdtValue.Clear;
  end
  else
  begin
     chkisfreight.Checked:=false;
     NovaEdtItemFormula.Enabled:=false;
     NovaEdtItemFormula.Clear;
     NovaEdtValue.Enabled:=false;
     NovaEdtValue.Clear;
  end;
end;

procedure TFrmTicketPriceItem.NovaEdtCodeChange(Sender: TObject);
var
  code:String;
begin
  inherited;
  code:=trim(NovaEdtCode.Text);
  NovaEdtName.ReadOnly:=true;
  if code='B' then
  begin
    NovaEdtName.Text:='车型运价费率';
  end
  else if code='C' then
  begin
    NovaEdtName.Text:='站务费';
  end
  else if code='D' then
  begin
    NovaEdtName.Text:='附加费';
  end
  else if code='E' then
  begin
    NovaEdtName.Text:='微机费';
  end
  else if code='F' then
  begin
    NovaEdtName.Text:='基本运价';
  end
  else if code='G' then
  begin
    NovaEdtName.Text:='空调费';
  end
  else if code='H' then
  begin
    NovaEdtName.Text:='配水费';
  end
  else if code='I' then
  begin
    NovaEdtName.Text:='保险费';
  end
  else if code='J' then
  begin
    NovaEdtName.Text:='其它'
  end
  else if code='K' then
  begin
    NovaEdtName.Text:='燃油费'
  end
  else
  begin
    NovaEdtName.ReadOnly:=false;
    NovaEdtName.Clear;
  end;
end;

procedure TFrmTicketPriceItem.NovaEdtCodeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(Key in ['A' .. 'Z','a' .. 'z']) then
    Key := #0;
end;

procedure TFrmTicketPriceItem.NovaEdtItemFormulaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(Key in ['0'..'9','A' .. 'Z','.','a' .. 'z','-','*','/','+','(',')',#8,#13]) then
    Key := #0;
end;

end.
