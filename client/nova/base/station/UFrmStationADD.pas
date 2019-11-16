unit UFrmStationADD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleEditForm,Services, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaComboBox,NovaEdit, NovaHelp, ImgList;

type
  TFrmStationADD =  class(TSimpleEditForm)
    lbl1: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    edtname: TNovaEdit;
    lbl4: TLabel;
    lbl6: TLabel;
    jsonCDSStationSave: TjsonClientDataSet;
    nvhlpdistrictid: TNovaHelp;
    lbl2: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    cbbgrade: TNovaComboBox;
    edthelpcode: TNovaEdit;
    Label1: TLabel;
    edtjianpin: TNovaEdit;
    lbl11: TLabel;
    edtsecondname: TNovaEdit;
    rb_depart: TRadioButton;
    rb_nodepart: TRadioButton;
    mmodes: TMemo;
    rg1: TRadioGroup;
    edtcode: TNovaEdit;
    lbcode: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtDistance: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtnameChange(Sender: TObject);
   private
    { Private declarations }
  public
   id,orgid,createby:integer;
   isactive,isroundtrip:Boolean;
  createtime,code:String;
  public
    { Public declarations }
  end;

var
  FrmStationADD: TFrmStationADD;

implementation
     uses PubFn;
{$R *.dfm}

procedure TFrmStationADD.bbtnSaveClick(Sender: TObject);
var nResult: integer;
    sResult, log, handletype:string;
begin
  inherited;
  if Trim(edtname.Text) = '' then
  begin
    SysDialogs.ShowMessage('站点名不能为空');
    edtname.SetFocus;
     exit;
  end;
  if Trim(nvhlpdistrictid.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择行政区域');
    nvhlpdistrictid.SetFocus;
    exit;
  end;
   if cbbgrade.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择站点级别');
    cbbgrade.SetFocus;
    exit;
  end;
  if Trim(edthelpcode.Text) = '' then
  begin
    SysDialogs.ShowMessage('操作码不能为空');
    edthelpcode.SetFocus;
     exit;
  end;
  if nvhlpdistrictid.Id = 0 then
    begin
      SysDialogs.ShowMessage('请选择正确的行政区域');
      nvhlpdistrictid.SetFocus;
      exit;
    end;
  with jsonCDSStationSave do
  begin
    Params.ParamByName('station.districtid').Value:=nvhlpdistrictid.Id;
    Params.ParamByName('station.id').Value :=id ;


    Params.ParamByName('station.name').Value :=Trim(edtname.Text) ;
    Params.ParamByName('station.helpcode').Value :=edthelpcode.Text ;
  // Params.ParamByName('station.isactive').Value :=id ;
    Params.ParamByName('station.isactive').Value :=isactive;
    if rb_depart.Checked then
    begin
      Params.ParamByName('station.isdepart').Value :=True;
    end
    else
    begin
      Params.ParamByName('station.isdepart').Value :=False;
    end;
    if rg1.ItemIndex = 0 then
    begin
      Params.ParamByName('station.isroundtrip').Value :=True;
    end
    else
    begin
      Params.ParamByName('station.isroundtrip').Value :=False;
    end;
//    Params.ParamByName('station.code').Value := edthelpcode.Text;
    Params.ParamByName('station.code').Value := code;
    Params.ParamByName('station.description').Value :=mmodes.Text ;
    Params.ParamByName('station.jianpin').Value :=edtjianpin.Text ;
    Params.ParamByName('station.orgid').Value :=orgid;
    Params.ParamByName('station.secondname').Value := edtsecondname.Text;
    Params.ParamByName('station.createby').Value := createby;
    Params.ParamByName('station.createtime').Value :=  createtime;
    Params.ParamByName('station.distance').Value := NovaEdtDistance.Text;
    Params.ParamByName('station.grade').Value := cbbgrade.GetSelectCode;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtname.SetFocus;
      end
      else
      begin
        log := '站点名称='+edtname.Text+',所属区域='+nvhlpdistrictid.Text+
        ',车站级别='+cbbgrade.Text+',操作码='+edthelpcode.Text+',简拼='+
        edtjianpin.Text+',第二语言='+edtsecondname.Text;
        if rb_depart.Checked then
          log := log + ',是上车点'
        else
          log := log + ',不是上车点';
        if rg1.ItemIndex = 0 then
          log := log + ',售返程票'
        else
          log := log + ',不售返程票';

        if code = '' then
          handletype := '添加站点信息'
        else
          handletype := '修改站点信息';
        if code <> Trim(edtcode.Text) then
          log := log + ',站点编码由='+code+'改为='+edtcode.Text;
        SysLog.WriteLog('业务管理——>站点管理', handletype,log);
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('站点增加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmStationADD.edtnameChange(Sender: TObject);
begin
  inherited;
  edtjianpin.Text:=GetPyChar(trim(edtname.Text)) ;
end;

procedure TFrmStationADD.FormCreate(Sender: TObject);
begin
  inherited;
  isactive:=True;
//    jsonCDSDistrictInit.Active:=false;
//     jsonCDSDistrictInit.Active:=True;
//  InitCombox(cbbdistrictid, jsonCDSDistrictInit);

  cbbgrade.Active:=False;
  cbbgrade.Active:=True;

end;



procedure TFrmStationADD.FormShow(Sender: TObject);
begin
  inherited;
  if isroundtrip = False then
    rg1.ItemIndex := 1
  else
    rg1.ItemIndex := 0;
end;

end.
