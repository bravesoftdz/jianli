package bp;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import models.Result;
import models.TmpTable;
import play.db.jpa.JPA;
import bpinterface.TmpTableBPInterface;

public class TmpTableBP implements TmpTableBPInterface {

	@Override
	public Result save(TmpTable tmpTable) throws Exception {
		// TODO Auto-generated method stub
		TmpTable tt = tmpTable.save();
		if (tt.getId() > 0) {
			return new Result(true, "添加成功！");
		} else {
			return new Result(false, "添加失败！");
		}
	}

	@Override
	public Result deleteBySessionId(String sessionId) {
		// TODO Auto-generated method stub
		int count = 0;
		String tmpname = null;
		StringBuilder sql = new StringBuilder();
		
		TmpTable tt = TmpTable.find("from TmpTable tt where tt.sessionid=?", sessionId).first();
		if (tt == null) {
			return new Result(true, "删除成功！");
		}
		tmpname = tt.getTablename();
		
		sql.append("declare")
		   .append(" tmp_exist number; ")
		   .append(" begin")
		   .append(" SELECT COUNT(*) into tmp_exist FROM TABS WHERE TABLE_NAME = UPPER('"+tmpname+"');")
		   .append(" if tmp_exist > 0 then")
		   .append(" execute immediate('truncate table "+tmpname+"');")
		   .append(" execute immediate('drop table "+tmpname+"');")
		   .append(" end if;")
		   .append(" end;");
		try{
			System.out.println(sql.toString());
			Query query = JPA.em().createNativeQuery(sql.toString());
			count = query.executeUpdate();
			if (count > 0) {
				TmpTable.delete("delete from TmpTable tt where tt.sessionid=?", sessionId);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return count > 0? new Result(true, "删除成功！"): new Result(false, "删除失败！");
	}

	@Override
	public List getList() {
		return TmpTable.find("from TmpTable tt").fetch();
	}

	@Override
	public Result deleteByDay() {
		int count = 0;
		String tmpname = null;
		
		Date currDate = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		String currDateStr = df.format(currDate);
		try {
			currDate = df.parse(currDateStr);
		} catch (ParseException e1) {
			e1.printStackTrace();
		}
		List<TmpTable> tt = TmpTable.find("from TmpTable tt where tt.createtime < ?",currDate).fetch();
		if (tt == null || tt.size() == 0) {
			return new Result(true, "删除成功！");
		}
		for (int i = 0; i < tt.size(); i++) {
			tmpname = tt.get(i).getTablename();
			StringBuilder sql = new StringBuilder();
			sql.append("declare")
			.append(" tmp_exist number; ")
			.append(" begin")
			.append(" SELECT COUNT(*) into tmp_exist FROM TABS WHERE TABLE_NAME = UPPER('"+tmpname+"');")
			.append(" if tmp_exist > 0 then")
			.append(" execute immediate('truncate table "+tmpname+"');")
			.append(" execute immediate('drop table "+tmpname+"');")
			.append(" end if;")
			.append(" end;");
			try{
				System.out.println(sql.toString());
				Query query = JPA.em().createNativeQuery(sql.toString());
				count = query.executeUpdate();
				if (count > 0) {
					TmpTable.delete("delete from TmpTable tt where tt.createtime < ?",currDate);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return count > 0? new Result(true, "删除成功！"): new Result(false, "删除失败！");
	}
}
