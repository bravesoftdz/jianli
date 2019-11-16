unit UFrmPrintTemplateAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  NovaHComboBox,UDMPublic,Services, DB, DBClient, jsonClientDataSet, ExtDlgs,
  Printers, ImgList;

type
  TFrmPrintTemplateAdd = class(TSimpleEditForm)
    lbltemplatetype: TLabel;
    lblname: TLabel;
    lblheight: TLabel;
    lblheightcorrection: TLabel;
    lblwidth: TLabel;
    lblleft: TLabel;
    lbltop: TLabel;
    lblbackgroundimage: TLabel;
    lblrowspace: TLabel;
    lblprintername: TLabel;
    lblcolumnsperpage: TLabel;
    Nvhcbbtemplatetype: TNovaHComboBox;
    nvedtname: TNovaEdit;
    nvedtheight: TNovaEdit;
    nvedtheightcorrection: TNovaEdit;
    nvedtwidth: TNovaEdit;
    nvedtleft: TNovaEdit;
    nvedttop: TNovaEdit;
    btnbackgroundimage: TButton;
    lblimagepath: TLabel;
    nvedtrowspace: TNovaEdit;
    nvcbbprintername: TNovaComboBox;
    nvedtcolumnsperpage: TNovaEdit;
    cbgeneratedetail: TCheckBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    jcdsSavePrinttemplate: TjsonClientDataSet;
    lblrowperpage: TLabel;
    nvedtrowperpage: TNovaEdit;
    lbl10: TLabel;
    dlgOpenPic: TOpenPictureDialog;
    ChkAutoPages: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure btnbackgroundimageClick(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Int64;
    procedure initPrinterList();
  public
    { Public declarations }
    id,createtime,createby:String;
    property operationid:Int64 read Foperationid;
  end;

var
  FrmPrintTemplateAdd: TFrmPrintTemplateAdd;

implementation

{$R *.dfm}

procedure TFrmPrintTemplateAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if Nvhcbbtemplatetype.ItemIndex<0 then
  begin
    SysDialogs.ShowError('模板类型不能为空！');
    Nvhcbbtemplatetype.SetFocus;
    exit;
  end;
  if trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowError('名称不能为空！');
    nvedtname.SetFocus;
    exit;
  end;
  if (nvedtrowperpage.Text='') or (StrToIntDef(nvedtrowperpage.Text,0)<=0) then
  begin
    SysDialogs.ShowError('数据集打印行数不能为空，请输入！');
    nvedtrowperpage.SetFocus;
    exit;
  end;
  if (nvedtcolumnsperpage.Text='') or (StrToIntDef(nvedtcolumnsperpage.Text,0)<=0) then
  begin
    SysDialogs.ShowError('数据集打印列数不能为空，请输入！');
    nvedtcolumnsperpage.SetFocus;
    exit;
  end;
  if (nvedtrowspace.Text='') or (StrToIntDef(nvedtrowspace.Text,0)<=0) then
  begin
    SysDialogs.ShowError('数据集行距不能为空，请输入！');
    nvedtrowspace.SetFocus;
    exit;
  end;
  if (nvedtheight.Text='') or (StrToIntDef(nvedtheight.Text,0)<=0) then
  begin
    SysDialogs.ShowError('高度不能为空，请输入！');
    nvedtheight.SetFocus;
    exit;
  end;
  if (nvedtheightcorrection.Text='') or (StrToIntDef(nvedtheightcorrection.Text,0)<=0) then
  begin
    SysDialogs.ShowError('高度修正不能为空，请输入！');
    nvedtheightcorrection.SetFocus;
    exit;
  end;
  if (nvedtwidth.Text='') or (StrToIntDef(nvedtwidth.Text,0)<=0) then
  begin
    SysDialogs.ShowError('宽度不能为空，请输入！');
    nvedtwidth.SetFocus;
    exit;
  end;
  if (trim(nvedtleft.Text)='') then
  begin
    SysDialogs.ShowError('距左不能为空，请输入！');
    nvedtleft.SetFocus;
    exit;
  end;

  if (trim(nvedttop.Text)='') then
  begin
    SysDialogs.ShowError('距顶不能为空，请输入！');
    nvedttop.SetFocus;
    exit;
  end;

  with jcdsSavePrinttemplate do
  begin
    Params.ParamValues['printtemplate.printtemplatetypeid']:=Nvhcbbtemplatetype.HelpFieldValue['id'];
    Params.ParamValues['printtemplate.name']:=trim(nvedtname.Text);
    Params.ParamValues['printtemplate.height']:=trim(nvedtheight.Text);
    Params.ParamValues['printtemplate.heightcorrection']:=trim(nvedtheightcorrection.Text);
    Params.ParamValues['printtemplate.width']:=trim(nvedtwidth.Text);
    Params.ParamValues['printtemplate.left']:=trim(nvedtleft.Text);
    Params.ParamValues['printtemplate.top']:=trim(nvedttop.Text);
    Params.ParamValues['printtemplate.backgroundimage']:=lblimagepath.Caption;
    Params.ParamValues['printtemplate.rowspace']:=trim(nvedtrowspace.Text);
    Params.ParamValues['printtemplate.rowperpage']:=trim(nvedtrowperpage.Text);
    Params.ParamValues['printtemplate.printername']:=trim(nvcbbprintername.Text);
    Params.ParamValues['printtemplate.columnsperpage']:=trim(nvedtcolumnsperpage.Text);
    Params.ParamValues['printtemplate.autopages']:=self.ChkAutoPages.Checked;
//       Params.ParamValues['updatetime']:=trim(nvedtname.Text);
//       Params.ParamValues['updateby']:=trim(nvedtname.Text);
    if edittype=Tedittype.update then
    begin
      Params.ParamValues['printtemplate.createtime']:=createtime;
      Params.ParamValues['printtemplate.createby']:=createby;
      Params.ParamValues['printtemplate.id']:=id;
    end
    else
    begin
      Params.ParamValues['autoGenerateItem']:=BoolToStr(cbgeneratedetail.Checked,true);
    end;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      Foperationid:=Params.ParamValues['operationid'];
      self.ModalResult:=mrok;
    end;
  end;

end;

procedure TFrmPrintTemplateAdd.btnbackgroundimageClick(Sender: TObject);
begin
  inherited;
  if dlgOpenPic.Execute(Self.Handle) then
  begin
    lblimagepath.Caption:=ExtractRelativePath(
                            ExtractFilePath(Application.ExeName),
                            dlgOpenPic.FileName);
  end;
end;

procedure TFrmPrintTemplateAdd.FormCreate(Sender: TObject);
begin
  inherited;
  lblimagepath.Caption:='';
  Nvhcbbtemplatetype.Active:=true;
  initPrinterList;
end;

procedure TFrmPrintTemplateAdd.initPrinterList;
//var  I: Integer;
begin
  nvcbbprintername.Clear;
  nvcbbprintername.Items.Assign(Printer.Printers);
end;

end.
