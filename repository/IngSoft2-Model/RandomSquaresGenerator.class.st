Class {
	#name : #RandomSquaresGenerator,
	#superclass : #Object,
	#instVars : [
		'probabilityRange',
		'fractionGenerator',
		'boardSize'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RandomSquaresGenerator class >> creating: slots with: probabilities sized: aBoardSize [
	(probabilities sum = 1) ifFalse: [ Error signal: 'Sum of probabilities differ from 1' ].
	^self new initializeCreating: slots with: probabilities sized: aBoardSize.
	
	
	

	
]

{ #category : #'as yet unclassified' }
RandomSquaresGenerator >> generateSlot [

	| numberGenerated slot |
	numberGenerated := fractionGenerator next.

	probabilityRange do: [ :range | 
		((numberGenerated >= (range at: 1)) and: [ 
			 numberGenerated <= (range at: 2) ]) ifTrue: [ slot := range at: 3 ] ].

	^ slot
]

{ #category : #'as yet unclassified' }
RandomSquaresGenerator >> generateSlots [
	|slots|
	slots := OrderedCollection new.
	
	(1 to: boardSize by: 1) do: [ :i |
		slots add: self generateSlot.
	].

	 ^ slots.
]

{ #category : #initialization }
RandomSquaresGenerator >> initializeCreating: slots with: probabilities sized: aBoardSize [
	
	boardSize := aBoardSize.
	probabilityRange := self rangeWith: probabilities and: slots.
	fractionGenerator := Random seed: (Time now asSeconds).
	
]

{ #category : #'as yet unclassified' }
RandomSquaresGenerator >> rangeWith: probabilities and: squares [

	|startingRange ranges|
	ranges := OrderedCollection new.
	startingRange := 0.
	(1 to: probabilities size by: 1) do: [ :i | 
		ranges add: {startingRange . startingRange + (probabilities at: i). squares at: i} .
		startingRange := startingRange + (probabilities at: i).
		].
	
	^ranges.

	
]
