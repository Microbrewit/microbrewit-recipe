Step = require './Step'
class FermentationStep extends Step

	_data:
		length: 14
		volume: 0
		temperature: 0
		notes: ''

	Object.defineProperties @prototype,
		stepNumber:
			get: ->
				return @_stepNumber
			set: (stepNumber) ->
				@_stepNumber = stepNumber
		length: 
			get: ->
				return @_data.length
			set: (length) ->
				@_data.length = length
		temperature:
			get: ->
				return @_data.temperature
			set: (temperature) ->
				@_data.temperature = temperature
		notes:
			get: ->
				return @_data.notes
			set: (notes) ->
				@_data.notes = notes