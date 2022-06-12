Class {
	#name : #RandomObjectGenerator,
	#superclass : #Object,
	#instVars : [
		'fractionGenerator',
		'probabilityRanges'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomObjectGenerator class >> creating: anAmount of: objects with: probabilities [

	self verifySumOf: probabilities.
	^ (self new
		  initializeOf: objects
		  with: probabilities) next: anAmount.
	
]

{ #category : #'instance creation' }
RandomObjectGenerator class >> of: objects [ 

	|probabilities|
	probabilities := OrderedCollection new.
	objects size timesRepeat: [ probabilities add: (1 / (objects size)) ].
	^ self new initializeOf: objects with: probabilities.
]

{ #category : #'instance creation' }
RandomObjectGenerator class >> verifySumOf: probabilities [

	probabilities sum = 1 ifFalse: [ 
		Error signal: 'Sum of probabilities differ from 1' ]
]

{ #category : #auxiliary }
RandomObjectGenerator >> group: objects withTheirRangeOf: probabilities [

	|rangeFloor ranges|
	ranges := OrderedCollection new.
	rangeFloor := 0.
	(1 to: probabilities size by: 1) do: [ :i |
		|rangeCeiling square objectProbability|
		square := objects at: i.
		objectProbability := probabilities at: i.
		rangeCeiling := rangeFloor + objectProbability.
		
		ranges add: {rangeFloor . rangeCeiling . square}.
		rangeFloor  := rangeFloor + (probabilities at: i).
		].
	
	^ranges.

	
]

{ #category : #initialization }
RandomObjectGenerator >> initializeOf: objects with: probabilities [

	probabilityRanges := self group: objects withTheirRangeOf: probabilities.
	fractionGenerator := Random seed: Time now asSeconds
]

{ #category : #'slot generation' }
RandomObjectGenerator >> next [

	| numberGenerated slot |
	numberGenerated := fractionGenerator next.

	probabilityRanges do: [ :range | 
		|rangeFloor rangeCeiling square|
		rangeFloor := range at: 1.
		rangeCeiling := range at: 2.
		square := range at: 3.
		
		(numberGenerated between: rangeFloor and: rangeCeiling ) 
			ifTrue: [ slot := square createAtRandom ] 
	].

	^ slot
]

{ #category : #'slot generation' }
RandomObjectGenerator >> next: amountToGenerate [

	| slots |
	slots := OrderedCollection new.
	amountToGenerate timesRepeat: [ slots add: self next ].
	^ slots
]
