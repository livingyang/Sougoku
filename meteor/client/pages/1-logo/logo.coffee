class @LogoController extends RouteController
	after: ->
		# alert HasCordovaWindow()
		if HasCordovaWindow() is true
			Meteor.logout ->
				Router.go "cordovaLogin"
		else
			Router.go "webLogin"