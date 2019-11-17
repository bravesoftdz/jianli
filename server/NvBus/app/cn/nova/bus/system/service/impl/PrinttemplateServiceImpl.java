/**
 * 
 */
package cn.nova.bus.system.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.PrinttemplateDao;
import cn.nova.bus.system.model.Printtemplate;
import cn.nova.bus.system.model.Printtemplateitem;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.bus.system.service.PrinttemplateService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */

public class PrinttemplateServiceImpl implements PrinttemplateService {

	private PrinttemplateDao dao = new PrinttemplateDao();
	
	private final String defaultFontName = "宋体";
	private final int defaultFontSize = 11;
	private final int defaultCharacterWidth = 40;   //单位0.1毫米
	private final int defaultCharacterHeight = 40;   //单位0.1毫米
	private final int defaultRowSpace = 40;   //单位0.1毫米
	private final int defaultWordSpace = 40;   //单位0.1毫米
	private Integer itemleft = 0;
	private Integer itemtop = 0;


	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[]{Printtemplate.class,"printtemplatetypename","createbyname","updatebyname"}, 
				dao.query(propertyFilters), 
				new Object[]{Printtemplate.class,String.class,String.class,String.class});
	}

	@Override
	public List<Map<String, Object>> queryItem(
			List<PropertyFilter> propertyFilters) {
				return ListUtil.listToMap(new Object[] { Printtemplateitem.class,
						"islist", "itemname", "itemcode", "itemtype", "createbyname",
						"updatebyname","picture" }, dao.queryItem(propertyFilters), new Object[] {
						Printtemplateitem.class, Boolean.class, String.class,
						String.class, String.class, String.class, String.class, String.class });
	}

	@Override
	public Printtemplate add(Printtemplate printtemplate, boolean autoGenerateItem, long userid)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!name", printtemplate.getName()));
		List<Printtemplate> printtemplates = dao.query(Printtemplate.class, propertyFilters);
		if(printtemplates!=null && printtemplates.size()>0){
			throw new ServiceException("0025");
		}
		printtemplate.setCreateby(userid);
		printtemplate.setCreatetime(new Date());
		printtemplate.setUpdateby(userid);
		printtemplate.setUpdatetime(new Date());
		if(autoGenerateItem){
			//自动生成打印项目
			List<Printtemplateitem> printtemplateitems = new ArrayList<Printtemplateitem>();
			itemleft = 0;
			itemtop = 0;
			Printtemplatetype printtemplatetype = (Printtemplatetype) dao.get(Printtemplatetype.class, printtemplate.getPrinttemplatetypeid());
			for (Printtemplatetypeitem printtemplatetypeitem : printtemplatetype.getPrinttemplatetypeitems()) {
				Printtemplateitem printtemplateitem = new Printtemplateitem();
				printtemplateitem.setCreateby(userid);
				printtemplateitem.setCreatetime(new Date());
				printtemplateitem.setFontname(defaultFontName);
				printtemplateitem.setFontsize(new BigDecimal(defaultFontSize));
				printtemplateitem.setHeight(defaultCharacterHeight);
				printtemplateitem.setIsprint(true);
				printtemplateitem.setParameter(null);
				printtemplateitem.setPrinttemplate(printtemplate);
				printtemplateitem.setPrinttemplatetypeitem(printtemplatetypeitem);
				printtemplateitem.setTitle(printtemplatetypeitem.getItemname());
				printtemplateitem.setUpdateby(userid);
				printtemplateitem.setUpdatetime(new Date());
				printtemplateitem.setValuetype("2");//字符串
				printtemplateitem.setWidth(printtemplatetypeitem.getItemname().length()*defaultCharacterWidth);
				//添加标签
				Printtemplateitem printtemplateitem_label = new Printtemplateitem(printtemplateitem);
				printtemplateitem_label.setTitle(printtemplateitem_label.getTitle()+":");
				printtemplateitem_label.setValuetype("1");//固定标题
				Printtemplatetypeitem printtemplatetypeitem_label = (Printtemplatetypeitem) dao.get(Printtemplatetypeitem.class,new Long(-1));
				printtemplateitem_label.setPrinttemplatetypeitem(printtemplatetypeitem_label);
				setItemLeftAndTop(printtemplateitem_label,printtemplate.getWidth());
				printtemplateitems.add(printtemplateitem_label);
				
				setItemLeftAndTop(printtemplateitem,printtemplate.getWidth());
				printtemplateitems.add(printtemplateitem);
			}
			printtemplate.setPrinttemplateitems(printtemplateitems);
		}
		return (Printtemplate) dao.merge(printtemplate);
	}
	
	private void setItemLeftAndTop(Printtemplateitem printtemplateitem,int width){
		if(itemleft+printtemplateitem.getTitle().length()*defaultCharacterWidth+defaultWordSpace>width){
			//另起一行
			itemleft = 0;
			itemtop = itemtop + defaultCharacterHeight+ defaultRowSpace;
		}
		printtemplateitem.setLeft(itemleft);
		itemleft = itemleft + printtemplateitem.getTitle().length()*defaultCharacterWidth+defaultWordSpace;
		printtemplateitem.setTop(itemtop);
	}

	@Override
	public Printtemplate udpate(Printtemplate printtemplate, long userid)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!name", printtemplate.getName()));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id", (new Long(printtemplate.getId())).toString()));
		List<Printtemplate> printtemplates = dao.query(Printtemplate.class, propertyFilters);
		if(printtemplates!=null && printtemplates.size()>0){
			throw new ServiceException("0025");
		}
		printtemplate.setUpdateby(userid);
		printtemplate.setUpdatetime(new Date());
		return (Printtemplate) dao.merge(printtemplate);
	}

	@Override
	public boolean delete(Printtemplate printtemplate, long userid) {
		printtemplate = (Printtemplate) dao.get(Printtemplate.class, printtemplate.getId());
		printtemplate.getPrinttemplateitems();
		return dao.del(printtemplate);
	}

	@Override
	public boolean saveItems(List<Printtemplateitem> printtemplateitems,long userid)
			throws ServiceException {
/*
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQO_t!printtemplate", printtemplateitems.get(0).getPrinttemplate()));
		List<Printtemplateitem> _printtemplateitems = dao.query(Printtemplateitem.class, propertyFilters);
		for (Printtemplateitem _printtemplateitem : _printtemplateitems) {
			boolean needdel = true;
			for (Printtemplateitem printtemplateitem : printtemplateitems) {
				if(printtemplateitem.getId()==_printtemplateitem.getId()){
					needdel = false;
					printtemplateitem.setCreateby(_printtemplateitem.getCreateby());
					printtemplateitem.setCreatetime(_printtemplateitem.getCreatetime());
					break;
				}
			}
			if(needdel){
				dao.del(_printtemplateitem);
			}
		}
		for (Printtemplateitem printtemplateitem : printtemplateitems) {
			printtemplateitem.setUpdateby(userid);
			printtemplateitem.setUpdatetime(new Date());
			if(printtemplateitem.getId()<=0){
				printtemplateitem.setCreateby(userid);
				printtemplateitem.setCreatetime(new Date());
			}
			printtemplateitem.setUpdateby(userid);
			printtemplateitem.setUpdatetime(new Date());
			dao.merge(printtemplateitem);
		}
		return true;
		*/
		for (Printtemplateitem printtemplateitem : printtemplateitems) {
			if("2".equals(printtemplateitem.getOpertype())){
				Printtemplateitem _printtemplateitem = (Printtemplateitem) dao.get(Printtemplateitem.class, printtemplateitem.getId());
				dao.del(_printtemplateitem);
			}
			else if("4".equals(printtemplateitem.getOpertype())){
				printtemplateitem.setCreateby(userid);
				printtemplateitem.setCreatetime(new Date());
				printtemplateitem.setUpdateby(userid);
				printtemplateitem.setUpdatetime(new Date());
				Printtemplate printtemplate = new Printtemplate();
				printtemplate.setId(printtemplateitem.getPrinttemplateid());
				printtemplateitem.setPrinttemplate(printtemplate);
				Printtemplatetypeitem printtemplatetypeitem = new Printtemplatetypeitem();
				printtemplatetypeitem.setId(printtemplateitem.getPrinttemplatetypeitemid());
				printtemplateitem.setPrinttemplatetypeitem(printtemplatetypeitem);
				dao.merge(printtemplateitem);
			}
			else if("8".equals(printtemplateitem.getOpertype())){
				Printtemplateitem _printtemplateitem = (Printtemplateitem) dao.get(Printtemplateitem.class, printtemplateitem.getId());
				_printtemplateitem.setUpdateby(userid);
				_printtemplateitem.setUpdatetime(new Date());
				if(printtemplateitem.getIsprint()!=_printtemplateitem.getIsprint()){
					_printtemplateitem.setIsprint(printtemplateitem.getIsprint());
				}
				if(printtemplateitem.getFontname()!=_printtemplateitem.getFontname()){
					_printtemplateitem.setFontname(printtemplateitem.getFontname());
				}
				if(printtemplateitem.getFontsize()!=_printtemplateitem.getFontsize()){
					_printtemplateitem.setFontsize(printtemplateitem.getFontsize());
				}
				if(printtemplateitem.getHeight()!=_printtemplateitem.getHeight()){
					_printtemplateitem.setHeight(printtemplateitem.getHeight());
				}
				if(printtemplateitem.getLeft()!=_printtemplateitem.getLeft()){
					_printtemplateitem.setLeft(printtemplateitem.getLeft());
				}
				if(printtemplateitem.getParameter()!=_printtemplateitem.getParameter()){
					_printtemplateitem.setParameter(printtemplateitem.getParameter());
				}
				if(printtemplateitem.getPrinttemplateid()!=_printtemplateitem.getPrinttemplate().getId()){
					Printtemplate printtemplate = new Printtemplate();
					printtemplate.setId(printtemplateitem.getPrinttemplateid());
					_printtemplateitem.setPrinttemplate(printtemplate);
				}
				if(printtemplateitem.getPrinttemplatetypeitemid()!=_printtemplateitem.getPrinttemplatetypeitem().getId()){
					Printtemplatetypeitem printtemplatetypeitem = new Printtemplatetypeitem();
					printtemplatetypeitem.setId(printtemplateitem.getPrinttemplatetypeitemid());
					_printtemplateitem.setPrinttemplatetypeitem(printtemplatetypeitem);
				}
				if(printtemplateitem.getTitle()!=_printtemplateitem.getTitle()){
					_printtemplateitem.setTitle(printtemplateitem.getTitle());
				}
				if(printtemplateitem.getTop()!=_printtemplateitem.getTop()){
					_printtemplateitem.setTop(printtemplateitem.getTop());
				}
				if(printtemplateitem.getValuetype()!=_printtemplateitem.getValuetype()){
					_printtemplateitem.setValuetype(printtemplateitem.getValuetype());
				}
				if(printtemplateitem.getWidth()!=_printtemplateitem.getWidth()){
					_printtemplateitem.setWidth(printtemplateitem.getWidth());
				}
				/*if(printtemplateitem.getPrintpicture()!=null && printtemplateitem.getPrintpicture().length>0 && !Arrays.equals(printtemplateitem.getPrintpicture(), _printtemplateitem.getPrintpicture()) ){
					_printtemplateitem.setpicture(printtemplateitem.getPrintpicture());
				}*/
				dao.merge(_printtemplateitem);
			}
		}
		return true;
	}

	@Override
	public boolean deleteInVisibleItem(Printtemplate printtemplate,long userid) {
		return dao.deleteInVisibleItem(printtemplate);
	}

	public void setDao(PrinttemplateDao dao) {
		this.dao = dao;
	}

	public PrinttemplateDao getDao() {
		return dao;
	}
	
	/**
	 * 打印模板复制
	 */
	public Printtemplate copyPrinttemplate(Printtemplate printtemplate, Global global) throws ServiceException {
		printtemplate = dao.getEntityManager().find(Printtemplate.class, printtemplate.getId());//通过前台传过来的打印模板id找到打印模板
		Printtemplate newTemplate = (Printtemplate) printtemplate.clone();//clone得到新的打印模板
		//给新打印模板命名
		List printtemplatetypeName = dao.getPrinttemplatetypeName(printtemplate.getPrinttemplatetypeid());
		if(printtemplatetypeName != null && printtemplatetypeName.size() > 0){
			String templateTypeName = (String) ((Object[]) printtemplatetypeName.get(0))[0];// 取打印模板类型名，供模板取名用，新模板名称为：模板类型_流水号
			int index = 1;
			String newTemplateName = templateTypeName + "_" + index;//构造新模板名称
			while(isExsitTemplateName(printtemplatetypeName, newTemplateName)){//判断新模板名称是否已经存在，若存在则需要重新构造
				index++;
				newTemplateName = templateTypeName + "_" + index;
			}
			newTemplate.setName(newTemplateName);
		}else{
			throw new ServiceException("复制模板功能错误：通过打印模板类型查询打印模板类型名称出错！");
		}
		//给新打印模板部分字段赋值
		Date date = new Date();
		newTemplate.setId(0L);//将id置为0，以便后面进行保存操作
		newTemplate.setCreateby(global.getUserinfo().getId());
		newTemplate.setCreatetime(date);
		newTemplate.setUpdateby(global.getUserinfo().getId());
		newTemplate.setUpdatetime(date);
		//1.保存新打印模板
		newTemplate = (Printtemplate) dao.getEntityManager().merge(newTemplate);
//		dao.getEntityManager().flush();
		
		//2. 模板打印项
		List<Printtemplateitem> printtemplateitemList = dao.getItemByTemplateId(printtemplate.getId());//通过打印模板id得到对应的打印项
		copyPrinttemplateitems(printtemplateitemList, global.getUserinfo().getId(), newTemplate);//保存模板打印项
	
		return newTemplate;
	}
	
	/**
	 * 判断该模板名称是否已经存在
	 * @param printtemplatetypeName:数据库已经存在的打印模板名称，现在取的是某种模板类型对应的模板名称，没有取所有模板名称
	 * @param newTemplateName：新模板名称
	 * @return
	 */
	private boolean isExsitTemplateName(List printtemplatetypeName, String  newTemplateName){
		boolean flag = false;
		
		for (int i = 0; i < printtemplatetypeName.size(); i++) {
			if(newTemplateName.equals((String) ((Object[]) printtemplatetypeName.get(i))[1])){
				flag = true;//如果有相同名称，则返回true，执行while循环体
				break;
			}
		}
		return flag;
	}
	
	/**
	 * 复制模板时，保存模板打印项
	 * @param printtemplateitemList
	 * @param userInfoId
	 * @param newTemplate
	 */
	private void copyPrinttemplateitems(List<Printtemplateitem> printtemplateitemList, Long userInfoId,
			Printtemplate newTemplate) throws ServiceException {
		Date date = new Date();
		Printtemplateitem newTemplateItem = null;
		for (Printtemplateitem printtemplateitem : printtemplateitemList) {
			newTemplateItem = (Printtemplateitem) printtemplateitem.clone();
			newTemplateItem.setId(0L);
			newTemplateItem.setCreateby(userInfoId);
			newTemplateItem.setCreatetime(date);
			newTemplateItem.setUpdateby(userInfoId);
			newTemplateItem.setUpdatetime(date);
			newTemplateItem.setPrinttemplate(newTemplate);
			newTemplateItem.setPrinttemplateid(newTemplate.getId());
			dao.merge(newTemplateItem);
		}
	}
	
}
