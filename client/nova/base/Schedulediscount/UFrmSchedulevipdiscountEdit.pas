unit UFrmSchedulevipdiscountEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaComboBox,
  DB, DBClient, jsonClientDataSet, NovaHComboBox, ImgList;

type
  TFrmSchedulevipdiscountEdit = class(TSimpleEditForm)
    lbl9: TLabel;
    lbl10: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    jsonCDSvipdiscountSave: TjsonClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    cbbvipgrade: TNovaComboBox;
    edtdefaultdiscount: TNovaEdit;
    cbbhelpcode: TNovaEdit;
    lbl3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtdefaultdiscountExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby,schedulediscountid, defaultdiscountrate : string;
    createtime : TDateTime;
    sign : Boolean;
  end;

var
  FrmSchedulevipdiscountEdit: TFrmSchedulevipdiscountEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSchedulevipdiscountEdit.bbtnSaveClick(Sender: TObject);
var nResult : LongWord;
    sResult : string;
begin
  inherited;
  if (cbbvipgrade.ItemIndex < 0) then
  begin
    SysDialogs.Warning('请选择VIP的等级！！');
    cbbhelpcode.SetFocus;
    exit;
  end;
  if Trim(edtdefaultdiscount.Text) = '' then
  begin
    SysDialogs.Warning('请选择VIP的等级！！');
    edtdefaultdiscount.SetFocus;
    exit;
  end;
  with jsonCDSvipdiscountSave do
  begin
    Close;
    if (edtdefaultdiscount.Text <= defaultdiscountrate) then
    begin
      SysDialogs.Warning('贵宾卡折扣率必须大于班次最低折扣率');
      edtdefaultdiscount.SetFocus;
      exit;
    end;

    Params.ParamByName('schedulevipdiscount.id').Value := id;
    Params.ParamByName('schedulevipdiscount.defaultdiscountrate').Value := StrToFloat(edtdefaultdiscount.Text)/100;
    Params.ParamByName('schedulevipdiscount.vipgrade').Value := TCommInfo(cbbvipgrade.Items.Objects[cbbvipgrade.ItemIndex]).Value;
    Params.ParamByName('schedulevipdiscount.createby').Value := createby;
    Params.ParamByName('schedulevipdiscount.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('schedulevipdiscount.schedulediscountid').Value := schedulediscountid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbvipgrade.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次贵宾折扣添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSchedulevipdiscountEdit.edtdefaultdiscountExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdefaultdiscount.Text) > 100) or (StrToFloat(edtdefaultdiscount.Text) < 0) then
  begin
    SysDialogs.ShowMessage('请输入0-100之间的数');
    edtdefaultdiscount.SetFocus;
    exit;
  end;
end;

procedure TFrmSchedulevipdiscountEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbvipgrade.Active:=false;
  cbbvipgrade.Active:=true;
end;

end.
