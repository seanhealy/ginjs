@RouteControllers = []
@ModelCollections = []

jQuery ->
	new RouteManager

window.gin =
	merge: (o1, o2) ->
		result = {}
		for key, value of o1
			result[key] = value if o1.hasOwnProperty(key)
		for key, value of o2
			result[key] = value if o2.hasOwnProperty(key)
		
		return result

