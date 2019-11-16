unit UFrmPrintTemplatePlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls,
  GridsEh, DBGridEh, NvDbgridEh, ComCtrls, ToolWin,udmpublic, DB, DBClient,
  jsonClientDataSet, DesignHookUtils,services, Menus, ImgList,
  UFrmPrintTemplateItemAdd, PrintTemplatePlan,Math, DBGridEhGrouping;

type
  TFrmPrintTemplatePlan = class(TSimpleEditForm)
    gbitems: TGroupBox;
    nvdbgrdhitems: TNvDbgridEh;
    scrlbxPlan: TScrollBox;
    bvl1: TBevel;
    tlbop: TToolBar;
    tbtnadd: TToolButton;
    jcdsqueryitem: TjsonClientDataSet;
    ds1: TDataSource;
    spl1: TSplitter;
    jcdsSavePrinttemplateitems: TjsonClientDataSet;
    pmedit: TPopupMenu;
    aa1: TMenuItem;
    ilsmalltools: TImageList;
    tbtnedit: TToolButton;
    tbtndelete: TToolButton;
    tbtn1: TToolButton;
    tbtnAlignLeft: TToolButton;
    tbtnAlignRight: TToolButton;
    tbtnAlignHCenter: TToolButton;
    tbtnAlignTop: TToolButton;
    tbtnAlignBottom: TToolButton;
    tbtnAlignVCenter: TToolButton;
    tbtnSpaceEquH: TToolButton;
    tbtnSapceEquV: TToolButton;
    tbtnMakeMaxHeight: TToolButton;
    tbtnMakeMinHeight: TToolButton;
    tbtnMakeMaxWidth: TToolButton;
    tbtnMakeMinWidth: TToolButton;
    tbtn2: TToolButton;
    tbtn3: TToolButton;
    tbtn4: TToolButton;
    tbtnHide: TToolButton;
    tbtnClear: TToolButton;
    tbtn5: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnAlignLeftClick(Sender: TObject);
    procedure tbtnAlignRightClick(Sender: TObject);
    procedure tbtnAlignHCenterClick(Sender: TObject);
    procedure tbtnAlignTopClick(Sender: TObject);
    procedure tbtnAlignBottomClick(Sender: TObject);
    procedure tbtnAlignVCenterClick(Sender: TObject);
    procedure tbtnSpaceEquHClick(Sender: TObject);
    procedure tbtnSapceEquVClick(Sender: TObject);
    procedure tbtnMakeMaxHeightClick(Sender: TObject);
    procedure tbtnMakeMinHeightClick(Sender: TObject);
    procedure tbtnMakeMaxWidthClick(Sender: TObject);
    procedure tbtnMakeMinWidthClick(Sender: TObject);
    procedure tbtnaddClick(Sender: TObject);
    procedure tbtneditClick(Sender: TObject);
    procedure tbtnHideClick(Sender: TObject);
    procedure tbtndeleteClick(Sender: TObject);
    procedure tbtnClearClick(Sender: TObject);
    procedure jcdsqueryitemAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    addIdSeq:Integer;
    FDesigner:Ilayout;
    printTemplatePlan:TPrintTemplatePlan;
  public
    { Public declarations }
    cdsPrintTemplate:TCustomClientDataSet;
    printtemplate_id:String;
    printtemplate_height:integer;
    printtemplatetype_id:string;
    printtemplate_backgroundimage:string;
    printtemplate_width:integer;
    printtemplate_top:integer;
    printtemplate_left:integer;
    printtemplate_rowperpage:integer;
    printtemplate_rowspace:integer;
    printtemplate_columnsperpage:integer;
  end;

var
  FrmPrintTemplatePlan: TFrmPrintTemplatePlan;

implementation

uses PubFn;

{$R *.dfm}

{ TFrmPrintTemplatePlan }

procedure TFrmPrintTemplatePlan.bbtnSaveClick(Sender: TObject);
var
  i:integer;
  oldAfterScroll:TDataSetNotifyEvent;
begin
  inherited;
  //更新调整后的数据回数据集
  with jcdsqueryitem do
  begin
    DisableControls;
    oldAfterScroll:=AfterScroll;
    try
      AfterScroll:=nil;
      First;
      while not eof do
      begin
        for I := 0 to printTemplatePlan.ControlCount - 1 do
        begin
          if SameText(printTemplatePlan.Controls[i].Name,printTemplatePlan.getComponentNameByid(jcdsqueryitem.FieldByName('id').AsLargeInt)) then
          begin
            //象素数 / DPI = 英寸数   英寸数 * 25.4 = 毫米数
            edit;
            FieldByName('Width').Value:=printTemplatePlan.getMmByPixel(printTemplatePlan.Controls[i].Width);
            FieldByName('height').Value:=printTemplatePlan.getMmByPixel(printTemplatePlan.Controls[i].height);
            FieldByName('top').Value:=printTemplatePlan.getMmByPixel(printTemplatePlan.Controls[i].top)-cdsPrintTemplate.FieldByName('top').AsInteger;
            FieldByName('left').Value:=printTemplatePlan.getMmByPixel(printTemplatePlan.Controls[i].left)-cdsPrintTemplate.FieldByName('left').AsInteger;
            FieldByName('FontName').Value:=printTemplatePlan.getPrintItemFont(printTemplatePlan.Controls[i]).Name;
            FieldByName('FontSize').Value:=printTemplatePlan.getPrintItemFont(printTemplatePlan.Controls[i]).Size;
  //          post;
            Break;
          end;
        end;
        next;
      end;
    finally
      AfterScroll:=oldAfterScroll;
      EnableControls;
    end;
    if jcdsqueryitem.ChangeCount=0 then
    begin
      self.ModalResult:=mrOk;
      Exit;
    end;
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('保存失败:未知错误！');
      end;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        self.ModalResult:=mrOk;
      end;
    except on E: Exception do
      SysDialogs.Warning('保存失败:'+e.Message);
    end;
  end;
{  //保存
  with jcdsSavePrinttemplateitems do
  begin
    i:=0;
    Params.Clear;
    jcdsqueryitem.DisableControls;
    jcdsqueryitem.First;
    while not jcdsqueryitem.eof do
    begin
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].id',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].fontname',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].fontsize',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].isprint',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].parameter',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].title',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].valuetype',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].height',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].width',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].top',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].left',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].createby',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].createtime',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].updateby',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].updatetime',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].printtemplatetypeitem.id',ptInput);
      Params.CreateParam(ftString,'printtemplateitems['+inttostr(i)+'].printtemplate.id',ptInput);


      if jcdsqueryitem.FieldByName('id').AsInteger<=0 then
        Params.ParamValues['printtemplateitems['+inttostr(i)+'].id']:=''
      else
        Params.ParamValues['printtemplateitems['+inttostr(i)+'].id']:=jcdsqueryitem.FieldByName('id').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].fontname']:=jcdsqueryitem.FieldByName('fontname').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].fontsize']:=jcdsqueryitem.FieldByName('fontsize').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].isprint']:=jcdsqueryitem.FieldByName('isprint').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].parameter']:=jcdsqueryitem.FieldByName('parameter').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].title']:=jcdsqueryitem.FieldByName('title').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].valuetype']:=jcdsqueryitem.FieldByName('valuetype').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].height']:=jcdsqueryitem.FieldByName('height').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].width']:=jcdsqueryitem.FieldByName('width').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].top']:=jcdsqueryitem.FieldByName('top').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].left']:=jcdsqueryitem.FieldByName('left').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].createby']:=jcdsqueryitem.FieldByName('createby').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].createtime']:=jcdsqueryitem.FieldByName('createtime').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].updateby']:=jcdsqueryitem.FieldByName('updateby').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].updatetime']:=jcdsqueryitem.FieldByName('updatetime').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].printtemplatetypeitem.id']:=jcdsqueryitem.FieldByName('printtemplatetypeitemid').AsString;
      Params.ParamValues['printtemplateitems['+inttostr(i)+'].printtemplate.id']:=printtemplate_id;
      inc(i);
      jcdsqueryitem.next;
    end;
    Params.CreateParam(ftString,'msg',ptoutput);
    Params.CreateParam(ftinteger,'flag',ptoutput);
    jcdsqueryitem.EnableControls;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;
  end;
  }
end;

procedure TFrmPrintTemplatePlan.FormCreate(Sender: TObject);
begin
  inherited;
  addIdSeq:=-1;
end;

procedure TFrmPrintTemplatePlan.FormShow(Sender: TObject);
begin
  inherited;
  with jcdsqueryitem do
  begin
    Params.ParamValues['filter_EQL_pti!printtemplate.id']:=printtemplate_id;
    Active:=true;
  end;
  printTemplatePlan:=TPrintTemplatePlan(displayPrintTemplate(cdsPrintTemplate,jcdsqueryitem,scrlbxPlan));
  self.Height:=min(Screen.Height,
              printTemplatePlan.Height+gbitems.Height+spl1.Height+tlbop.Height+pnlOperation.Height+self.Height-self.ClientHeight);
  self.Width:=max(self.Width,min(Screen.Width,printTemplatePlan.Width+self.Width-self.ClientWidth));
  FDesigner:=BeginDesign(self,printTemplatePlan);
end;

procedure TFrmPrintTemplatePlan.jcdsqueryitemAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if Assigned(FDesigner) then
  begin
    FDesigner.Clear;
    FDesigner.Add(printTemplatePlan.getDisplayItemByCDS);
    FDesigner.ShowGrabHandle(true);
  end;
end;

procedure TFrmPrintTemplatePlan.tbtnaddClick(Sender: TObject);
begin
  inherited;
  FrmPrintTemplateItemAdd:=TFrmPrintTemplateItemAdd.Create(self);
  with FrmPrintTemplateItemAdd do
  begin
    try
      Caption:='添加打印项目';
      edittype:=TEditType.add;
      printtemplateid:=strtoint64(self.printtemplate_id);
      printtemplatetypeid:=self.printtemplatetype_id;
      if SysMainForm.showFormModal(FrmPrintTemplateItemAdd,False)=mrOk then
      begin
        with jcdsqueryitem do
        begin
          Params.ParamByName('pictures').Value :=printtemplateitem.picture;
          AfterScroll:=nil;
          try
            Insert;
            FieldByName('id').Value:=inttostr(addIdSeq);
            Dec(addIdSeq);
            FieldByName('printtemplateid').Value:=printtemplateitem.printtemplateid;
            FieldByName('printtemplatetypeitemid').Value:=printtemplateitem.printtemplatetypeitemid;
            FieldByName('title').Value:=printtemplateitem.title;
            FieldByName('isprint').Value:=printtemplateitem.isprint;
            FieldByName('fontname').Value:=printtemplateitem.fontname;
            FieldByName('fontsize').Value:=printtemplateitem.fontsize;
            FieldByName('top').Value:=printtemplateitem.top;
            FieldByName('left').Value:=printtemplateitem.left;
            FieldByName('width').Value:=printtemplateitem.width;
            FieldByName('height').Value:=printtemplateitem.height;
            FieldByName('valuetype').Value:=printtemplateitem.valuetype;
            FieldByName('parameter').Value:=printtemplateitem.parameter;
            FieldByName('createtime').Value:=_strtodatetime(printtemplateitem.createtime);
            FieldByName('createby').Value:=printtemplateitem.createby;
            FieldByName('printpicture').Value:=printtemplateitem.picture;
            FieldByName('picture').Value:= printtemplateitem.picture;
            post;
            printTemplatePlan.createDisplayItem();
          finally
            AfterScroll:=jcdsqueryitemAfterScroll;
          end;
        end;
      end;
    finally
      FreeAndNil(FrmPrintTemplateItemAdd);
    end;
  end;
end;

procedure TFrmPrintTemplatePlan.tbtnAlignBottomClick(Sender: TObject);
begin
  inherited;
  FDesigner.AlignBottom;
end;

procedure TFrmPrintTemplatePlan.tbtnAlignHCenterClick(Sender: TObject);
begin
  inherited;
  FDesigner.AlignCenterH;
end;

procedure TFrmPrintTemplatePlan.tbtnAlignLeftClick(Sender: TObject);
begin
  inherited;
  FDesigner.AlignLeft;
end;

procedure TFrmPrintTemplatePlan.tbtnAlignRightClick(Sender: TObject);
begin
  inherited;
  FDesigner.AlignRight;
end;

procedure TFrmPrintTemplatePlan.tbtnAlignTopClick(Sender: TObject);
begin
  inherited;
  FDesigner.AlignTop;
end;

procedure TFrmPrintTemplatePlan.tbtnAlignVCenterClick(Sender: TObject);
begin
  inherited;
  FDesigner.AlignCenterV;
end;

procedure TFrmPrintTemplatePlan.tbtnClearClick(Sender: TObject);
var Acontrol:TControl;
begin
  inherited;
  with jcdsqueryitem do
  begin
    AfterScroll:=nil;
    try
      First;
      while not eof do
      begin
        if not FieldByName('isprint').AsBoolean then
        begin
          Acontrol:=printTemplatePlan.getDisplayItemByCDS;
          Delete;
//          Post;
          FDesigner.Remove(Acontrol);
          Acontrol.Free;
        end;
        next;
      end;
    finally
      AfterScroll:=jcdsqueryitemAfterScroll;
    end;
  end;
end;

procedure TFrmPrintTemplatePlan.tbtndeleteClick(Sender: TObject);
var
  i:integer;
  tmpControls:TList;
begin
  inherited;
  if FDesigner.getControls.Count=0 then
  begin
    SysDialogs.ShowInfo('请先选择要删除的项目');
    exit;
  end
  else
  begin
    with jcdsqueryitem do
    begin
      AfterScroll:=nil;
      try
        tmpControls:=TList.Create;
        try
          tmpControls.Assign(FDesigner.getControls);
          FDesigner.Clear;
          for I := 0 to tmpControls.Count - 1 do
          begin
            printTemplatePlan.locateCDSByDisplayItem(Tcontrol(tmpControls.Items[i]));
            Delete;
//            Post;
            Tcontrol(tmpControls.Items[i]).Free;
          end;
        finally
          tmpControls.Free;
        end;
      finally
        AfterScroll:=jcdsqueryitemAfterScroll;
      end;
    end;
  end;
end;

procedure TFrmPrintTemplatePlan.tbtneditClick(Sender: TObject);
var acontrol:TControl;
HexStr:String;
begin
  inherited;
  if FDesigner.getControls.Count=0 then
  begin
    SysDialogs.ShowInfo('请先选择要修改的项目');
    exit;
  end
  else if FDesigner.getControls.Count>1 then
  begin
    SysDialogs.ShowInfo('不能同时修改多个项目');
    exit;
  end
  else
  begin
    printTemplatePlan.locateCDSByDisplayItem(Tcontrol(FDesigner.getControls.Items[0]));
  end;

  FrmPrintTemplateItemAdd:=TFrmPrintTemplateItemAdd.Create(self);
  with FrmPrintTemplateItemAdd do
  begin
    try
      Caption:='修改打印项目';
      edittype:=TEditType.update;
      printtemplateid:=strtoint64(self.printtemplate_id);
      printtemplatetypeid:=self.printtemplatetype_id;
      createby:=jcdsqueryitem.FieldByName('createby').AsLargeInt;
      createtime:=jcdsqueryitem.FieldByName('createtime').AsString;

      Nvhcbbtypeitem.SetItemIndexByField('id',jcdsqueryitem.FieldByName('printtemplatetypeitemid').AsLargeInt);
      NvhcbbtypeitemChange(Nvhcbbtypeitem);
      nvedtTitle.Text:=jcdsqueryitem.FieldByName('title').AsString;
      nvcbbvaluetype.SetItemIndexByCode(jcdsqueryitem.FieldByName('valuetype').AsString);
      nvcbbvaluetypeChange(nvcbbvaluetype);
      if jcdsqueryitem.FieldByName('valuetype').AsString='7' then
         begin
           HexStr := jcdsqueryitem.FieldByName('printpicture').AsString;
           if (HexStr <> '') then
           imgImg_Picture1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
           if (HexStr = '') then
           HexStr := jcdsqueryitem.FieldByName('picture').AsString;
           if (HexStr <> '') then
              imgImg_Picture1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
         end;

      if jcdsqueryitem.FieldByName('valuetype').AsString='6' then
      begin
        nvcbbparameter.ItemIndex:=nvcbbparameter.Items.IndexOf(jcdsqueryitem.FieldByName('parameter').AsString);
//        nvcbbparameter.Visible:=true;
//        nvedtparameter.Visible:=false;
      end
      else
      begin
        nvedtparameter.Text:=jcdsqueryitem.FieldByName('parameter').AsString;
//        nvcbbparameter.Visible:=false;
//        nvedtparameter.Visible:=true;
      end;
      nvcbbFontname.ItemIndex:=nvcbbFontname.Items.IndexOf(jcdsqueryitem.FieldByName('fontname').AsString);
//      nvedtFontsize.Text:=jcdsqueryitem.FieldByName('fontsize').AsString;
//      nvedttop.Text:=jcdsqueryitem.FieldByName('top').AsString;
//      nvedtleft.Text:=jcdsqueryitem.FieldByName('left').AsString;
//      nvedtwidth.Text:=jcdsqueryitem.FieldByName('width').AsString;
//      nvedtheight.Text:=jcdsqueryitem.FieldByName('height').AsString;
      acontrol:=printTemplatePlan.getDisplayItemByCDS;
      nvedttop.Text:= inttostr(printTemplatePlan.getMmByPixel(AControl.Top)-cdsPrintTemplate.FieldByName('top').AsInteger);
      nvedtleft.Text:=inttostr(printTemplatePlan.getMmByPixel(AControl.Left)-cdsPrintTemplate.FieldByName('left').AsInteger);
      nvedtwidth.Text:=inttostr(printTemplatePlan.getMmByPixel(AControl.Width));
      nvedtheight.Text:=inttostr(printTemplatePlan.getMmByPixel(AControl.Height));
      if AControl is TLabel then
      begin
        nvedtFontsize.Text:= inttostr(TLabel(AControl).Font.Size);
      end
      else
      begin
        nvedtFontsize.Text:=jcdsqueryitem.FieldByName('fontsize').AsString;
      end;

      cbisprint.Checked:=jcdsqueryitem.FieldByName('isprint').AsBoolean;
      if SysMainForm.showFormModal(FrmPrintTemplateItemAdd,False)=mrOk then
      begin
        with jcdsqueryitem do
        begin
          edit;
          FieldByName('printtemplatetypeitemid').Value:=printtemplateitem.printtemplatetypeitemid;
          FieldByName('title').Value:=printtemplateitem.title;
          FieldByName('isprint').Value:=printtemplateitem.isprint;
          FieldByName('fontname').Value:=printtemplateitem.fontname;
          FieldByName('fontsize').Value:=printtemplateitem.fontsize;
          FieldByName('top').Value:=printtemplateitem.top;
          FieldByName('left').Value:=printtemplateitem.left;
          FieldByName('width').Value:=printtemplateitem.width;
          FieldByName('height').Value:=printtemplateitem.height;
          FieldByName('valuetype').Value:=printtemplateitem.valuetype;
          FieldByName('parameter').Value:=printtemplateitem.parameter;
          FieldByName('createtime').Value:=_strtodatetime(printtemplateitem.createtime);
          FieldByName('createby').Value:=printtemplateitem.createby;
          FieldByName('picture').Value:= printtemplateitem.picture;
//          post;
          printTemplatePlan.setDisplayProperty(printTemplatePlan.getDisplayItemByCDS);
          FDesigner.ShowGrabHandle(true);
        end;
      end;
    finally
      FreeAndNil(FrmPrintTemplateItemAdd);
    end;
  end;
end;

procedure TFrmPrintTemplatePlan.tbtnHideClick(Sender: TObject);
var
  i:integer;
  oldVisible:Boolean;
begin
  inherited;
  if FDesigner.getControls.Count=0 then
  begin
    SysDialogs.ShowInfo('请先选择要隐藏的项目');
    exit;
  end
  else
  begin
    with jcdsqueryitem do
    begin
      AfterScroll:=nil;
      try
        oldVisible:=false;
        for I := 0 to FDesigner.getControls.Count - 1 do
        begin
          printTemplatePlan.locateCDSByDisplayItem(Tcontrol(FDesigner.getControls.Items[i]));
          if FieldByName('isprint').AsBoolean then
          begin
            oldVisible:=true;
            Break;
          end;
        end;
        for I := 0 to FDesigner.getControls.Count - 1 do
        begin
          printTemplatePlan.locateCDSByDisplayItem(Tcontrol(FDesigner.getControls.Items[i]));
          edit;
          FieldByName('Width').Value:=printTemplatePlan.getMmByPixel(Tcontrol(FDesigner.getControls.Items[i]).Width);
          FieldByName('height').Value:=printTemplatePlan.getMmByPixel(Tcontrol(FDesigner.getControls.Items[i]).height);
          FieldByName('top').Value:=printTemplatePlan.getMmByPixel(Tcontrol(FDesigner.getControls.Items[i]).top);
          FieldByName('left').Value:=printTemplatePlan.getMmByPixel(Tcontrol(FDesigner.getControls.Items[i]).left);
          FieldByName('FontName').Value:=printTemplatePlan.getPrintItemFont(Tcontrol(FDesigner.getControls.Items[i])).Name;
          FieldByName('FontSize').Value:=printTemplatePlan.getPrintItemFont(Tcontrol(FDesigner.getControls.Items[i])).Size;
          FieldByName('isprint').Value:=not oldVisible;
//          post;
          printTemplatePlan.setDisplayProperty(Tcontrol(FDesigner.getControls.Items[i]));
        end;
      finally
        AfterScroll:=jcdsqueryitemAfterScroll;
      end;
    end;
  end;
end;

procedure TFrmPrintTemplatePlan.tbtnMakeMaxHeightClick(Sender: TObject);
begin
  inherited;
  FDesigner.HeightGrow;
end;

procedure TFrmPrintTemplatePlan.tbtnMakeMaxWidthClick(Sender: TObject);
begin
  inherited;
  FDesigner.WidthGrow;
end;

procedure TFrmPrintTemplatePlan.tbtnMakeMinHeightClick(Sender: TObject);
begin
  inherited;
  FDesigner.HeightCut;
end;

procedure TFrmPrintTemplatePlan.tbtnMakeMinWidthClick(Sender: TObject);
begin
  inherited;
  FDesigner.WidthCut;
end;

procedure TFrmPrintTemplatePlan.tbtnSapceEquVClick(Sender: TObject);
begin
  inherited;
  FDesigner.SpaceEquallyV;
end;

procedure TFrmPrintTemplatePlan.tbtnSpaceEquHClick(Sender: TObject);
begin
  inherited;
  FDesigner.SpaceEquallyH;
end;

end.
