Class {
	#name : #RandomSquaresGenerator,
	#superclass : #Object,
	#instVars : [
		'fractionGenerator',
		'squareAmount',
		'probabilityRanges'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomSquaresGenerator class >> creating: anAmount of: slots with: probabilities [

	self verifySumOf: probabilities.
	^ self new
		  initializeCreating: anAmount
		  of: slots
		  with: probabilities
]

{ #category : #'instance creation' }
RandomSquaresGenerator class >> verifySumOf: probabilities [

	probabilities sum = 1 ifFalse: [ 
		Error signal: 'Sum of probabilities differ from 1' ]
]

{ #category : #'slot generation' }
RandomSquaresGenerator >> generateSquare [

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
RandomSquaresGenerator >> generateSquares [

	| slots |
	slots := OrderedCollection new.
	squareAmount timesRepeat: [ slots add: self generateSquare ].
	^ slots
]

{ #category : #auxiliary }
RandomSquaresGenerator >> group: squares withTheirRangeOf: probabilities [

	|rangeFloor ranges|
	ranges := OrderedCollection new.
	rangeFloor := 0.
	(1 to: probabilities size by: 1) do: [ :i |
		|rangeCeiling square squareProbability|
		square := squares at: i.
		squareProbability := probabilities at: i.
		rangeCeiling := rangeFloor + squareProbability.
		
		ranges add: {rangeFloor . rangeCeiling . square}.
		rangeFloor  := rangeFloor + (probabilities at: i).
		].
	
	^ranges.

	
]

{ #category : #initialization }
RandomSquaresGenerator >> initializeCreating: anAmount of: slots with: probabilities [

	squareAmount := anAmount.
	probabilityRanges := self group: slots withTheirRangeOf: probabilities.
	fractionGenerator := Random seed: Time now asSeconds
]
