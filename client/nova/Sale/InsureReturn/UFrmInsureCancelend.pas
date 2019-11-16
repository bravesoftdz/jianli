unit UFrmInsureCancelend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, ExtCtrls, StdCtrls, Buttons,FunctionItemIntf, UDMPublic,
  DBGridEhGrouping, GridsEh, DBGridEh, ImgList;

type
  TFrmInsureCancelend = class(TBaseForm)
    pnlEditBox: TPanel;
    pnlOperation: TPanel;
    bbtnSave: TBitBtn;
    bbtnClose: TBitBtn;
    Bevel1: TBevel;
    ImageList: TImageList;
    pnlinsurereceipt: TPanel;
    lblinsurenum_: TLabel;
    lblinsurenum: TLabel;
    Label5: TLabel;
    lblinsuretotalnum: TLabel;
    pnlrr: TPanel;
    bvlrr: TBevel;
    lblreason: TLabel;
    mmoreason: TMemo;
    procedure pnlOperationResize(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    selfActiveWhenKeydown:boolean;
    selfKeydowned:boolean;
  public
    { Public declarations }
    edittype:TEditType;
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true);override;
    //用于标明显示本窗体的用处
  end;

var
  FrmInsureCancelend: TFrmInsureCancelend;

implementation

{$R *.dfm}

procedure TFrmInsureCancelend.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  self.ModalResult:=mrok;
end;

constructor TFrmInsureCancelend.Create(AOwner: TComponent;
  functionItem: IFunctionItem;parameter:TFunctionItemParameters;checkpermission:boolean);
begin
  inherited;
  edittype:=TEdittype.add;
  selfActiveWhenKeydown:=false;
  selfKeydowned:=false;
end;

procedure TFrmInsureCancelend.FormDeactivate(Sender: TObject);
begin
  inherited;
  selfActiveWhenKeydown:=false;
  selfKeydowned:=false;
end;

procedure TFrmInsureCancelend.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  selfActiveWhenKeydown:=self.Active;
  selfKeydowned:=true;
end;

procedure TFrmInsureCancelend.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not selfActiveWhenKeydown then
  begin
    selfKeydowned:=false;
    exit;
  end;
  if not selfKeydowned then  exit;
  selfActiveWhenKeydown:=false;
  selfKeydowned:=false;
  if key=vk_return then
  begin
    if (GetParentForm(self).ActiveControl is Tcombobox) then
      if (GetParentForm(self).ActiveControl as Tcombobox).Style in [csDropDownList,
          csOwnerDrawFixed,csOwnerDrawVariable] then
         key:=0;
      if (GetParentForm(self).ActiveControl is TDBGridEH) then
      begin
        if (GetParentForm(self).ActiveControl as TDBGridEH).DataSource.DataSet.Active
          and (not (GetParentForm(self).ActiveControl as TDBGridEH).DataSource.DataSet.Eof)  then
        begin
         (GetParentForm(self).ActiveControl as TDBGridEH).DataSource.DataSet.Next;
         exit;
        end;
      end;
    selectnext(GetParentForm(self).ActiveControl,true,true);
  end;
  if key=vk_escape then
  begin
    if (GetParentForm(self).ActiveControl is Tcombobox) then
      if (GetParentForm(self).ActiveControl as Tcombobox).Style in [csDropDownList,
         csOwnerDrawFixed,csOwnerDrawVariable] then
         key:=0;
    selectnext(GetParentForm(self).ActiveControl,false,true);
   end;
end;

procedure TFrmInsureCancelend.pnlOperationResize(Sender: TObject);
var newleft:integer;
begin
  inherited;
  newleft:=(TWinControl(Sender).Width-(bbtnClose.Left+bbtnClose.Width-bbtnSave.Left)) div 2;
  bbtnClose.Left:=bbtnClose.Left-(bbtnSave.Left-newleft);
  bbtnSave.Left:=newleft;
end;

end.
