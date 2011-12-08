class @Controller
	constructor: ->
		@setup() if @setup
		@contentIndexDivs = jQuery('.cowry_index')
		@contentShowDivs = jQuery('.cowry_show')

	index: (params, secondaryCallback = null) ->
		@getIndexContent (content) =>
			@contentIndexDivs.each (index, element) =>
				@populateDiv element, content, 'Ihow', secondaryCallback
			@view['indexComplete']() if @view['indexComplete']?
		, params

	getIndexContent: (callback, params) ->
		callback(@controller_content)
	
	show:(params, secondaryCallback = null)->
		@getShowContent (content) =>
			@contentShowDivs.each (index, element) =>
				@populateDiv element, content, 'Show', secondaryCallback
			@view['showComplete']() if @view['showComplete']?
		, params
		
	getShowContent: (callback, params) ->
		callback(@controller_content)
		
	populateDiv: (element, content, action, callback) ->
		divName = _.last(element.className.split(/\s+/))
		if @view["#{divName}#{action}Template"]?
			jQuery(element).children().remove()
			if @view["get#{divName}#{action}JSON"]?
				content = Mustache.to_html(@view["#{divName}#{action}Template"], @view["get#{divName}#{action}JSON"](content))
			else
				content = Mustache.to_html(@view["#{divName}#{action}Template"], content)
			jQuery(element).append(content)
		@view["#{divName}#{action}Complete"]() if @view["#{divName}#{action}Complete"]?
		callback() if callback
