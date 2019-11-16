Unit DateCn;

Interface

Uses Windows, SysUtils, Controls;

Const
  //农历月份数据，每年4字节，从1901年开始，共150年
  //数据来源：UCDOS 6.0 UCT.COM
  //分析整理：Copyright (c) 1996-1998, Randolph
  //数据解析：
  //如果第一字节的bit7为1，则该年1月1日位于农历12月，否则位于11月
  //第一字节去除bit7为该年1月1日的农历日期
  //         第二字节                 第三字节
  //bit:     7  6  5  4  3  2  1  0   7  6  5  4  3  2  1  0
  //农历月份:16 15 14 13 12 11 10 9   8  7  6  5  4  3  2  1
  //农历月份指的是从该年1月1日的农历月份算起的顺序号
  //农历月份对应的bit为1则该月为30日，否则为29日
  //第四字节为闰月月份
//  BaseDate='2000/02/04';//2000立春
  BaseAnimalDate = '1972'; //1972年支为子(是鼠年)
  BaseSkyStemDate = '1974'; //1974年干为甲
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
//日期是该年的第几天，1月1日为第一天
Function CnMonthOfDate(Date: TDate; Days: Integer): String; OverLoad;
Function CnMonthOfDate(Date: TDate): String; OverLoad; //指定日期的农历月

Function CnMonth(Date: TDate): Integer; //指定日期的农历月
Function CnDay(Date: TDate): Integer; //指定日期的农历日包括节日
Function CnDayOfDate(Date: TDate): String; overload; //指定日期的农历日包括节日
Function CnDayOfDate(Year,Month,Day: integer): String; overload; //指定日期的农历日包括节日

Function CnDayOfDate(Date: TDate; Days: integer; ShowDate: Boolean = false): String; overload; //指定日期的农历日包括节日

Function CnDateOfDateStr(Date: TDate): String; //指定日期的农历日期
Function CnDayOfDatePH(Date: TDate): String; //指定日期的农历月
Function CnDateOfDateStrPH(Date: TDate): String; //指定日期的农历日期包括节日

Function CnDayOfDateJr(Date: TDate): String; overload; //只有节日
Function CnDayOfDateJr(Date: TDate; Days: Integer): String; overload; //只有节日

Function CnanimalOfYear(Date: TDate): String; //返回十二生肖(地支)
Function CnSkyStemOfYear(Date: TDate): String; //返回十大天干
Function CnSolarTerm(Date: TDate): String; //返回十大天干

Function GetLunarHolDay(InDate: TDateTime): String; overload;
Function GetLunarHolDay(InDate: TDateTime; Days: Integer): String; overload;

Function l_GetLunarHolDay(iYear, iMonth, iDay: Word): Word;
Function GetAnimal(Date: TDate): integer; //返回十二生肖

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


//日期是该年的第几天，1月1日为第一天

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

//日期的农历日期，返回农历格式：月份*100 + 日，负数为闰月
//超出范围则返回0

Function GetAnimal(Date: TDate): integer; //返回十二生肖
Var
  Animal: String;
Begin
  Animal := CnanimalOfYear(Date);
  If Animal = '子鼠' Then
    result := 0;

  If Animal = '丑牛' Then
    result := 1;

  If Animal = '寅虎' Then
    result := 2;

  If Animal = '卯兔' Then
    result := 3;

  If Animal = '辰龙' Then
    result := 4;

  If Animal = '巳蛇' Then
    result := 5;

  If Animal = '午马' Then
    result := 6;

  If Animal = '未羊' Then
    result := 7;

  If Animal = '申猴' Then
    result := 8;

  If Animal = '酉鸡' Then
    result := 9;

  If Animal = '戌狗' Then
    result := 10;

  If Animal = '亥猪' Then
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
          If CnMonth[15 - I] < 0 Then //上月为闰月
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
    '正', '二', '三', '四', '五', '六', '七', '八', '九', '十',
    '冬', '腊');
Var
  Month: Integer;
Begin
  //  Date := StrToDate(FormatDateTime('yyyy/mm/dd', Date));
  Month := CnDateOfDate(Date) Div 100;
  If Month < 0 Then
    Result := '闰' + CnMonthStr[-Month]
  Else
    Result := CnMonthStr[Month] + '月';
End;

Function CnDayOfDatePH(Date: TDate): String;
Const
  CnDayStr: Array[1..30] Of String = (
    '初一', '初二', '初三', '初四', '初五',
    '初六', '初七', '初八', '初九', '初十',
    '十一', '十二', '十三', '十四', '十五',
    '十六', '十七', '十八', '十九', '二十',
    '廿一', '廿二', '廿三', '廿四', '廿五',
    '廿六', '廿七', '廿八', '廿九', '三十');
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

Function CnDayOfDate(Date: TDate; Days: integer; ShowDate: Boolean = false): String; //指定日期的农历日包括节日
Var
  Year, Month, Day: word;
Begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnDayOfDate(EncodeDate(Year, Month, Days));

End;

Function CnDayOfDate(Year,Month,Day: integer): String; overload; //指定日期的农历日包括节日
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
    '初一', '初二', '初三', '初四', '初五',
    '初六', '初七', '初八', '初九', '初十',
    '十一', '十二', '十三', '十四', '十五',
    '十六', '十七', '十八', '十九', '二十',
    '廿一', '廿二', '廿三', '廿四', '廿五',
    '廿六', '廿七', '廿八', '廿九', '三十');
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
      If (CnMonthOfDate(Date) = '正月') Then
        Result := '春节';
    5:
      If CnMonthOfDate(Date) = '五月' Then
        Result := '端午节';
    7:
      If CnMonthOfDate(Date) = '七月' Then
        Result := '七夕节';
    15:
      If CnMonthOfDate(Date) = '八月' Then
        Result := '中秋节'
      Else
        If (CnMonthOfDate(Date) = '正月') Then
          Result := '元宵节';
    9:
      If CnMonthOfDate(Date) = '九月' Then
        Result := '重阳节';
    8:
      If CnMonthOfDate(Date) = '腊月' Then
        Result := '腊八节';
  Else
    If (CnMonthOfDate(Date + 1) = '正月') And (CnMonthOfDate(Date) <> '正月') Then
      Result := '除夕';
  End; {case}
End;

Function CnanimalOfYear(Date: TDate): String; //返回十二生肖
Var
  i: integer;
  DateStr: String;
Begin
  DateStr := FormatDateTime('yyyy/mm/dd', Date);
  i := length(inttostr(month(date)));
  Case (StrToInt(Copy(DateStr, 1, 4)) - StrToInt(BaseAnimalDate))
    Mod 12 Of
    0:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '子鼠'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '亥猪'
          Else
            Result := '子鼠';
        End;
    1, -11:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '丑牛'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '子鼠'
          Else
            Result := '丑牛';
        End;
    2, -10:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '寅虎'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '丑牛'
          Else
            Result := '寅虎';
        End;
    3, -9:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '卯兔'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '寅虎'
          Else
            Result := '卯兔';
        End;
    4, -8:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '辰龙'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '卯兔'
          Else
            Result := '辰龙';
        End;
    5, -7:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '巳蛇'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '辰龙'
          Else
            Result := '巳蛇';
        End;
    6, -6:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '午马'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '巳蛇'
          Else
            Result := '午马';
        End;
    7, -5:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '未羊'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '午马'
          Else
            Result := '未羊';
        End;
    8, -4:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '申猴'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '未羊'
          Else
            Result := '申猴';
        End;
    9, -3:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '酉鸡'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '申猴'
          Else
            Result := '酉鸡';
        End;
    10, -2:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '戌狗'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '酉鸡'
          Else
            Result := '戌狗';
        End;
    11, -1:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '亥猪'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '戌狗'
          Else
            Result := '亥猪';
        End;
  End; {case}
End;

Function CnSkyStemOfYear(Date: TDate): String; //返回十大天干
Var
  i: integer;
  DateStr: String;
Begin
  DateStr := FormatDateTime('yyyy/mm/dd', Date);
  i := length(inttostr(month(date)));
  Case (StrToInt(Copy(DateStr, 1, 4)) - StrToInt(BaseSkyStemDate))
    Mod 10 Of
    0:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '甲'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '癸'
          Else
            Result := '甲';
        End;
    1, -9:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '乙'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '甲'
          Else
            Result := '乙';
        End;
    2, -8:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '丙'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '乙'
          Else
            Result := '丙';
        End;
    3, -7:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '丁'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '丙'
          Else
            Result := '丁';
        End;
    4, -6:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '戊'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '丁'
          Else
            Result := '戊';
        End;
    5, -5:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '巳'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '戊'
          Else
            Result := '巳';
        End;
    6, -4:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '庚'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '巳'
          Else
            Result := '庚';
        End;
    7, -3:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '辛'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '庚'
          Else
            Result := '辛';
        End;
    8, -2:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '壬'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '辛'
          Else
            Result := '壬';
        End;
    9, -1:
      If (StrToInt(Copy(DateStr, 6, i)) < 4) And ((Pos('腊',
        CnMonthOfDate(Date)) = 0) And (Pos('冬', CnMonthOfDate(Date)) = 0)) Then
        Result := '癸'
      Else
        Begin
          If StrToInt(Copy(DateStr, 6, i)) < 4 Then
            Result := '壬'
          Else
            Result := '癸';
        End;
  End;
  Result := Result + Copy(CnanimalOfYear(Date), 1, 3);
End;

Function CnSolarTerm(Date: TDate): String; //返回十大天干
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
    1: Result := '小寒';
    2: Result := '大寒';
    3: Result := '立春';
    4: Result := '雨水';
    5: Result := '惊蛰';
    6: Result := '春分';
    7: Result := '清明';
    8: Result := '谷雨';
    9: Result := '立夏';
    10: Result := '小满';
    11: Result := '芒种';
    12: Result := '夏至';
    13: Result := '小暑';
    14: Result := '大暑';
    15: Result := '立秋';
    16: Result := '处暑';
    17: Result := '白露';
    18: Result := '秋分';
    19: Result := '寒露';
    20: Result := '霜降';
    21: Result := '立冬';
    22: Result := '小雪';
    23: Result := '大雪';
    24: Result := '冬至';
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
  //五月的第二个星期日庆祝母亲节
  //將每年6月的第3個星期天定為父親節      ?
  {

  新年元旦[01/01] 腊八节[农历十二月初八]


   世界湿地日[02/02] 国际气象节[02/10] 情人节[02/14]
  除夕[农历十二月三十] 春节[农历正月初一] 元宵节[农历正月十五]


   全国爱耳日[03/03] 妇女节[03/08] 植树节[03/12]
  国际警察日[03/14] 国际消费日[03/15] 世界森林日[03/21]
  世界水日[03/22] 世界气象日[03/23] 世界防治结核病日[03/24]


   愚人节[04/01] 清明[04/05] 世界卫生日[04/07]
  世界地球日[04/22]


   国际劳动节[05/01] 中国青年节[05/04] 全国碘缺乏病日[05/05]
  世界红十字日[05/08] 国际护士节[05/12] 国际家庭日[05/15]
  世界电信日[05/17] 国际博物馆日[05/18] 全国助残日[05/19]
  全国学生营养日[05/20] 国际生物多样性日[05/22] 国际牛奶日[05/23]
  世界无烟日[05/31] 端午节[农历五月初五] 母亲节[第二个星期日]


   国际儿童节[06/01] 世界环境日[06/05] 全国爱眼日[06/06]
  端午节[06/15] 父亲节[第三个星期日] 防治荒漠化和干旱日[06/17]
  国际奥林匹克日[06/23] 全国土地日[06/25] 国际反毒品日[06/26]


   香港回归日[07/01] 七夕情人节[农历七月初七] 建党日[07/01]　
  中国人民抗日战争纪念日[07/07] 世界人口日[07/11]　


   八一建军节[08/01]　　


   劳动节[09/02]　 国际扫盲日[09/08] 教师节[09/10]
  国际臭氧层保护日[09/16] 国际和平日[09/17] 国际爱牙日[09/20]
  中秋节[农历八月十五] 国际聋人节[09/22] 世界旅游日[09/27]
  重阳节[农历九月九日]


   国庆节[10/01]　 国际音乐节[10/01] 国际减轻自然灾害日[10/02]
  世界动物日[10/04] 国际住房日[10/07] 全国高血压日[10/08]
  世界视觉日[10/08] 世界邮政日[10/09] 世界精神卫生日[10/10]
  国际盲人节[10/15] 世界粮食节[10/16] 世界消除贫困日[10/17]
  世界传统医药日[10/22] 联合国日[10/24] 万圣节[10/31]



   中国记者日[11/08]　 消防宣传日[11/09] 世界糖尿病日[11/14]
  国际大学生节[11/17] 感恩节[11/28]


   冬至节[农历12月22日] 世界艾滋病日[12/01] 世界残疾人日[12/03]
  世界足球日[12/09] 圣诞节[12/25]





  }
  result := '';

  Case Month Of
    1:
      Begin
      End;

    2:
      Begin

        If day = 2 Then
          result := '湿地日';

        If day = 10 Then
          result := '气象节';

      End;
    3:
      Begin
        If day = 3 Then
          result := '爱耳日';


        If day = 12 Then
          result := '植树节';

        If day = 14 Then
          result := '警察日';

        If day = 15 Then
          result := '消费节';

        If day = 21 Then
          result := '森林日';

        If day = 22 Then
          result := '水日';

        If day = 23 Then
          result := '气象日';

      End;
    4:
      Begin

        If day = 7 Then
          result := '卫生日';

        If day = 22 Then
          result := '地球日';

      End;
    5:
      Begin
        If day = 8 Then
          result := '红十字';

        If day = 12 Then
          result := '护士节';

        If day = 15 Then
          result := '家庭日';

        If day = 17 Then
          result := '电信日';

        If day = 18 Then
          result := '博物馆';

        If day = 19 Then
          result := '助残日';

        If day = 23 Then
          result := '牛奶日';

        If day = 31 Then
          result := '无烟日';

        // 母亲节[第二个星期日]
      End;
    6:
      Begin

        If day = 5 Then
          result := '环境日';

        If day = 6 Then
          result := '爱眼日';

        If day = 23 Then
          result := '体育日';

        If day = 25 Then
          result := '土地日';

        If day = 26 Then
          result := '反毒品';

        // 父亲节[第三个星期日]
      End;
    7:
      Begin

        If day = 11 Then
          result := '人口日';

      End;
    8:
      Begin

      End;
    9:
      Begin
        If day = 8 Then
          result := '扫盲日';


        If day = 17 Then
          result := '和平日';

        If day = 20 Then
          result := '爱牙日';

        If day = 22 Then
          result := '聋人节';

        If day = 27 Then
          result := '旅游日';

      End;
    10:
      Begin

        If day = 6 Then
          result := '老人节';

        If day = 4 Then
          result := '动物日';

        If day = 7 Then
          result := '住房日';

        If day = 9 Then
          result := '邮政日';

        If day = 15 Then
          result := '盲人节';

        If day = 16 Then
          result := '粮食日';


      End;

    11:
      Begin
        If day = 8 Then
          result := '记者日';

        If day = 9 Then
          result := '消防日';

        If day = 17 Then
          result := '大学生';


      End;
    12:
      Begin
        If day = 9 Then
          result := '足球日';

        If day = 24 Then
          result := '平安夜';
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
          result := '元旦节';
      End;

    2:
      Begin
        If day = 14 Then
          result := '情人节';
      End;
    3:
      Begin
        If day = 8 Then
          result := '妇女节';
      End;
    4:
      Begin
        If day = 1 Then
          result := '愚人节';
      End;
    5:
      Begin
        If day = 1 Then
          result := '劳动节';

        If day = 4 Then
          result := '青年节';

        // 母亲节[第二个星期日]
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        If (DayOfWeek(dDate) = 1) Then
          If (Trunc((Day - 1) / 7) = 1) Then
            result := '母亲节';

      End;
    6:
      Begin
        If day = 1 Then
          result := '儿童节';

        // 父亲节[第三个星期日]
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        If (DayOfWeek(dDate) = 1) Then
          If (Trunc((Day - 1) / 7) = 2) Then
            result := '父亲节';
      End;
    7:
      Begin
        If day = 1 Then
          result := '建党节';
      End;
    8:
      Begin
        If day = 1 Then
          result := '建军节';

      End;
    9:
      Begin
        If day = 10 Then
          result := '教师节';
      End;
    10:
      Begin
        If day = 1 Then
          result := '国庆节';

        If day = 6 Then
          result := '老人节';

        If day = 31 Then
          result := '万圣节';

      End;

    11:
      Begin
        If day = 8 Then
          result := '记者日';

        // 感恩节(11月的第四个星期四 )
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        If (DayOfWeek(dDate) = 5) Then
          If (Trunc((Day - 1) / 7) = 3) Then
            result := '感恩节';

      End;
    12:
      Begin
        If day = 25 Then
          result := '圣诞节';
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
            //如果是没有30(闰月)，就提前一天
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
          result := '摩羯座';

        If day(ADate) >= 20 Then
          result := '水瓶座';
      End;

    2:
      Begin
        If day(ADate) <= 18 Then
          result := '水瓶座';

        If day(ADate) >= 19 Then
          result := '双鱼座';
      End;

    3:
      Begin
        If day(ADate) <= 20 Then
          result := '双鱼座';

        If day(ADate) >= 21 Then
          result := '白羊座';
      End;

    4:
      Begin
        If day(ADate) <= 19 Then
          result := '白羊座';

        If day(ADate) >= 20 Then
          result := '金牛座';
      End;

    5:
      Begin
        If day(ADate) <= 20 Then
          result := '金牛座';

        If day(ADate) >= 21 Then
          result := '双子座';
      End;

    6:
      Begin
        If day(ADate) <= 21 Then
          result := '双子座';

        If day(ADate) >= 22 Then
          result := '巨蟹座';
      End;

    7:
      Begin
        If day(ADate) <= 22 Then
          result := '巨蟹座';

        If day(ADate) >= 23 Then
          result := '狮子座';
      End;

    8:
      Begin
        If day(ADate) <= 22 Then
          result := '狮子座';

        If day(ADate) >= 24 Then
          result := '处女座';
      End;

    9:
      Begin
        If day(ADate) <= 22 Then
          result := '处女座';

        If day(ADate) >= 23 Then
          result := '天秤座';
      End;

    10:
      Begin
        If day(ADate) <= 23 Then
          result := '天秤座';

        If day(ADate) >= 24 Then
          result := '天蝎座';
      End;

    11:
      Begin
        If day(ADate) <= 21 Then
          result := '天蝎座';

        If day(ADate) >= 22 Then
          result := '射手座';
      End;

    12:
      Begin
        If day(ADate) <= 21 Then
          result := '射手座';

        If day(ADate) >= 22 Then
          result := '摩羯座';
      End;
  End;
End;
{
//存储星座配信息
1白羊座： 03月21日-------04月19日  Aries
2金牛座： 04月20日-------05月20日  Taurus
3双子座： 05月21日-------06月21日  Gemini
4巨蟹座： 06月22日-------07月22日  Cancer
5狮子座： 07月23日-------08月22日  Leo
6处女座： 08月23日-------09月22日  Virgo
7天秤座： 09月23日-------10月23日  Libra
8天蝎座： 10月24日-------11月21日  Scorpio
9射手座： 11月22日-------12月21日  Sagittarius
10摩羯座： 12月22日-------01月19日  Capricorn
11水瓶座： 01月20日-------02月18日  Aquarius
12双鱼座： 02月19日-------03月20日  Pisces
}
End.

