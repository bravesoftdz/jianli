unit UFrmQueryRouteDynamicCompare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
  TfrmQueryRouteDynamicCompare = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    nvcbbAddObject: TNovaCheckedComboBox;
    nvhlpRoute: TNovaHelp;
    chkByroute: TCheckBox;
    chkBydate: TCheckBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure dtpComStarChange(Sender: TObject);
//    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryRouteDynamicCompare: TfrmQueryRouteDynamicCompare;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryRouteDynamicCompare.dtpComEndChange(Sender: TObject);
begin
   if not(dtpComEnd.Date=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date)
   then
   begin
      dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
   end;
end;

procedure TfrmQueryRouteDynamicCompare.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
   dtpComEnd.Date:=dtpComStar.Date+dtpenddate.Date-dtpstartdate.Date;
end;

procedure TfrmQueryRouteDynamicCompare.dtpenddateChange(Sender: TObject);
begin
//  if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
//  begin
//    dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
//  end;

end;

//procedure TfrmQueryRouteDynamicCompare.dtpstartdateChange(Sender: TObject);
//begin
//  inherited;
//  if dtpstartdate.Checked then
//  dtpenddate.Date := dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date;
//end;

procedure TfrmQueryRouteDynamicCompare.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbAddObject.Active := False;
  nvcbbAddObject.Active := True;
  chkBydate.Checked := True;
end;

procedure TfrmQueryRouteDynamicCompare.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now;
  dtpComEnd.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryRouteDynamicCompare.tbtnFilterClick(Sender: TObject);
var
  peplodistance: double;
  alldistance: Int64;
  allseatnum: Int64;
  checkticketnum: Int64;
  peplodistance1: double;
  alldistance1: Int64;
  allseatnum1: Int64;
  checkticketnum1: Int64;
  truetake: double;
  _truetake: double;
  aa,log:string;
begin
  inherited;
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpComStar.Date) > FormatDateTime('yyyymmdd',
    dtpComEnd.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
   { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
  begin
    SysDialogs.Warning('同比日期天数差必须等于发车日期天数差!');
    Exit;
  end; }
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    begin
    Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    end
    else
    begin
       Params.ParamValues['filter_EQL_r!id']:= '';
    end;
    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComStar.Date);
    Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date);
      Params.ParamValues['filter_INS_c!addObject'] := nvcbbAddObject.GetSelectID;
    compareObjectid := nvcbbAddObject.GetSelectID;

    //是否按日期排序
    if chkBydate.Checked then
      Params.ParamValues['isbydate']:= 'true'
    else
      Params.ParamValues['isbydate']:= 'false';

      //是否按班线
    if chkByroute.Checked then
      Params.ParamValues['isbyroute']:= 'true'
    else
      Params.ParamValues['isbyroute']:= 'false';

    Active := True;
    if recordcount > 0 then
    begin
      alldistance :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['routedistance']));
      peplodistance :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['peopledistance']));
      allseatnum :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['seats']));
      checkticketnum :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['ticketnum']));

      alldistance1 :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['routedistance1']));
      peplodistance1 :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['peopledistance1']));
      allseatnum1 :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['seats1']));
      checkticketnum1 :=StrToInt(dbgrdhResult.GetFooterValue(0,dbgrdhResult.FieldColumns['ticketnum1']));

      if alldistance>0 then
      begin
        truetake:= roundEx((peplodistance * 100 / alldistance), 2);
        dbgrdhResult.FieldColumns['rate'].Footer.Value :=floattostr(truetake)+'%';
        dbgrdhResult.FieldColumns['seatrate'].Footer.Value :=floattostr( roundEx
        (checkticketnum * 100 / allseatnum, 2))+'%';
      end
      else
      begin
        dbgrdhResult.FieldColumns['rate'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['seatrate'].Footer.Value :='0';
      end;

      if alldistance1>0 then
      begin
        _truetake:= roundEx((peplodistance1 * 100 / alldistance1), 2)   ;
        dbgrdhResult.FieldColumns['rate1'].Footer.Value :=floattostr(_truetake)+'%';
          dbgrdhResult.FieldColumns['seatrate1'].Footer.Value :=floattostr(
          roundEx(checkticketnum1 * 100 / allseatnum1, 2))+'%';
      end
      else
      begin
        dbgrdhResult.FieldColumns['rate1'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['seatrate1'].Footer.Value :='0';
      end;

      dbgrdhResult.FieldColumns['incomerate'].Footer.Value :='100%';
      dbgrdhResult.FieldColumns['incomerate1'].Footer.Value :='100%';
    end
    else
    begin
        dbgrdhResult.FieldColumns['rate'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['incomerate'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['seatrate'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['rate1'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['incomerate1'].Footer.Value :='0';
        dbgrdhResult.FieldColumns['seatrate1'].Footer.Value :='0';
    end;
     dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '查询条件有：[发车日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date)
      +'[同比日期] 从 '+FormatDateTime('yyyy-mm-dd',dtpComStar.Date)
      +' 至 '+FormatDateTime('yyyy-mm-dd',dtpComEnd.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;
    if nvhlpRoute.Id <> 0 then
      log := log +',[线路]:'+ nvhlpRoute.Text;
    if chkBydate.Checked then
      log := log +',[按发车日期统计]' ;
    if chkByroute.Checked then
      log := log +',[按线路名统计]';
    if Trim(nvcbbAddObject.Text)<>'' then
      log := log +',[对比项目]：'+nvcbbAddObject.Text;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->客运班线动态同期对比表','查询',log);
  end;

end;

procedure TfrmQueryRouteDynamicCompare.jcdsResultAfterOpen(DataSet: TDataSet);
var i,partindex:Integer;
    curcolumn:TColumnTitleEh;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    //是否按日期排序
    if chkBydate.Checked then
      dbgrdhResult.Columns[1].Visible :=True
    else
     dbgrdhResult.Columns[1].Visible :=False;
      //是否按班线
    if chkByroute.Checked then
      dbgrdhResult.Columns[0].Visible :=True
    else
      dbgrdhResult.Columns[0].Visible :=False;

    if Pos('10',compareObjectid)<=0  then      //发班数
      begin
          //curcolumn :=dbgrdhResult.Columns[1].Title;
          //curcolumn.Caption := '发班数';
          dbgrdhResult.Columns[2].Visible :=False;
          dbgrdhResult.Columns[3].Visible :=False;
          dbgrdhResult.Columns[4].Visible :=False;
          dbgrdhResult.Columns[5].Visible :=False;
      end
      else
      begin
          //curcolumn :=dbgrdhResult.Columns[1].Title;
          //curcolumn.Caption := '发班数|本期';
          dbgrdhResult.Columns[2].Visible :=True;
          dbgrdhResult.Columns[3].Visible :=True;
          dbgrdhResult.Columns[4].Visible :=True;
          dbgrdhResult.Columns[5].Visible :=True;
      end;
    if Pos('20',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[5].Title;
          //curcolumn.Caption := '总座位数';
          dbgrdhResult.Columns[6].Visible :=False;
          dbgrdhResult.Columns[6].Visible :=False;
          dbgrdhResult.Columns[8].Visible :=False;
          dbgrdhResult.Columns[9].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[5].Title;
         //curcolumn.Caption := '总座位数|本期';
         dbgrdhResult.Columns[6].Visible :=True;
         dbgrdhResult.Columns[6].Visible :=True;
         dbgrdhResult.Columns[8].Visible :=True;
         dbgrdhResult.Columns[9].Visible :=True;
      end;
     if Pos('30',compareObjectid)<=0 then
      begin
         // curcolumn :=dbgrdhResult.Columns[9].Title;
          //curcolumn.Caption := '人数';
          dbgrdhResult.Columns[10].Visible :=False;
          dbgrdhResult.Columns[11].Visible :=False;
          dbgrdhResult.Columns[12].Visible :=False;
          dbgrdhResult.Columns[13].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[9].Title;
         //curcolumn.Caption := '人数|本期';
         dbgrdhResult.Columns[10].Visible :=True;
         dbgrdhResult.Columns[11].Visible :=True;
         dbgrdhResult.Columns[12].Visible :=True;
         dbgrdhResult.Columns[13].Visible :=True;
      end;
     if Pos('40',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[13].Title;
          //curcolumn.Caption := '售票金额';
          dbgrdhResult.Columns[14].Visible :=False;
          dbgrdhResult.Columns[15].Visible :=False;
          dbgrdhResult.Columns[16].Visible :=False;
          dbgrdhResult.Columns[17].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[13].Title;
         //curcolumn.Caption := '售票金额|本期';
         dbgrdhResult.Columns[14].Visible :=True;
         dbgrdhResult.Columns[15].Visible :=True;
         dbgrdhResult.Columns[16].Visible :=True;
         dbgrdhResult.Columns[17].Visible :=True;
      end;
     if Pos('50',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[17].Title;
          //curcolumn.Caption := '结算金额';
          dbgrdhResult.Columns[18].Visible :=False;
          dbgrdhResult.Columns[19].Visible :=False;
          dbgrdhResult.Columns[20].Visible :=False;
          dbgrdhResult.Columns[21].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[17].Title;
         //curcolumn.Caption := '结算金额|本期';
         dbgrdhResult.Columns[18].Visible :=True;
         dbgrdhResult.Columns[19].Visible :=True;
         dbgrdhResult.Columns[20].Visible :=True;
         dbgrdhResult.Columns[21].Visible :=True;
      end;
     if Pos('60',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[21].Title;
         // curcolumn.Caption := '车站收入';

          dbgrdhResult.Columns[22].Visible :=False;
          dbgrdhResult.Columns[23].Visible :=False;
          dbgrdhResult.Columns[24].Visible :=False;
          dbgrdhResult.Columns[25].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[21].Title;
         //curcolumn.Caption := '车站收入|本期';
         dbgrdhResult.Columns[22].Visible :=True;
         dbgrdhResult.Columns[23].Visible :=True;
         dbgrdhResult.Columns[24].Visible :=True;
         dbgrdhResult.Columns[25].Visible :=True;
      end;
     if Pos('70',compareObjectid)<=0 then
      begin
         // curcolumn :=dbgrdhResult.Columns[25].Title;
          //curcolumn.Caption := '客运代理费';
          dbgrdhResult.Columns[26].Visible :=False;
          dbgrdhResult.Columns[27].Visible :=False;
          dbgrdhResult.Columns[28].Visible :=False;
          dbgrdhResult.Columns[29].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[25].Title;
         //curcolumn.Caption := '客运代理费|本期';
         dbgrdhResult.Columns[26].Visible :=True;
         dbgrdhResult.Columns[27].Visible :=True;
         dbgrdhResult.Columns[28].Visible :=True;
         dbgrdhResult.Columns[29].Visible :=True;
      end;
     if Pos('80',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[29].Title;
          //curcolumn.Caption := '站务费';
          dbgrdhResult.Columns[30].Visible :=False;
          dbgrdhResult.Columns[31].Visible :=False;
          dbgrdhResult.Columns[32].Visible :=False;
          dbgrdhResult.Columns[33].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[29].Title;
         //curcolumn.Caption := '站务费|本期';
         dbgrdhResult.Columns[30].Visible :=True;
         dbgrdhResult.Columns[31].Visible :=True;
         dbgrdhResult.Columns[32].Visible :=True;
         dbgrdhResult.Columns[33].Visible :=True;
      end;
     if Pos('90',compareObjectid)<=0 then
      begin
         // curcolumn :=dbgrdhResult.Columns[33].Title;
          //curcolumn.Caption := '微机费';
          dbgrdhResult.Columns[34].Visible :=False;
          dbgrdhResult.Columns[35].Visible :=False;
          dbgrdhResult.Columns[36].Visible :=False;
          dbgrdhResult.Columns[37].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[33].Title;
         //curcolumn.Caption := '微机费|本期';
         dbgrdhResult.Columns[34].Visible :=True;
         dbgrdhResult.Columns[35].Visible :=True;
         dbgrdhResult.Columns[36].Visible :=True;
         dbgrdhResult.Columns[37].Visible :=True;
      end;
     if Pos('111',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[37].Title;
          //curcolumn.Caption := '空调费';
          dbgrdhResult.Columns[38].Visible :=False;
          dbgrdhResult.Columns[39].Visible :=False;
          dbgrdhResult.Columns[40].Visible :=False;
          dbgrdhResult.Columns[41].Visible :=False;
      end
      else
      begin
        // curcolumn :=dbgrdhResult.Columns[37].Title;
         //curcolumn.Caption := '空调费|本期';
         dbgrdhResult.Columns[38].Visible :=True;
         dbgrdhResult.Columns[39].Visible :=True;
         dbgrdhResult.Columns[40].Visible :=True;
         dbgrdhResult.Columns[41].Visible :=True;
      end;
     if Pos('121',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[41].Title;
          //curcolumn.Caption := '附加费';
          dbgrdhResult.Columns[42].Visible :=False;
          dbgrdhResult.Columns[43].Visible :=False;
          dbgrdhResult.Columns[44].Visible :=False;
          dbgrdhResult.Columns[45].Visible :=False;
      end
      else
      begin
        // curcolumn :=dbgrdhResult.Columns[41].Title;
         //curcolumn.Caption := '附加费|本期';
         dbgrdhResult.Columns[42].Visible :=True;
         dbgrdhResult.Columns[43].Visible :=True;
         dbgrdhResult.Columns[44].Visible :=True;
         dbgrdhResult.Columns[45].Visible :=True;
      end;
     if Pos('131',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[45].Title;
          //curcolumn.Caption := '线路总公里';
          dbgrdhResult.Columns[46].Visible :=False;
          dbgrdhResult.Columns[47].Visible :=False;
          dbgrdhResult.Columns[48].Visible :=False;
          dbgrdhResult.Columns[49].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[45].Title;
         //curcolumn.Caption := '线路总公里|本期';
         dbgrdhResult.Columns[46].Visible :=True;
         dbgrdhResult.Columns[47].Visible :=True;
         dbgrdhResult.Columns[48].Visible :=True;
         dbgrdhResult.Columns[49].Visible :=True;
      end;
     if Pos('141',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[49].Title;
          //curcolumn.Caption := '周转量';
          dbgrdhResult.Columns[50].Visible :=False;
          dbgrdhResult.Columns[51].Visible :=False;
          dbgrdhResult.Columns[52].Visible :=False;
          dbgrdhResult.Columns[53].Visible :=False;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[49].Title;
         //curcolumn.Caption := '周转量|本期';
         dbgrdhResult.Columns[50].Visible :=True;
         dbgrdhResult.Columns[51].Visible :=True;
         dbgrdhResult.Columns[52].Visible :=True;
         dbgrdhResult.Columns[53].Visible :=True;
      end;

     if Pos('151',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[53].Title;
          //curcolumn.Caption := '实载率';
          dbgrdhResult.Columns[54].Visible :=False;
          dbgrdhResult.Columns[55].Visible :=False;
          dbgrdhResult.Columns[56].Visible :=False;
          dbgrdhResult.Columns[57].Visible :=False;
        if Pos('131',compareObjectid)<=0 then
        begin
          //curcolumn :=dbgrdhResult.Columns[45].Title;
          //curcolumn.Caption := '线路总公里';
          dbgrdhResult.Columns[46].Visible :=False;
          dbgrdhResult.Columns[47].Visible :=False;
          dbgrdhResult.Columns[48].Visible :=False;
          dbgrdhResult.Columns[49].Visible :=False;
        end ;
        if Pos('141',compareObjectid)<=0 then
       begin
          //curcolumn :=dbgrdhResult.Columns[49].Title;
          //curcolumn.Caption := '周转量';
          dbgrdhResult.Columns[50].Visible :=False;
          dbgrdhResult.Columns[51].Visible :=False;
          dbgrdhResult.Columns[52].Visible :=False;
          dbgrdhResult.Columns[53].Visible :=False;
        end
      end
      else
      begin
        // curcolumn :=dbgrdhResult.Columns[53].Title;
        // curcolumn.Caption := '实载率|本期';
         dbgrdhResult.Columns[54].Visible :=True;
         dbgrdhResult.Columns[55].Visible :=True;
         dbgrdhResult.Columns[56].Visible :=True;
         dbgrdhResult.Columns[57].Visible :=True;
         // curcolumn :=dbgrdhResult.Columns[45].Title;
        // curcolumn.Caption := '线路总公里|本期';
         dbgrdhResult.Columns[46].Visible :=True;
         dbgrdhResult.Columns[47].Visible :=True;
         dbgrdhResult.Columns[48].Visible :=True;
         dbgrdhResult.Columns[49].Visible :=True;
         //curcolumn :=dbgrdhResult.Columns[49].Title;
         //curcolumn.Caption := '周转量|本期';
         dbgrdhResult.Columns[50].Visible :=True;
         dbgrdhResult.Columns[51].Visible :=True;
         dbgrdhResult.Columns[52].Visible :=True;
         dbgrdhResult.Columns[53].Visible :=True;

      end;

     if Pos('161',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[57].Title;
          //curcolumn.Caption := '座位利用率';
          dbgrdhResult.Columns[58].Visible :=False;
          dbgrdhResult.Columns[59].Visible :=False;
          dbgrdhResult.Columns[60].Visible :=False;
          dbgrdhResult.Columns[61].Visible :=False;
        if Pos('20',compareObjectid)<=0 then
          begin
            //curcolumn :=dbgrdhResult.Columns[5].Title;
            //curcolumn.Caption := '总座位数';
            dbgrdhResult.Columns[6].Visible :=False;
            dbgrdhResult.Columns[7].Visible :=False;
            dbgrdhResult.Columns[8].Visible :=False;
            dbgrdhResult.Columns[9].Visible :=False;
          end;
          if Pos('30',compareObjectid)<=0 then
          begin
            //curcolumn :=dbgrdhResult.Columns[9].Title;
            //curcolumn.Caption := '人数';
            dbgrdhResult.Columns[10].Visible :=False;
            dbgrdhResult.Columns[11].Visible :=False;
            dbgrdhResult.Columns[12].Visible :=False;
            dbgrdhResult.Columns[13].Visible :=False;
          end;
      end
      else
      begin
         //curcolumn :=dbgrdhResult.Columns[57].Title;
         //curcolumn.Caption := '座位利用率|本期';
         dbgrdhResult.Columns[58].Visible :=True;
         dbgrdhResult.Columns[59].Visible :=True;
         dbgrdhResult.Columns[60].Visible :=True;
         dbgrdhResult.Columns[61].Visible :=True;
         //curcolumn :=dbgrdhResult.Columns[5].Title;
         //curcolumn.Caption := '总座位数|本期';
         dbgrdhResult.Columns[6].Visible :=True;
         dbgrdhResult.Columns[7].Visible :=True;
         dbgrdhResult.Columns[8].Visible :=True;
         dbgrdhResult.Columns[9].Visible :=True;
         //curcolumn :=dbgrdhResult.Columns[9].Title;
         //curcolumn.Caption := '人数|本期';
         dbgrdhResult.Columns[10].Visible :=True;
         dbgrdhResult.Columns[11].Visible :=True;
         dbgrdhResult.Columns[12].Visible :=True;
         dbgrdhResult.Columns[13].Visible :=True;
      end;

     if Pos('171',compareObjectid)<=0 then
      begin
          //curcolumn :=dbgrdhResult.Columns[61].Title;
         // curcolumn.Caption := '营收比重';
          dbgrdhResult.Columns[62].Visible :=False;
          dbgrdhResult.Columns[63].Visible :=False;
          dbgrdhResult.Columns[64].Visible :=False;
          dbgrdhResult.Columns[65].Visible :=False;
      end
      else
      begin
        // curcolumn :=dbgrdhResult.Columns[61].Title;
         //curcolumn.Caption := '营收比重|本期';
         dbgrdhResult.Columns[62].Visible :=True;
         dbgrdhResult.Columns[63].Visible :=True;
         dbgrdhResult.Columns[64].Visible :=True;
         dbgrdhResult.Columns[65].Visible :=True;
      end;

      if (not( chkBydate.Checked )) or (chkByroute.Checked)then
      begin
          //curcolumn :=dbgrdhResult.Columns[61].Title;
         // curcolumn.Caption := '营收比重';
          dbgrdhResult.Columns[66].Visible :=False;
          dbgrdhResult.Columns[67].Visible :=False;
          dbgrdhResult.Columns[68].Visible :=False;
          dbgrdhResult.Columns[69].Visible :=False;
      end
      else  if (chkBydate.Checked) and ( Pos('181',compareObjectid)>1 ) then
      begin
        // curcolumn :=dbgrdhResult.Columns[61].Title;
         //curcolumn.Caption := '营收比重|本期';
         dbgrdhResult.Columns[66].Visible :=True;
         dbgrdhResult.Columns[67].Visible :=True;
         dbgrdhResult.Columns[68].Visible :=True;
         dbgrdhResult.Columns[69].Visible :=True;
      end;
  end;
end;

end.
