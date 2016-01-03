formulas = require 'microbrewit-formulas'

###
Base class for ingredients

@author Torstein Thune
@copyright 2015 Microbrew.it
###
class Ingredient
	calc: formulas

	_data: {}
	_ingredient: {}
	_meta: {}

	constructor: (ingredient) ->
		@ingredient = ingredient

	Object.defineProperties @prototype,
		# Get the ingredient prototype
		ingredient:
			get: -> 
				return @_ingredient
			set: (ingredient) -> 
				for key, val of ingredient
					if @_ingredient[key]?
						@_ingredient[key] = val

					if @_data[key]?
						@_data[key] = val

					if @_meta[key]?
						@_meta[key] = val
					else
						@[key] = val

				@_onIngredient?()
				@onIngredient?()

		# Calculated data
		data:
			get: ->
				return @_data
		
		# Type of ingredient
		type:
			get: ->
				return @_type
		
		# Name of ingredient (usually not edited)
		name:
			get: ->
				if @_data.name 
					return @_data.name
				else if @_.name
					return @_.name
			set: (name) ->
				old = name
				@_data.name = name
				@_onName?(old, name)
				@onName?(old, name)

		# Amount of the ingredient
		amount:
			get: ->
				return @_data.amount
			set: (amount) ->
				old = @_data.amount
				@_data.amount = amount
				@_onAmount?(old, amount)
				@onAmount?(old, amount)

module.exports = Ingredient