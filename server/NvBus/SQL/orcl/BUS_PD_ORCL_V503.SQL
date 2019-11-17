--beginblock
CREATE OR REPLACE FUNCTION F_TRANS_PINYIN_CAPITAL(P_NAME IN VARCHAR2) RETURN VARCHAR2 AS
V_COMPARE VARCHAR2(100);
V_RETURN VARCHAR2(4000);
 
FUNCTION F_NLSSORT(P_WORD IN VARCHAR2) RETURN VARCHAR2 AS
BEGIN
RETURN NLSSORT(P_WORD, 'NLS_SORT=SCHINESE_PINYIN_M');
END;
BEGIN  
FOR I IN 1..LENGTH(P_NAME) LOOP
V_COMPARE := F_NLSSORT(SUBSTR(P_NAME, I, 1));
IF V_COMPARE >= F_NLSSORT('吖 ') AND V_COMPARE <= F_NLSSORT('驁 ') THEN
V_RETURN := V_RETURN || 'A';
ELSIF V_COMPARE >= F_NLSSORT('八 ') AND V_COMPARE <= F_NLSSORT('簿 ') THEN
V_RETURN := V_RETURN || 'B';
ELSIF V_COMPARE >= F_NLSSORT('嚓 ') AND V_COMPARE <= F_NLSSORT('錯 ') THEN
V_RETURN := V_RETURN || 'C';
ELSIF V_COMPARE >= F_NLSSORT('咑 ') AND V_COMPARE <= F_NLSSORT('鵽 ') THEN
V_RETURN := V_RETURN || 'D';
ELSIF V_COMPARE >= F_NLSSORT('妸 ') AND V_COMPARE <= F_NLSSORT('樲 ') THEN
V_RETURN := V_RETURN || 'E';
ELSIF V_COMPARE >= F_NLSSORT('发 ') AND V_COMPARE <= F_NLSSORT('猤 ') THEN
V_RETURN := V_RETURN || 'F';
ELSIF V_COMPARE >= F_NLSSORT('旮 ') AND V_COMPARE <= F_NLSSORT('腂 ') THEN
V_RETURN := V_RETURN || 'G';
ELSIF V_COMPARE >= F_NLSSORT('妎 ') AND V_COMPARE <= F_NLSSORT('夻 ') THEN
V_RETURN := V_RETURN || 'H';
ELSIF V_COMPARE >= F_NLSSORT('丌 ') AND V_COMPARE <= F_NLSSORT('攈 ') THEN
V_RETURN := V_RETURN || 'J';
ELSIF V_COMPARE >= F_NLSSORT('咔 ') AND V_COMPARE <= F_NLSSORT('穒 ') THEN
V_RETURN := V_RETURN || 'K';
ELSIF V_COMPARE >= F_NLSSORT('垃 ') AND V_COMPARE <= F_NLSSORT('擽 ') THEN
V_RETURN := V_RETURN || 'L';
ELSIF V_COMPARE >= F_NLSSORT('嘸 ') AND V_COMPARE <= F_NLSSORT('椧 ') THEN
V_RETURN := V_RETURN || 'M';
ELSIF V_COMPARE >= F_NLSSORT('拏 ') AND V_COMPARE <= F_NLSSORT('瘧 ') THEN
V_RETURN := V_RETURN || 'N';
ELSIF V_COMPARE >= F_NLSSORT('筽 ') AND V_COMPARE <= F_NLSSORT('漚 ') THEN
V_RETURN := V_RETURN || 'O';
ELSIF V_COMPARE >= F_NLSSORT('妑 ') AND V_COMPARE <= F_NLSSORT('曝 ') THEN
V_RETURN := V_RETURN || 'P';
ELSIF V_COMPARE >= F_NLSSORT('七 ') AND V_COMPARE <= F_NLSSORT('裠 ') THEN
V_RETURN := V_RETURN || 'Q';
ELSIF V_COMPARE >= F_NLSSORT('亽 ') AND V_COMPARE <= F_NLSSORT('鶸 ') THEN
V_RETURN := V_RETURN || 'R';
ELSIF V_COMPARE >= F_NLSSORT('仨 ') AND V_COMPARE <= F_NLSSORT('蜶 ') THEN
V_RETURN := V_RETURN || 'S';
ELSIF V_COMPARE >= F_NLSSORT('侤 ') AND V_COMPARE <= F_NLSSORT('籜 ') THEN
V_RETURN := V_RETURN || 'T';
ELSIF V_COMPARE >= F_NLSSORT('屲 ') AND V_COMPARE <= F_NLSSORT('鶩 ') THEN
V_RETURN := V_RETURN || 'W';
ELSIF V_COMPARE >= F_NLSSORT('夕 ') AND V_COMPARE <= F_NLSSORT('鑂 ') THEN
V_RETURN := V_RETURN || 'X';
ELSIF V_COMPARE >= F_NLSSORT('丫 ') AND V_COMPARE <= F_NLSSORT('韻 ') THEN
V_RETURN := V_RETURN || 'Y';
ELSIF V_COMPARE >= F_NLSSORT('帀 ') AND V_COMPARE <= F_NLSSORT('咗 ') THEN
V_RETURN := V_RETURN || 'Z';
END IF;
END LOOP;
RETURN V_RETURN;
END;
;
--endblock
--beginblock
declare
  cursor c_steward is
    select name from steward;
  c_row     c_steward%rowtype;
  v_steward steward.jianpin%TYPE;
begin
  for c_row in c_steward loop
    select F_TRANS_PINYIN_CAPITAL(c_row.name) into v_steward from dual;
    update steward set jianpin = v_steward where name = c_row.name;
  end loop;
end;
;
--endblock
--beginblock
declare
  cursor c_driver is
    select name from driver;
  c_row     c_driver%rowtype;
  v_driver driver.jianpin%TYPE;
begin
  for c_row in c_driver loop
    select F_TRANS_PINYIN_CAPITAL(c_row.name) into v_driver from dual;
    update driver set jianpin = v_driver where name = c_row.name;
  end loop;
end;
;
--endblock

