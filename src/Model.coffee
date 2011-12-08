class @Model
	constructor: (modelInfo, @viewcallback = null) ->
		_.each _.keys( modelInfo ), (key) =>
			@[key] = modelInfo[key]
	
	create: (after_create = null)->
		jQuery.ajax
			url: "/#{@resourceUrl()}#{@model.extension||".json"}",
			data: @
			method: 'post'
			success: (data, status, xhr) =>
				console.log transport.responseText
			failure: (data, status, xhr) =>
				throw "Failed to save model"
		this
	
	save: (after_save = null) ->
		jQuery.ajax
			url: "{@myUrl()}"
			data: @
			method: 'post'
			success: (data, status, xhr) =>
				console.log transport.responseText
			failure: (data, status, xhr) =>
				throw "Failed to save model"
		this
	
	destroy: ->
		jQuery.ajax
			url: "#{@myUrl()}#{@model.extension||".json"}",
			method: 'delete'
	
	my_url: ->
		"#{@.__proto__.constructor.resourceURL()}/#{@id}"
		
	@all: (callback) ->
		if window.ModelCollections[@className()]
			callback(window.ModelCollections[@className()])
		else
			window.ModelCollections[@className()] = new ModelCollection(@, null, callback)
	
	@find: (id, callback) ->
		if window.ModelCollections[@className()]
			callback(window.ModelCollections[@className()].find(id))
		else
			jQuery.ajax
				url: "/#{@className().toLowerCase()}/#{id}#{@__proto__.extension || ".json"}"
				success: (data, status, xhr) ->
					callback(@(data))
				
	@className: ->
		@toString().match(/function ([^\(]*)/)[1]
	
	className: ->
		@__proto__.constructor.toString().match(/function ([^\(]*)/)[1]
