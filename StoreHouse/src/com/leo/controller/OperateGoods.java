package com.leo.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import com.jfinal.core.Controller;
import com.leo.model.Goods;
import com.leo.model.Kinds;

public class OperateGoods extends Controller{

	public void index(){
		renderJsp("addGoods.jsp");
	}
	
//	add goods to database	

	public void getGoodsKind() throws IOException{
		ArrayList<Kinds> arrayList = (ArrayList<Kinds>) new Kinds().find("select * from goodskind");
		
		StringBuffer kindStr = new StringBuffer();
		
		for (Kinds kind : arrayList) {
			kindStr.append(kind.getKindName()).append("*");
		}

		renderText(kindStr.toString());
	}
	
	
//	add goods
	public void uploadGoods(){
		String kind = getPara("kind");
		String name = getPara("name");
		String price = getPara("price");
		String num = getPara("num");
		String sumPrice = getPara("sumPrice");
		String remark = getPara("remark");
		
		boolean results = new Goods().set("kind", kind).set("name", name).set("price", Float.parseFloat(price))
				.set("num", Integer.parseInt(num)).set("sumprice",Float.parseFloat(sumPrice)).set("remark", remark)
				.save();
		if(results){
			renderJson("status",1);
		}else {
			renderJson("status",0);
		}
		
	}
	
//	modify goods
	public void modifyGoods(){
		String ID = getPara("ID");
		Goods goods = new Goods().findById(Integer.parseInt(ID));
		setSessionAttr("goods", goods);
		render("modifyJsp.jsp");
	}
	
//	updateGoods depend on the goods id
	public void updateGoods(){
		String kind = getPara("kind");
		String name = getPara("name");
		String price = getPara("price");
		String num = getPara("num");
		String sumPrice = getPara("sumPrice");
		String remark = getPara("remark");
		String id = getPara("ID");
		
//		update sql
		boolean results = Goods.goods.findById(Integer.parseInt(id)).set("kind", kind).set("name", name).set("price", Float.parseFloat(price))
		.set("num", Integer.parseInt(num)).set("sumprice",Float.parseFloat(sumPrice)).set("remark", remark).update();
		if(results){
			this.redirect("/goods");
		}else{
			renderText("update failed");
		}
		
		
	}
	
	
//	delete goods
	public void deleteGoods(){
		String ID = getPara("ID");
		boolean results = Goods.goods.deleteById(Integer.parseInt(ID));
		if (results){
			renderJson("status",1);
		}else{
			renderJson("status",0);
		}
	
	}
	
	
}
