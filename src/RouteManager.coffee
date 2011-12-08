class RouteManager
	constructor: ->
		jQuery(document).click (event) =>
			element = if jQuery(event.target).attr('href') then event.target else jQuery(event.target).closest('[href]')[0]
			return unless element?
			
			routeString = jQuery(element).attr("href")
			
			for route in @routes
				parameterMatches = routeString.match(route.routeRegEx)
				if parameterMatches
					event.preventDefault()
					route.invoke(parameterMatches, element, event)
					break
		@parseRoutes()
	
	parseRoutes: ->
		@routes = []
		return unless Routes?
		_.each Routes, (routeHash) =>
			@routes.push(new Route(routeHash))
