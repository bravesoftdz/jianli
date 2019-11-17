--begin  addby yaolu  2016-7-14
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 0}
delete from digitaldictionarydetail where digitaldictionaryid=35;

@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 950}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (950, 35, 0, '0', '居民身份证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 951}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (951, 35, 1, '1', '手机号', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 952}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (952, 35, 2, '2', '户口簿', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 953}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (953, 35, 3, '3', '机动车驾驶证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 954}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (954, 35, 4, '4', '军官证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 955}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (955, 35, 5, '5', '武警警官证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 956}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (956, 35, 6, '6', '士兵证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 957}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (957, 35, 7, '7', '军队学员证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 958}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (958, 35, 8, '8', '文职干部证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 959}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (959, 35, 9, '9', '离退休干部证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 960}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (960, 35, 10, '10', '军队职工证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 961}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (961, 35, 11, '11', '退伍证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 962}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (962, 35, 12, '12', '护照', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 963}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (963, 35, 13, '13', '港澳通行证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 964}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (964, 35, 14, '14', '台湾通行证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 965}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (965, 35, 15, '15', '外国人居留证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 966}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (966, 35, 16, '16', '外国人出入境证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 967}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (967, 35, 17, '17', '外交官证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 968}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (968, 35, 18, '18', '领事馆证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 969}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (969, 35, 19, '19', '海员证', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 970}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (970, 35, 20, '20', '外国人身份证明', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 971}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (971, 35, 21, '21', '护照报关证明', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 972}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (972, 35, 22, '22', '乘车临时身份证明', '', sysdate, 0, sysdate, 0);
@repeat{SELECT count(*) FROM Digitaldictionarydetail where id = 973}
insert into Digitaldictionarydetail (ID, DIGITALDICTIONARYID, ORDERNO, CODE, VALUE, DESCRIBE, CREATETIME, CREATEBY, UPDATETIME, UPDATEBY)
values (973, 35, 23, '23', '学生证', '', sysdate, 0, sysdate, 0);