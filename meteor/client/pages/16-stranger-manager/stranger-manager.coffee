class @StrangerManagerController extends RouteController
	data: ->
		strangerList: Meteor.users.find _id: $ne: Meteor.userId()

Template.strangerManager.events "click .add": ->
	alert "add id: #{@_id} name: #{@profile.name}"