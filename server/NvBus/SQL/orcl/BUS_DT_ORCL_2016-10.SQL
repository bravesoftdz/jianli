--begin addby daijiy 2016-9-23  增加营运车辆违规结算违规结算类型参数
@repeat{SELECT count(*) FROM parameter where id = 206 or code='4008'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)     
values (206, '40', '4008', '0', 1, 1, '营运车辆违规结算违规结算类型:0、罚金，1、暂扣款', sysdate, 0, '是否');
--end

--begin zhaohh 2016-09-29 票据类型的保险单改成保险票
@repeat{SELECT count(*) - 1 FROM billtype t where upper(t.code) = upper('Insure')}
update billtype t set t.name = '保险票', t.printname = '保险票' where upper(t.code) = upper('Insure');
--end zhaohh 2016-09-29

--begin yaolu 2016-10-11 参数设置的4068参数，没有说明参数设置为0时的备注
@repeat{SELECT count(*)-1 FROM parameter t where t.code = '4068'}
update parameter t set t.remark = '应结金额进位规则：0按实际计算结果，1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点' where t.code = '4068';
--end yaolu 2016-10-11

--begin addby daijiy  增加日报表运行job
@repeat{SELECT count(*) FROM jobconfig where id = 200}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (200, 1158012, 'AutoGenticketsellbysalerdayJob', 'cn.nova.bus.job.AutoGenticketsellbysalerdayJob', 'null', 3, 1, '06:00', '22:00', sysdate, '自动生成日报表数据', 1, sysdate, 1158013, sysdate, 1158013, 1);
--end
--begin addby jiangyr 2016年10月14日15:14:17 增加参数1075
@repeat{SELECT count(*) FROM parameter where id = 1075 or code='1075'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1075, '10', '1075', '1', 1, 1, '是否启用购物车功能，0不启用，1启用，默认为1', sysdate, 0, '是否');
--end
--BEGIN JYR 2016年10月17日12:45:17 增加参数和业务异常提醒
@repeat{SELECT count(*) FROM exceptioninfo where id = 1568 or code='1568'}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (1568, '1568', '该帐号不属于该机构不允许登录!', '系统登录');
@repeat{SELECT count(*) FROM parameter where id = 12512 or code='0029'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (12512, '00', '0029', '1', 1, 1, '集中式数据库A站用户是否可以在B站下的售票点登录,参数值为0则不允许登录，参数值为1则允许登录,默认为 1', sysdate, 0, '是否');
--end

--begin addby daijiy  增加参数1082是否输出保险文本
@repeat{SELECT count(*) FROM parameter where id = 1082 or code='1082'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (1082, '10', '1082', '1', 1, 0, '是否输出保险文本，0不输出，1输出，默认为1', sysdate, 0, '是否');
--end
--begin  jyr 2016年10月17日18:21:28 修改参数6021 备注
@repeat{SELECT count(*)-1 FROM parameter t where t.code = '6021'}
update parameter p set p.remark = '安检合格通知单打印模板，0安检合格通知单模板，1包含安检项目明细及三联单确认的固定模板，2包含安检项目明细的固定模板，默认为0; 国标插件仅支持1,2; 普通安检仅支持0' where p.code = '6021';
--end
--begin zhaomingliang 2016年10月20日  添加结算单打印模版数据集
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 1166588}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values ('1166588', '4', '除半票外票数', '0', 'fullpeoples', '1');
--end
--begin sunyue 2016年10月25日 15:15:24 添加停靠点数据字典
@repeat{SELECT count(*) FROM digitaldictionarydetail where id = 16101901}
insert into digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (16101901, 23, 3, '3', '停靠点', null, sysdate, 0, sysdate, 0);
--end--
--begin zhaomingliang 2016年10月25日 添加出站检查登记表参数
@repeat{SELECT count(*) FROM parameter where id = 2043 or code='2043'}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values ('2043', '30', '2043', '0', '1', '1', '出站检查时，出站驾驶员跟报到驾驶员不一致是否允许出站，0不允许，1允许，默认为0',sysdate, '1158013', '是否');
@repeat{SELECT count(*) FROM parameter where id = 2044 or code='2044'}
insert into PARAMETER (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values ('2044', '30', '2044', '0', '1', '1', '出站检查时，出站乘务员跟报到乘务员不一致是否允许出站，0不允许，1允许，默认为0', sysdate, '1158013', '是否');
--end

--begin  daijy 2016年10月27日15:21:28 修改参数4015 备注
@repeat{SELECT count(*)-1 FROM parameter t where t.code = '4015'}
update parameter p set p.remark = '打印结算单时，0相同发车站相同到站相同票价分组打印，1相同发车站相同到站相同票价相同票种分组打印，2相同到站相同票价分组打印，3相同到站相同票价相同票种分组打印，4相同到站分组打印，默认为0' where p.code = '4015';
--end
--begin  孙越  2016年10月27日 19:23:00 添加参数  --
@repeat{SELECT count(*) FROM parameter where id = 16102701 or code='3047'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (16102701, '30', '3047', '3', 1, 1, '综合检票界面实名制检票成功后弹出的乘车人信息框显示时间,默认为3',sysdate, 0, '秒');

@repeat{SELECT count(*) FROM parameter where id = 16102702 or code='3046'}
insert into parameter (ID, TYPE, CODE, VALUE, ISVISIBLE, ISEDITABLE, REMARK, UPDATETIME, UPDATEBY, UNIT)
values (16102702, '30', '3046', '0', 1, 1, '综合检票界面实名制检票成功后是否弹出乘车人信息框，0不弹出，1弹出，默认为0',sysdate, 0, '是否');
--end--
--begin zhaomingliang 2016年10月27日  添加结算单打印模版数据集
@repeat{SELECT count(*) FROM printtemplatetypeitem where id = 1166765}
insert into printtemplatetypeitem (ID, PRINTTEMPLATETYPEID, ITEMNAME, ITEMTYPE, ITEMCODE, ISLIST)
values ('1166765', '4', '除半票外总人数', '0', 'otherticketnum', '0');
--end
--begin 2016-11-01 张清风 黑名单购票给予提示 --
@repeat{select count(*) from exceptioninfo where code = '6221'}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (6221, '6221', '黑名单用户不能购票！', '售票');
--end 2016-11-01 张清风 黑名单购票给予提示 --
--begin 2016-11-02 张清风 两种票价报班 --
@repeat{SELECT count(*) FROM exceptioninfo where id = 6118}
insert into exceptioninfo (ID, CODE, MSG, MODULES)
values (6118, '6118', '报到车辆相同座位类型小于已售座位类型，不允许报到', '车辆报到');
--end 2016-11-02 张清风 两种票价报班 --
--begin  增加自动报班JOB
@repeat{select count(*) from jobconfig where id = '5646'}
insert into jobconfig (ID, ORGID, JOBNAME, FULLCLASSNAME, PARAMETERS, INTERVALTYPE, INTERVALS, STARTTIME, ENDTIME, LASTRUNTIME, REMARKS, ISACTIVE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY, TYPE)
values (5646, 1158012, 'AutoReportJob', 'cn.nova.bus.job.AutoReportJob', 'null', 3, 2, '00:00', '05:00',sysdate, '自动报班', 0, sysdate, 0,sysdate, 0, 1);
--end

--begin addby liuyan 2016-10-09  售票增加F1功能权限 改签手续费修改权限 补票手续费修改权限
@repeat{SELECT count(*) FROM FUNCTIONPERMISSIONREG where id = 1239933 }
INSERT INTO FUNCTIONPERMISSIONREG (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY) VALUES ('1239933', '6', 'F1功能', '{FBB5706F-2103-47F0-877C-F5D180E96A41}', NULL, TO_DATE('2016-09-27 16:26:26', 'SYYYY-MM-DD HH24:MI:SS'), '0', TO_DATE('2016-09-27 16:26:32', 'SYYYY-MM-DD HH24:MI:SS'), '0');

@repeat{SELECT count(*) FROM FUNCTIONPERMISSIONREG where id = 1239934 }
INSERT INTO FUNCTIONPERMISSIONREG (ID, FUNCTIONREGID, PERMISSIONNAME, PERMISSIONKEY, PERMISSIONDESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY) VALUES ('1239934', '6', '服务费', '{BF4C858F-3AC0-4D2B-B7AC-0EA93281A901}', ' 服务费修改权限', TO_DATE('2016-10-08 15:17:46', 'SYYYY-MM-DD HH24:MI:SS'), '0', TO_DATE('2016-10-08 15:17:57', 'SYYYY-MM-DD HH24:MI:SS'), '0');


@repeat{SELECT count(*)-1 FROM parameter where code='4008' }
update parameter t set t.isvisible=1 where t.code='4008';

@repeat{SELECT count(*) FROM menupermission where functionpermissionregid=1239933}
insert into menupermission
  select SEQ_PUB.Nextval, r.id, 1, m.menuid, t.id, sysdate, 0, sysdate, 0
    from functionpermissionreg t, role r, menupermission m
   where t.id in (1239933, 1239934)
     and r.id = m.roleid
     and m.menuid = 41
     and r.id not in
         (select tt.roleid
            from menupermission tt
           where tt.functionpermissionregid in (1239933, 1239934));

--end
