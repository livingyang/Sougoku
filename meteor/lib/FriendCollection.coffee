###
@FriendCollection 朋友集合
###

@FriendCollection = new Meteor.Collection "friend"

FriendCollection.requestFriend = (targetUserId, userId = Meteor.userId()) ->
	@insert
		_id: userId + targetUserId
		senderId: userId
		targetId: targetUserId
		isAccept: false

FriendCollection.getUserInfo = (userId = Meteor.userId()) ->
	Meteor.users.findOne _id: userId

FriendCollection.getMyRequestFriendList = (userId = Meteor.userId()) ->
	(@find senderId: userId, isAccept: true).fetch()

FriendCollection.getAcceptFriendList = (userId = Meteor.userId()) ->
	(@find targetId: userId, isAccept: true).fetch()

FriendCollection.getMyRequestList = (userId = Meteor.userId()) ->
	(@find senderId: userId, isAccept: false).fetch()

FriendCollection.getOthersRequestList = (userId = Meteor.userId()) ->
	(@find targetId: userId, isAccept: false).fetch()

FriendCollection.getStrangeList = (userId = Meteor.userId()) ->
	notStrangeIdList = [userId]
	(@find senderId: userId).forEach (request) ->
		notStrangeIdList.push request.targetId

	(@find targetId: userId).forEach (request) ->
		notStrangeIdList.push request.senderId

	(Meteor.users.find _id: $nin: notStrangeIdList).fetch()

FriendCollection.acceptRequest = (requestId) ->
	@update {_id: requestId}, {$set: isAccept: true}
	
FriendCollection.removeRequest = (requestId) ->
	@remove _id: requestId
