@repeat{SELECT count(*) FROM Digitaldictionary where id = 6111}
insert into Digitaldictionary (ID, NAME, DESCRIBE, TABLENAME, COLUMNNAME, ISCANEDIT, UPDATETIME, UPDATEBY, ISCANADD)
values (6111, '顾客表民族', '01:汉，02:蒙古，03:回........', 'customer', 'nation', 0,sysdate, 0, 0 );
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='01' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,1, '01', '汉'       ,'',sysdate,0,sysdate,0);    
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='02' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,2, '02', '蒙古'      ,'',sysdate,0,sysdate,0); 
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='03' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,3, '03', '回'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='04' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,4, '04', '藏'        ,'',sysdate,0,sysdate,0);    
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='05' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,5, '05', '维吾尔'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='06' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,6, '06', '苗'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='07' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,7, '07', '彝'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='08' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,8, '08', '壮'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='09' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,9, '09', '布依'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='10' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,10,'10', '朝鲜'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='11' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,11,'11', '满'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='12' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,12,'12', '侗'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='13' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,13,'13', '瑶'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='14' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,14,'14', '白'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='15' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,15,'15', '土家'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='16' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,16,'16', '哈尼'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='17' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,17,'17', '哈萨克'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='18' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,18,'18', '傣'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='19' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,19,'19', '黎'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='20' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,20,'20', '傈僳'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='21' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,21,'21', '佤'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='22' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,22,'22', '畲'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='23' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,23,'23', '高山'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='24' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,24,'24', '拉祜'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='25' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,25,'25', '水'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='26' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,26,'26', '东乡'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='27' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,27,'27', '纳西'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='28' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,28,'28', '景颇'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='29' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,29,'29', '柯尔克孜'  ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='30' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,30,'30', '土'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='21' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,31,'31', '达斡尔'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='32' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,32,'32', '仫佬'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='33' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,33,'33', '羌'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='34' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,34,'34', '布朗'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='35' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,35,'35', '撒拉'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='36' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,36,'36', '毛难'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='37' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,37,'37', '仡佬'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='38' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,38,'38', '锡伯'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='39' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,39,'39', '阿昌'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='40' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,40,'40', '普米'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='41' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,41,'41', '塔吉克'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='42' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,42,'42', '怒'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='43' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,43,'43', '乌孜别克'  ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='44' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,44,'44', '俄罗斯'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='45' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,45,'45', '鄂温克'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='46' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,46,'46', '崩龙'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='47' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,47,'47', '保安'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='48' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,48,'48', '裕固'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='49' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,49,'49', '京'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='50' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,50,'50', '塔塔尔'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='51' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,51,'51', '独龙'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='52' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,52,'52', '鄂伦春'    ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='53' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,53,'53', '赫哲'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='54' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,54,'54', '门巴'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='55' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,55,'55', '珞巴'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='56' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,56,'56', '基诺'      ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='97' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,57,'97', '其他'        ,'',sysdate,0,sysdate,0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail t where t.code='98' and t.digitaldictionaryid=6111 }
INSERT INTO Digitaldictionarydetail VALUES (SEQ_PUB.Nextval,6111,58,'98', '外国血统'    ,'',sysdate,0,sysdate,0);