class @MixController extends RouteController
	data: ->
		mixTargetList: MixCollection.getMixList()
		
Template.mix.events "click .mix-btn": ->
	# alert "mix click"
	MixCollection.mix @type, @targetId