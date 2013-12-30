###
class @FriendListController 朋友列表
###

class @FriendListController extends RouteController
	data: ->
		myRequestFriendList: for request in FriendCollection.getMyRequestFriendList()
			request.requestUser = FriendCollection.getUserInfo request.targetId
			request

		acceptFriendList: for request in FriendCollection.getAcceptFriendList()
			request.requestUser = FriendCollection.getUserInfo request.senderId
			request

Template.friendList.events "click .deleteFriend": ->
	FriendCollection.removeRequest @_id
	# alert "click deleteFriend, _id: #{@_id}"

###
class @StrangerListController 陌生人列表
###

class @StrangerListController extends RouteController
	data: ->
		# strangerList: Meteor.users.find _id: $ne: Meteor.userId()
		strangerList: FriendCollection.getStrangeList()

Template.strangerList.events "click .add": ->
	# alert "add id: #{@_id} name: #{@profile.name}"
	FriendCollection.requestFriend @_id

###
class @FriendRequestListController 请求列表
###

class @FriendRequestListController extends RouteController
	data: ->
		myRequestList: for request in FriendCollection.getMyRequestList()
			request.requestUser = FriendCollection.getUserInfo request.targetId
			request
		othersRequestList: for request in FriendCollection.getOthersRequestList()
			request.requestUser = FriendCollection.getUserInfo request.senderId
			request

Template.friendRequestList.events "click .deleteRequest": ->
	# alert "delete targetId: #{@targetId}"
	FriendCollection.removeRequest @_id

Template.friendRequestList.events "click .acceptRequest": ->
	# alert "accept senderId: #{@senderId}"
	FriendCollection.acceptRequest @_id

Template.friendRequestList.events "click .rejectRequest": ->
	# alert "delete senderId: #{@senderId}"
	FriendCollection.removeRequest @_id