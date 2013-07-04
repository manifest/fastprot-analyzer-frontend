'use strict'

emptyFun = (data) -> {}

angular.module('misc', [])
	.factory('Example', ['$rootScope', ($rootScope) -> {
		get: (cbSuccess = emptyFun, cbError = emptyFun) ->
			xhr = new XMLHttpRequest
			xhr.open('GET', 'misc/fast-message-example', true)
			xhr.responseType = 'arraybuffer'
			xhr.onerror = (e) ->
				$rootScope.$apply () -> cbError {code: 0, body: 'Service not available'}
			xhr.abort = (e) ->
				$rootScope.$apply () -> cbError {code: 0, body: 'Request aborted'}
			xhr.ontimeout = (e) ->
				$rootScope.$apply () -> cbError {code: 0, body: 'Timeout occured'}
			xhr.onload = (e) ->
				status = this.status
				body = this.response
				if (status == 200)
					$rootScope.$apply () -> cbSuccess(new Uint8Array(body))
				else
					$rootScope.$apply () -> cbError {code: status, body: body}
			xhr.send()
	}])

