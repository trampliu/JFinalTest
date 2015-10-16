package com.leo.controller;
import java.util.List;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.upload.UploadFile;
import com.leo.model.Goods;

public class ShowGoodsController extends Controller {
	public void index(){
	
		this.pageInfo();
		
	}
	
//  get info from page index
	
	public void pageInfo(){
		
		String pageIndex = getPara("index");
		if(pageIndex==null){
			pageIndex = "1";
		}
//		find the data from the currentPage
		int currentPageIndex = Integer.parseInt(pageIndex);
		Page<Goods> goodsPage = Goods.goods.paginate(currentPageIndex, 5, "select *", "from goods");
		List<Goods> list = goodsPage.getList();
		
//		get the pageCount
		long count = Db.queryLong("select count(*) from goods");
		long pageCount = count%5 == 0 ? count/5 : count/5+1;
//		record 
		setSessionAttr("count", pageCount);
		setSessionAttr("currentPageIndex", currentPageIndex);
		setSessionAttr("Goods", list);
		
		renderJsp("showGoods.jsp");
		
	}
	
	
	public void uploadFile(){
		UploadFile files = getFile(getPara("file"),"d:/");
		renderJson("");
	}
	
}
