unit UFrmScheduleSeatReserve;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping,
  GridsEh, DBGridEh, NvDbgridEh, ComCtrls, ToolWin, ImgList, NovaEdit, NovaHelp,
  DB, DBClient, jsonClientDataSet;

type
  TFrmScheduleSeatReserve = class(TSimpleEditForm)
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    NovaHelpSchedule: TNovaHelp;
    NovaEdtRoute: TNovaEdit;
    grp1: TGroupBox;
    tlb1: TToolBar;
    btn1: TToolButton;
    btnAdd: TToolButton;
    btnUpdate: TToolButton;
    btnDel: TToolButton;
    NvDbgridEh1: TNvDbgridEh;
    pnl2: TPanel;
    grp2: TGroupBox;
    dbgrdhResult: TNvDbgridEh;
    pnl3: TPanel;
    spl1: TSplitter;
    grp3: TGroupBox;
    tlb2: TToolBar;
    btn5: TToolButton;
    btn6: TToolButton;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    DBGridEh2: TNvDbgridEh;
    grp4: TGroupBox;
    tlb3: TToolBar;
    btn11: TToolButton;
    btn12: TToolButton;
    btn13: TToolButton;
    btn14: TToolButton;
    NvDbgridEh2: TNvDbgridEh;
    jcsdQryReaserve: TjsonClientDataSet;
    ds1: TDataSource;
    jcsdQryDelReaserve: TjsonClientDataSet;
    procedure FormResize(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
  private
    { Private declarations }
    procedure qryReaserve;
  public
    { Public declarations }
  end;

var
  FrmScheduleSeatReserve: TFrmScheduleSeatReserve;

implementation

uses PubFn, Services, UFrmScheduleSeatReserveEdt, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleSeatReserve.btnAddClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;
  FrmScheduleSeatReserveEdt := TFrmScheduleSeatReserveEdt.Create(self);
  try
    with FrmScheduleSeatReserveEdt do
    begin
      Caption := '添加班次固定留位信息';
      edittype := add;
      scheduleid := NovaHelpSchedule.Id;
      createby := SysInfo.LoginUserInfo.UserID;
      code:=NovaHelpSchedule.Text;
      if SysMainForm.showFormModal(FrmScheduleSeatReserveEdt, false) = mrok then
      begin
        curid := Id;
        qryReaserve;
        jcsdQryReaserve.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmScheduleSeatReserveEdt);
  end;
end;

procedure TFrmScheduleSeatReserve.btnDelClick(Sender: TObject);
var
  sResult,log: string;
  nResult:integer;
begin
  inherited;
  if not jcsdQryReaserve.Active then
    exit;
  if jcsdQryReaserve.RecordCount <= 0 then
    exit;
  if SysDialogs.Confirm('删除操作','确认要删除该记录吗？') then
  with jcsdQryDelReaserve do
  begin
    Active := false;
    log:='班次号='+NovaHelpSchedule.Text;
    Params.ParamValues['scheduleseatreserve.id'] := jcsdQryReaserve.FieldByName('id').AsString;
    Params.ParamValues['scheduleseatreserve.updateby'] := SysInfo.LoginUserInfo.UserID;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除固定留位信息', '删除', log);
      qryReaserve;
    end;
  end;
end;

procedure TFrmScheduleSeatReserve.btnUpdateClick(Sender: TObject);
var
  curid: Int64;
begin
  inherited;
  if not jcsdQryReaserve.Active then
    exit;
  if jcsdQryReaserve.RecordCount <= 0 then
    exit;

  FrmScheduleSeatReserveEdt := TFrmScheduleSeatReserveEdt.Create(self);
  try
    with FrmScheduleSeatReserveEdt do
    begin
      Caption := '修改班次固定留位信息';
      edittype := tedittype.update;
      scheduleid := NovaHelpSchedule.Id;
      createby := SysInfo.LoginUserInfo.UserID;
      id := jcsdQryReaserve.FieldByName('id').AsLargeInt;
      dtpStartdate.Date := jcsdQryReaserve.FieldByName('startdate').AsDateTime;
      dtpEndstart.Date :=  jcsdQryReaserve.FieldByName('enddate').AsDateTime;
      Seatnum:=jcsdQryReaserve.FieldByName('seatnum').AsString;
      seatnos:=jcsdQryReaserve.FieldByName('seatnos').AsString;
      createtime:=jcsdQryReaserve.FieldByName('createtime').AsString;
      vehicletypeid:=jcsdQryReaserve.FieldByName('vehicletypeid').AsLargeInt;
      brandModelid:=jcsdQryReaserve.FieldByName('vehiclebrandmodelid').AsLargeInt;
      if SysMainForm.showFormModal(FrmScheduleSeatReserveEdt, false) = mrok then
      begin
        curid := Id;
        qryReaserve;
        jcsdQryReaserve.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmScheduleSeatReserveEdt);
  end;
end;

procedure TFrmScheduleSeatReserve.FormResize(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFrmScheduleSeatReserve.FormShow(Sender: TObject);
begin
  inherited;
  bbtnClose.Left := (self.Width div 2) - (bbtnClose.Width div 2);
  qryReaserve;
end;

procedure TFrmScheduleSeatReserve.qryReaserve;
begin
  with jcsdQryReaserve do
  begin
    Active := false;
    Params.ParamByName('scheduleid').Value :=NovaHelpSchedule.Id;
    Active := true;
  end;
end;

end.
