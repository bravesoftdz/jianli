@repeat{SELECT COUNT(*) FROM USER_TAB_COLUMNS WHERE TABLE_NAME = upper('PRINTTEMPLATE') AND COLUMN_NAME = upper('autopages')}
alter table PRINTTEMPLATE add autopages NUMBER(1) default 0;