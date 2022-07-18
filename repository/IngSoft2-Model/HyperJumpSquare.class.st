Class {
	#name : #HyperJumpSquare,
	#superclass : #Square,
	#instVars : [
		'parsecSequence',
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
HyperJumpSquare class >> new [

	^ super new initializeWith: self randomizeParsecSequence
]

{ #category : #'parameter randomization' }
HyperJumpSquare class >> randomizeParsecSequence [

	^((1 to: 3 atRandom by: 1) collect: [:aNumber | 20 atRandom ])
]

{ #category : #'instance creation' }
HyperJumpSquare class >> withLightYears: aNumberOfJumps [

	|jumpsInParsecs|
	jumpsInParsecs := aNumberOfJumps collect: [ :jumpInLightYears | jumpInLightYears /3 ].
	^ self new initializeWith: jumpsInParsecs 
]

{ #category : #'instance creation' }
HyperJumpSquare class >> withParsecs: aNumberOfJumps [

	^ self new initializeWith: aNumberOfJumps
]

{ #category : #comparing }
HyperJumpSquare >> = anotherHyperJumpSquare [

	^(parsecSequence = anotherHyperJumpSquare parsecSequence and: [ anotherHyperJumpSquare className match: self className ])
]

{ #category : #'Reverse Polarity Card handling' }
HyperJumpSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
HyperJumpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship by: parsecSequence next
]

{ #category : #'executing effects' }
HyperJumpSquare >> applyReverseEffectTo: spaceship from: game [
	
	| target |
	target := game spaceships.
	target remove: spaceship.
	
	target do: [ :ship | game move: ship by: parsecSequence next ].
]

{ #category : #comparing }
HyperJumpSquare >> hash [ 

	^( self className hash bitXor: ( parsecSequence hash ))
]

{ #category : #initialization }
HyperJumpSquare >> initializeWith: someJumps [

	parsecSequence := TrenchRunSequence withAll:
		                (someJumps sorted: [ :jumpA :jumpB | jumpA > jumpB ])
]

{ #category : #initialization }
HyperJumpSquare >> parsecSequence [

	^ parsecSequence 
]

{ #category : #'Reverse Polarity Card handling' }
HyperJumpSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [ ^ 0 ]
		ifNotNil: [ ^ playedReversePolarityCardCount ]
]
