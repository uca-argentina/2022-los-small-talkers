Class {
	#name : #SquareGenerator,
	#superclass : #Object,
	#instVars : [
		'fractionGenerator',
		'probabilityRanges'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SquareGenerator class >> creating: anAmount of: objects with: probabilities [

	self verifySumOf: probabilities.
	^ (self new
		  initializeOf: objects
		  with: probabilities) next: anAmount.
	
]

{ #category : #'instance creation' }
SquareGenerator class >> verifySumOf: probabilities [

	probabilities sum = 1 ifFalse: [ 
		Error signal: 'Sum of probabilities differ from 1' ]
]

{ #category : #auxiliary }
SquareGenerator >> group: squares withTheirRangeOf: probabilities [

	|accumulatedProbability ranges|
	ranges := OrderedCollection new.
	accumulatedProbability := 0.
	(1 to: probabilities size by: 1) do: [ :objectIndex |
		|square objectProbability|
		square := squares at: objectIndex.
		objectProbability := probabilities at: objectIndex.
		
		accumulatedProbability := accumulatedProbability + objectProbability.
		ranges add: {accumulatedProbability . square}.
		].
	
	^ranges.

	
]

{ #category : #initialization }
SquareGenerator >> initializeOf: objects with: probabilities [

	probabilityRanges := self group: objects withTheirRangeOf: probabilities.
	fractionGenerator := Random seed: Time now asSeconds
]

{ #category : #'slot generation' }
SquareGenerator >> next [

	| numberGenerated slot |
	numberGenerated := fractionGenerator next.

	probabilityRanges do: [ :range | 
		|rangeCeiling square |
		rangeCeiling := range at: 1.
		square := range at: 2.

		(numberGenerated < rangeCeiling) ifTrue: [ 
			slot := square new ] ].

	^ slot
]

{ #category : #'slot generation' }
SquareGenerator >> next: amountToGenerate [

	| slots |
	slots := OrderedCollection new.
	amountToGenerate timesRepeat: [ slots add: self next ].
	^ slots
]
