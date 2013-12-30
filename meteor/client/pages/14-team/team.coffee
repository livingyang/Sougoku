Template.team.rendered = ->
	$('#div-team').layout
		north__size: .1
		north__spacing_open: 0
		center__childOptions:
			west__size: .5
			west__spacing_open: 0

class @TeamController extends RouteController
	load: ->
		setTeamCardIdAndCountMap TeamCollection.getTeam()

	unload: ->
		TeamCollection.setTeam getTeamCardIdAndCountMap()

	data: ->
		teamCardList = []
		for cardId, count of getTeamCardIdAndCountMap()
			for i in [0...count]
				teamCardList.push UserCardCollection.getDetailUserCardFromCardId cardId

		totalAttack = 0
		totalHealth = 0

		for userCard in teamCardList
			totalAttack += userCard.attack
			totalHealth += userCard.health
		
		userCardList: UserCardCollection.getDetailUserCardList()
		teamCardList: teamCardList
		totalAttack: totalAttack
		totalHealth: totalHealth

Template.team.events "click .div-left-card": ->
	if @count >= 1 > getTeamCardCount @card._id
		addTeamCard @card._id
	else
		console.log "enough select card: #{@card._id}"

Template.team.events "click .div-right-card": ->
	removeTeamCard @card._id

Template.team.events "click #activeCombo": ->
	teamCardIdList = (cardId for cardId, count of getTeamCardIdAndCountMap() when count > 0)
	comboList = ComboCollection.getActiveComboList teamCardIdList
	upPercentInfo = {}
	for combo in comboList
		upPercentInfo[combo.type] = 0 if not upPercentInfo[combo.type]?
		upPercentInfo[combo.type] += Number(combo.upPercent)
	
	alert "Active Combe: #{(ComboCollection.getActiveComboIdList teamCardIdList).join()}, upPercent: #{JSON.stringify upPercentInfo}"

###
Team card count manager
###

keyTeamCardIdAndCountMap = "keyTeamCardIdAndCountMap"

getTeamCardCount = (cardId) ->
	(Session.get keyTeamCardIdAndCountMap)[cardId] ? 0

getTeamCardIdAndCountMap = ->
	Session.get keyTeamCardIdAndCountMap

setTeamCardIdAndCountMap = (map) ->
	Session.set keyTeamCardIdAndCountMap, map

addTeamCard = (cardId) ->
	map = getTeamCardIdAndCountMap() ? {}
	map[cardId] ?= 0
	++map[cardId]
	setTeamCardIdAndCountMap map
	map

removeTeamCard = (cardId) ->
	map = getTeamCardIdAndCountMap() ? {}
	if map[cardId] > 0
		--map[cardId]
		setTeamCardIdAndCountMap map
	map
