Class {
	#name : #'Gen_SquareGenerator',
	#superclass : #Object,
	#instVars : [
		'fractionGenerator',
		'probabilityRanges'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Gen_SquareGenerator class >> creating: anAmount of: objects with: probabilities [

	self verifySumOf: probabilities.
	^ (self new
		  initializeOf: objects
		  with: probabilities) next: anAmount.
	
]

{ #category : #'instance creation' }
Gen_SquareGenerator class >> verifySumOf: probabilities [

	probabilities sum = 1 ifFalse: [ 
		Error signal: 'Sum of probabilities differ from 1' ]
]

{ #category : #auxiliary }
Gen_SquareGenerator >> group: objects withTheirRangeOf: probabilities [

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
Gen_SquareGenerator >> initializeOf: objects with: probabilities [

	probabilityRanges := self group: objects withTheirRangeOf: probabilities.
	fractionGenerator := Random seed: Time now asSeconds
]

{ #category : #'slot generation' }
Gen_SquareGenerator >> next [

	| numberGenerated slot |
	numberGenerated := fractionGenerator next.

	probabilityRanges do: [ :range | 
		| rangeFloor rangeCeiling square |
		rangeFloor := range at: 1.
		rangeCeiling := range at: 2.
		square := range at: 3.

		(numberGenerated between: rangeFloor and: rangeCeiling) ifTrue: [ 
			slot := square new ] ].

	^ slot
]

{ #category : #'slot generation' }
Gen_SquareGenerator >> next: amountToGenerate [

	| slots |
	slots := OrderedCollection new.
	amountToGenerate timesRepeat: [ slots add: self next ].
	^ slots
]
