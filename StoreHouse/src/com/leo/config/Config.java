package com.leo.config;


import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.kit.PropKit;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import com.leo.controller.OperateGoods;
import com.leo.controller.ShowGoodsController;
import com.leo.model.Goods;
import com.leo.model.Kinds;


public class Config extends JFinalConfig{

	@Override
	public void configConstant(Constants arg0) {
		// TODO Auto-generated method stub
		PropKit.use("sql.property");
		arg0.setDevMode(true);
		arg0.setViewType(ViewType.JSP);
		arg0.setBaseViewPath("WEB-INF/view");
		arg0.setEncoding("UTF-8");
		
	}

	@Override
	public void configHandler(Handlers arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void configInterceptor(Interceptors arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void configPlugin(Plugins arg0) {
		// TODO Auto-generated method stub
		C3p0Plugin cp = new C3p0Plugin(PropKit.get("jdbcUrl"),PropKit.get("user"),PropKit.get("pass"));
        cp.setDriverClass(PropKit.get("driver"));
        arg0.add(cp);


        ActiveRecordPlugin activeRecordPlugin = new ActiveRecordPlugin(cp);
        arg0.add(activeRecordPlugin);
        activeRecordPlugin.addMapping("goods", Goods.class);
        activeRecordPlugin.addMapping("goodskind",Kinds.class);

	}

	@Override
	public void configRoute(Routes arg0) {
		// TODO Auto-generated method stub
		arg0.add("/goods",ShowGoodsController.class,"/");
		arg0.add("/operateGoods",OperateGoods.class,"/");
		
	}
	
}
