Class {
	#name : #MoonWalkSquare,
	#superclass : #Square,
	#instVars : [
		'someRetrogression'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
MoonWalkSquare class >> createAtRandom [

	^self new initializeWith: (self randomizeRetrogression).
]

{ #category : #'parameter randomization' }
MoonWalkSquare class >> randomizeRetrogression [

	^ 10 atRandom.
]

{ #category : #'instance creation' }
MoonWalkSquare class >> with: someRetrogression [

	^self new initializeWith: someRetrogression 
]

{ #category : #'executing effects' }
MoonWalkSquare >> applyEffectTo: spaceship from: game [

	game moveAllSpaceshipsAnAmountOf: someRetrogression exceptFor: spaceship.
]

{ #category : #initialization }
MoonWalkSquare >> initializeWith: aNumberOfBackwardsJumps [

	someRetrogression := aNumberOfBackwardsJumps
]
