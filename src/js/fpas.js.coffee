'use strict'

emptyFun = (data) -> {}

angular.module('fpas', [])
	.factory('Message', ['$rootScope', ($rootScope) -> {
		decode: (bytes, cbSuccess = emptyFun, cbError = emptyFun) ->
			xhr = new XMLHttpRequest
			xhr.open('POST', 'http://fpas.yanot.org/api/templates/RTSX/decode', true)
			xhr.setRequestHeader('Content-Type', 'application/octet-stream')
			xhr.responseType = 'text'
			xhr.onerror = (e) ->
				$rootScope.$apply () -> cbError {code: 0, body: 'Service not available'}
			xhr.abort = (e) ->
				$rootScope.$apply () -> cbError {code: 0, body: 'Request aborted'}
			xhr.ontimeout = (e) ->
				$rootScope.$apply () -> cbError {code: 0, body: 'Timeout occured'}
			xhr.onload = (e) ->
				status = this.status
				body = JSON.parse(this.response)
				if status == 200
					$rootScope.$apply () -> cbSuccess(body)
				else
					$rootScope.$apply () -> cbError {code: status, body: body.error}
			xhr.send(bytes)
	}])

