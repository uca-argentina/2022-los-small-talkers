Class {
	#name : #MoonWalkSquare,
	#superclass : #Square,
	#instVars : [
		'retrogression'
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

{ #category : #'executing effects' }
MoonWalkSquare >> applyEffectTo: spaceship from: game [

	game
		moveAllSpaceshipsAnAmountOf: retrogression
		exceptFor: spaceship.
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #comparing }
MoonWalkSquare >> hash [ 

	^ self className hash bitXor: ( retrogression hash ).
]

{ #category : #initialization }
MoonWalkSquare >> initializeWith: aNumberOfBackwardsJumps [

	retrogression := aNumberOfBackwardsJumps
]

{ #category : #accessing }
MoonWalkSquare >> retrogression [

	^ retrogression 
]
