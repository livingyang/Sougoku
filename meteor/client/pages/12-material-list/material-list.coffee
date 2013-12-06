class @MaterialListController extends RouteController
	data: ->
		userMaterial = UserMaterialCollection.getUserMaterialCount() ? {}
		materialList = for material in MaterialCollection.getIsOpenCursor().fetch()
			material.count = userMaterial[material._id] ? 0
			material

		materialList: materialList

Template.materialList.events "click .div-material": ->
	UserMaterialCollection.addMaterial @_id