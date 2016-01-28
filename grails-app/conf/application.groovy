
// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.userLookup.userDomainClassName = 'optimize.Optuser'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'optimize.OptuserOptrole'
grails.plugin.springsecurity.authority.className = 'optimize.Optrole'

grails.plugin.springsecurity.apf.postOnly = false
grails.plugin.springsecurity.auth.loginFormUrl = '/optimizelogin'
grails.plugin.springsecurity.auth.ajaxLoginFormUrl = '/optimizelogin'
grails.plugin.springsecurity.failureHandler.defaultFailureUrl = '/optimizelogin'

grails.plugin.springsecurity.controllerAnnotations.staticRules = [
	'/':                ['permitAll'],
	'/optimizelogin':                    ['permitAll'],
	'/optimizelogin.gsp':                ['permitAll'],
	'/error':           ['permitAll'],
	'/index':           ['permitAll'],
	'/index.gsp':       ['permitAll'],
	'/shutdown':        ['permitAll'],
	'/assets/**':       ['permitAll'],
	'/**/js/**':        ['permitAll'],
	'/**/css/**':       ['permitAll'],
	'/**/images/**':    ['permitAll'],
	'/**/favicon.ico':  ['permitAll']
]

