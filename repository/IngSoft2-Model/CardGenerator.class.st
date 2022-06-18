Class {
	#name : #CardGenerator,
	#superclass : #Object,
	#instVars : [
		'fractionGenerator',
		'probabilityRanges'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardGenerator class >> creating: anAmount of: objects with: probabilities [

	self verifySumOf: probabilities.
	^ (self new
		  initializeOf: objects
		  with: probabilities) next: anAmount.
	
]

{ #category : #'instance creation' }
CardGenerator class >> of: objects [ 

	|probabilities|
	probabilities := OrderedCollection new.
	objects size timesRepeat: [ probabilities add: (1 / (objects size)) ].
	^ self new initializeOf: objects with: probabilities.
]

{ #category : #'instance creation' }
CardGenerator class >> verifySumOf: probabilities [

	probabilities sum = 1 ifFalse: [ 
		Error signal: 'Sum of probabilities differ from 1' ]
]

{ #category : #auxiliary }
CardGenerator >> group: cards withTheirRangeOf: probabilities [

	| rangeFloor ranges |
	ranges := OrderedCollection new.
	rangeFloor := 0.
	(1 to: probabilities size by: 1) do: [ :i | 
		| rangeCeiling card objectProbability |
		card := cards at: i.
		objectProbability := probabilities at: i.
		rangeCeiling := rangeFloor + objectProbability.

		ranges add: { 
				rangeFloor.
				rangeCeiling.
				card }.
		rangeFloor := rangeFloor + (probabilities at: i) ].

	^ ranges
]

{ #category : #initialization }
CardGenerator >> initializeOf: cards with: probabilities [

	probabilityRanges := self group: cards withTheirRangeOf: probabilities.
	fractionGenerator := Random seed: Time now asSeconds
]

{ #category : #'slot generation' }
CardGenerator >> next [

	| numberGenerated card |
	numberGenerated := fractionGenerator next.

	probabilityRanges do: [ :range | 
		| rangeFloor rangeCeiling cardClass |
		rangeFloor := range at: 1.
		rangeCeiling := range at: 2.
		cardClass := range at: 3.

		(numberGenerated between: rangeFloor and: rangeCeiling) ifTrue: [ 
			card := cardClass ] ].

	^ card
]

{ #category : #'slot generation' }
CardGenerator >> next: amountToGenerate [

	| cards |
	cards := OrderedCollection new.
	amountToGenerate timesRepeat: [ cards add: self next ].
	^ cards
]
