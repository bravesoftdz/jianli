unit UFrmStationPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaCheckedComboBox,UFrmStationPriceEdit,Services,
  NovaHelp, NovaHComboBox;

type
  TfrmStationPrice = class(TSimpleCRUDForm)
    jcdsDelete: TjsonClientDataSet;
    lbl5: TLabel;
    lbl10: TLabel;
    nvhlpNovaHStation: TNovaHelp;
    nvcbbDepartstation: TNovaCheckedComboBox;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmStationPrice: TfrmStationPrice;

implementation
uses UDMPublic,PubFn;

{$R *.dfm}

procedure TfrmStationPrice.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbDepartstation.Active:= False;
  nvcbbDepartstation.Active := True;
end;

procedure TfrmStationPrice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
   with jcdsResult do
  begin
    Active:=False;
      Params.ParamValues['filter_INS_dt!id']:=nvcbbDepartstation.GetSelectID;
      if (nvhlpNovaHStation.Text<>'') and (nvhlpNovaHStation.Id >0) then
      begin
       Params.ParamValues['filter_EQL_rt!id']:=nvhlpNovaHStation.Id;
      end
      else
        Params.ParamValues['filter_EQL_rt!id']:='';
    Active:=True;
    end;
end;

procedure TfrmStationPrice.tbtnInsertClick(Sender: TObject);
begin
  inherited;
 //添加
   frmStationPriceEdt := TfrmStationPriceEdt.Create(self);
  with frmStationPriceEdt do
  begin
   try
    Caption := '添加站点平时票价';
    isedit:= False;
     ShowModal;
     if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
   finally
    FreeAndNil(frmStationPriceEdt);
   end;
  end;
end;

procedure TfrmStationPrice.tbtnEditClick(Sender: TObject);
var HexStr:string;curid:int64;
begin
  inherited;
  //修改
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0)  then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('请先选择需要修改的记录！');
    end;
    try
      frmStationPriceEdt := TfrmStationPriceEdt.Create(self);
      with frmStationPriceEdt do
      begin
        Caption:='修改站点平时票价';
        isedit := True;
        id :=  jcdsResult.FieldByName('id').AsInteger;
        edtNovatFullprice.Text :=  jcdsResult.FieldByName('fullprice').AsString;
        fullprice := jcdsResult.FieldByName('fullprice').AsString;
        edtNovaHalfprice.Text :=jcdsResult.FieldByName('halfprice').AsString;
        halfprice :=jcdsResult.FieldByName('halfprice').AsString;
        edtNovaStudentprice.Text :=jcdsResult.FieldByName('studentprice').AsString;
        studentprice:=jcdsResult.FieldByName('studentprice').AsString;
        nvhlpNovaHStation.Text :=  jcdsResult.FieldByName('reachstationname').AsString;
        nvhlpNovaHStation.id := jcdsResult.FieldByName('reachstationid').AsInteger;
        reachestation := jcdsResult.FieldByName('reachstationname').AsString;
        nvhlpNovaHStation.Enabled := false;
        orgname:= jcdsResult.FieldByName('orgname').AsString;
        orgid := jcdsResult.FieldByName('orgid').AsLargeInt;
        departstation := jcdsResult.FieldByName('departstationname').AsString;
        departstationid := jcdsResult.FieldByName('departstationid').AsString;
       ShowModal;
       if ModalResult = mrok then
       begin
         tbtnFilterClick(Sender);
         jcdsResult.Locate('id',id,[] );
       end;
      end;
    finally
      FreeAndNil(frmStationPriceEdt);
    end;
  end;
end;


procedure TfrmStationPrice.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
       // 删除
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该记录吗？') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' 机构：'+jcdsResult.FieldByName('orgname').AsString+','
        +' 发车站：'+jcdsResult.FieldByName('departstationname').AsString+','
        +' 到达站：'+jcdsResult.FieldByName('reachstationname').AsString+','
        +' 全票价'+jcdsResult.FieldByName('fullprice').AsString+','
        +' 半票价'+jcdsResult.FieldByName('halfprice').AsString+','
        +' 学生价'+jcdsResult.FieldByName('studentprice').AsString ;
      SysLog.WriteLog('站点平时票价管理', '删除', log);
      log:='';
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;
end.