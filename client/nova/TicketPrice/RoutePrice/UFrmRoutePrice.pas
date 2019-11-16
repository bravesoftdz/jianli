unit UFrmRoutePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaComboBox, NovaCheckedComboBox,
  Buttons;

type
  TFrmRoutePrice = class(TSimpleCRUDForm)
    Label2: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    lblendstation: TLabel;
    NvHpendstation: TNovaHelp;
    jcdsResultid: TLargeintField;
    jcdsResultorgname: TWideStringField;
    jcdsResultNAME: TWideStringField;
    jcdsResultstartstationname: TWideStringField;
    jcdsResultENDSTATIONNAME: TWideStringField;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    jcsdQryRoutePrice: TjsonClientDataSet;
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    jscdAddRoutePrice: TjsonClientDataSet;
    jscdDelRouteprice: TjsonClientDataSet;
    grpAddInprice: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    DpFromDate: TDateTimePicker;
    DpEndDate: TDateTimePicker;
    bbtnSave: TBitBtn;
    BitBtn2: TBitBtn;
    lblroute: TLabel;
    nvhlproute: TNovaHelp;
    GroupBox3: TGroupBox;
    NvDbgridEh2: TNvDbgridEh;
    Splitter2: TSplitter;
    dsResult1: TDataSource;
    jcdsQryBasePrice: TjsonClientDataSet;
    tlbstop: TToolBar;
    tbtn2: TToolButton;
    tbtnaddstop: TToolButton;
    tbtn7: TToolButton;
    tbtnUpdatestop: TToolButton;
    tbtn8: TToolButton;
    tbtndelstop: TToolButton;
    tbtn14: TToolButton;
    ilsmalltools: TImageList;
    jcdsSaveBasePrice: TjsonClientDataSet;
    jscdDelBaseprice: TjsonClientDataSet;
    jcdsqryRoutestops: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure BitBtn2Click(Sender: TObject);
    procedure nvhlprouteIdChange(Sender: TObject);
    procedure tbtnaddstopClick(Sender: TObject);
    procedure tbtndelstopClick(Sender: TObject);
    procedure tbtnUpdatestopClick(Sender: TObject);
  private
    { Private declarations }
    procedure delRouteprice(ids: String);
    procedure delBaseprice(ids: String);
  public
    { Public declarations }
    isDown: boolean;
    startNO: Integer;
    EndNO: Integer;
  end;

var
  FrmRoutePrice: TFrmRoutePrice;

implementation

uses UFrmRoutePriceEdt, PubFn, Services, UDMPublic, UFrmRoutepriceAdd;
{$R *.dfm}

procedure TFrmRoutePrice.bbtnSaveClick(Sender: TObject);
var
  flag: Integer;
  sResult: string;
begin
  inherited;
//  with jcsdQryRoutePrice do
//  begin
//    while not Eof do
//    begin
//      if ((DpFromDate.Date > jcsdQryRoutePrice.FieldByName('fromdate').AsDateTime) and
//         ( DpFromDate.Date < jcsdQryRoutePrice.FieldByName('todate').AsDateTime)) or
//         ((DpEndDate.Date > jcsdQryRoutePrice.FieldByName('fromdate').AsDateTime) and
//         ( DpEndDate.Date < jcsdQryRoutePrice.FieldByName('todate').AsDateTime))   then
//         begin
//         SysDialogs.Warning('分段票价日期不能交叉!');
//         Exit
//         end
//      else
//      begin
//      Next;
//      end;
//    end;
//  end;
   //
  try
    with jscdAddRoutePrice do
    begin
      Active := false;
      Params.ParamValues['routeprice.routeid'] := jcdsResult.FieldByName('id')
        .AsLargeInt;
      Params.ParamValues['routeprice.fromdate'] := formatdatetime('yyyy-mm-dd',
        DpFromDate.Date);
      Params.ParamValues['routeprice.todate'] := formatdatetime('yyyy-mm-dd',
        DpEndDate.Date);
      Params.ParamValues['routeprice.isbaseprice'] := 0;
      Execute;
      sResult := Params.ParamValues['msg'];
      SysDialogs.ShowMessage(sResult);
      flag := Params.ParamValues['flag'];
      if flag = 1 then
      begin
        grpAddInprice.Visible := false;
        jcdsResultAfterScroll(nil);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('线路分段票价增加失败：' + E.Message);
    end;
  end;
end;

procedure TFrmRoutePrice.BitBtn2Click(Sender: TObject);
begin
  inherited;
  grpAddInprice.Visible := false;
end;

procedure TFrmRoutePrice.delRouteprice(ids: String);
var
  nResult, flag, i: Integer;
  sResult, result, log, temp, title: string;
begin
  try
    with jscdDelRouteprice do
    begin
      Active := false;
      Params.ParamValues['ids'] := ids;
      Execute;
      sResult := Params.ParamValues['msg'];
      flag := Params.ParamValues['flag'];

      if flag <= 0 then
      begin
        SysDialogs.Warning(sResult);
        exit;
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        jcdsResultAfterScroll(nil);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('线路票价信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmRoutePrice.delBaseprice(ids: String);
var
  nResult, flag, i: Integer;
  sResult, result, log, temp, title: string;
begin
  try
    with jscdDelBaseprice do
    begin
      Active := false;
      Params.ParamValues['ids'] := ids;
      Execute;
      sResult := Params.ParamValues['msg'];
      flag := Params.ParamValues['flag'];

      if flag <= 0 then
      begin
        SysDialogs.Warning(sResult);
        exit;
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        jcdsResultAfterScroll(nil);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('线路基础票价信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmRoutePrice.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := true;
  grpAddInprice.Visible := false;
  // grpAddInprice.Top := trunc(self.Height / 2 - 100);
  // grpAddInprice.Top := trunc(self.Width / 2 - 100);
end;

procedure TFrmRoutePrice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with jcsdQryRoutePrice do
  begin
    Active := false;
    Params.ParamValues['routeid'] := jcdsResult.FieldByName('id').AsLargeInt;
    Active := true;
  end;
  with jcdsQryBasePrice do
  begin
    Active := false;
    Params.ParamValues['routeid'] := jcdsResult.FieldByName('id').AsLargeInt;
    Active := true;
  end;
end;

procedure TFrmRoutePrice.nvhlprouteIdChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(Sender);
end;

procedure TFrmRoutePrice.tbtnaddstopClick(Sender: TObject);
var
  nResult, flag, i: Integer;
  ids, sResult, result, log, temp, title: string;
  isbaseprice : Boolean;

begin
  inherited;
  try



    with jcsdQryRoutePrice do
    begin
      First;
      isbaseprice := False;
      while not eof do
      begin
        if (jcsdQryRoutePrice.FieldByName('isselect').AsBoolean) and
          (jcsdQryRoutePrice.FieldByName('id').AsLargeInt > 0) then
        begin
          ids := ids + ',' + jcsdQryRoutePrice.FieldByName('id').AsString;
          isbaseprice := isbaseprice or (jcsdQryRoutePrice.FieldByName('isselect').AsBoolean and jcsdQryRoutePrice.FieldByName('isbaseprice').AsBoolean);
        end;
       temp := BoolToStr(jcsdQryRoutePrice.FieldByName('isbaseprice').AsBoolean) ;
//         isbaseprice := isbaseprice and jcsdQryRoutePrice.FieldByName('isbaseprice').AsBoolean;

        next;
      end;
    end;


    if not isbaseprice then
    begin
      SysDialogs.ShowMessage('选择一条有基础票价的票价信息！');
      isbaseprice := False;
      Exit;
    end;


    if length(ids) > 1 then
    begin
      ids := copy(ids, 2, length(ids));
    end;
    if length(ids) > 0 then
    begin
      // 转存基础票价信息
      with jcdsSaveBasePrice do
      begin
        Active := false;
        Params.ParamValues['ids'] := ids;
        Execute;
        sResult := Params.ParamValues['msg'];
        flag := Params.ParamValues['flag'];
        if flag <= 0 then
        begin
          SysDialogs.Warning(sResult);
          exit;
        end
        else
        begin
          SysDialogs.ShowMessage(sResult);
          jcdsResultAfterScroll(nil);
        end;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('基础票价转存失败：' + E.Message);
    end;
  end;
end;

procedure TFrmRoutePrice.tbtnDeleteClick(Sender: TObject);
var
  ids: string;
begin
  if jcsdQryRoutePrice.Active then
    if jcsdQryRoutePrice.RecordCount > 0 then
    begin
      if SysDialogs.Confirm('删除操作', '确认要删除该线路票价信息吗？') then
        try
          with jcsdQryRoutePrice do
          begin
            First;
            while not eof do
            begin
              if (jcsdQryRoutePrice.FieldByName('isselect').AsBoolean) and
                (jcsdQryRoutePrice.FieldByName('id').AsLargeInt > 0) then
              begin
                ids := ids + ',' + jcsdQryRoutePrice.FieldByName('id').AsString;
              end;
              next;
            end;
          end;
          if length(ids) > 1 then
          begin
            ids := copy(ids, 2, length(ids));
            delRouteprice(ids);
          end;
        except
          on E: Exception do
          begin
            SysLog.WriteErr('保存线路票价信息失败：' + E.Message);
          end
        end;
    end;

end;

procedure TFrmRoutePrice.tbtndelstopClick(Sender: TObject);
var
  nResult, flag, i: Integer;
  ids, sResult, result, log, temp, title: string;
begin
  inherited;
  if jcdsQryBasePrice.Active then
    if jcdsQryBasePrice.RecordCount > 0 then
    begin
      if SysDialogs.Confirm('删除操作', '确认要删除该基础票价信息吗？') then
        try
          with jcdsQryBasePrice do
          begin
            First;
            while not eof do
            begin
              if (jcdsQryBasePrice.FieldByName('isselect').AsBoolean) and
                (jcdsQryBasePrice.FieldByName('id').AsLargeInt > 0) then
              begin
                ids := ids + ',' + jcdsQryBasePrice.FieldByName('id').AsString;
              end;
              next;
            end;
          end;
          if length(ids) > 1 then
          begin
            ids := copy(ids, 2, length(ids));
            delBaseprice(ids);
          end;
        except
          on E: Exception do
          begin
            SysLog.WriteErr('删除线路基础票价信息失败：' + E.Message);
          end
        end;
    end;
end;

procedure TFrmRoutePrice.tbtnEditClick(Sender: TObject);
begin
  inherited;
  FrmRoutePriceEdt := TFrmRoutePriceEdt.Create(self);
  try
    with FrmRoutePriceEdt do
    begin
      Caption := '修改线路票价信息';
      createby := SysInfo.LoginUserInfo.UserID;
      NovaEdtRoute.Text := jcdsResult.FieldByName('NAME').AsString;
      NovaEdtRoute.Id := jcdsResult.FieldByName('id').AsLargeInt;
      NovaEdtRoute.Enabled := false;

      if SysMainForm.showFormModal(FrmRoutePriceEdt, false) = mrok then
      begin
        jcdsResultAfterScroll(nil);
      end;
    end;
  finally
    FreeAndNil(FrmRoutePriceEdt);
  end;
end;

procedure TFrmRoutePrice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    NovaCkbOrg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    Params.ParamValues['filter_LIKES_r!name_OR_r!code_OR_r!jianpin'] := trim
      (nvhlproute.Text);
    if NvHpendstation.Id > 0 then
    begin
      Params.ParamValues['filter_EQL_ste!id'] := NvHpendstation.Id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_ste!id'] := '';
    end;
    jcdsResult.AfterScroll := nil;
    try
      Active := true;
      if RecordCount > 0 then
      begin
        jcdsResultAfterScroll(nil);
      end;
    finally
      nvhlproute.SetFocus;
      nvhlproute.SelectAll;
      jcdsResult.AfterScroll := jcdsResultAfterScroll;
    end;
  end;
end;

procedure TFrmRoutePrice.tbtnInsertClick(Sender: TObject);
var
  Id: Int64;
begin
  inherited;
  if (jcdsResult.FieldByName('id').AsLargeInt)<1 then
  begin
    sysdialogs.ShowMessage('请选择一条线路');
    exit;
  end;

  with jcdsqryRoutestops do
  begin
    Active := False;
    Params.ParamValues['routeid']:= jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['isdepart']:= True;
    Active := True;

    if (Params.ParamValues['msg'] <> '') then    //该线路不存在上车点
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
      Exit;
    end;
  end;


  FrmRoutepriceAdd := TFrmRoutepriceAdd.Create(self);
  try
    with FrmRoutepriceAdd do
    begin
      Caption := '添加线路票价信息';
      routeid := jcdsResult.FieldByName('id').AsLargeInt;

      if SysMainForm.showFormModal(FrmRoutepriceAdd, false) = mrok then
      begin
        Id := curid;
        jcdsResultAfterScroll(nil);
        jcsdQryRoutePrice.Locate('id', Id, []);
      end;
    end;
  finally
    FreeAndNil(FrmRoutepriceAdd);
  end;
end;

procedure TFrmRoutePrice.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  grpAddInprice.Visible := true;
  DpFromDate.MinDate := now;
  DpEndDate.MinDate := now;
end;

procedure TFrmRoutePrice.tbtnUpdatestopClick(Sender: TObject);
var
  nResult, flag, i: Integer;
  sResult, result, log, temp, title: string;
begin
  inherited;
  try
    with jcdsQryBasePrice do
    begin

      nResult := ApplyUpdates(-1);
      sResult := Params.ParamValues['msg'];
      flag := Params.ParamValues['flag'];

      if flag <= 0 then
      begin
        SysDialogs.ShowMessage(sResult);
        exit;
      end
      else
      begin
        SysDialogs.ShowMessage('修改成功！');
        ModalResult := mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存线路票价信息失败：' + E.Message);
    end;
  end;
end;

end.
