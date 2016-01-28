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

	<h3 style="text-align:center;">登录</h3>
	<div class="seperator"></div><br/><br/>

<form class="form-horizontal" id="loginForm" action="${resource(file: 'j_spring_security_check')}" method="POST" autocomplete="off">
  <div class="form-group">
    <label for="inputEmail3" class="col-sm-2 control-label">用户名：</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="username" name="j_username" placeholder="用户名">
    </div>
  </div>
  <br/>
  <div class="form-group">
    <label for="inputPassword3" class="col-sm-2 control-label">密码：</label>
    <div class="col-sm-10">
      <input type="password" class="form-control" id="password" name="j_password" placeholder="密码">
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <div class="checkbox">
        <label>
          <input type="checkbox" name="_spring_security_remember_me" id="remember_me"> 记住我
        </label>
      </div>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button type="submit" class="btn btn-default btn-block" id="submit">登录</button>
    </div>
  </div>
</form>


	</div>
	</div>
	</div>
	</div>
<script>
	(function() {
		document.forms['loginForm'].elements['j_username'].focus();
	})();
</script>
	</body>
</html>
