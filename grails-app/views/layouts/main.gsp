<!doctype html>
<html lang="zh-CN">
    <head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
        <title>中电投风电场优化系统</title>
        <asset:stylesheet src="bootstrap.min.css"/>
        <asset:stylesheet src="application.css"/>
		<asset:javascript src="jquery-1.11.3.js"/>
		<asset:javascript src="application.js"/>
		<asset:javascript src="sprintf.js"/>
		<asset:javascript src="bootstrap.min.js"/>
    </head>
	<body>

    <nav class="navbar transparent navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="${createLink([action:'index',controller:'index'])}" style="margin-top:-5px;"><img src="${assetPath(src:'logo_small.png')}"></a>
          <a class="navbar-brand hidden-sm" href="${createLink([action:'index',controller:'index'])}">中电投风电场优化系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">

          </ul>
        </div>
      </div>
    </nav>

	<g:layoutBody/>
	<script>
	var homeurl = "${createLink([action:'action',controller:'controller'])}";
	var logout = "${resource(file: 'j_spring_security_logout')}";

	function GetHref ( action, controller ) {
		return homeurl.replace('action',action).replace('controller',controller);
	}
	var cont = '<sec:ifNotLoggedIn>\n' 
			  + '<li><a href="'+GetHref('logindex','index')+'">登录</a></li>\n' 
			  + '</sec:ifNotLoggedIn>\n' 
			  + '<sec:ifLoggedIn>\n' 
			  + '<li><a class="slidenav" href="'+logout+'">退出</a></li>\n' 
			  + '</sec:ifLoggedIn>\n';

	for ( var i=0; i<OptNames.length; i++ ) {
		var len = OptNames[i][1].length;
		if ( len > 0 ) {
			cont += '<li class="dropdown"><a class="dropdown-link" data-hover="dropdown" href="'+GetHref(OptNames[i][0][2],OptNames[i][0][1])+'">'+OptNames[i][0][0]+'<span class="caret"></span></a>\n';
			cont += '<ul class="dropdown-menu">\n';
		} else {
			cont += '<li><a href="'+GetHref(OptNames[i][0][2],OptNames[i][0][1])+'">'+OptNames[i][0][0]+'</a>\n';
		}
		for ( var j=0; j<len; j++ ) {
			cont += '<li><a href="'+GetHref(OptNames[i][1][j][2],OptNames[i][1][j][1])+'">'+OptNames[i][1][j][0]+'</a>\n';
			if ( j < len-1 ) {
				cont += '<li role="separator" class="divider"></li>\n';
			}
		}
		if ( len > 0 ) cont += '</ul>\n';
		cont += '</li>\n'
	}
	$('.navbar-nav').html(cont);

	</script>
	<asset:javascript src="bootstrap-hover-dropdown.min.js"/>
	</body>
</html>
