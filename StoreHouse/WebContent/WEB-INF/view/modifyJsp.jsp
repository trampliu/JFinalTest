<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 15/9/30
  Time: 上午10:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=utf-8" language="java" %>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<base href="${pageContext.request.contextPath}/">
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>首页</title>

  <!-- 新 Bootstrap 核心 CSS 文件 -->
  <link rel="stylesheet" href="css/custom.css">
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

  <script>
    <%--初始化--%>
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
      var url = "operateGoods/getGoodsKind";
      xmlHttp.open("GET", url, true);
 
      xmlHttp.onreadystatechange = function () {
    	  if (xmlHttp.readyState == 4&&xmlHttp.status==200) {
    		  var allKinds = xmlHttp.responseText;
    		  var kindsArr = allKinds.split("*");
    		  var kindSel = document.getElementById("select");
    		  var selectedValue = document.getElementById("selectedOption").textContent;
    		  for(var i=0;i<kindsArr.length;i++){
    			  var kind = kindsArr[i];
    			  if(selectedValue != kind){
    				  select.add(new Option(kind,kind));
    			  }
    		}
        }
      };
      xmlHttp.send();
    }

    //   判断
    function validateInput(element){
      var content = element.value;
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
      var element = document.modifyGoods.sumPrice;
      var price = document.modifyGoods.price.value;
      var number = document.modifyGoods.num.value;

      element.value = price * number;
    }

    function quitModify(){
      window.location.href="goods";
    }

  </script>

</head>
<body onload="loadKind()">
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
        <li><a href="goods">首页</a></li>
      </ul>

      <ul class="nav navbar-nav navbar-right">

        <li ><a href="operateGoods/">新增</a></li>
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

<%--该方法需要加入 jstl standard 两个包--%>
<div class="container" style="padding-top: 55px; margin: 0 auto;" >

    <c:set value="${goods}" scope="session" var="goods"></c:set>

    <div class="row">
      <form action="operateGoods/updateGoods" method="post" name="modifyGoods">
        <%--disabled 为true后  无法获取到值 改成readonly--%>
        <input  name="ID" readonly="readonly" class="col-xs-1 col-md-1 col-sm-1" type="text" value="<c:out value="${goods.id}"></c:out>">
        <select id="select" name="kind" class="col-xs-1 col-md-1 col-sm-1">
          <option value="<c:out value="${goods.kind}"></c:out>" id="selectedOption"><c:out value="${goods.kind}"></c:out></option>
        </select>

        <input name="name" class="col-xs-1 col-md-1 col-sm-1" type="text" onblur="validateInput(this)" value="<c:out value="${goods.name}"></c:out>">
        <input name="price" class="col-xs-1 col-md-1 col-sm-1" type="number" onblur="validateInput(this);caculateSumPrice()" value="<c:out value="${goods.price}"></c:out>">
        <input name="num" class="col-xs-1 col-md-1 col-sm-1" type="number" onblur="validateInput(this);caculateSumPrice()" value="<c:out value="${goods.num}"></c:out>">
        <input name="remark" class="col-xs-1 col-md-1 col-sm-1" type="text" value="<c:out value="${goods.remark}"></c:out>">
        <input type="hidden" name="sumPrice" value="<c:out value="${goods.sumPrice}"></c:out>"><!--总价-->
        <input id="submit" class="col-xs-1 col-md-1 col-sm-1" type="submit" value="确定">
        <input class="col-xs-1 col-md-1 col-sm-1" type="button" onclick="quitModify()" value="取消">
      </form>
    </div>
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
