unit UFrmContractor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls,UFrmContractorEdit,Services, NovaHComboBox, NovaEdit,
  NovaCheckedComboBox, NovaHelp;

type
  TfrmContractor = class(TSimpleCRUDForm)
    lbl3: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    nvedtName: TNovaEdit;
    lbllbvehicleid: TLabel;
    lbl18: TLabel;
    nvedtContractno: TNovaEdit;
    jcdsDelete: TjsonClientDataSet;
    lbl23: TLabel;
    lbl2: TLabel;
    nvhelpVehicle: TNovaHelp;
    dtpBegin1: TDateTimePicker;
    dtpEnd1: TDateTimePicker;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmContractor: TfrmContractor;

implementation

{$R *.dfm}

procedure TfrmContractor.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
    //证件已过期
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
 if (jcdsResult.FieldByName('enddate').AsDateTime<Now) then
  begin
    Background := clRed;
  end;
end;

procedure TfrmContractor.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpBegin1.Date := Now;
  dtpBegin1.Checked := False;
  dtpEnd1.Date := Now;
  dtpEnd1.Checked := False;
end;

procedure TfrmContractor.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
    // 删除
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该承包者档案吗？') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['delid']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
      log := ' 删除'+jcdsResult.FieldByName('orgname').AsString+'的承包者:'+jcdsResult.FieldByName('name').AsString;
      SysLog.WriteLog('承包者档案管理', '删除', log);
      log:='';
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TfrmContractor.tbtnEditClick(Sender: TObject);
begin
  inherited;
      //修改
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0)  then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('请先选择需要修改的记录！');
    end;
    try
      frmContractorEdt := TfrmContractorEdt.Create(self);
      with frmContractorEdt do
      begin
        Caption:='修改承包者信息';
        isedit := True;
        id :=  jcdsResult.FieldByName('id').AsInteger;
        createby :=  jcdsResult.FieldByName('createby').AsString;
        createtime :=  jcdsResult.FieldByName('createtime').AsString;

        nvedtName.Text:=  jcdsResult.FieldByName('name').AsString;
        contractname :=jcdsResult.FieldByName('name').AsString;
        nvedtIDcard.Text := jcdsResult.FieldByName('idcard').AsString;
        idcard := jcdsResult.FieldByName('idcard').AsString;
        nvedtContactphone.Text := jcdsResult.FieldByName('contactphone').AsString;
        phone := jcdsResult.FieldByName('contactphone').AsString;
        nvedtAdress.Text := jcdsResult.FieldByName('contactaddress').AsString;
        adress := jcdsResult.FieldByName('contactaddress').AsString;
        nvedtContractno.Text := jcdsResult.FieldByName('contractno').AsString;
        contractno := jcdsResult.FieldByName('contractno').AsString;
        nvedtMonthamount.Text := jcdsResult.FieldByName('monthamount').AsString;
        amount := jcdsResult.FieldByName('monthamount').AsString;
        nvhcbbOrg.SetItemIndexByField('name',jcdsResult.FieldByName('orgname').AsString);
        //nvhcbbVehicle.SetItemIndexByField('name',jcdsResult.FieldByName('vehiclename').AsString);
         orgname:= nvhcbbOrg.Text;
        nvhelpVehicle.Text := jcdsResult.FieldByName('vehiclename').AsString;
        vehicle := jcdsResult.FieldByName('vehiclename').AsString;
        nvhelpVehicle.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
        dtpStartdate.Date := jcdsResult.FieldByName('startdate').AsDateTime;
        starttime := jcdsResult.FieldByName('startdate').AsString;
        dtpEnddate.Date  :=jcdsResult.FieldByName('enddate').AsDateTime;
        endtime :=jcdsResult.FieldByName('enddate').AsString;

        ShowModal;
        if ModalResult = mrok then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id',id,[] );
        end;
      end;
    finally
      FreeAndNil(frmContractorEdt);
    end;
  end;
end;


procedure TfrmContractor.tbtnFilterClick(Sender: TObject);
begin
  inherited;
    with jcdsResult do
  begin
    Active:=False;
      Params.ParamValues['filter_INS_o!id']:=  nvckbOrgid.GetSelectID;

   if (not (Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id>0) then
    begin
      Params.ParamValues['filter_EQL_v!id']:= nvhelpVehicle.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_v!id']:= '';
    end;

      Params.ParamValues['filter_LIKES_c!name']:=  nvedtName.Text;
      Params.ParamValues['filter_LIKES_c!contractno']:= nvedtContractno.Text;
      if dtpBegin1.Checked=True then
      begin
       Params.ParamValues['filter_GED_c!startdate']:=  formatdatetime('yyyy-mm-dd',dtpBegin1.Date);
      end
      else
      begin
        Params.ParamValues['filter_GED_c!startdate']:='';
      end;
      if dtpEnd1.Checked = True then
      begin
       Params.ParamValues['filter_LED_c!enddate']:=  formatdatetime('yyyy-mm-dd',dtpEnd1.Date);
      end
      else
      begin
       Params.ParamValues['filter_LED_c!enddate']:='';
      end;
      Active := True;
  end;
end;

procedure TfrmContractor.tbtnInsertClick(Sender: TObject);
begin
  inherited;
//添加
   frmContractorEdt := TfrmContractorEdt.Create(self);
  with frmContractorEdt do
  begin
    Caption := '添加承包者档案信息';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

end.
