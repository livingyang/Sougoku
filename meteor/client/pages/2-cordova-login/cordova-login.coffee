
Template.cordovaLogin.events "click #login": =>
	console.log "You pressed the button"
	@PurchasePlatform.instance.login()

Template.cordovaLogin.events "click #relogin": =>
	console.log "You pressed the button"
	@PurchasePlatform.instance.relogin()

Template.cordovaLogin.events "click #purchase": =>
	console.log "You pressed the button"
	@PurchasePlatform.instance.purchase "ord121212"

class @CordovaLoginController extends RouteController

	# before: ->
	# 	console.log "before"

	# after: ->
	# 	console.log "after"

	run: ->

		Meteor.logout ->
			new PurchasePlatformCreator window.top, 
				91:
					appId: "100010"
					appKey: "C28454605B9312157C2F76F27A9BCA2349434E546A6E9C75"
				pp:
					appId: "76"
					appKey: "04569029582680d7602989feb0a0a7e2"
					isNSLogData: true
					rechargeAmount: 10
					isLongComet: false
					isLogOutPushLoginView: true
					isOpenRecharge: true
					closeRechargeAlertMessage: "关闭充值提示"

		super
