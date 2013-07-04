'use strict'

angular.module('app', ['fpas', 'misc'])
	.controller('mainCtrl', ['$scope', 'Message', 'Example', ($scope, Message, Example) ->
		makeTable = (fields) ->
			acc = for field in fields
				switch field.type
					when 'field'
						field
					when 'sequence'
						children = field.value
						acc = for entry in children
							makeTable(entry)
						
						# add entry labels
						for index of acc
							acc[index][0].labels = [
								{name: 'entry', descr: 'entry starts here'},
								{name:   index, descr: 'entry sequence number'}
							]

						# add sequence label and description
						field.length.labels = [{name: 'sequence', descr: 'sequence starts here'}]
						field.length.descr = field.name

						[field.length].concat acc...
					when 'group'
						children = field.value
						delete field.value
						field.labels = [{name: 'group', descr: 'group starts here'}]
						[field].concat makeTable(children)
					else
						null
			[].concat acc...

		$scope.makeTagLink = (tag) ->
			'http://fixwiki.org/fixwiki/' + tag

		$scope.hideTable = ->
			$scope.table = {show: false}

		$scope.showTable = (fields) ->
			$scope.table = {show: true, data: makeTable(fields)}
		
		$scope.hideAlert = ->
			$scope.alert = {show: false}

		$scope.showAlert = (type, title, descr) ->
			$scope.alert = {type: type, title: title, descr: descr, show: true}
			ga('send', 'event', 'alert', type, title + ' ' + descr)

		$scope.templatesFeatureRequest = ->
			ga('set', 'dimension2', 'templates')
			ga('send', 'event', 'feature', 'request', 'templates')
			$scope.showAlert('info', 'Thank you.', 'Templates feature request was sent.')

		$scope.templateUrl = (name) ->
			'http://fpas.yanot.org/api/templates/' + name

		decodeMessage = (bytes) ->
			Message.decode(
				bytes,
				(data)  ->
					$scope.hideAlert()
					$scope.showTable(data)
				(error) ->
					$scope.hideTable()
					$scope.showAlert('error', 'Error.', error.body)
			)

		$scope.setFile = (files) ->
			if files.length < 1
				return

			reader = new FileReader
			reader.onload = (event) ->
				bytes =  new Uint8Array(event.target.result)
				decodeMessage(bytes)
			reader.onerror = (event) ->
				$scope.hideTable()
				$scope.showAlert('error', 'File uploading error.')

			reader.readAsArrayBuffer(files[0])

		$scope.showExample = () ->
			ga('send', 'event', 'button', 'click', 'show example')
			Example.get(
				(bytes) ->
					decodeMessage(bytes)
				(error) ->
					$scope.hideTable()
					$scope.showAlert('error', 'Internal error.', 'Example not available.')
			)

		$scope.showCurrentTemplate = () ->
			ga('send', 'event', 'button', 'click', 'show current template')

		$scope.showTagDescr = () ->
			ga('send', 'event', 'button', 'click', 'show tag description')

		ga('send', 'event', 'compatibility', 'nope', 'xhr2') if !Modernizr.xhr2
		ga('send', 'event', 'compatibility', 'nope', 'cors') if !Modernizr.cors

		# by default
		$scope.isObsoleteBrowser = !Modernizr.xhr2 || !Modernizr.cors
		$scope.hideAlert()
		$scope.hideTable()
	])

