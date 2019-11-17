package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Goods;
import cn.nova.bus.pack.service.GoodsService;
import cn.nova.bus.pack.service.impl.GoodsServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class GoodsAction extends BaseAction{
	private List<Map<String, Object>> goodslist;
	private List<Map<String, Object>> goodsnomap;
	
	private String pictureName;
	
	private Goods goods;
	private long goodsid;
	
	private String param;
	
	private GoodsService goodsService;
	
	public String query(){
		goodsService = new GoodsServiceImpl();
		setGoodslist(goodsService.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String saveGoods(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (goods != null) {
					if (goods.getId() != 0) {
						goods.setUpdateby(global.getUserinfo().getId());
						goods.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
						if(goods.getOperator()!=null && goods.getOperator()!=0){
							setMsg("提领成功！");
						}
					} else {
						goods.setOperator(global.getUserinfo().getId());
						goods.setCreateby(global.getUserinfo().getId());
						goods.setCreatetime(new Date());
						goods.setUpdateby(global.getUserinfo().getId());
						goods.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					goodsService = new GoodsServiceImpl();
					goods = goodsService.saveGoods(goods);
					setGoodsid(goods.getId());
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	/**
	 * 作废
	 */
	public String wasteGoods(){
		Global global = CurrentUtil.getGlobal();
		try {
			goods.setUpdateby(global.getUserinfo().getId());
			goods.setUpdatetime(new Date());
			goodsService = new GoodsServiceImpl();
			goodsService.wasteGoods(goods);
			setMsg("废弃成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("废弃失败，" + e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String queryGgoodsno(){
		goodsService = new GoodsServiceImpl();
		setGoodsnomap(goodsService.queryGgoodsno(param,ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	/**
	 * 小件寄存修改的时候下载图片
	 * @return
	 */
	public String downloadGoodsPicture() {
		try {
			goodsService = new GoodsServiceImpl();
			setPictureName(goodsService.downloadGoodsPicture(goodsid));
			markSuccess();
			setMsg("图片下载成功");
		} catch (Exception e) {
			markFail();
			setMsg("下载图片失败");
			e.printStackTrace();
		}
		
		return "json";
	}
	
	public List<Map<String, Object>> getGoodslist() {
		return goodslist;
	}

	public void setGoodslist(List<Map<String, Object>> goodslist) {
		this.goodslist = goodslist;
	}

	public Goods getGoods() {
		return goods;
	}

	public void setGoods(Goods goods) {
		this.goods = goods;
	}

	public long getGoodsid() {
		return goodsid;
	}

	public void setGoodsid(long goodsid) {
		this.goodsid = goodsid;
	}

	public List<Map<String, Object>> getGoodsnomap() {
		return goodsnomap;
	}

	public void setGoodsnomap(List<Map<String, Object>> goodsnomap) {
		this.goodsnomap = goodsnomap;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getPictureName() {
		return pictureName;
	}

	public void setPictureName(String pictureName) {
		this.pictureName = pictureName;
	}

	
}
