class @TeamController extends RouteController
	load: ->
		console.log "load"
		console.log TeamCollection.getTeam()
		setTeamCardIdAndCountMap TeamCollection.getTeam()

	unload: ->
		TeamCollection.setTeam getTeamCardIdAndCountMap()

	data: ->
		teamCardList = []
		for cardId, count of getTeamCardIdAndCountMap()
			for i in [0...count]
				teamCardList.push UserCardCollection.getDetailUserCardFromCardId cardId

		totalAttack = 0
		totalDefense = 0

		userCardList: UserCardCollection.getDetailUserCardList()
		teamCardList: teamCardList
		totalAttack: totalAttack
		totalDefense: totalDefense

Template.team.events "click .div-left-card": ->
	if @count > getTeamCardCount @card._id
		addTeamCard @card._id
		console.log getTeamCardIdAndCountMap()
	else
		console.log "enough select card: #{@card._id}"

Template.team.events "click .div-right-card": ->
	removeTeamCard @card._id

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
