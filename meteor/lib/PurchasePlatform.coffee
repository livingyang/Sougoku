if Meteor.isClient

	@PurchasePlatformCreator = PurchasePlatformCreator = class
		constructor: (@cordovaWindow, @options) ->
			@cordovaWindow.document.addEventListener "deviceready", @onDeviceReady

		onDeviceReady: =>
			@cordova = @cordovaWindow.cordova
			# alert "PurchasePlatform onDeviceReady"
			@cordova.exec @onGetInfo, @onGetInfoError, "PurchasePlatform", "getInfo", ["getInfo"]
		
		onGetInfo: (info) =>
			if PurchasePlatform[info?.type]?
				PurchasePlatform.instance = new PurchasePlatform[info.type] @options[info.type], @cordovaWindow.cordova, info
				alert "PurchasePlatform.instance: #{info.type}"

		onGetInfoError: (error) -> alert JSON.stringify error

	class PurchasePlatformOperator
		constructor: (@options, @cordova, @info) ->
			@init options

		init: (options) ->
			@cordova.exec (->), (->), "PurchasePlatform", "init", [options]

		login: (params) ->
			@cordova.exec @loginSuccess, @loginFail, "PurchasePlatform", "login", params
		relogin: (params) ->
			@cordova.exec @loginSuccess, @loginFail, "PurchasePlatform", "relogin", params
		purchase: (params) ->
			@cordova.exec @purchaseSuccess, @purchaseFail, "PurchasePlatform", "purchase", params
		
		loginSuccess: (obj) ->
			alert "loginSuccess: #{JSON.stringify obj}"
		loginFail: (obj) ->
			alert "loginFail: #{JSON.stringify obj}"
		purchaseSuccess: (obj) ->
			alert "purchaseSuccess: #{JSON.stringify obj}"
		purchaseFail: (obj) ->
			alert "purchaseFail: #{JSON.stringify obj}"

	@PurchasePlatform = PurchasePlatform =

		test: class extends PurchasePlatformOperator
			login: ->
				super []
			relogin: ->
				super []
			purchase: ->
				super []
		
		91: class extends PurchasePlatformOperator
			login: ->
				super []
			relogin: ->
				super []
			purchase: (orderId) ->
				super [orderId]

			loginSuccess: (obj) ->
				super
			loginFail: (obj) ->
				super
			purchaseSuccess: (obj) ->
				super
			purchaseFail: (obj) ->
				super

		pp: class extends PurchasePlatformOperator
			login: ->
				super []
			relogin: ->
				super []
			purchase: (orderId) ->
				super [orderId]

			loginSuccess: (obj) ->
				super
			loginFail: (obj) ->
				super
			purchaseSuccess: (obj) ->
				super
			purchaseFail: (obj) ->
				super

# if Meteor.isServer
# 	console.log "Meteor.isServer"