###
Recipe Step Base Class

@author Torstein Thune
@copyright 2015 Microbrew.it
###
class Step

	Fermentable: require './ingredients/Fermentable'
	Hop: require './ingredients/Hop'
	Other: require './ingredients/Other'
	Yeast: require './ingredients/Yeast'

	_calc:
		bitterness: {}
		mcu: 0
		gravityPoints: 0

	# Recalculate step meta
	recalc: ->
		@_calc.bitterness = {}
		@_calc.mcu = 0
		@_calc.gravityPoints = 0
		for ingredient in ingredients
			if ingredient.bitterness?
				for formula, val in ingredient.bitterness
					unless @_calc.bitterness[formula]
						@_calc.bitterness[formula] = val
					else
						@_calc.bitterness[formula] += val
			if ingredient.mcu
				@_calc.mcu += ingredient.mcu
			if ingredient.gravityPoints
				@_calc.gravityPoints += ingredient.gravityPoints

	# Add ingredient to step
	# @param [String] type Type of ingredient
	# @param [Object] config The ingredient metadata
 	addIngredient: (type, config) ->
		old = _.clone @model
		config = _.clone config if config
		switch type
			when 'fermentable'
				@model.ingredients.push new @Fermentable config
			when 'hop'
				@model.ingredients.push new @Hop config
			when 'other'
				@model.ingredients.push new @Other config
			when 'yeast'
				@model.ingredients.push new @Yeast config

		@calculateMeta()
		@updated(old, @model)

	# Remove an ingredient from the step
	# @param [Object, Integer] mixed Either a Ingredient instance or a index
	# @todo
	removeIngredient: (mixed) ->
		if typeof mixed is 'number'
			@ingredients.splice(mixed, 1)

	getIngredientIndex: (object) ->

	moveIngredient: (from, to) ->


module.exports = Step