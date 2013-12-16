Template.settings.events "click #rename": ->
	username = $("#name").val()
	Meteor.users.update {_id: Meteor.userId()}, {$set: {"profile.name": username}}