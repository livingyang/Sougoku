class @MixController extends RouteController
	data: ->
		mixTargetList: [
			{
				icon: "/item/IT011AB.jpg"
				canMix: true
				mixPartList: [
					{
						icon: "/item/IT012AB.jpg"
						_id: 1
						type: "card"
						curCount: 1
						needCount: 3
					}
					{
						icon: "/item/IT013AB.jpg"
						curCount: 5
						needCount: 4
					}
				]
			}
		]

Template.mix.events "click .mix-btn": ->
	alert "mix click"