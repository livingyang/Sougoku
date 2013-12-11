class @MixController extends RouteController
	data: ->
		mixTargetList: MixCollection.getMixList()
		
Template.mix.events "click .mix-btn": ->
	MixCollection.mix @type, @targetId