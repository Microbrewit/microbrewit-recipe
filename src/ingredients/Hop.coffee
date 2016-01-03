Ingredient = require './Ingredient'

class Hop extends Ingredient

	_type: 'hop'

	_data: 
		aaValue: 0
		betaValue: 0
		amount: 0
		hopForm: {}

	_ingredient: 
		hopId: null
		name: ''
		acids: {}
		notes: ''
		flavourDescription: ''
		origin: {}
		flavours: []
		aromaWheel: []

		aliases: []
		purpose: ''
		substitutes: []

		oils: []

		beerStyles: []

	_meta:
		boilGravity: 1

	Object.defineProperties @prototype,
		id:
			get: ->
				return @_ingredient.hopId

		data: 
			get: ->
				return {
					hopId: @_ingredient.hopId
					name: @name
					amount: @amount
					aaValue: @_data.aaValue
				}
		alpha:
			get: ->
				return @_data.aaValue
			set: (aa) ->
				@_data.aaValue = aa
				@_calcBitterness()

	# Called when amount changes
	_onAmount: () ->
		@_calcBitterness()

	# Calculate colour (for each available colour formula)
	# @private
	_calcBitterness: ->
		bitterness = {}
		
		for formula in @calc.bitterness.available()
			bitterness[formula] = @calc.bitterness[formula]
				boilGravity: @_meta.boilGravity
				aa: @_data.aaValue
				amount: @_data.amount

		@colour = colours


module.exports = Hop