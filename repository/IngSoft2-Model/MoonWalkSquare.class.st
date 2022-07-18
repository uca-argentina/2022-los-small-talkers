Class {
	#name : #MoonWalkSquare,
	#superclass : #Square,
	#instVars : [
		'retrogression',
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
MoonWalkSquare class >> new [

	^ super new initializeWith: self randomizeRetrogression
]

{ #category : #'parameter randomization' }
MoonWalkSquare class >> randomizeRetrogression [

	^ 10 atRandom.
]

{ #category : #'instance creation' }
MoonWalkSquare class >> with: someRetrogression [

	^self new initializeWith: someRetrogression 
]

{ #category : #comparing }
MoonWalkSquare >> = anotherMoonWalkSquare [

	^( retrogression = anotherMoonWalkSquare retrogression and: [ self className match: anotherMoonWalkSquare className ])
]

{ #category : #'Reverse Polarity Card handling' }
MoonWalkSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
MoonWalkSquare >> applyEffectTo: spaceship from: game [

	game moveAllSpaceshipsAnAmountOf: retrogression exceptFor: spaceship
]

{ #category : #'executing effects' }
MoonWalkSquare >> applyReverseEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: retrogression.
]

{ #category : #comparing }
MoonWalkSquare >> hash [ 

	^ self className hash bitXor: ( retrogression hash ).
]

{ #category : #initialization }
MoonWalkSquare >> initializeWith: aNumberOfBackwardsJumps [

	retrogression := 0 - aNumberOfBackwardsJumps
]

{ #category : #'Reverse Polarity Card handling' }
MoonWalkSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [ ^ 0 ]
		ifNotNil: [ ^ playedReversePolarityCardCount ]
]

{ #category : #accessing }
MoonWalkSquare >> retrogression [

	^ retrogression 
]
