Ingredient = require './Ingredient'

class Other extends Ingredient

	_type: 'other'
	
	_data: 
		amount: 0

	_ingredient:
		otherId: null
		name: ''
		type: ''

module.exports = Other