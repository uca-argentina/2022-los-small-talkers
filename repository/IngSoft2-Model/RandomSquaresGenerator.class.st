Class {
	#name : #RandomSquaresGenerator,
	#superclass : #Object,
	#instVars : [
		'probabilityRange',
		'fractionGenerator',
		'boardSize',
		'nMax',
		'mMax',
		'mAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RandomSquaresGenerator class >> creating: slots with: probabilities sized: aBoardSize accordingTo: creationParameters [

	self verify: creationParameters.
	
	probabilities sum = 1 ifFalse: [ 
		Error signal: 'Sum of probabilities differ from 1' ].
	^ self new
		  initializeCreating: slots
		  with: probabilities
		  sized: aBoardSize
		  accordingTo: creationParameters
]

{ #category : #'data validation' }
RandomSquaresGenerator class >> verify: creationParameters [

	creationParameters at: 'Mmax' ifAbsent: [ Error signal: 'Missing Mmax on creation parameters' ].
	creationParameters at: 'Mamount' ifAbsent: [ Error signal: 'Missing Mamount on creation parameters' ].
	creationParameters at: 'Nmax' ifAbsent: [ Error signal: 'Missing Nmax on creation parameters' ]
]

{ #category : #'random number generation' }
RandomSquaresGenerator >> generateM [

	^ (1 to: mAmount by: 1) collect: [ :i | mMax atRandom ].
]

{ #category : #'random number generation' }
RandomSquaresGenerator >> generateN [

	^ nMax atRandom.
]

{ #category : #'slot generation' }
RandomSquaresGenerator >> generateSlot [

	| numberGenerated slot |
	numberGenerated := fractionGenerator next.

	probabilityRange do: [ :range | 
		(numberGenerated between: (range at: 1) and: (range at: 2)) ifTrue: [ 
			slot := (range at: 3) with: { 
					        ('M' -> self generateM).
					        ('N' -> self generateN) } asDictionary ] ].

	^ slot
]

{ #category : #'slot generation' }
RandomSquaresGenerator >> generateSlots [
	|slots|
	slots := OrderedCollection new.
	
	(1 to: boardSize by: 1) do: [ :i |
		slots add: self generateSlot.
	].

	 ^ slots.
]

{ #category : #initialization }
RandomSquaresGenerator >> initializeCreating: slots with: probabilities sized: aBoardSize accordingTo: creationParameters [

	boardSize := aBoardSize.
	probabilityRange := self rangeWith: probabilities and: slots.
	fractionGenerator := Random seed: Time now asSeconds.
	nMax := creationParameters at: 'Nmax'.
	mMax := creationParameters at: 'Mmax'.
	mAmount := creationParameters at: 'Mamount'.
]

{ #category : #auxiliary }
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
