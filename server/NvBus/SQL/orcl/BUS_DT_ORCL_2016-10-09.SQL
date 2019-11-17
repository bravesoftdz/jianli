
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