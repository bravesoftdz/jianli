unit UFrmScheduleCyleType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping,
  ComCtrls, ToolWin, GridsEh, DBGridEh, ImgList, NovaEdit, DB, DBClient,
  jsonClientDataSet, NovaComboBox, NvDbgridEh;

type
  TFrmScheduleCycleType = class(TSimpleEditForm)
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaEdtName: TNovaEdit;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    ImageList1: TImageList;
    Panel2: TPanel;
    ToolBar4: TToolBar;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton18: TToolButton;
    Label5: TLabel;
    jcdsQryStatus: TjsonClientDataSet;
    DataSource1: TDataSource;
    NovaCbbType: TNovaComboBox;
    NvDbgridEh1: TNvDbgridEh;
    Panel4: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Panel5: TPanel;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox26: TCheckBox;
    CheckBox27: TCheckBox;
    CheckBox28: TCheckBox;
    CheckBox29: TCheckBox;
    CheckBox30: TCheckBox;
    CheckBox31: TCheckBox;
    CheckBox32: TCheckBox;
    CheckBox33: TCheckBox;
    CheckBox34: TCheckBox;
    CheckBox35: TCheckBox;
    CheckBox36: TCheckBox;
    CheckBox37: TCheckBox;
    Panel6: TPanel;
    CheckBox38: TCheckBox;
    CheckBox39: TCheckBox;
    CheckBox40: TCheckBox;
    CheckBox41: TCheckBox;
    CheckBox42: TCheckBox;
    CheckBox43: TCheckBox;
    CheckBox44: TCheckBox;
    CheckBox45: TCheckBox;
    CheckBox46: TCheckBox;
    CheckBox47: TCheckBox;
    CheckBox48: TCheckBox;
    CheckBox49: TCheckBox;
    CheckBox50: TCheckBox;
    CheckBox51: TCheckBox;
    CheckBox52: TCheckBox;
    CheckBox53: TCheckBox;
    CheckBox54: TCheckBox;
    CheckBox55: TCheckBox;
    CheckBox56: TCheckBox;
    CheckBox57: TCheckBox;
    CheckBox58: TCheckBox;
    CheckBox59: TCheckBox;
    CheckBox60: TCheckBox;
    CheckBox61: TCheckBox;
    CheckBox62: TCheckBox;
    CheckBox63: TCheckBox;
    CheckBox64: TCheckBox;
    CheckBox65: TCheckBox;
    CheckBox66: TCheckBox;
    CheckBox67: TCheckBox;
    CheckBox68: TCheckBox;
    Label6: TLabel;
    jcdsSaveSchedulecycle: TjsonClientDataSet;
    procedure NovaCbbTypeChange(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure jcdsQryStatusAfterInsert(DataSet: TDataSet);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    orderno:integer;
    log : String;
  public
    { Public declarations }
    pid, id,  createby,orgid,ruletype: integer;
    createtime:string;
    rules,rules1,rules2,rules3:string;
  end;

var
  FrmScheduleCycleType: TFrmScheduleCycleType;

implementation
uses PubFn,Services, UDMPublic,ruleConvert;
{$R *.dfm}

procedure TFrmScheduleCycleType.bbtnSaveClick(Sender: TObject);
var
  rule:string;
  i:integer;
  msg: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  if NovaCbbType.ItemIndex<0 then
  begin
    SysDialogs.Warning('请选择循环类型！');
    NovaCbbType.SetFocus;
    exit;
  end;
  if NovaCbbType.ItemIndex=0 then
  with jcdsQryStatus do
  begin
    First;
    rule:='';
    while not eof  do
    begin
      if jcdsQryStatus.FieldByName('status').AsBoolean then
        rule:=rule+'1'
      else
        rule:=rule+'0';
      next;
    end;
  end
  else if NovaCbbType.ItemIndex=1 then
  begin
     rule:='';
     for i:= 0 to Panel4.ControlCount-1 do
     begin
       if (Panel4.Controls[i] is TCheckBox) then
       begin
         if (TCheckBox(Panel4.Controls[i]).Checked) then
            rule:=rule+inttostr(TCheckBox(Panel4.Controls[i]).TabOrder+1)+',';
       end;
     end;
  end
  else if NovaCbbType.ItemIndex=2 then
  begin
     rule:='';
     for i:= 0 to Panel5.ControlCount-1 do
     begin
       if (Panel5.Controls[i] is TCheckBox) then
       begin
         if (TCheckBox(Panel5.Controls[i]).Checked) then
            rule:=rule+inttostr(TCheckBox(Panel5.Controls[i]).TabOrder+1)+',';
       end;
     end;
  end
  else if NovaCbbType.ItemIndex=3 then
  begin
     rule:='';
     for i:= 0 to Panel6.ControlCount-1 do
     begin
       if (Panel6.Controls[i] is TCheckBox) then
       begin
         if (TCheckBox(Panel6.Controls[i]).Checked) then
            rule:=rule+inttostr(TCheckBox(Panel6.Controls[i]).TabOrder+1)+',';
       end;
     end;
  end;
  if (rule='') then
  begin
      SysDialogs.Warning('请设置循环规则！');
      exit;
  end;
  if (NovaCbbType.ItemIndex>0) then
  begin
    rule:=ruleSort(rule);
  end;
 // showmessage(rule);
 // strtoint('1') ;

 with jcdsSaveSchedulecycle do
  begin
    close;
    Params.ParamByName('schedulecycle.id').Value := 0;
    Params.ParamByName('schedulecycle.rule').Value := rule;
    Params.ParamByName('schedulecycle.cyclescheme.id').Value := pid;
    Params.ParamByName('schedulecycle.type').Value := NovaCbbType.ItemIndex;
    Params.ParamByName('schedulecycle.createby').Value := createby;
    if createtime<>'' then
      Params.ParamByName('schedulecycle.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;

      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaEdtName.SetFocus;
      end
      else
      begin
        if NovaCbbType.ItemIndex=0 then
        with jcdsQryStatus do
        begin
          First;
          rule:='';
          while not eof  do
          begin
            if jcdsQryStatus.FieldByName('status').AsBoolean then
              rule:=rule+'1'
            else
              rule:=rule+'0';
            next;
          end;
        end
        else if NovaCbbType.ItemIndex=1 then
        begin
           rule:='';
           for i:= 0 to Panel4.ControlCount-1 do
           begin
             if (Panel4.Controls[i] is TCheckBox) then
             begin
               if (TCheckBox(Panel4.Controls[i]).Checked) then
                  rule:=rule+inttostr(TCheckBox(Panel4.Controls[i]).TabOrder+1)+',';
             end;
           end;
        end
        else if NovaCbbType.ItemIndex=2 then
        begin
           rule:='';
           for i:= 0 to Panel5.ControlCount-1 do
           begin
             if (Panel5.Controls[i] is TCheckBox) then
             begin
               if (TCheckBox(Panel5.Controls[i]).Checked) then
                  rule:=rule+inttostr(TCheckBox(Panel5.Controls[i]).TabOrder+1)+',';
             end;
           end;
        end
        else if NovaCbbType.ItemIndex=3 then
        begin
           rule:='';
           for i:= 0 to Panel6.ControlCount-1 do
           begin
             if (Panel6.Controls[i] is TCheckBox) then
             begin
               if (TCheckBox(Panel6.Controls[i]).Checked) then
                  rule:=rule+inttostr(TCheckBox(Panel6.Controls[i]).TabOrder+1)+',';
             end;
           end;
        end;
        log := '添加循环规则：循环组名称='+NovaEdtName.Text+',循环开始日期='+
        FormatDateTime('yyyy-mm-dd',DateTpFromDate.Date)+',循环开始日期='+
        FormatDateTime('yyyy-mm-dd',DateTpEndDate.Date)+',循环类型='+
        NovaCbbType.Text+',循环规则='+rule;
        SysLog.WriteLog('业务管理——>班次循环','循环规则',log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次循环类型信息增加失败：' + E.Message);
      end;
    end;
  end;


end;

procedure TFrmScheduleCycleType.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCbbType.Active:=false;
  NovaCbbType.Active:=true;
end;

procedure TFrmScheduleCycleType.FormShow(Sender: TObject);
begin
  inherited;
  if edittype=tedittype.update then
  begin
     NovaCbbTypeChange(sender);
  end;
end;

procedure TFrmScheduleCycleType.jcdsQryStatusAfterInsert(DataSet: TDataSet);
begin
  inherited;
  jcdsQryStatus.Edit;
  jcdsQryStatus.FieldByName('status').Value:=false;
end;

procedure TFrmScheduleCycleType.NovaCbbTypeChange(Sender: TObject);
var
  item,temprules:string;
  i:integer;
begin

  if NovaCbbType.ItemIndex=0 then
  begin
    panel2.Visible:=true;
    panel4.Visible:=false;
    panel5.Visible:=false;
    panel6.Visible:=false;
    with jcdsQryStatus do
    begin
      active:=false;
      Params.ParamValues['cyclescheme.id']:= pid;
      active:=true;
      jcdsQryStatus.Edit;
    end;
  end
  else if NovaCbbType.ItemIndex=1 then
  begin
    panel2.Visible:=false;
    panel4.Visible:=true;
    panel5.Visible:=false;
    panel6.Visible:=false;
  end
  else if NovaCbbType.ItemIndex=2 then
  begin
    panel2.Visible:=false;
    panel4.Visible:=false;
    panel5.Visible:=true;
    panel6.Visible:=false;
  end
  else if NovaCbbType.ItemIndex=3 then
  begin
    panel2.Visible:=false;
    panel4.Visible:=false;
    panel5.Visible:=false;
    panel6.Visible:=true;
  end;
  if (NovaCbbType.ItemIndex=1) and (rules1<>'') then
  begin
      temprules:=rules1+',' ;
      while (length(temprules) > 0) do
      begin
        item := copy(temprules, 1, pos(',', temprules) - 1);
        for i:= 0 to Panel4.ControlCount-1 do
        begin
           if (Panel4.Controls[i] is TCheckBox) then
           begin
             if (TCheckBox(Panel4.Controls[i]).TabOrder=(strtoint(item)-1)) then
             begin
                TCheckBox(Panel4.Controls[i]).Checked:=true;
                break;
             end;
           end;
        end;
        temprules := copy(temprules, pos(',', temprules) + 1, length(temprules));
      end;
  end
  else if(NovaCbbType.ItemIndex=2) and (rules2<>'')then
    begin
      temprules:=rules2+',' ;
      while (length(temprules) > 0) do
      begin
        item := copy(temprules, 1, pos(',', temprules) - 1);
        for i:= 0 to Panel5.ControlCount-1 do
        begin
           if (Panel5.Controls[i] is TCheckBox) then
           begin
             if (TCheckBox(Panel5.Controls[i]).TabOrder=(strtoint(item)-1)) then
             begin
                TCheckBox(Panel5.Controls[i]).Checked:=true;
                break;
             end;
           end;
        end;
        temprules := copy(temprules, pos(',', temprules) + 1, length(temprules));
      end;
   end
   else if(NovaCbbType.ItemIndex=3) and (rules3<>'') then
    begin
      temprules:=rules3+',' ;
      while (length(temprules) > 0) do
      begin
        item := copy(temprules, 1, pos(',', temprules) - 1);
        for i:= 0 to Panel6.ControlCount-1 do
        begin
           if (Panel6.Controls[i] is TCheckBox) then
           begin
             if (TCheckBox(Panel6.Controls[i]).TabOrder=(strtoint(item)-1)) then
             begin
                TCheckBox(Panel6.Controls[i]).Checked:=true;
                break;
             end;
           end;
        end;
        temprules := copy(temprules, pos(',', temprules) + 1, length(temprules));
      end;
   end
end;

procedure TFrmScheduleCycleType.ToolButton14Click(Sender: TObject);
begin
  inherited;
  if NovaCbbType.ItemIndex<0 then
    exit;
  jcdsQryStatus.Last;
  jcdsQryStatus.Append;
end;

procedure TFrmScheduleCycleType.ToolButton18Click(Sender: TObject);
var
  cur:integer;
begin
  inherited;
  if jcdsQryStatus.RecordCount>0  then
  jcdsQryStatus.Delete;
end;

end.
