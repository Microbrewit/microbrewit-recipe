Ingredient = require './Ingredient'

class Yeast extends Ingredient

	_type: 'yeast'

	_data:
		amount: 0

	_ingredient:
		yeastId: 2
		name: ''
		temperature: {}
		flocculation: ''
		alcoholTolerance: ''
		productCode: ''
		notes: ''
		type: null,
		brewerySource: ''
		species: ''
		attenutionRange: ''
		pitchingFermentationNotes: ''
		supplier: {}
		dataType: "yeast"
		custom: false

module.exports = Yeast