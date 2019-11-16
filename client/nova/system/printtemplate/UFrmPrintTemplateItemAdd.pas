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
    SysDialogs.ShowError('��ѡ������Դ');
    Nvhcbbtypeitem.SetFocus;
    exit;
  end;
  if Trim(nvedtTitle.Text)='' then
  begin
    SysDialogs.ShowError('��ʾ��ǩ����Ϊ�գ�');
    nvedtTitle.SetFocus;
    exit;
  end;
  if nvcbbvaluetype.ItemIndex<0 then
  begin
    SysDialogs.ShowError('��ѡ���ӡ����');
    nvcbbvaluetype.SetFocus;
    exit;
  end;
  if nvcbbparameter.Visible and  (nvcbbparameter.ItemIndex<0) then
  begin
    SysDialogs.ShowError('��ѡ���������');
    nvcbbparameter.SetFocus;
    exit;
  end;

  if lblparameterhint.Visible
    and  ((Trim(nvedtparameter.Text)='') and (nvcbbparameter.ItemIndex<0)) then
  begin
    SysDialogs.ShowError('�������ӡ����');
    nvedtparameter.SetFocus;
    exit;
  end;
//nvedtparameter
  if nvcbbFontname.ItemIndex<0 then
  begin
    SysDialogs.ShowError('��ѡ������');
    nvcbbFontname.SetFocus;
    exit;
  end;
  if (StrToFloatdef(trim(nvedtFontsize.Text),0)<=0) then
  begin
    SysDialogs.ShowError('�����С����Ϊ�գ������룡');
    nvedtFontsize.SetFocus;
    exit;
  end;
  if trim(nvedttop.Text)='' then
  begin
    SysDialogs.ShowError('�ඥ����Ϊ�գ������룡');
    nvedttop.SetFocus;
    exit;
  end;
  if trim(nvedtleft.Text)='' then
  begin
    SysDialogs.ShowError('������Ϊ�գ������룡');
    nvedtleft.SetFocus;
    exit;
  end;
  if (StrToIntDef(trim(nvedtwidth.Text),0)<=0) then
  begin
    SysDialogs.ShowError('��Ȳ���Ϊ�գ������룡');
    nvedtwidth.SetFocus;
    exit;
  end;
  if (StrToIntDef(trim(nvedtheight.Text),0)<=0) then
  begin
    SysDialogs.ShowError('�߶ȶȲ���Ϊ�գ������룡');
    nvedtheight.SetFocus;
    exit;
  end;

  if (Nvhcbbtypeitem.HelpFieldValue['id']=-6) and (imgImg_Picture1.Visible)  then
  begin
     if imgImg_Picture1.Picture.Graphic = nil then
     begin
       SysDialogs.ShowMessage('ͼƬ����Ϊ�գ������룡');
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
        // ת��ΪJPG��ʽ
        jpg1 := TJpegImage.Create;
        jpg1.Assign(imgImg_Picture1.Picture.Graphic);
        jpg1.SaveToStream(mem);
        jpg1.Free;


        if mem.Size > 1048576 then
        begin
          SysDialogs.Warning('ͼƬ��С���ܳ���1M');
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
  nvcbbFontname.ItemIndex:=nvcbbFontname.Items.IndexOf('����');
  if (nvcbbFontname.ItemIndex<0) and (nvcbbFontname.Items.Count>0) then
  begin
    nvcbbFontname.ItemIndex:=0;
  end;
end;

procedure TFrmPrintTemplateItemAdd.nvcbbvaluetypeChange(Sender: TObject);
var CommInfo : TCommInfo;
begin
  inherited;
//��ӡ���ͣ�0���ߡ�1�̶����⡢2�ַ�����3��д���֡�4Сд���֡�5����ʱ�䡢6-�����룩 ȡ�����ֵ�
//��Ŀ�������ͣ�0��ͨ��1��ֵ��2���ڡ�3�����֣� ȡ�����ֵ�
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
    CommInfo.Name := '�̶�����';
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
    CommInfo.Name := '����';
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
    CommInfo.Name := 'ͼƬ';
    CommInfo.Value := '7';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    grpPicture.Visible := True;
    lbl4.Visible := True;
  end
  else if (cbb.HelpFieldValue['id']=-3) or (cbb.HelpFieldValue['id']=-4) or (cbb.HelpFieldValue['id']=-5) then
  begin                      //��ǰҳ��                           //��ҳ��                  //��ӡʱ��
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
//��ӡ���ͣ�0���ߡ�1�̶����⡢2�ַ�����3��д���֡�4Сд���֡�5����ʱ�䡢6-�����룩 ȡ�����ֵ�
//��Ŀ�������ͣ�0��ͨ��1��ֵ��2���ڡ�3�����֣� ȡ�����ֵ�
//  nvedtparameter.Visible:=true;
//  nvcbbparameter.Visible:=false;
  nvcbbvaluetype.Clear;
  if itemtype='0' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '�ַ���';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
  end
  else if itemtype='1' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '�ַ���';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '��д����';
    CommInfo.Value := '3';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := 'Сд����';
    CommInfo.Value := '4';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '��д���';
    //CommInfo.Value := '7';
    CommInfo.Value := '8';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
  end
  else if itemtype='2' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '�ַ���';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '����ʱ��';
    CommInfo.Value := '5';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
  end
  else if itemtype='3' then
  begin
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '�ַ���';
    CommInfo.Value := '2';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
    CommInfo := TCommInfo.Create;
    CommInfo.ID := 0;
    CommInfo.Name := '������';
    CommInfo.Value := '6';
    nvcbbvaluetype.Items.AddObject(CommInfo.Name, CommInfo);
//    nvedtparameter.Visible:=false;
//    nvcbbparameter.Visible:=true;
  end;
  nvcbbvaluetypeChange(nvcbbvaluetype);
end;

end.
