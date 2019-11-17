package plugin;

import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.Map;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;
import util.CommonUtil;

public class ExportExcel {
	
	/**
	 * 
	 * @param list
	 * @param headers
	 * @param flds
	 * @param url
	 * @param os
	 * @return
	 */ 
	public static InputStream exportExc(List list, List headers, String[] flds, String url, OutputStream os) {
		System.out.println("exportExc ...");
		InputStream is = null;
		// 准备设置excel工作表的标题
		try {
			// 创建Excel工作薄
			WritableWorkbook wwb;
			// 新建立一个jxl文件,即在e盘下生成testJXL.xls
			// OutputStream os = new ByteArrayOutputStream();
			wwb = Workbook.createWorkbook(os);
			// 添加第一个工作表并设置第一个Sheet的名字
			WritableSheet sheet = wwb.createSheet(url, 0);
			Label label = null;
			jxl.write.WritableCellFormat cellFormat = new jxl.write.WritableCellFormat();
			cellFormat.setAlignment(Alignment.CENTRE);
			cellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
			String cellText = null;
			int rowStart = 0, colStart = 0, rows = 0, cols = 0;
			int ltx = 0, 	//要合并的左上角的单元格的列号 left top
				lty = 0, 	//要合并的左上角的单元格的行号
				rdx = 0, 	//要合并的右下角的单元格的列号 
				rdy = 0,	//要合并的右下角的单元格的行号 right bottom
				dataStartRowNum = 0;
			for (int i = 0; i < headers.size(); i++) {
				String[] cells = ((String)headers.get(i)).split(",");
				for (int j = 0; j < cells.length; j ++) {
					String[] cellSplits = cells[j].split(":");
					cellText = cellSplits[0];
					if (cellSplits.length == 4) {
						// 格式     title::rows:cols
						rows = Integer.parseInt(cellSplits[2]);
						cols = Integer.parseInt(cellSplits[3]);
						label = new Label(colStart, i, cellText,cellFormat);
						ltx = colStart;
					} else {
						rows = 1;
						cols = 1;
						label = new Label(Integer.parseInt(cellSplits[1]), i, cellText, cellFormat);
						ltx = Integer.parseInt(cellSplits[1]);
					}
					
					sheet.addCell(label);
					if (rows > 1 || cols >1) {
						lty = i;
						rdx = ltx + cols - 1;
						rdy = lty + rows - 1;	
//						System.out.println("ltx="+ltx+" lty="+lty+" rdx="+rdx+"  rdy="+rdy);
						sheet.mergeCells(ltx, lty, rdx, rdy);
					}
					colStart += cols;
				}
				colStart = 0;
			}
			
			// 下面是填充数据
			/*
			 * 保存数字到单元格，需要使用jxl.write.Number 必须使用其完整路径，否则会出现错误
			 */
			dataStartRowNum = sheet.getRows();  // 获取表格的行数，即表头行数，然后紧接着表头开始插入数据
			String field = null;
			for (int i = 0; i < list.size(); i++) {
				for (int j = 0; j < flds.length; j++) {
					Map<String, Object> map = (Map<String, Object>) list.get(i);
					field = flds[j].trim();
					Object fieldValue = map.get(field);
					fillCell(sheet, dataStartRowNum, i, j, fieldValue);
				}
			}
			os.flush();
			// 写入数据
			wwb.write();
			// 关闭文件
			wwb.close();
			os.close();
			/*
			 * byte[] buff = new byte[1024]; is = new
			 * ByteArrayInputStream(buff); while (is.read(buff) != -1) {
			 * os.write(buff); }
			 */
			// os.close();

		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return is;
	}

	/**
	 * 导出excel
	 * @param top 表格上面的部分
	 * @param list  数据
	 * @param title	表头
	 * @param fields	数据字段
	 * @param url
	 * @param os
	 * @param mergeCells 需要合并的数据单元格
	 * @return
	 */
	public static InputStream exportUnExc(String top, String tail, List list, String[] title, String[] fields, String url, OutputStream os, String mergeCells) {
		System.out.println("exportUnExc...");
		String[] tops = null, tails = null;
		String[] header = null;
		InputStream is = null;
		// 准备设置excel工作表的标题
		try {
			// 创建Excel工作薄
			WritableWorkbook wwb;
			// 新建立一个jxl文件,即在e盘下生成testJXL.xls
			// OutputStream os = new ByteArrayOutputStream();
			wwb = Workbook.createWorkbook(os);
			// 添加第一个工作表并设置第一个Sheet的名字
			WritableSheet sheet = wwb.createSheet(url, 0);
			Label label = null;
			jxl.write.WritableCellFormat cellFormat = new jxl.write.WritableCellFormat();
			cellFormat.setAlignment(Alignment.CENTRE);
			cellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
			int dataStartRowNum = 0,
				ltx = 0, 	//要合并的左上角的单元格的列号
				lty = 0, 	//要合并的左上角的单元格的行号
				ldx = 0, 	//要合并的右下角的单元格的列号
				ldy = 0;	//要合并的右下角的单元格的行号;
			
			if (CommonUtil.isNotEmptyString(top)) {
				tops = top.split(",");
				String[] topEles = null;
				String text = null;
				int colStart = 0, rowStart = 0, cols = 0, rows = 0;
				for (int i =0; i < tops.length; i++) {
					topEles = tops[i].split(":");

					text = topEles[0];
					colStart = Integer.parseInt(topEles[1]);
					rowStart = Integer.parseInt(topEles[2]);
					cols = Integer.parseInt(topEles[3]);
					rows = Integer.parseInt(topEles[4]);
					label = new Label(colStart, rowStart, text, cellFormat);
					sheet.addCell(label);
					if(cols > 1 || rows > 1){
						sheet.mergeCells(colStart, rowStart, colStart + cols -1, rowStart + rows - 1);
					}
				}
			}
			dataStartRowNum = sheet.getRows();  // 获取表格的行数
			for (int i = 0; i < title.length; i++) {
				if (title[i].contains(":")) {
					header = title[i].split(":");
					label = new Label(Integer.parseInt(header[1]), Integer.parseInt(header[2]) + dataStartRowNum , header[0]);
				} else {
					label = new Label(i, 0 + dataStartRowNum, title[i]);
				}
				// 将定义好的单元格添加到工作表中
				sheet.addCell(label);
				if (header != null && header.length > 3) {
					ltx = Integer.parseInt(header[1]);
					lty = Integer.parseInt(header[2]) + dataStartRowNum;
					ldx = Integer.parseInt(header[3]) == 1? ltx: ltx + Integer.parseInt(header[3]) - 1;
					ldy = Integer.parseInt(header[4]) == 1? lty: lty + Integer.parseInt(header[4]) - 1;
					label.setCellFormat(cellFormat);
					if (ldx-ltx>0 || ldy-lty > 0) {
						sheet.mergeCells(ltx, lty, ldx, ldy);
					}
				}
			}
			/*
			 * 下面是填充数据
			 * 保存数字到单元格，需要使用jxl.write.Number 必须使用其完整路径，否则会出现错误
			 */
			dataStartRowNum = sheet.getRows();  // 获取表格的行数，即表头行数，然后紧接着表头开始插入数据
			for (int i = 0; i < list.size(); i++) {
				for (int j = 0; j < fields.length; j++) {
					String str = "";
					Map<String, Object> map = null;
					Object obj = null;
					Object valObj = null;
					//判断是否是map元素，如果是则从map对象里取每一个元素，否则从Object中取
					if (list.get(i) instanceof Map) {
						map = (Map<String, Object>) list.get(i);
						valObj = map.get(fields[j]);
					} else {
						obj = list.get(i);
						Method m = obj.getClass().getMethod("get"+fields[j].trim().replaceFirst(fields[j].trim().substring(0, 1), fields[j].trim().substring(0, 1).toUpperCase()));
						valObj = m.invoke(obj);
					}
					fillCell(sheet, dataStartRowNum, i, j, valObj);
				}
			}
			//查看是否有需要合并的数据单元格，如果有则合并
			if (CommonUtil.isNotEmptyString(mergeCells)) {
				String[] merges = mergeCells.split(",");
				String[] mergeCell = null;
				for (int i = 0; i < merges.length; i++) {
					mergeCell = merges[i].split(":");
					ltx = Integer.parseInt(mergeCell[0]);	
					lty = Integer.parseInt(mergeCell[1]) + dataStartRowNum; 	
					ldx = Integer.parseInt(mergeCell[0]) + Integer.parseInt(mergeCell[2]) - 1; 	
					ldy = Integer.parseInt(mergeCell[1]) + Integer.parseInt(mergeCell[3]) + dataStartRowNum - 1; 
					sheet.mergeCells(ltx, lty, ldx, ldy);
					sheet.getWritableCell(ltx, lty).setCellFormat(cellFormat);
				}
			}
			dataStartRowNum = sheet.getRows() + 2;
			if (CommonUtil.isNotEmptyString(tail)) {
				tails = tail.split(",");
				String[] tailEles = null;
				String text = null;
				int colStart = 0, rowStart = 0, cols = 0, rows = 0;
				for (int i =0; i < tails.length; i++) {
					tailEles = tails[i].split(":");

					text = tailEles[0];
					colStart = Integer.parseInt(tailEles[1]);
					rowStart = Integer.parseInt(tailEles[2]) + dataStartRowNum ;
					cols = Integer.parseInt(tailEles[3]);
					rows = Integer.parseInt(tailEles[4]);
					label = new Label(colStart, rowStart, text, cellFormat);
					sheet.addCell(label);
					if(cols > 1 || rows > 1){
						sheet.mergeCells(colStart, rowStart, colStart + cols -1, rowStart + rows - 1);
					}
				}
			}
			
			os.flush();
			// 写入数据
			wwb.write();
			// 关闭文件
			wwb.close();
			os.close();
			/*
			 * byte[] buff = new byte[1024]; is = new
			 * ByteArrayInputStream(buff); while (is.read(buff) != -1) {
			 * os.write(buff); }
			 */
			// os.close();

		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return is;
	}
	
	private static void fillCell(WritableSheet sheet, int dataStartRowNum,
			int row, int col, Object fieldValue) throws WriteException,
			RowsExceededException {
		Label label;
		String str;
		jxl.write.Number number;
		double convertedValue;
		if (fieldValue instanceof BigDecimal) {
			convertedValue = fieldValue == null ? 0.0f : ((BigDecimal)fieldValue).doubleValue();
			number = new Number(col, row + dataStartRowNum, convertedValue);
			sheet.addCell(number);
		}
		if (fieldValue instanceof BigInteger) {
			convertedValue = fieldValue == null ? 0.0f : ((BigInteger)fieldValue).doubleValue();
			number = new Number(col, row + dataStartRowNum, convertedValue);
			sheet.addCell(number);
		}
		if (fieldValue instanceof Long) {
			convertedValue = fieldValue == null ? 0.0f : ((Long)fieldValue).doubleValue();
			number = new Number(col, row + dataStartRowNum, convertedValue);
			sheet.addCell(number);

		}
		if (fieldValue instanceof Integer) {
			convertedValue = fieldValue == null ? 0.0f : ((Integer)fieldValue).doubleValue();
			number = new Number(col, row + dataStartRowNum, convertedValue);
			sheet.addCell(number);
			
		}
		if (fieldValue instanceof Double) {
			convertedValue = fieldValue == null ? 0.0f : ((Double)fieldValue).doubleValue();
			number = new Number(col, row + dataStartRowNum, convertedValue);
			sheet.addCell(number);
			
		}
		if (fieldValue instanceof Date) {
			str = ((Date) fieldValue == null ? ""
					: (Date) fieldValue).toString();
			label = new Label(col, row + dataStartRowNum, str);
			sheet.addCell(label);
		}
		if (fieldValue instanceof String) {
			label = new Label(col, row + dataStartRowNum, (String) fieldValue);
			sheet.addCell(label);
		}
		if (fieldValue instanceof Character) {
			label = new Label(col, row + dataStartRowNum, fieldValue.toString());
			sheet.addCell(label);
		}
		if (fieldValue!=null && fieldValue instanceof byte[]) {	//导出图片
			WritableImage wi = new WritableImage(col, row + dataStartRowNum, 1, 1,(byte[]) fieldValue);
			sheet.addImage(wi);
			sheet.setRowView(row + dataStartRowNum, 800);	// 设置行高
		}
	}
	
	/**
	 * 导出excel
	 * @param top 表格首部
	 * @param tail 表格尾部
	 * @param list  数据
	 * @param title	表头
	 * @param fields	数据字段
	 * @param url
	 * @param os
	 * @param mergeCells 需要合并的静态数据单元格
	 * @param getMerge   需要合并的动态数据单元格的方法
	 * @param clazz 调用gerMerge方法的实例
	 * @return
	 */
	public static InputStream exportUnExc(String top, String tail, List list, String[] title, String[] fields, String url, OutputStream os, String mergeCells, Method getMerge, Object clazz) {
		System.out.println("exportUnExc...");
		String[] tops = null, tails = null;
		String[] header = null;
		InputStream is = null;
		// 准备设置excel工作表的标题
		try {
			// 创建Excel工作薄
			WritableWorkbook wwb;
			// 新建立一个jxl文件,即在e盘下生成testJXL.xls
			// OutputStream os = new ByteArrayOutputStream();
			wwb = Workbook.createWorkbook(os);
			// 添加第一个工作表并设置第一个Sheet的名字
			WritableSheet sheet = wwb.createSheet(url, 0);
			Label label = null;
			jxl.write.WritableCellFormat cellFormat = new jxl.write.WritableCellFormat();
			cellFormat.setAlignment(Alignment.CENTRE);
			cellFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
			int dataStartRowNum = 0,
				ltx = 0, 	//要合并的左上角的单元格的列号
				lty = 0, 	//要合并的左上角的单元格的行号
				ldx = 0, 	//要合并的右下角的单元格的列号
				ldy = 0;	//要合并的右下角的单元格的行号;
			
			//表格首部  添加内容
			if (CommonUtil.isNotEmptyString(top)) {
				tops = top.split(",");
				String[] topEles = null;
				String text = null;
				int colStart = 0, rowStart = 0, cols = 0, rows = 0;
				for (int i =0; i < tops.length; i++) {
					topEles = tops[i].split(":");

					text = topEles[0];
					colStart = Integer.parseInt(topEles[1]);
					rowStart = Integer.parseInt(topEles[2]);
					cols = Integer.parseInt(topEles[3]);
					rows = Integer.parseInt(topEles[4]);
					label = new Label(colStart, rowStart, text, cellFormat);
					sheet.addCell(label);
					if(cols > 1 || rows > 1){
						sheet.mergeCells(colStart, rowStart, colStart + cols -1, rowStart + rows - 1);
					}
				}
			}
			
			//表格首部 下面添加 表头
			dataStartRowNum = sheet.getRows();  // 获取表格的行数
			for (int i = 0; i < title.length; i++) {
				if (title[i].contains(":")) {
					header = title[i].split(":");
					label = new Label(Integer.parseInt(header[1]), Integer.parseInt(header[2]) + dataStartRowNum , header[0].replaceAll("<br>", ""));
				} else {
					label = new Label(i, 0 + dataStartRowNum, title[i]);
				}
				// 将定义好的单元格添加到工作表中
				sheet.addCell(label);
				if (header != null && header.length > 3) {
					ltx = Integer.parseInt(header[1]);
					lty = Integer.parseInt(header[2]) + dataStartRowNum;
					ldx = Integer.parseInt(header[3]) == 1? ltx: ltx + Integer.parseInt(header[3]) - 1;
					ldy = Integer.parseInt(header[4]) == 1? lty: lty + Integer.parseInt(header[4]) - 1;
					label.setCellFormat(cellFormat);
					if (ldx-ltx>0 || ldy-lty > 0) {
						sheet.mergeCells(ltx, lty, ldx, ldy);
					}
				}
			}
			 //加工数据集  并返回要合并的数据单元格
			if(getMerge!=null && clazz != null){
				mergeCells=(String)getMerge.invoke(clazz, list);
			}
			/*
			 * 填充数据
			 * 保存数字到单元格，需要使用jxl.write.Number 必须使用其完整路径，否则会出现错误
			 */
			dataStartRowNum = sheet.getRows();  // 获取表格的行数，即表头行数，然后紧接着表头开始插入数据
			for (int i = 0; i < list.size(); i++) {
				for (int j = 0; j < fields.length; j++) {
					String str = "";
					Map<String, Object> map = null;
					Object obj = null;
					Object valObj = null;
					//判断是否是map元素，如果是则从map对象里取每一个元素，否则从Object中取
					if (list.get(i) instanceof Map) {
						map = (Map<String, Object>) list.get(i);
						valObj = map.get(fields[j]);
					} else {
						obj = list.get(i);
						Method m = obj.getClass().getMethod("get"+fields[j].trim().replaceFirst(fields[j].trim().substring(0, 1), fields[j].trim().substring(0, 1).toUpperCase()));
						valObj = m.invoke(obj);
					}
					
					if (valObj instanceof BigDecimal) {
						str = ((BigDecimal) valObj == null ? ""
								: (BigDecimal) valObj).toString();
						label = new Label(j, i + dataStartRowNum, str);
						sheet.addCell(label);
					}
					if (valObj instanceof Double) {
						str = ((Double) valObj == null ? ""
								: (Double) valObj).toString();
						label = new Label(j, i + dataStartRowNum, str);
						sheet.addCell(label);
					}
					if (valObj instanceof Integer) {
						str = ((Integer) valObj == null ? ""
								: (Integer) valObj).toString();
						label = new Label(j, i + dataStartRowNum, str);
						sheet.addCell(label);
					}
					if (valObj instanceof Long) {
						str = ((Long) valObj == null ? ""
								: (Long) valObj).toString();
						label = new Label(j, i + dataStartRowNum, str);
						sheet.addCell(label);
					}
					if (valObj instanceof Date) {
						str = ((Date) valObj == null ? ""
								: (Date) valObj).toString();
						label = new Label(j, i + dataStartRowNum, str);
						sheet.addCell(label);
					}
					if (valObj instanceof String) {
						label = new Label(j, i + dataStartRowNum, ((String) valObj).replaceAll("<br>", "\n"));
						sheet.addCell(label);
					}
					if(valObj == null){
						label = new Label(j, i + dataStartRowNum, "");
						sheet.addCell(label);
					}
				}
			}
		   
			//查看是否有需要合并的数据单元格，如果有则合并
			if (CommonUtil.isNotEmptyString(mergeCells)) {
				String[] merges = mergeCells.split(",");
				String[] mergeCell = null;
				for (int i = 0; i < merges.length; i++) {
					mergeCell = merges[i].split(":");
					ltx = Integer.parseInt(mergeCell[0]);	
					lty = Integer.parseInt(mergeCell[1]) + dataStartRowNum; 	
					ldx = Integer.parseInt(mergeCell[0]) + Integer.parseInt(mergeCell[2]) - 1; 	
					ldy = Integer.parseInt(mergeCell[1]) + Integer.parseInt(mergeCell[3]) + dataStartRowNum - 1; 
					sheet.mergeCells(ltx, lty, ldx, ldy);
					sheet.getWritableCell(ltx, lty).setCellFormat(cellFormat);
					
				}
			}
			//表格尾部 添加内容
			dataStartRowNum = sheet.getRows() + 2;
			if (CommonUtil.isNotEmptyString(tail)) {
				tails = tail.split(",");
				String[] tailEles = null;
				String text = null;
				int colStart = 0, rowStart = 0, cols = 0, rows = 0;
				for (int i =0; i < tails.length; i++) {
					tailEles = tails[i].split(":");

					text = tailEles[0];
					colStart = Integer.parseInt(tailEles[1]);
					rowStart = Integer.parseInt(tailEles[2]) + dataStartRowNum ;
					cols = Integer.parseInt(tailEles[3]);
					rows = Integer.parseInt(tailEles[4]);
					label = new Label(colStart, rowStart, text, cellFormat);
					sheet.addCell(label);
					if(cols > 1 || rows > 1){
						sheet.mergeCells(colStart, rowStart, colStart + cols -1, rowStart + rows - 1);
					}
				}
			}
			
			os.flush();
			// 写入数据
			wwb.write();
			// 关闭文件
			wwb.close();
			os.close();
			/*
			 * byte[] buff = new byte[1024]; is = new
			 * ByteArrayInputStream(buff); while (is.read(buff) != -1) {
			 * os.write(buff); }
			 */
			// os.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return is;
	}
	
}
