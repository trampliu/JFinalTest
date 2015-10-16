package com.leo.model;

import com.jfinal.plugin.activerecord.Model;

public class Kinds extends Model<Kinds>{
	public final static Kinds kinds = new Kinds();

	public String getKindName(){
		System.out.println(this.getStr("kind"));
		return this.getStr("kind");
	}
}
