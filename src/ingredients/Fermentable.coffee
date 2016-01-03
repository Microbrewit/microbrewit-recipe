Ingredient = require './Ingredient'

###
Class containing getters and setters for Fermentable

@author Torstein Thune
@copyright 2015 Microbrew.it
###
class Fermentable extends Ingredient

	_type: 'fermentable'
	
	# Calculated data
	_data:
		name: ''
		amount: 0
		lovibond: 0
		ppg: 0
		gravityPoints: 0
		mcu: 0
		colour: 
			morey: 0
			daniels: 0
			mosher: 0

	# Original ingredient
	_ingredient:
		type: ''
		fermentableId: ''
		name: ''
		lovibond: 0
		ppg: 0
		colour: 
			morey: 0
			daniels: 0
			mosher: 0

	# Other meta needed for calculations
	_meta:
		efficiency: 70 # Defined by recipe
		postBoilVolume: 0 # Defined by recipe

	# Called when an _ingredient is set
	# @private
	_onIngredient: ->
		@_calculateGravityPoints()
		@_calculateColour()

	# Called when amount is set
	# @private
	_onAmount: ->
		@_calculateColour()
		@_calculateGravityPoints()

	Object.defineProperties @prototype,
		id:
			get: ->
				return @_ingredient.fermentableId

		lovibond:
			get: ->
				if @_data.lovibond
					return @_data.lovibond
				else if @_data.lovibond
					return @_data.lovibond
			set: (lovibond) ->
				old = @_data.lovibond
				@_data.lovibond = lovibond
				@_calculateColour()
				@onLovibond?(old,lovibond)

		ppg:
			get: ->
				if @_data.ppg
					return @_data.ppg
				else if @_data.ppg
					return @_data.ppg
			set: (ppg) ->
				old = @_data.ppg
				@_data.ppg = ppg
				@_calculateGravityPoints()
				@onPpg?(old, ppg)

		postBoilVolume:
			get: ->
				return @_meta.postBoilVolume
			set: (postBoilVolume) ->
				@_meta.postBoilVolume = postBoilVolume
				@_calculateColour()
				@_calculateGravityPoints()

		colour: 
			get: ->
				if @_data.colour
					return @_data.colour
				else if @_.colour
					return @_.colour
			set: (colour) ->
				for key, val of colour
					@_data.colour[key] = val
				@onColour?({}, @_data.colour)

		mcu: 
			get: ->
				return @_data.mcu

		gravityPoints: 
			get: ->
				return @_data.gravityPoints

		efficiency:
			get: ->
				return @_meta.efficiency
			set: (efficiency) ->
				old = @_meta.efficiency
				@_meta.efficiency = efficiency
				@_calculateGravityPoints()

				@onEfficiency?(old, efficiency)

	# Calculate colour (for each available colour formula)
	# @private
	_calculateColour: ->
		colours = {}
		@_data.mcu = @calc.colour.mcu(@amount, @lovibond, @postBoilVolume)
		for formula in @calc.colour.available()
			colours[formula] = @calc.colour[formula]
				mcu: @mcu
				weight: @amount
				lovibond: @lovibond
				postBoilVolume: @postBoilVolume

		@colour = colours

	# @todo Move to microbrewit-formulas
	_calcGravityPoints: (config) ->
		return Math.round((config.weight*config.ppg*config.efficiency)/config.volume)

	# Calculate Gravity Points
	# @private
	_calculateGravityPoints: ->
		console.log '_calculateGravityPoints'
		old = @_data.gravityPoints
		@_data.gravityPoints = @_calcGravityPoints
			weight: @amount
			ppg: @ppg
			efficiency: @efficiency
			volume: @postBoilVolume

		@onGravityPoints?(old, @_data.gravityPoints)

	fromMBit: (json) ->


	toMBit: ->
		return {
			fermentableId: @ingredient.id
			name: @name
			lovibond: @lovibond
			ppg: @ppg
			type: @ingredient.type
			amount: @amount
		}



module.exports = Fermentable