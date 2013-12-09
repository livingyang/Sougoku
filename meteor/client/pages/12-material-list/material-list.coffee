class @MaterialListController extends RouteController
	data: ->
		userMaterial = UserMaterialCollection.getMaterialIdAndCountMap() ? {}
		materialList = for material in MaterialCollection.getIsOpenCursor().fetch()
			material.count = userMaterial[material._id]?.count ? 0
			material.totalCount = userMaterial[material._id]?.totalCount ? 0
			material

		materialList: materialList

Template.materialList.events "click .div-material": ->
	UserMaterialCollection.addMaterial @_id