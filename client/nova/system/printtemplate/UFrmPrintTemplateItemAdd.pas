unit UFrmPrintTemplateItemAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  NovaHComboBox,Services,UDMPublic, ImgList, Menus, ExtDlgs,Jpeg,PubFn;

type
  TPrinttemplateitem = class
	  id:Int64;
    createby:Int64;
    createtime:string;
    fontname:String;
    fontsize:Double;
    height:Integer;
    isprint:Boolean;
    left:Integer;
    parameter:String;
    title:String;
    top:Integer;
    valuetype:String;
    width:Integer;
    printtemplateid:Int64;
    printtemplatetypeitemid:Int64;
    printpicture:String;
    picture:string;
  end;

  TFrmPrintTemplateItemAdd = class(TSimpleEditForm)
    lbltypeitem: TLabel;
    lblTitle: TLabel;
    lblfontname: TLabel;
    lblfontsize: TLabel;
    lbltop: TLabel;
    lblleft: TLabel;
    lblwidth: TLabel;
    lblheight: TLabel;
    lblvaluetype: TLabel;
    lblparameter: TLabel;
    cbisprint: TCheckBox;
    Nvhcbbtypeitem: TNovaHComboBox;
    nvedtTitle: TNovaEdit;
    nvcbbvaluetype: TNovaComboBox;
    nvedtparameter: TNovaEdit;
    nvcbbparameter: TNovaComboBox;
    nvcbbFontname: TNovaComboBox;
    nvedtFontsize: TNovaEdit;
    nvedttop: TNovaEdit;
    nvedtleft: TNovaEdit;
    nvedtwidth: TNovaEdit;
    nvedtheight: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lblparameterhint: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    grpPicture: TGroupBox;
    btn2: TSpeedButton;
    btn1: TSpeedButton;
    pnl1: TPanel;
    imgImg_Picture1: TImage;
    dlgOpenPicPictrue: TOpenPictureDialog;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    lbl4: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NvhcbbtypeitemChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvcbbvaluetypeChange(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
    Fprinttemplatetypeid:String;
    FFprinttemplatetypeid: String;
    mem: TMemoryStream;
    procedure setValueTypeByItemType(itemtype:string);
    procedure setPrinttemplatetypeid(const Value: String);
  public
    { Public declarations }
    printtemplateid:Int64;
    createby:Int64;
    createtime:string;
    //printpicture:string;
    picture:string;
    printtemplateitem:TPrinttemplateitem;
    property printtemplatetypeid:String read FFprinttemplatetypeid write setPrinttemplatetypeid;
  end;

var
  FrmPrintTemplateItemAdd: TFrmPrintTemplateItemAdd;

implementation

{$R *.dfm}

procedure TFrmPrintTemplateItemAdd.bbtnSaveClick(Sender: TObject);
var
jpg1: TJpegImage;
pictures:string;
begin
  inherited;
  if Nvhcbbtypeitem.ItemIndex<0 then
  begin
    SysDialogs.ShowError('请选择数据源');
    Nvhcbbtypeitem.SetFocus;
    exit;
  end;
  if Trim(nvedtTitle.Text)='' then
  begin
    SysDialogs.ShowError('显示标签不能为空！');
    nvedtTitle.SetFocus;
    exit;
  end;
  if nvcbbvaluetype.ItemIndex<0 then
  begin
    SysDialogs.ShowError('请选择打印类型');
    nvcbbvaluetype.SetFocus;
    exit;
  end;
  if nvcbbparameter.Visible and  (nvcbbparameter.ItemIndex<0) then
  begin
    SysDialogs.ShowError('请选择参数类型');
    nvcbbparameter.SetFocus;
    exit;
  end;

  if lblparameterhint.Visible
    and  ((Trim(nvedtparameter.Text)='') and (nvcbbparameter.ItemIndex<0)) then
  begin
    SysDialogs.ShowError('请输入打印参数');
    nvedtparameter.SetFocus;
    exit;
  end;
//nvedtparameter
  if nvcbbFontname.ItemIndex<0 then
  begin
    SysDialogs.ShowError('请选择字体');
    nvcbbFontname.SetFocus;
    exit;
  end;
  if (StrToFloatdef(trim(nvedtFontsize.Text),0)<=0) then
  begin
    SysDialogs.ShowError('字体大小不能为空，请输入！');
    nvedtFontsize.SetFocus;
    exit;
  end;
  if trim(nvedttop.Text)='' then
  begin
    SysDialogs.ShowError('距顶不能为空，请输入！');
    nvedttop.SetFocus;
    exit;
  end;
  if trim(nvedtleft.Text)='' then
  begin
    SysDialogs.ShowError('距左不能为空，请输入！');
    nvedtleft.SetFocus;
    exit;
  end;
  if (StrToIntDef(trim(nvedtwidth.Text),0)<=0) then
  begin
    SysDialogs.ShowError('宽度不能为空，请输入！');
    nvedtwidth.SetFocus;
    exit;
  end;
  if (StrToIntDef(trim(nvedtheight.Text),0)<=0) then
  begin
    SysDialogs.ShowError('高度度不能为空，请输入！');
    nvedtheight.SetFocus;
    exit;
  end;

  if (Nvhcbbtypeitem.HelpFieldValue['id']=-6) and (imgImg_Picture1.Visible)  then
  begin
     if imgImg_Picture1.Picture.Graphic = nil then
     begin
       SysDialogs.ShowMessage('图片不能为空，请输入！');
       Exit;
     end;

  end;

  if imgImg_Picture1.Picture.Graphic = nil then
    begin
      pictures := '';
    end
    else
    begin
      if (not imgImg_Picture1.Picture.Graphic.Empty) then
      begin
        if not assigned(mem) then
        begin
          mem := TMemoryStream.Create;
        end
        else
          mem.Clear;
        // 转换为JPG格式
        jpg1 := TJpegImage.Create;
        jpg1.Assign(imgImg_Picture1.Picture.Graphic);
        jpg1.SaveToStream(mem);
        jpg1.Free;


        if mem.Size > 1048576 then
        begin
          SysDialogs.Warning('图片大小不能超过1M');
          exit;
        end;
        pictures := MemoryStreamToHexStr(mem);
      end;
    end;

  if not assigned(printtemplateitem) then
  begin
    printtemplateitem:=Tprinttemplateitem.Create;
    with printtemplateitem do
    begin
      id:=0;
      printpicture:=pictures;
      picture := pictures;
      if self.edittype=TEditType.update then
      begin
        createby:=self.createby;
        createtime:=Self.createtime;
      end
      else
      begin
        createby:=SysInfo.LoginUserInfo.UserID;
        createtime:=DateTimeToStr(now());
      end;
      fontname:=nvcbbFontname.Text;
      fontsize:=StrToFloat(Trim(nvedtFontsize.Text));
      height:=StrToInt(Trim(nvedtheight.Text));
      isprint:=cbisprint.Checked;
      left:=StrToInt(Trim(nvedtleft.Text));
      if nvedtparameter.Visible then
      begin
        parameter:=nvedtparameter.Text;
      end
      else if nvcbbparameter.Visible then
      begin
        parameter:=nvcbbparameter.Text;
      end;
      title:=nvedtTitle.Text;
      top:=StrToInt(Trim(nvedttop.Text));
      valuetype:=nvcbbvaluetype.GetSelectCode;
      width:=StrToInt(Trim(nvedtwidth.Text));
      printtemplateid:=self.printtemplateid;
      printtemplatetypeitemid:=Nvhcbbtypeitem.HelpFieldValue['id'];
      self.ModalResult:=mrOk;
    end;
  end;
end;


procedure TFrmPrintTemplateItemAdd.btn1Click(Sender: TObject);
begin
  inherited;
  if dlgOpenPicPictrue.Execute then
  begin
    imgImg_Picture1.Picture.Assign(nil);
    imgImg_Picture1.Picture.LoadFromFile(dlgOpenPicPictrue.FileName);
    imgImg_Picture1.Repaint;
  end;
end;

procedure TFrmPrintTemplateItemAdd.btn2Click(Sender: TObject);
begin
  inherited;
  imgImg_Picture1.Picture.Assign(nil);
end;

procedure TFrmPrintTemplateItemAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbFontname.items.Assign(Screen.Fonts);
  nvcbbFontname.ItemIndex:=nvcbbFontname.Items.IndexOf('宋体');
  if (nvcbbFontname.ItemIndex<0) and (nvcbbFontname.Items.Count>0) then
  begin
    nvcbbFontname.ItemIndex:=0;
  end;
end;

procedure TFrmPrintTemplateItemAdd.nvcbbvaluetypeChange(Sender: TObject);
var CommInfo : TCommInfo;
begin
  inherited;
//打印类型（0画线、1固定标题、2字符串、3大写数字、4小写数字、5日期时间、6-条形码） 取数据字典
//项目数据类型（0普通、1数值、2日期、3纯数字） 取数据字典
  nvedtparameter.Visible:=false;
  nvcbbparameter.Visible:=false;
  lblparameterhint.Visible:=false;
  lblparameter.Visible:=false;
  nvedtparameter.NumbersOnly:=false;
  nvedtparameter.ValueType:=ssString;
  if nvcbbvaluetype.ItemIndex<0 then exit;

  CommInfo:=TCommInfo(nvcbbvaluetype.Items.Objects[nvcbbvaluetype.ItemIndex]);
  case strtoint(CommInfo.Value) of
    2:begin
        nvedtparameter.Visible:=true;
        nvcbbparameter.Visible:=false;
        lblparameterhint.Visible:=false;
        lblparameter.Visible:=True;
      end;
    3,4:begin
        nvedtparameter.Visible:=true;
        nvcbbparameter.Visible:=false;
        lblparameterhint.Visible:=True;
        lblparameter.Visible:=True;
//        nvedtparameter.NumbersOnly:=true;
        nvedtparameter.ValueType:=ssDouble;
      end;
    5:begin
        nvedtparameter.Visible:=true;
        nvcbbparameter.Visible:=false;
        lblparameterhint.Visible:=True;
        lblparameter.Visible:=True;
        nvedtparameter.NumbersOnly:=false;
      end;
    6:begin
        nvedtparameter.Visible:=false;
        nvcbbparameter.Visible:=true;
        lblparameterhint.Visible:=True;
        lblparameter.Visible:=True;
      end;
    7:begin
        nvedtparameter.Visible:=true;
        nvcbbparameter.Visible:=false;
        lblparameterhint.Visible:=false;
        lblparameter.Visible:=True;
      end;
    else
      ;
  end;
end;

procedure TFrmPrintTemplateItemAdd.NvhcbbtypeitemChange(Sender: TObject);
var cbb:TNovaHComboBox;
    CommInfo : TCommInfo;
begin
  inherited;
  if assigned(Sender) and (sender is TNovaHComboBox) then
  begin
    cbb:=TNovaHComboBox(sender);
  end
  else
  begin
    cbb:=Nvhcbbtypeitem;
  end;
  if cbb.HelpFieldValue['id']>0 then
  begin
//    lblparameter.Visible:=true;
//    lblparameterhint.Visible:=true;
    setValueTypeByItemType(cbb.HelpFieldValue['itemtype']);
    grpPicture.Visible := false;
    lbl4.Visible := false;
  end
  else if cbb.HelpFieldValue['id']=-1 then
  begin
    nvcbbvaluetype.Clear;
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '固定标题';
    CommInfo.Value := '1';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    grpPicture.Visible := false;
    lbl4.Visible := false;
//    nvedtparameter.Visible:=false;
//    nvcbbparameter.Visible:=false;
//    lblparameter.Visible:=false;
//    lblparameterhint.Visible:=False;
  end
  else if cbb.HelpFieldValue['id']=-2 then
  begin
    nvcbbvaluetype.Clear;
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '画线';
    CommInfo.Value := '0';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    grpPicture.Visible := false;
    lbl4.Visible := false;
//    nvedtparameter.Visible:=false;
//    nvcbbparameter.Visible:=false;
//    lblparameter.Visible:=false;
//    lblparameterhint.Visible:=False;
  end
  else if cbb.HelpFieldValue['id']=-6 then
  begin
    nvcbbvaluetype.Clear;
    CommInfo := TCommInfo.Create;
    //TODO
    CommInfo.ID := 0;
    CommInfo.Name := '图片';
    CommInfo.Value := '7';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    grpPicture.Visible := True;
    lbl4.Visible := True;
  end
  else if (cbb.HelpFieldValue['id']=-3) or (cbb.HelpFieldValue['id']=-4) or (cbb.HelpFieldValue['id']=-5) then
  begin                      //当前页码                           //总页数                  //打印时间
//    lblparameter.Visible:=true;
//    lblparameterhint.Visible:=true;
    setValueTypeByItemType(cbb.HelpFieldValue['itemtype']);
    grpPicture.Visible := false;
    lbl4.Visible := false;
  end
  ;
  if nvcbbvaluetype.Items.Count=1 then
  begin
    nvcbbvaluetype.ItemIndex:=0;
    nvcbbvaluetypeChange(nvcbbvaluetype);
  end;
  nvedtTitle.Text:=Nvhcbbtypeitem.Text;
end;

procedure TFrmPrintTemplateItemAdd.setPrinttemplatetypeid(const Value: String);
begin
  FFprinttemplatetypeid := Value;
  Nvhcbbtypeitem.Params.ParamValues['printtemplatetype.id']:=printtemplatetypeid;
  Nvhcbbtypeitem.Active:=true;
end;

procedure TFrmPrintTemplateItemAdd.setValueTypeByItemType(itemtype:string);
var CommInfo : TCommInfo;
begin
//打印类型（0画线、1固定标题、2字符串、3大写数字、4小写数字、5日期时间、6-条形码） 取数据字典
//项目数据类型（0普通、1数值、2日期、3纯数字） 取数据字典
//  nvedtparameter.Visible:=true;
//  nvcbbparameter.Visible:=false;
  nvcbbvaluetype.Clear;
  if itemtype='0' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '字符串';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
  end
  else if itemtype='1' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '字符串';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '大写数字';
    CommInfo.Value := '3';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '小写数字';
    CommInfo.Value := '4';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '大写金额';
    //CommInfo.Value := '7';
    CommInfo.Value := '8';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
  end
  else if itemtype='2' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '字符串';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '日期时间';
    CommInfo.Value := '5';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
  end
  else if itemtype='3' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '字符串';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '条形码';
    CommInfo.Value := '6';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
//    nvedtparameter.Visible:=false;
//    nvcbbparameter.Visible:=true;
  end;
  nvcbbvaluetypeChange(nvcbbvaluetype);
end;

end.
