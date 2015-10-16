<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 15/10/8
  Time: 上午10:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>  <!--记住设置显示格式-->
<html>
<head>
<base href="${pageContext.request.contextPath}/">
<meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>首页</title>

  <!-- 新 Bootstrap 核心 CSS 文件 -->
  <link rel="stylesheet" href="css/custom.css">  <!--上面引用了base标签，进行了路径的导入，这里可以用相对路径了 -->
  <!-- Bootstrap core CSS -->
  <link href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="navbar-fixed-top.css" rel="stylesheet">

  <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
  <!--[if lt IE 9]><script src="../../assets/js/ie8-responsive-file-warning.js"></script><![endif]-->

  <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="//cdn.bootcss.com/html5shiv/3.7.2/html5shiv.min.js"></script>
  <script src="//cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
  <![endif]-->

    <title></title>
  <script>
<%--初始化  原始使用Ajax方法--%>
    function initAjax() {
      var xmlHttp;
      if (window.XMLHttpRequest) {
        xmlHttp = new XMLHttpRequest();
      } else if (window.ActiveXObject) {
        try {
          xmlHttp = new ActiveXObject("Msxm12.XMLHTTP");
        } catch (e) {
          try {
            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
          } catch (e) {
            window.alert("该浏览器不支持AJAX");
          }
        }
      }
      return xmlHttp;
    }
// 加载种类
    function loadKind() {
	
      var xmlHttp = initAjax();
      var url = "/StoreHouse/operateGoods/getGoodsKind";
      xmlHttp.open("GET", url, true);
 
      xmlHttp.onreadystatechange = function () {
 // 拆分响应内容
        if (xmlHttp.readyState == 4&&xmlHttp.status==200) {
  
          var allKinds = xmlHttp.responseText;
          var kindsArr = allKinds.split("*");
          
          var kindSel = document.getElementById("select");
          
	for(var i=0;i<kindsArr.length;i++){
	
		if (i==0){
			kindSel.add(new Option(kindsArr[i],kindsArr[i]),true,true);
		}else{
			kindSel.add(new Option(kindsArr[i],kindsArr[i]));
		}
	
	}
          

        }
      };
      xmlHttp.send();
    }
    function focusCursor(){
      var name = document.addGoods.name;
      name.focus();
    }

//   判断
    function validateInput(element){
      var content = element.value;
      var submitBtn = document.getElementById("submit");
      if(content=="" || content==undefined || content==null){
        element.style.borderColor="#FF0000";
        element.placeholder="不为空";

//        submitBtn.hidden=true;
        $("#submit").attr("disabled","disabled");
      }else{
        element.style.borderWidth=1;
        element.style.borderColor="000000";
//        submitBtn.hidden=false; // 可提交
        $("#submit").removeAttr("disabled");
      }
    }

// 计算总价
    function caculateSumPrice(){
      var element = document.addGoods.sumPrice;
      var price = document.addGoods.price.value;
      var number = document.addGoods.num.value;

      element.value = price * number;
    }





  </script>

</head>

<body onload="focusCursor();loadKind()">
<%
  String status = (String)session.getAttribute("status");
  if (status!=null && status.equals("1")){
    out.println("<script>alert(\"成功\")</script>");
  }
%>

<nav class="navbar navbar-default navbar-fixed-top" id="custom_nav">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>

    <div id="navbar" class="navbar-collapse collapse">

      <ul class="nav navbar-nav navbar-left">
        <li><a href="/StoreHouse/goods">首页</a></li>
      </ul>

      <ul class="nav navbar-nav navbar-right">

        <li ><a onclick="">新增</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">查询 <span class="caret"></span></a>
          <ul class="dropdown-menu">
            <li><a href="#">精确查找</a></li>
            <li><a href="#">高级查找</a></li>
          </ul>
        </li>
      </ul>
    </div>

  </div>
</nav>


<div class="container" style="padding-top: 55px; margin: 0 auto;" >
<form name="addGoods" action="/StoreHouse/operateGoods/uploadGoods" method="post">
  
  <select id="select" name="kind" class="col-xs-1 col-md-1 col-sm-1">
  </select>
  <input name="name" class="col-xs-1 col-md-1 col-sm-1" type="text" onblur="validateInput(this)" >
  <input name="price" class="col-xs-1 col-md-1 col-sm-1" type="number" onblur="validateInput(this)" >
  <input name="num" class="col-xs-1 col-md-1 col-sm-1" type="number" onblur="validateInput(this);caculateSumPrice()" >
  <input name="remark" class="col-xs-1 col-md-1 col-sm-1" type="text" >
  <input type="hidden" name="sumPrice" ><!--总价-->
  <input type="submit" value="添加" id="submit">

</form>
</div>


<!-- Bootstrap core JavaScript
   ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
