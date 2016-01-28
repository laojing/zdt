<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
	</head>
	<body>

	<div class="mainpage">
	<div class="container">
	<div class="row">
	<div class="col-md-12 col-lg-6 col-lg-offset-3">

	<h3 style="text-align:center;">没有权限</h3>

	</div>
	</div>
	</div>
	</div>
	</body>
</html>
		  <sec:ifNotLoggedIn>
		  <li><a href="${createLink([action:'logindex',controller:'index'])}">登录</a></li>
		  </sec:ifNotLoggedIn>
		  <sec:ifLoggedIn>
		  <li><a class="slidenav" href="${resource(file: 'j_spring_security_logout')}">退出</a></li>
		  </sec:ifLoggedIn>

		  <li>
		  <a href="#" class="slidenav" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">功率特性<span class="caret"></span></a>
			<ul class="hid hid1">
			  <li><a href="${createLink([action:'index',controller:'power'])}">功率总览</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'effi',controller:'power'])}">功率排名</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'check',controller:'power'])}">功率查询</a></li>
			</ul>
		  </li>

		  <li class="dropdown">
		  <a href="${createLink([action:'index',controller:'pitch'])}" class="dropdown-toggle dropdown-link" data-hover="dropdown">变桨距<span class="caret"></span></a>
			<ul class="dropdown-menu">
			  <li><a href="${createLink([action:'index',controller:'pitch'])}">变桨距总览</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'real',controller:'pitch'])}">实时曲线</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'fitting',controller:'pitch'])}">曲线拟合</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'compare',controller:'pitch'])}">拟合比较</a></li>
			</ul>
		  </li>


		  <li class="dropdown">
		  <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">风速风向<span class="caret"></span></a>
			<ul class="dropdown-menu">
			  <li><a href="${createLink([action:'index',controller:'wind'])}">总览</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'yaw',controller:'wind'])}">偏航总览</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'lost',controller:'wind'])}">偏航损耗</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'change',controller:'wind'])}">参数调整</a></li>
			</ul>
		  </li>

		  <li><a class="highnav" href="${createLink([action:'index',controller:'sector'])}">扇区管理</a></li>

		  <li class="dropdown">
		  <a href="${createLink([action:'index',controller:'follow'])}" class="dropdown-link" data-hover="dropdown">无功分配<span class="caret"></span></a>
			<ul class="dropdown-menu">
			  <li><a href="${createLink([action:'index',controller:'follow'])}">总览</a></li>
			  <li role="separator" class="divider"></li>
			  <li><a href="${createLink([action:'dist',controller:'follow'])}">无功分配</a></li>
			</ul>
		  </li>
          </ul>


