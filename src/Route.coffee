class Route
	constructor: (routeHash) ->
		@parameterNames = _.map routeHash.route.match( /(\w+):/g), (element) ->
			element.replace(/:/, '')
		@routeRegEx = new RegExp("^" + routeHash.route.replace(/([\w\d]+):/, '') + "$")
		
		# if we already have an instance of this controller use it; else make a new one
		console.log "Loading controller: #{routeHash.controller}"
		@controller = RouteControllers[routeHash.controller] || new window[routeHash.controller]
		@action = routeHash.action
		 
		# put either the new controller into the array or the old one again
		RouteControllers[routeHash.controller] = @controller
		if @controller.after_create
			@controller.after_create()
		
	invoke: (parameterValues, element, event) ->
		try
			params = _.inject @parameterNames, (accumulator, element, index) ->
				accumulator[element] = parameterValues[index+1]
				return accumulator
			,{}
			params.element = element
			params.event = event
			
			console.log("#{@controller.__proto__.constructor.toString().match(/function ([^\(]*)/)[1]} #{@action}")
			@controller[@action] params
		catch error
			console.log "Something went wrong: #{error.message} \n source: #{error.sourceURL} \n line: #{ error.line}";
