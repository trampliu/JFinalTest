<%@ page import="java.util.ArrayList" %>


<%--
  Created by IntelliJ IDEA.
  User: leo
  Date: 15/9/30
  Time: 上午10:41
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
    function modifyList(ID){
      window.location.href="/StoreHouse/operateGoods/modifyGoods?ID="+ID;
    }

    function deleteList(ID){

//      alert(ID);

      $.ajax({

        type: 'POST',

        url: "operateGoods/deleteGoods" ,

        data: {ID:ID},

        success: function (data) {
        	if(data.status == 1){
        		document.getElementById(ID).remove();
        	}else{
        		alet("删除失败");
        	}
        }

      });
    }
    
  </script>



</head>
<body>


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

    <div id="navbar" class="navbar-collapse collapse navbar-right">
      <ul class="nav navbar-nav">

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
<div class="container" style="padding-top: 55px;">

    <c:forEach items="${sessionScope.Goods}" var = "goods">

      <div class="row" id="${goods.id}">
        <div class="col-xs-1 col-md-1 col-sm-1">
        ${goods.id}
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
        ${goods.kind}
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
        ${goods.name}
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
        ${goods.price}
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
        ${goods.num}
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
        ${goods.sumPrice}
        </div>
        <div class="col-xs-2 col-md-2 col-sm-2">
        ${goods.remark}
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
          <button onclick="modifyList(${goods.id})">修改</button>
        </div>
        <div class="col-xs-1 col-md-1 col-sm-1">
          <button onclick="deleteList(${goods.id})">删除</button>
        </div>
      </div>
    </c:forEach>
</div>



<form method="post" enctype="multipart/form-data" action="/StoreHouse/goods/uploadFile">
	<input type="file" id="file" name="file" style="display:inline">
    <input type="submit" id="btn" value="上传">
</form>



<footer class="footer">
<div class="container" id="page">
	<a href="goods?index=1">首页</a>
	<c:if test="${currentPageIndex!=1}">
		<a href="goods?index=${currentPageIndex-1}">上一页</a>
	</c:if>
	<c:if test="${currentPageIndex!=count}">
		<a href="goods?index=${currentPageIndex+1}">下一页</a>
	</c:if>
	<a href="goods?index=${count}">尾页</a>
</div>
</footer>


<!-- Bootstrap core JavaScript
   ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
<script src="../../assets/js/ie10-viewport-bug-workaround.js"></script>
</body>
</html>
