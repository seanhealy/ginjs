class @ModelCollection extends Array
	constructor: (@model, associations, @callbackCompletion) ->
		@resourceName = @model.resourceURL associations
		if @model.extension?
			requestURL = "#{@resourceName}#{@model.extension}"
		else
			requestURL = "#{@resourceName}.json"
		new Ajax.Request requestURL,
			method: 'get'
			onSuccess: @callbacks.addUpdates.bind this
	
	find: (id) =>
		@detect (element) =>
			element.id == id
	
	deleteElement: (id) =>
		@reject (element) ->
			element.id == id
		
	callbacks:
		addUpdates: (transport) ->
			for model in ( transport.responseJSON || jQuery.parseJSON(transport.responseText).rows )
				if model.class_name?
					@push new window[model.class_name](model)
				else
					@push new @model(model) 
			if @callbackCompletion?
				@callbackCompletion @
	
	toArray: ->
		@inject [], (acc, element) ->
			acc.push(element)
			acc
