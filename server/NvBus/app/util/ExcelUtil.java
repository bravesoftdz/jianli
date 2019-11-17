package util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.CellType;
import jxl.FormulaCell;
import jxl.NumberCell;
import jxl.Sheet;
import jxl.SheetSettings;
import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import net.sf.jxls.exception.ParsePropertyException;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.CellValue;
import org.apache.poi.ss.usermodel.FormulaEvaluator;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * @ClassName: ExcelUtil
 * @Description: jxl操作excel的工具类
 */
public class ExcelUtil {

    private static DecimalFormat decimalFormat = new DecimalFormat("###################.###########");
    
    /**
     * @Title: exportToExcel
     * @Description: 导出excel
     * @param response
     * @param objData
     *            导出内容数组
     * @param sheetName
     *            导出工作表的名称
     * @param heads
     *            列对应的数据在Map中的key
     * @param columns
     *            导出Excel的表头数组
     * @return
     */
    public static int exportToExcel(HttpServletResponse response,
            List<Map<String, Object>> objData, String sheetName,
            List<String> columns, List<String> heads) {
        int flag = 0;
        // 声明工作簿jxl.write.WritableWorkbook
        WritableWorkbook wwb;
        try {
            // 根据传进来的file对象创建可写入的Excel工作薄
            OutputStream os = response.getOutputStream();

            wwb = Workbook.createWorkbook(os);

            /*
             * 创建一个工作表、sheetName为工作表的名称、"0"为第一个工作表
             * 打开Excel的时候会看到左下角默认有3个sheet、"sheet1、sheet2、sheet3"
             * 这样代码中的"0"就是sheet1、其它的一一对应 createSheet(sheetName,
             * 0)一个是工作表的名称，另一个是工作表在工作薄中的位置
             */
            WritableSheet ws = wwb.createSheet(sheetName, 0);

            SheetSettings ss = ws.getSettings();
            ss.setVerticalFreeze(1);// 冻结表头

            WritableFont font1 = new WritableFont(
                    WritableFont.createFont("微软雅黑"), 10, WritableFont.BOLD);
            WritableFont font2 = new WritableFont(
                    WritableFont.createFont("微软雅黑"), 9, WritableFont.NO_BOLD);
            WritableCellFormat wcf = new WritableCellFormat(font1);
            WritableCellFormat wcf2 = new WritableCellFormat(font2);
            WritableCellFormat wcf3 = new WritableCellFormat(font2);// 设置样式，字体

            // 创建单元格样式
            // WritableCellFormat wcf = new WritableCellFormat();

            // 背景颜色
            wcf.setBackground(jxl.format.Colour.YELLOW);
            wcf.setAlignment(Alignment.CENTRE); // 平行居中
            wcf.setVerticalAlignment(VerticalAlignment.CENTRE); // 垂直居中
            wcf3.setAlignment(Alignment.CENTRE); // 平行居中
            wcf3.setVerticalAlignment(VerticalAlignment.CENTRE); // 垂直居中
            wcf3.setBackground(Colour.LIGHT_ORANGE);
            wcf2.setAlignment(Alignment.CENTRE); // 平行居中
            wcf2.setVerticalAlignment(VerticalAlignment.CENTRE); // 垂直居中

            /*
             * 这个是单元格内容居中显示 还有很多很多样式
             */
            wcf.setAlignment(Alignment.CENTRE);

            // 判断一下表头数组是否有数据
            if (columns != null && columns.size() > 0) {

                // 循环写入表头
                for (int i = 0; i < columns.size(); i++) {

                    /*
                     * 添加单元格(Cell)内容addCell() 添加Label对象Label()
                     * 数据的类型有很多种、在这里你需要什么类型就导入什么类型 如：jxl.write.DateTime
                     * 、jxl.write.Number、jxl.write.Label Label(i, 0, columns[i],
                     * wcf) 其中i为列、0为行、columns[i]为数据、wcf为样式
                     * 合起来就是说将columns[i]添加到第一行(行、列下标都是从0开始)第i列、样式为什么"色"内容居中
                     */
                    ws.addCell(new Label(i, 0, columns.get(i), wcf));
                }

                // 判断表中是否有数据
                if (objData != null && objData.size() > 0) {
                    // 循环写入表中数据
                    for (int i = 0; i < objData.size(); i++) {

                        // 转换成map集合{activyName:测试功能,count:2}
                        Map<String, Object> map = (Map<String, Object>) objData
                                .get(i);

                        // 循环输出map中的子集：既列值
                        for (int j = 0; j < heads.size(); j++) {
                            ws.addCell(new Label(j, i + 1, String.valueOf(map
                                    .get(heads.get(j)) == null ? "" : map
                                    .get(heads.get(j)))));
                        }
                    }
                } else {
                    flag = -1;
                }

                // 写入Exel工作表
                wwb.write();

                // 关闭Excel工作薄对象
                wwb.close();

                // 关闭流
                os.flush();
                os.close();

                os = null;
            }
        } catch (IllegalStateException e) {
            System.err.println(e.getMessage());
        } catch (Exception ex) {
            flag = 0;
            ex.printStackTrace();
        }

        return flag;
    }

    /**
     * @Title: exportexcle
     * @Description: 下载excel
     * @param response
     * @param filename
     *            文件名 ,如:20110808.xls
     * @param listData
     *            数据源
     * @param sheetName
     *            表头名称
     * @param heads
     *            列对应的数据在Map中的key
     * @param columns
     *            列名称集合,如：{物品名称，数量，单价}
     */
    public static void exportexcle(HttpServletResponse response,
            String filename, List<Map<String, Object>> listData,
            String sheetName, List<String> columns, List<String> heads) {
        // 调用上面的方法、生成Excel文件
        response.setContentType("application/vnd.ms-excel");
        try {
            response.setHeader("Content-Disposition", "attachment;filename="
            // + new String(filename.getBytes("gb2312"), "ISO8859-1")
                    + filename + ".xls");

            exportToExcel(response, listData, sheetName, columns, heads);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    /**
     * @Title: exportExcleByTemplate 
     * @Description: 根据模板导出Excel文件
     * @param response
     * @param templateFilePath 模板文件路径包括模板名称和扩展名
     * @param beanParams 导出数据
     * @param resultFileName 导出文件名称和扩展名
     * @throws UnsupportedEncodingException 
     */
    public static void exportExcleByTemplate(HttpServletResponse response, String templateFilePath, Map<String,Object> beanParams, String resultFileName) throws UnsupportedEncodingException {
        //设置响应  
        response.setHeader("Content-Disposition", "attachment;filename=" + new String(resultFileName.getBytes("UTF-8"), "ISO8859-1" ));  
        response.setContentType("application/vnd.ms-excel");
        
        //创建XLSTransformer对象  
        XLSTransformer transformer = new XLSTransformer();  
        
        InputStream in=null;  
        OutputStream out=null;  
        
        try {  
            in=new BufferedInputStream(new FileInputStream(templateFilePath));  
            org.apache.poi.ss.usermodel.Workbook workbook=transformer.transformXLS(in, beanParams);  
            out=response.getOutputStream();  
            //将内容写入输出流并把缓存的内容全部发出去  
            workbook.write(out);  
            out.flush();  
        } catch (InvalidFormatException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } finally {  
            if (in!=null){try {in.close();} catch (IOException e) {}}  
            if (out!=null){try {out.close();} catch (IOException e) {}}  
        } 
        
    }
    
    /**
     * @Title: createExcel 
     * @Description: 根据模板生成Excel文件
     * @param srcFilePath 模板文件路径
     * @param beanParams 模板中存放的数据
     * @param destFilePath 生成的文件路径
     */
    public static void createExcel(String srcFilePath, Map<String,Object> beanParams, String destFilePath){  
        //创建XLSTransformer对象  
        XLSTransformer transformer = new XLSTransformer();  
        try {  
            //生成Excel文件  
            transformer.transformXLS(srcFilePath, beanParams, destFilePath);  
        } catch (ParsePropertyException e) {  
            e.printStackTrace();  
        } catch (IOException e) {  
            e.printStackTrace();  
        } catch (InvalidFormatException e) {
            e.printStackTrace();
        }  
    }

    /**
     * @Title: readExcel
     * @Description: 读取Excel文件的内容
     * @param file
     *            待读取的文件
     * @return
     */
    public static List<List<List<String>>> readExcel(File file)
            throws BiffException, IOException {
        Workbook workBook = Workbook.getWorkbook(file);

        if (workBook == null)
            return null;

        return getDataInWorkbook(workBook);
    }

    private static List<List<List<String>>> getDataInWorkbook(Workbook workBook) {
        // 获得了Workbook对象之后，就可以通过它得到Sheet（工作表）对象了
        Sheet[] sheet = workBook.getSheets();

        List<List<List<String>>> dataList = new ArrayList<List<List<String>>>();

        if (sheet != null && sheet.length > 0) {
            // 对每个工作表进行循环
            for (int i = 0; i < sheet.length; i++) {
                List<List<String>> rowList = new ArrayList<List<String>>();
                // 得到当前工作表的行数
                int rowNum = sheet[i].getRows();
                int colNum = sheet[i].getColumns();
                for (int j = 0; j < rowNum; j++) {
                    // 得到当前行的所有单元格
                    Cell[] cells = sheet[i].getRow(j);
                    if (cells != null && cells.length > 0) {
                        List<String> cellList = new ArrayList<String>();
                        // 对每个单元格进行循环
                        for (int k = 0; k < colNum; k++) {
                            Cell cell = sheet[i].getCell(k, j);
                            String cellValue = "";
                            // 判断单元格的值是否是数字
                            if (cell.getType() == CellType.NUMBER) {
                                NumberCell numberCell = (NumberCell) cell;
                                double value = numberCell.getValue();
                                cellValue = decimalFormat.format(value);
                            } else if (cell.getType() == CellType.NUMBER_FORMULA
                                    || cell.getType() == CellType.STRING_FORMULA
                                    || cell.getType() == CellType.BOOLEAN_FORMULA
                                    || cell.getType() == CellType.DATE_FORMULA
                                    || cell.getType() == CellType.FORMULA_ERROR) {
                                FormulaCell nfc = (FormulaCell) cell;
                                cellValue = nfc.getContents();
                            } else {
                                // 读取当前单元格的值
                                cellValue = cell.getContents();
                                // 特殊字符处理
                                cellValue = excelCharaterDeal(cellValue);
                            }
                            // 去掉空格
                            cellList.add(cellValue.trim());
                        }
                        rowList.add(cellList);
                    }
                }
                dataList.add(rowList);
            }
        }
        // 最后关闭资源，释放内存
        workBook.close();

        return dataList;
    }

    /**
     * @Title: toToken
     * @Description: 除去字符串中指定的分隔符
     * @param s
     *            字符串
     * @param val
     *            指定的分隔符
     * @return
     */
    private static String toToken(String s, String val) {
        if (s == null || s.trim().equals("")) {
            return s;
        }
        if (val == null || val.equals("")) {
            return s;
        }
        StringBuffer stringBuffer = new StringBuffer();
        String[] result = s.split(val);
        for (int x = 0; x < result.length; x++) {
            stringBuffer.append(" ").append(result[x]);
        }
        return stringBuffer.toString();

    }

    /**
     * @Title: excelCharaterDeal
     * @Description: Excel特殊字符处理
     * @param str
     *            字符串
     * @return
     */
    private static String excelCharaterDeal(String str) {
        String[] val = { "-", "_", "/" };// 定义特殊字符
        for (String i : val) {
            str = toToken(str, i);
        }
        return str;
    }
    
    /**
     * @Title: readExcelTitle 
     * @Description: 读取Excel表格表头的内容
     * @param file 待读取的文件
     * @return 表头内容的数组
     * @throws Exception
     */
    public String[] readExcelTitle(File file) throws Exception {
        InputStream is = new FileInputStream(file);
        HSSFWorkbook wb = new HSSFWorkbook(is);
        HSSFSheet sheet = wb.getSheetAt(0);
        HSSFRow row = sheet.getRow(0);
        // 标题总列数
        int colNum = row.getPhysicalNumberOfCells();
        String[] title = new String[colNum];
        for (int i = 0; i < colNum; i++) {
            title[i] = getCellFormatValue(row.getCell(i));
        }
        return title;
    }

    /**
     * @Title: readExcelByPoi 
     * @Description: 通过POI读取Excel文件的内容
     * @param file 待读取的文件
     * @return
     * @throws Exception
     */
    public static List<List<List<String>>> readExcelByPoi(File file) throws Exception {
        List<List<List<String>>> dataList = new ArrayList<List<List<String>>>();
        boolean isE2007 = false;    //判断是否是excel2007格式  
        if(file.getPath().toUpperCase().endsWith("XLSX")){
        	isE2007 = true;  
        }else if(file.getPath().toUpperCase().endsWith("XLS")){
        }else{
        	return dataList;
        }
        
        InputStream is = new FileInputStream(file);
        org.apache.poi.ss.usermodel.Workbook  wb = null;
        if(isE2007)  
        	wb = new XSSFWorkbook(is);//解析xlsx格式   
        else  
        	wb = new HSSFWorkbook(is);  
        
        int sheetNum = wb.getNumberOfSheets();
        
        for (int i = 0; i < sheetNum; i++) {
        	org.apache.poi.ss.usermodel.Sheet  sheet = wb.getSheetAt(i);
            if (sheet == null) {
                continue;
            }
            // 得到总行数
            int rowNum = sheet.getLastRowNum();
            
            Row  row = sheet.getRow(0);
            if (row == null) {
                continue;
            }
            // 得到总列数
            int colNum = row.getPhysicalNumberOfCells();
            
            List<List<String>> rowList = new ArrayList<List<String>>();
            // 循环行Row
            for (int j = 0; j <= rowNum; j++) {
                row = sheet.getRow(j);
                if (row == null) {
                    continue;
                }
                List<String> cellList = new ArrayList<String>();
                int k = 0;
                while (k < colNum) {
                    String cellValue = getCellFormatValue(row.getCell(k)).trim();
                    cellList.add(cellValue);
                    k++;
                }
                rowList.add(cellList);
            }
            dataList.add(rowList);
        }
        
        return dataList;
    }

    /**
     * @Title: getCellFormatValue 
     * @Description: 获取单元格数据内容为字符串类型的数据
     * @param cell Excel单元格
     * @return 单元格数据内容
     */
    private static String getCellFormatValue(org.apache.poi.ss.usermodel.Cell cell) {
        String cellvalue = "";
        if (cell != null) {
            // 判断当前Cell的Type
            switch (cell.getCellType()) {
            // 如果当前Cell的Type为NUMERIC
            case HSSFCell.CELL_TYPE_NUMERIC:
                // 取得当前Cell的数值
                cellvalue = decimalFormat.format(cell.getNumericCellValue());
                break;
            case HSSFCell.CELL_TYPE_FORMULA: {
                // 判断当前的cell是否为Date
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    // 如果是Date类型则，转化为Data格式
                    
                    //方法1：这样子的data格式是带时分秒的：2011-10-12 0:00:00
                    //cellvalue = cell.getDateCellValue().toLocaleString();
                    
                    //方法2：这样子的data格式是不带带时分秒的：2011-10-12
                    Date date = cell.getDateCellValue();
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    cellvalue = sdf.format(date);
                }
                else {
                    FormulaEvaluator evaluator = cell.getSheet().getWorkbook().getCreationHelper().createFormulaEvaluator();
                    CellValue cellValue = evaluator.evaluate(cell);
                    switch (cellValue.getCellType()) {
                    case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_BOOLEAN:
                        cellvalue = String.valueOf(cellValue.getBooleanValue());
                        break;
                    case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_NUMERIC:
                        cellvalue = decimalFormat.format(cellValue.getNumberValue());
                        break;
                    case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_STRING:
                        cellvalue = String.valueOf(cellValue.getStringValue());
                        break;
                    case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_BLANK:
                        break;
                    case org.apache.poi.ss.usermodel.Cell.CELL_TYPE_ERROR:
                        break;
                    }
                }
                break;
            }
            // 如果当前Cell的Type为STRIN
            case HSSFCell.CELL_TYPE_STRING:
                // 取得当前的Cell字符串
                cellvalue = cell.getRichStringCellValue().getString();
                break;
            // 默认的Cell值
            default:
                cellvalue = "";
            }
        } else {
            cellvalue = "";
        }
        return cellvalue;
    }
}