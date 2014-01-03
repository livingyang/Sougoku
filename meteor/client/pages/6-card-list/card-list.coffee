
class @CardListController extends RouteController
	data: ->
		cardList = CardCollection.getIsOpenCursor().fetch()
		userCardList = UserCardCollection.getUserCardMap()
		for card in cardList
			card.count = userCardList?[card._id]?.count ? 0
			card.totalCount = userCardList?[card._id]?.totalCount ? 0
			
			card.skill1 = SkillCollection.getSkill card.skillId1
			card.skill2 = SkillCollection.getSkill card.skillId2

		cardList: cardList

Template.cardList.events "click .div-card": ->
	UserCardCollection.addUserCard @_id
