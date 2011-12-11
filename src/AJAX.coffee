window.AJAX =
	request: (options) ->
		defaults =
			url: '/'
			method: 'GET'
			onSuccess: (response) -> # console.log response
			onFailure: (response) -> # console.log response
			onComplete: (response) -> # console.log response
		
		options = gin.merge defaults, options
		
		oXHR = new XMLHttpRequest()
		oXHR.open(options.method, options.url, true)
		oXHR.onreadystatechange = (oEvent) ->
			if (oXHR.readyState == 4)
				if (oXHR.status == 200)
					options.onSuccess oXHR
				else
					options.onSuccess oXHR
				
				options.onComplete oXHR
		
		oXHR.send(null)
