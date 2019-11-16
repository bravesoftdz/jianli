Unit DateCn;

Interface

Uses Windows, SysUtils, Controls;

Const
  //ũ���·����ݣ�ÿ��4�ֽڣ���1901�꿪ʼ����150��
  //������Դ��UCDOS 6.0 UCT.COM
  //��������Copyright (c) 1996-1998, Randolph
  //���ݽ�����
  //�����һ�ֽڵ�bit7Ϊ1�������1��1��λ��ũ��12�£�����λ��11��
  //��һ�ֽ�ȥ��bit7Ϊ����1��1�յ�ũ������
  //         �ڶ��ֽ�                 �����ֽ�
  //bit:     7  6  5  4  3  2  1  0   7  6  5  4  3  2  1  0
  //ũ���·�:16 15 14 13 12 11 10 9   8  7  6  5  4  3  2  1
  //ũ���·�ָ���ǴӸ���1��1�յ�ũ���·������˳���
  //ũ���·ݶ�Ӧ��bitΪ1�����Ϊ30�գ�����Ϊ29��
  //�����ֽ�Ϊ�����·�
//  BaseDate='2000/02/04';//2000����
  BaseAnimalDate = '1972'; //1972��֧Ϊ��(������)
  BaseSkyStemDate = '1974'; //1974���Ϊ��
  START_YEAR = 1901;
  END_YEAR = 2050;

  gLunarHolDay: Array[0..1799] Of Byte = (
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1901
    $96, $A4, $96, $96, $97, $87, $79, $79, $79, $69, $78, $78, //1902
    $96, $A5, $87, $96, $87, $87, $79, $69, $69, $69, $78, $78, //1903
    $86, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $78, $87, //1904
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1905
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78, //1906
    $96, $A5, $87, $96, $87, $87, $79, $69, $69, $69, $78, $78, //1907
    $86, $A5, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1908
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1909
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78, //1910
    $96, $A5, $87, $96, $87, $87, $79, $69, $69, $69, $78, $78, //1911
    $86, $A5, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1912
    $95, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1913
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $78, //1914
    $96, $A5, $97, $96, $97, $87, $79, $79, $69, $69, $78, $78, //1915
    $96, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1916
    $95, $B4, $96, $A6, $96, $97, $78, $79, $78, $69, $78, $87, //1917
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $77, //1918
    $96, $A5, $97, $96, $97, $87, $79, $79, $69, $69, $78, $78, //1919
    $96, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1920
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $87, //1921
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $77, //1922
    $96, $A4, $96, $96, $97, $87, $79, $79, $69, $69, $78, $78, //1923
    $96, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1924
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $87, //1925
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1926
    $96, $A4, $96, $96, $97, $87, $79, $79, $79, $69, $78, $78, //1927
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1928
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1929
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1930
    $96, $A4, $96, $96, $97, $87, $79, $79, $79, $69, $78, $78, //1931
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1932
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1933
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1934
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78, //1935
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1936
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1937
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1938
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78, //1939
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1940
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1941
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1942
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78, //1943
    $96, $A5, $96, $A5, $A6, $96, $88, $78, $78, $78, $87, $87, //1944
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1945
    $95, $B4, $96, $A6, $97, $97, $78, $79, $78, $69, $78, $77, //1946
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $78, //1947
    $96, $A5, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //1948
    $A5, $B4, $96, $A5, $96, $97, $88, $79, $78, $79, $77, $87, //1949
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $77, //1950
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $78, //1951
    $96, $A5, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //1952
    $A5, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1953
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $68, $78, $87, //1954
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1955
    $96, $A5, $A5, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //1956
    $A5, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1957
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1958
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1959
    $96, $A4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87, //1960
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1961
    $96, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1962
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1963
    $96, $A4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87, //1964
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1965
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1966
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1967
    $96, $A4, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //1968
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1969
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1970
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77, //1971
    $96, $A4, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //1972
    $A5, $B5, $96, $A5, $A6, $96, $88, $78, $78, $78, $87, $87, //1973
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1974
    $96, $B4, $96, $A6, $97, $97, $78, $79, $78, $69, $78, $77, //1975
    $96, $A4, $A5, $B5, $A6, $A6, $88, $89, $88, $78, $87, $87, //1976
    $A5, $B4, $96, $A5, $96, $96, $88, $88, $78, $78, $87, $87, //1977
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $78, $87, //1978
    $96, $B4, $96, $A6, $96, $97, $78, $79, $78, $69, $78, $77, //1979
    $96, $A4, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $87, //1980
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $77, $87, //1981
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1982
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $77, //1983
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87, //1984
    $A5, $B4, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //1985
    $A5, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //1986
    $95, $B4, $96, $A5, $96, $97, $88, $79, $78, $69, $78, $87, //1987
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //1988
    $A5, $B4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87, //1989
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $79, $77, $87, //1990
    $95, $B4, $96, $A5, $86, $97, $88, $78, $78, $69, $78, $87, //1991
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //1992
    $A5, $B3, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87, //1993
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1994
    $95, $B4, $96, $A5, $96, $97, $88, $76, $78, $69, $78, $87, //1995
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //1996
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //1997
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //1998
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //1999
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //2000
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2001
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //2002
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //2003
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //2004
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2005
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2006
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87, //2007
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $87, $78, $87, $86, //2008
    $A5, $B3, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2009
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2010
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $78, $87, //2011
    $96, $B4, $A5, $B5, $A5, $A6, $87, $88, $87, $78, $87, $86, //2012
    $A5, $B3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87, //2013
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2014
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87, //2015
    $95, $B4, $A5, $B4, $A5, $A6, $87, $88, $87, $78, $87, $86, //2016
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87, //2017
    $A5, $B4, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2018
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $79, $77, $87, //2019
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $86, //2020
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //2021
    $A5, $B4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87, //2022
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $79, $77, $87, //2023
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96, //2024
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //2025
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2026
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //2027
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96, //2028
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //2029
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2030
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, //2031
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96, //2032
    $A5, $C3, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $86, //2033
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $78, $88, $78, $87, $87, //2034
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2035
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96, //2036
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86, //2037
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2038
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2039
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96, //2040
    $A5, $C3, $A5, $B5, $A5, $A6, $87, $88, $87, $78, $87, $86, //2041
    $A5, $B3, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $87, //2042
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2043
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $88, $87, $96, //2044
    $A5, $C3, $A5, $B4, $A5, $A6, $87, $88, $87, $78, $87, $86, //2045
    $A5, $B3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87, //2046
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87, //2047
    $95, $B4, $A5, $B4, $A5, $A5, $97, $87, $87, $88, $86, $96, //2048
    $A4, $C3, $A5, $A5, $A5, $A6, $97, $87, $87, $78, $87, $86, //2049
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $78, $78, $87, $87); //2050


  CnData: Array[0..599] Of Byte = (
    $0B, $52, $BA, $00, $16, $A9, $5D, $00, $83, $A9, $37, $05, $0E, $74, $9B,
    $00,
    $1A, $B6, $55, $00, $87, $B5, $55, $04, $11, $55, $AA, $00, $1C, $A6, $B5,
    $00,
    $8A, $A5, $75, $02, $14, $52, $BA, $00, $81, $52, $6E, $06, $0D, $E9, $37,
    $00,
    $18, $74, $97, $00, $86, $EA, $96, $05, $10, $6D, $55, $00, $1A, $35, $AA,
    $00,
    $88, $4B, $6A, $02, $13, $A5, $6D, $00, $1E, $D2, $6E, $07, $0B, $D2, $5E,
    $00,
    $17, $E9, $2E, $00, $84, $D9, $2D, $05, $0F, $DA, $95, $00, $19, $5B, $52,
    $00,
    $87, $56, $D4, $04, $11, $4A, $DA, $00, $1C, $A5, $5D, $00, $89, $A4, $BD,
    $02,
    $15, $D2, $5D, $00, $82, $B2, $5B, $06, $0D, $B5, $2B, $00, $18, $BA, $95,
    $00,
    $86, $B6, $A5, $05, $10, $56, $B4, $00, $1A, $4A, $DA, $00, $87, $49, $BA,
    $03,
    $13, $A4, $BB, $00, $1E, $B2, $5B, $07, $0B, $72, $57, $00, $16, $75, $2B,
    $00,
    $84, $6D, $2A, $06, $0F, $AD, $55, $00, $19, $55, $AA, $00, $86, $55, $6C,
    $04,
    $12, $C9, $76, $00, $1C, $64, $B7, $00, $8A, $E4, $AE, $02, $15, $EA, $56,
    $00,
    $83, $DA, $55, $07, $0D, $5B, $2A, $00, $18, $AD, $55, $00, $85, $AA, $D5,
    $05,
    $10, $53, $6A, $00, $1B, $A9, $6D, $00, $88, $A9, $5D, $03, $13, $D4, $AE,
    $00,
    $81, $D4, $AB, $08, $0C, $BA, $55, $00, $16, $5A, $AA, $00, $83, $56, $AA,
    $06,
    $0F, $AA, $D5, $00, $19, $52, $DA, $00, $86, $52, $BA, $04, $11, $A9, $5D,
    $00,
    $1D, $D4, $9B, $00, $8A, $74, $9B, $03, $15, $B6, $55, $00, $82, $AD, $55,
    $07,
    $0D, $55, $AA, $00, $18, $A5, $B5, $00, $85, $A5, $75, $05, $0F, $52, $B6,
    $00,
    $1B, $69, $37, $00, $89, $E9, $37, $04, $13, $74, $97, $00, $81, $EA, $96,
    $08,
    $0C, $6D, $52, $00, $16, $2D, $AA, $00, $83, $4B, $6A, $06, $0E, $A5, $6D,
    $00,
    $1A, $D2, $6E, $00, $87, $D2, $5E, $04, $12, $E9, $2E, $00, $1D, $EC, $96,
    $0A,
    $0B, $DA, $95, $00, $15, $5B, $52, $00, $82, $56, $D2, $06, $0C, $2A, $DA,
    $00,
    $18, $A4, $DD, $00, $85, $A4, $BD, $05, $10, $D2, $5D, $00, $1B, $D9, $2D,
    $00,
    $89, $B5, $2B, $03, $14, $BA, $95, $00, $81, $B5, $95, $08, $0B, $56, $B2,
    $00,
    $16, $2A, $DA, $00, $83, $49, $B6, $05, $0E, $64, $BB, $00, $19, $B2, $5B,
    $00,
    $87, $6A, $57, $04, $12, $75, $2B, $00, $1D, $B6, $95, $00, $8A, $AD, $55,
    $02,
    $15, $55, $AA, $00, $82, $55, $6C, $07, $0D, $C9, $76, $00, $17, $64, $B7,
    $00,
    $86, $E4, $AE, $05, $11, $EA, $56, $00, $1B, $6D, $2A, $00, $88, $5A, $AA,
    $04,
    $14, $AD, $55, $00, $81, $AA, $D5, $09, $0B, $52, $EA, $00, $16, $A9, $6D,
    $00,
    $84, $A9, $5D, $06, $0F, $D4, $AE, $00, $1A, $EA, $4D, $00, $87, $BA, $55,
    $04,
    $12, $5A, $AA, $00, $1D, $AB, $55, $00, $8A, $A6, $D5, $02, $14, $52, $DA,
    $00,
    $82, $52, $BA, $06, $0D, $A9, $3B, $00, $18, $B4, $9B, $00, $85, $74, $9B,
    $05,
    $11, $B5, $4D, $00, $1C, $D6, $A9, $00, $88, $35, $AA, $03, $13, $A5, $B5,
    $00,
    $81, $A5, $75, $0B, $0B, $52, $B6, $00, $16, $69, $37, $00, $84, $E9, $2F,
    $06,
    $10, $F4, $97, $00, $1A, $75, $4B, $00, $87, $6D, $52, $05, $11, $2D, $69,
    $00,
    $1D, $95, $B5, $00, $8A, $A5, $6D, $02, $15, $D2, $6E, $00, $82, $D2, $5E,
    $07,
    $0E, $E9, $2E, $00, $19, $EA, $96, $00, $86, $DA, $95, $05, $10, $5B, $4A,
    $00,
    $1C, $AB, $69, $00, $88, $2A, $D8, $03);

Function DaysNumberOfDate(Date: TDate): Integer;
//�����Ǹ���ĵڼ��죬1��1��Ϊ��һ��
Function CnMonthOfDate(Date: TDate; Days: Integer): String; OverLoad;
Function CnMonthOfDate(Date: TDate): String; OverLoad; //ָ�����ڵ�ũ����

Function CnMonth(Date: TDate): Integer; //ָ�����ڵ�ũ����
Function CnDay(Date: TDate): Integer; //ָ�����ڵ�ũ���հ�������
Function CnDayOfDate(Date: TDate): String; overload; //ָ�����ڵ�ũ���հ�������
Function CnDayOfDate(Year,Month,Day: integer): String; overload; //ָ�����ڵ�ũ���հ�������

Function CnDayOfDate(Date: TDate; Days: integer; ShowDate: Boolean = false): String; overload; //ָ�����ڵ�ũ���հ�������

Function CnDateOfDateStr(Date: TDate): String; //ָ�����ڵ�ũ������
Function CnDayOfDatePH(Date: TDate): String; //ָ�����ڵ�ũ����
Function CnDateOfDateStrPH(Date: TDate): String; //ָ�����ڵ�ũ�����ڰ�������

Function CnDayOfDateJr(Date: TDate): String; overload; //ֻ�н���
Function CnDayOfDateJr(Date: TDate; Days: Integer): String; overload; //ֻ�н���

Function CnanimalOfYear(Date: TDate): String; //����ʮ����Ф(��֧)
Function CnSkyStemOfYear(Date: TDate): String; //����ʮ�����
Function CnSolarTerm(Date: TDate): String; //����ʮ�����

Function GetLunarHolDay(InDate: TDateTime): String; overload;
Function GetLunarHolDay(InDate: TDateTime; Days: Integer): String; overload;

Function l_GetLunarHolDay(iYear, iMonth, iDay: Word): Word;
Function GetAnimal(Date: TDate): integer; //����ʮ����Ф

Function GetCnDateToDate(dDate: TDateTime): TDateTime; overload;
Function GetCnDateToDate(cYear, cMonth, cDay: word): TDateTime; overload;

Function OtherHoliday(Month, Day: integer): String;
Function Holiday(Date: TDateTime; Day: integer): String;
Function GetDays(ADate: TDate): Extended;

Function Constellation(Date: TDateTime; Day: integer): String; overload;
Function Constellation(ADate: TDate): String; overload;
//procedure l_CalcLunarDate(var iYear,iMonth,iDay:Word;iSpanDays:Longword);
//function CalcDateDiff(iEndYear,iEndMonth,iEndDay:Word;iStartYear:Word;iStartMonth:Word;iStartDay:Word):Longword;

Implementation

Function Year(MyDate: TDateTime): Word;
Begin
  result := StrToInt(FormatDateTime('yyyy', MyDate)); //SetDates(MyDate, 1);
End;

Function Month(MyDate: TDateTime): Word;
Begin
  result := StrToInt(FormatDateTime('mm', MyDate)); //SetDates(MyDate, 2);
End;

Function day(MyDate: TDateTime): Word;
Begin
  result := StrToInt(FormatDateTime('dd', MyDate)); //SetDates(MyDate, 3);
End;


//�����Ǹ���ĵڼ��죬1��1��Ϊ��һ��

Function DaysNumberOfDate(Date: TDate): Integer;
Var
  DaysNumber: Integer;
  I: Integer;
  yyyy, mm, dd: Word;
Begin
  //  Date := StrToDate(FormatDateTime('yyyy/mm/dd', Date));
  DecodeDate(Date, yyyy, mm, dd);
  DaysNumber := 0;
  For I := 1 To mm - 1 Do
    Inc(DaysNumber, MonthDays[IsLeapYear(yyyy), I]);
  Inc(DaysNumber, dd);
  Result := DaysNumber;
End;

//���ڵ�ũ�����ڣ�����ũ����ʽ���·�*100 + �գ�����Ϊ����
//������Χ�򷵻�0

Function GetAnimal(Date: TDate): integer; //����ʮ����Ф
Var
  Animal: String;
Begin
  Animal := CnanimalOfYear(Date);
  If Animal = '����' Then
    result := 0;

  If Animal = '��ţ' Then
    result := 1;

  If Animal = '����' Then
    result := 2;

  If Animal = 'î��' Then
    result := 3;

  If Animal = '����' Then
    result := 4;

  If Animal = '����' Then
    result := 5;

  If Animal = '����' Then
    result := 6;

  If Animal = 'δ��' Then
    result := 7;

  If Animal = '���' Then
    result := 8;

  If Animal = '�ϼ�' Then
    result := 9;

  If Animal = '�繷' Then
    result := 10;

  If Animal = '����' Then
    result := 11;


End;

Function CnDateOfDate(Date: TDate): Integer;
Var
  CnMonth, CnMonthDays: Array[0..15] Of Integer;
  CnBeginDay, LeapMonth: Integer;
  yyyy, mm, dd: Word;
  Bytes: Array[0..3] Of Byte;
  I: Integer;
  CnMonthData: Word;
  DaysCount, CnDaysCount, ResultMonth, ResultDay: Integer;
Begin
  //  Date := StrToDate(FormatDateTime('yyyy/mm/dd', Date));
  DecodeDate(Date, yyyy, mm, dd);
  If (yyyy < 1901) Or (yyyy > 2050) Then
    Begin
      Result := 0;
      Exit;
    End;
  Bytes[0] := CnData[(yyyy - 1901) * 4];
  Bytes[1] := CnData[(yyyy - 1901) * 4 + 1];
  Bytes[2] := CnData[(yyyy - 1901) * 4 + 2];
  Bytes[3] := CnData[(yyyy - 1901) * 4 + 3];
  If (Bytes[0] And $80) <> 0 Then
    CnMonth[0] := 12
  Else
    CnMonth[0] := 11;
  CnBeginDay := (Bytes[0] And $7F);
  CnMonthData := Bytes[1];
  CnMonthData := CnMonthData Shl 8;
  CnMonthData := CnMonthData Or Bytes[2];
  LeapMonth := Bytes[3];

  For I := 15 Downto 0 Do
    Begin
      CnMonthDays[15 - I] := 29;
      If ((1 Shl I) And CnMonthData) <> 0 Then
        Inc(CnMonthDays[15 - I]);
      If CnMonth[15 - I] = LeapMonth Then
        CnMonth[15 - I + 1] := -LeapMonth
      Else
        Begin
          If CnMonth[15 - I] < 0 Then //����Ϊ����
            CnMonth[15 - I + 1] := -CnMonth[15 - I] + 1
          Else
            CnMonth[15 - I + 1] := CnMonth[15 - I] + 1;
          If CnMonth[15 - I + 1] > 12 Then CnMonth[15 - I + 1] := 1;
        End;
    End;

  DaysCount := DaysNumberOfDate(Date) - 1;
  If DaysCount <= (CnMonthDays[0] - CnBeginDay) Then
    Begin
      If (yyyy > 1901) And
        (CnDateOfDate(EncodeDate(yyyy - 1, 12, 31)) < 0) Then
        ResultMonth := -CnMonth[0]
      Else
        ResultMonth := CnMonth[0];
      ResultDay := CnBeginDay + DaysCount;
    End
  Else
    Begin
      CnDaysCount := CnMonthDays[0] - CnBeginDay;
      I := 1;
      While (CnDaysCount < DaysCount) And
        (CnDaysCount + CnMonthDays[I] < DaysCount) Do
        Begin
          Inc(CnDaysCount, CnMonthDays[I]);
          Inc(I);
        End;
      ResultMonth := CnMonth[I];
      ResultDay := DaysCount - CnDaysCount;
    End;
  If ResultMonth > 0 Then
    Result := ResultMonth * 100 + ResultDay
  Else
    Result := ResultMonth * 100 - ResultDay
End;

Function CnMonth(Date: TDate): Integer;
Begin
  Result := Abs(CnDateOfDate(Date) Div 100);
End;

Function CnMonthOfDate(Date: TDate; Days: Integer): String;
Var
  Year, Month, Day: word;
Begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnMonthOfDate(EncodeDate(Year, Month, Days));

End;

Function CnMonthOfDate(Date: TDate): String;
Const
  CnMonthStr: Array[1..12] Of String = (
    '��', '��', '��', '��', '��', '��', '��', '��', '��', 'ʮ',
    '��', '��');
Var
  Month: Integer;
Begin
  //  Date := StrToDate(FormatDateTime('yyyy/mm/dd', Date));
  Month := CnDateOfDate(Date) Div 100;
  If Month < 0 Then
    Result := '��' + CnMonthStr[-Month]
  Else
    Result := CnMonthStr[Month] + '��';
End;

Function CnDayOfDatePH(Date: TDate): String;
Const
  CnDayStr: Array[1..30] Of String = (
    '��һ', '����', '����', '����', '����',
    '����', '����', '����', '����', '��ʮ',
    'ʮһ', 'ʮ��', 'ʮ��', 'ʮ��', 'ʮ��',
    'ʮ��', 'ʮ��', 'ʮ��', 'ʮ��', '��ʮ',
    'إһ', 'إ��', 'إ��', 'إ��', 'إ��',
    'إ��', 'إ��', 'إ��', 'إ��', '��ʮ');
Var
  Day: Integer;
Begin
  //  Date := StrToDate(FormatDateTime('yyyy/mm/dd', Date));
  Day := Abs(CnDateOfDate(Date)) Mod 100;
  Result := CnDayStr[Day];
End;

Function CnDateOfDateStr(Date: TDate): String;
Begin
  Result := CnMonthOfDate(Date) + CnDayOfDatePH(Date);
End;

Function CnDayOfDate(Date: TDate; Days: integer; ShowDate: Boolean = false): String; //ָ�����ڵ�ũ���հ�������
Var
  Year, Month, Day: word;
Begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnDayOfDate(EncodeDate(Year, Month, Days));

End;

Function CnDayOfDate(Year,Month,Day: integer): String; overload; //ָ�����ڵ�ũ���հ�������
Begin
  Result := CnDayOfDate(EncodeDate(Year, Month, Day));
End;


Function CnDay(Date: TDate): Integer;
Begin
  Result := Abs(CnDateOfDate(Date)) Mod 100;
End;

Function CnDayOfDate(Date: TDate): String;
Const
  CnDayStr: Array[1..30] Of String = (
    '��һ', '����', '����', '����', '����',
    '����', '����', '����', '����', '��ʮ',
    'ʮһ', 'ʮ��', 'ʮ��', 'ʮ��', 'ʮ��',
    'ʮ��', 'ʮ��', 'ʮ��', 'ʮ��', '��ʮ',
    'إһ', 'إ��', 'إ��', 'إ��', 'إ��',
    'إ��', 'إ��', 'إ��', 'إ��', '��ʮ');
Var
  Day: Integer;
Begin
  //  Date := StrToDate(FormatDateTime('yyyy/mm/dd', Date));
  Day := Abs(CnDateOfDate(Date)) Mod 100;
  Result := CnDayStr[Day];

End;

Function CnDateOfDateStrPH(Date: TDate): String;
Begin
  Result := CnMonthOfDate(Date) + CnDayOfDate(Date);
End;

Function CnDayOfDateJr(Date: TDate; Days: Integer): String;
Var
  Year, Month, Day: word;
Begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnDayOfDateJr(EncodeDate(Year, Month, Days));

End;

Function CnDayOfDateJr(Date: TDate): String;
Var
  Day: Integer;
Begin
  Result := '';
  Day := Abs(CnDateOfDate(Date)) Mod 100;
  Case Day Of
    1:
      If (CnMonthOfDate(Date) = '����') Then
        Result := '����';
    5:
      If CnMonthOfDate(Date) = '����' Then
        Result := '�����';
    7:
      If CnMonthOfDate(Date) = '����' Then
        Result := '��Ϧ��';
    15:
      If CnMonthOfDate(Date) = '����' Then
        Result := '�����'
      Else
        If (CnMonthOfDate(Date) = '����') Then
          Result := 'Ԫ����';
    9:
      If CnMonthOfDate(Date) = '����' Then
        Result := '������';
    8:
      If CnMonthOfDate(Date) = '����' Then
        Result := '���˽�';
  Else
    If (CnMonthOfDate(Date + 1) = '����') And (CnMonthOfDate(Date) <> '����') Then
      Result := '��Ϧ';
  End; {case}
End;

Function CnanimalOfYear(Date: TDate): String; //����ʮ����Ф
Var
  i: integer;
  DateStr: String;
Begin
  DateStr := FormatDateTime('yyyy/mm/dd', Date);
  i := length(inttostr(month(date)));
  Case (StrToInt(Copy(DateStr, 1, 4)) - StrToInt(BaseAnimalDate))
    Mod 12 Of
    0:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '����'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '����'
          Else
            Result := '����';
        End;
    1, -11:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��ţ'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '����'
          Else
            Result := '��ţ';
        End;
    2, -10:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '����'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��ţ'
          Else
            Result := '����';
        End;
    3, -9:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := 'î��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '����'
          Else
            Result := 'î��';
        End;
    4, -8:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '����'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := 'î��'
          Else
            Result := '����';
        End;
    5, -7:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '����'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '����'
          Else
            Result := '����';
        End;
    6, -6:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '����'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '����'
          Else
            Result := '����';
        End;
    7, -5:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := 'δ��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '����'
          Else
            Result := 'δ��';
        End;
    8, -4:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '���'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := 'δ��'
          Else
            Result := '���';
        End;
    9, -3:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '�ϼ�'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '���'
          Else
            Result := '�ϼ�';
        End;
    10, -2:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '�繷'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '�ϼ�'
          Else
            Result := '�繷';
        End;
    11, -1:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '����'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '�繷'
          Else
            Result := '����';
        End;
  End; {case}
End;

Function CnSkyStemOfYear(Date: TDate): String; //����ʮ�����
Var
  i: integer;
  DateStr: String;
Begin
  DateStr := FormatDateTime('yyyy/mm/dd', Date);
  i := length(inttostr(month(date)));
  Case (StrToInt(Copy(DateStr, 1, 4)) - StrToInt(BaseSkyStemDate))
    Mod 10 Of
    0:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    1, -9:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    2, -8:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    3, -7:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    4, -6:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    5, -5:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    6, -4:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    7, -3:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    8, -2:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
    9, -1:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('��',
        CnMonthOfDate(Date)) = 0) And (Pos('��', CnMonthOfDate(Date)) = 0)) Then
        Result := '��'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '��'
          Else
            Result := '��';
        End;
  End;
  Result := Result + Copy(CnanimalOfYear(Date), 1, 3);
End;

Function CnSolarTerm(Date: TDate): String; //����ʮ�����
Var
  Year, Month, Day, Hour: Word;
Begin
  DecodeDate(Date, Year, Month, Day);
  //  d:=( ( 31556925974.7*(Year-1900) + SolarTerm[Month]*60000) + Date(1900,0,6,2,5) );

End;

Function GetLunarHolDay(InDate: TDateTime; Days: Integer): String;
Var
  Year, Month, Day, Hour: Word;
Begin
  DecodeDate(Date, Year, Month, Day);
  Result := GetLunarHolDay(EncodeDate(Year, Month, Days));

End;

Function GetLunarHolDay(InDate: TDateTime): String;
Var
  i, iYear, iMonth, iDay: Word;
Begin
  //  InDate := StrToDate(FormatDateTime('yyyy/mm/dd', InDate));

  Result := '';
  DecodeDate(InDate, iYear, iMonth, iDay);

  i := l_GetLunarHolDay(iYear, iMonth, iDay);
  Case i Of
    1: Result := 'С��';
    2: Result := '��';
    3: Result := '����';
    4: Result := '��ˮ';
    5: Result := '����';
    6: Result := '����';
    7: Result := '����';
    8: Result := '����';
    9: Result := '����';
    10: Result := 'С��';
    11: Result := 'â��';
    12: Result := '����';
    13: Result := 'С��';
    14: Result := '����';
    15: Result := '����';
    16: Result := '����';
    17: Result := '��¶';
    18: Result := '���';
    19: Result := '��¶';
    20: Result := '˪��';
    21: Result := '����';
    22: Result := 'Сѩ';
    23: Result := '��ѩ';
    24: Result := '����';
  End;
End;

Function l_GetLunarHolDay(iYear, iMonth, iDay: Word): Word;
Var
  Flag: Byte;
  Day: Word;
Begin
  //  var offDate = new Date( ( 31556925974.7*(y-1900) + sTermInfo[n]*60000  ) + Date.UTC(1900,0,6,2,5) )
  Flag := gLunarHolDay[(iYear - START_YEAR) * 12 + iMonth - 1];
  If iDay < 15 Then
    Day := 15 - ((Flag Shr 4) And $0F)
  Else
    Day := (Flag And $0F) + 15;
  If iDay = Day Then
    If iDay > 15 Then
      Result := (iMonth - 1) * 2 + 2
    Else
      Result := (iMonth - 1) * 2 + 1
  Else
    Result := 0;
End;


Function OtherHoliday(Month, Day: integer): String;
Begin
  //���µĵڶ�����������ףĸ�׽�
  //��ÿ��6�µĵ�3�������춨�鸸�H��      ?
  {

  ����Ԫ��[01/01] ���˽�[ũ��ʮ���³���]


   ����ʪ����[02/02] ���������[02/10] ���˽�[02/14]
  ��Ϧ[ũ��ʮ������ʮ] ����[ũ�����³�һ] Ԫ����[ũ������ʮ��]


   ȫ��������[03/03] ��Ů��[03/08] ֲ����[03/12]
  ���ʾ�����[03/14] ����������[03/15] ����ɭ����[03/21]
  ����ˮ��[03/22] ����������[03/23] ������ν�˲���[03/24]


   ���˽�[04/01] ����[04/05] ����������[04/07]
  ���������[04/22]


   �����Ͷ���[05/01] �й������[05/04] ȫ����ȱ������[05/05]
  �����ʮ����[05/08] ���ʻ�ʿ��[05/12] ���ʼ�ͥ��[05/15]
  ���������[05/17] ���ʲ������[05/18] ȫ��������[05/19]
  ȫ��ѧ��Ӫ����[05/20] ���������������[05/22] ����ţ����[05/23]
  ����������[05/31] �����[ũ�����³���] ĸ�׽�[�ڶ���������]


   ���ʶ�ͯ��[06/01] ���绷����[06/05] ȫ��������[06/06]
  �����[06/15] ���׽�[������������] ���λ�Į���͸ɺ���[06/17]
  ���ʰ���ƥ����[06/23] ȫ��������[06/25] ���ʷ���Ʒ��[06/26]


   ��ۻع���[07/01] ��Ϧ���˽�[ũ�����³���] ������[07/01]��
  �й�������ս��������[07/07] �����˿���[07/11]��


   ��һ������[08/01]����


   �Ͷ���[09/02]�� ����ɨä��[09/08] ��ʦ��[09/10]
  ���ʳ����㱣����[09/16] ���ʺ�ƽ��[09/17] ���ʰ�����[09/20]
  �����[ũ������ʮ��] �������˽�[09/22] ����������[09/27]
  ������[ũ�����¾���]


   �����[10/01]�� �������ֽ�[10/01] ���ʼ�����Ȼ�ֺ���[10/02]
  ���綯����[10/04] ����ס����[10/07] ȫ����Ѫѹ��[10/08]
  �����Ӿ���[10/08] ����������[10/09] ���羫��������[10/10]
  ����ä�˽�[10/15] ������ʳ��[10/16] ��������ƶ����[10/17]
  ���紫ͳҽҩ��[10/22] ���Ϲ���[10/24] ��ʥ��[10/31]



   �й�������[11/08]�� ����������[11/09] ����������[11/14]
  ���ʴ�ѧ����[11/17] �ж���[11/28]


   ������[ũ��12��22��] ���簬�̲���[12/01] ����м�����[12/03]
  ����������[12/09] ʥ����[12/25]





  }
  result := '';

  Case Month Of
    1:
      Begin
      End;

    2:
      Begin

        If day = 2 Then
          result := 'ʪ����';

        If day = 10 Then
          result := '�����';

      End;
    3:
      Begin
        If day = 3 Then
          result := '������';


        If day = 12 Then
          result := 'ֲ����';

        If day = 14 Then
          result := '������';

        If day = 15 Then
          result := '���ѽ�';

        If day = 21 Then
          result := 'ɭ����';

        If day = 22 Then
          result := 'ˮ��';

        If day = 23 Then
          result := '������';

      End;
    4:
      Begin

        If day = 7 Then
          result := '������';

        If day = 22 Then
          result := '������';

      End;
    5:
      Begin
        If day = 8 Then
          result := '��ʮ��';

        If day = 12 Then
          result := '��ʿ��';

        If day = 15 Then
          result := '��ͥ��';

        If day = 17 Then
          result := '������';

        If day = 18 Then
          result := '�����';

        If day = 19 Then
          result := '������';

        If day = 23 Then
          result := 'ţ����';

        If day = 31 Then
          result := '������';

        // ĸ�׽�[�ڶ���������]
      End;
    6:
      Begin

        If day = 5 Then
          result := '������';

        If day = 6 Then
          result := '������';

        If day = 23 Then
          result := '������';

        If day = 25 Then
          result := '������';

        If day = 26 Then
          result := '����Ʒ';

        // ���׽�[������������]
      End;
    7:
      Begin

        If day = 11 Then
          result := '�˿���';

      End;
    8:
      Begin

      End;
    9:
      Begin
        If day = 8 Then
          result := 'ɨä��';


        If day = 17 Then
          result := '��ƽ��';

        If day = 20 Then
          result := '������';

        If day = 22 Then
          result := '���˽�';

        If day = 27 Then
          result := '������';

      End;
    10:
      Begin

        If day = 6 Then
          result := '���˽�';

        If day = 4 Then
          result := '������';

        If day = 7 Then
          result := 'ס����';

        If day = 9 Then
          result := '������';

        If day = 15 Then
          result := 'ä�˽�';

        If day = 16 Then
          result := '��ʳ��';


      End;

    11:
      Begin
        If day = 8 Then
          result := '������';

        If day = 9 Then
          result := '������';

        If day = 17 Then
          result := '��ѧ��';


      End;
    12:
      Begin
        If day = 9 Then
          result := '������';

        If day = 24 Then
          result := 'ƽ��ҹ';
      End;

  End;
End;

Function Holiday(Date: TDateTime; Day: integer): String;
Var
  dDate: TDate;
Begin
  result := '';
//  result := OtherHoliday(Month(Date), Day);

  Case Month(Date) Of
    1:
      Begin
        If day = 1 Then
          result := 'Ԫ����';
      End;

    2:
      Begin
        If day = 14 Then
          result := '���˽�';
      End;
    3:
      Begin
        If day = 8 Then
          result := '��Ů��';
      End;
    4:
      Begin
        If day = 1 Then
          result := '���˽�';
      End;
    5:
      Begin
        If day = 1 Then
          result := '�Ͷ���';

        If day = 4 Then
          result := '�����';

        // ĸ�׽�[�ڶ���������]
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        If (DayOfWeek(dDate) = 1) Then
          If (Trunc((Day - 1) / 7) = 1) Then
            result := 'ĸ�׽�';

      End;
    6:
      Begin
        If day = 1 Then
          result := '��ͯ��';

        // ���׽�[������������]
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        If (DayOfWeek(dDate) = 1) Then
          If (Trunc((Day - 1) / 7) = 2) Then
            result := '���׽�';
      End;
    7:
      Begin
        If day = 1 Then
          result := '������';
      End;
    8:
      Begin
        If day = 1 Then
          result := '������';

      End;
    9:
      Begin
        If day = 10 Then
          result := '��ʦ��';
      End;
    10:
      Begin
        If day = 1 Then
          result := '�����';

        If day = 6 Then
          result := '���˽�';

        If day = 31 Then
          result := '��ʥ��';

      End;

    11:
      Begin
        If day = 8 Then
          result := '������';

        // �ж���(11�µĵ��ĸ������� )
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        If (DayOfWeek(dDate) = 5) Then
          If (Trunc((Day - 1) / 7) = 3) Then
            result := '�ж���';

      End;
    12:
      Begin
        If day = 25 Then
          result := 'ʥ����';
      End;

  End;
End;

Function GetCnDateToDate(dDate: TDateTime): TDateTime;
Begin
  Result := GetCnDateToDate(Year(Now), CnMonth(dDate), CnDay(dDate));
End;

Function GetCnDateToDate(cYear, cMonth, cDay: word): TDateTime;
Var
  tempDate: TDateTime;
  tempDay, tempMonth: Integer;

Begin
  If cMonth > 11 Then
    tempDate := EnCodeDate(cYear - 1, cMonth, cDay)
  Else
    tempDate := EnCodeDate(cYear, cMonth, cDay);

  Result := 0;
  tempMonth := 0;
  tempDay := 0;
  While Result = 0 Do
    Begin
      tempDate := tempDate + 1;

      If CnMonth(tempDate) = cMonth Then
        If CnDay(tempDate) = cDay Then
          Begin
            Result := tempDate;
            exit;
          End
        Else
          If (cDay = 30) And (CnDay(tempDate) = 29)
            And (CnDay(tempDate + 1) <> 30) Then
            Begin
            //�����û��30(����)������ǰһ��
              Result := tempDate;
              exit;
            End;

    End;
End;

Function GetDays(ADate: TDate): Extended;
Var
  FirstOfYear: TDateTime;
Begin
  FirstOfYear := EncodeDate(StrToInt(FormatDateTime('yyyy', now)) - 1, 12, 31);
  Result := ADate - FirstOfYear;
End;

Function Constellation(Date: TDateTime; Day: integer): String; overload;
Var
  Year, Month, Days, Hour: Word;
Begin
  DecodeDate(Date, Year, Month, Days);
  Result := Constellation(EncodeDate(Year, Month, Day));
end;

Function Constellation(ADate: TDate): String;
Begin
  Case Month(ADate) Of
    1:
      Begin
        If day(ADate) <= 19 Then
          result := 'Ħ����';

        If day(ADate) >= 20 Then
          result := 'ˮƿ��';
      End;

    2:
      Begin
        If day(ADate) <= 18 Then
          result := 'ˮƿ��';

        If day(ADate) >= 19 Then
          result := '˫����';
      End;

    3:
      Begin
        If day(ADate) <= 20 Then
          result := '˫����';

        If day(ADate) >= 21 Then
          result := '������';
      End;

    4:
      Begin
        If day(ADate) <= 19 Then
          result := '������';

        If day(ADate) >= 20 Then
          result := '��ţ��';
      End;

    5:
      Begin
        If day(ADate) <= 20 Then
          result := '��ţ��';

        If day(ADate) >= 21 Then
          result := '˫����';
      End;

    6:
      Begin
        If day(ADate) <= 21 Then
          result := '˫����';

        If day(ADate) >= 22 Then
          result := '��з��';
      End;

    7:
      Begin
        If day(ADate) <= 22 Then
          result := '��з��';

        If day(ADate) >= 23 Then
          result := 'ʨ����';
      End;

    8:
      Begin
        If day(ADate) <= 22 Then
          result := 'ʨ����';

        If day(ADate) >= 24 Then
          result := '��Ů��';
      End;

    9:
      Begin
        If day(ADate) <= 22 Then
          result := '��Ů��';

        If day(ADate) >= 23 Then
          result := '�����';
      End;

    10:
      Begin
        If day(ADate) <= 23 Then
          result := '�����';

        If day(ADate) >= 24 Then
          result := '��Ы��';
      End;

    11:
      Begin
        If day(ADate) <= 21 Then
          result := '��Ы��';

        If day(ADate) >= 22 Then
          result := '������';
      End;

    12:
      Begin
        If day(ADate) <= 21 Then
          result := '������';

        If day(ADate) >= 22 Then
          result := 'Ħ����';
      End;
  End;
End;
{
//�洢��������Ϣ
1�������� 03��21��-------04��19��  Aries
2��ţ���� 04��20��-------05��20��  Taurus
3˫������ 05��21��-------06��21��  Gemini
4��з���� 06��22��-------07��22��  Cancer
5ʨ������ 07��23��-------08��22��  Leo
6��Ů���� 08��23��-------09��22��  Virgo
7������� 09��23��-------10��23��  Libra
8��Ы���� 10��24��-------11��21��  Scorpio
9�������� 11��22��-------12��21��  Sagittarius
10Ħ������ 12��22��-------01��19��  Capricorn
11ˮƿ���� 01��20��-------02��18��  Aquarius
12˫������ 02��19��-------03��20��  Pisces
}
End.

