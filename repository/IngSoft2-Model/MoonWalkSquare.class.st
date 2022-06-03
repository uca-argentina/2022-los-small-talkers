Class {
	#name : #MoonWalkSquare,
	#superclass : #Square,
	#instVars : [
		'amountToMove'
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

	| positions length spaceshipsToMove |
	positions := game spaceships.
	spaceshipsToMove := positions.
	spaceshipsToMove remove: spaceship.
	length := spaceshipsToMove size.
	(1 to: length by: 1) do: [ :i | 
		game move: (spaceshipsToMove at: i) anAmountOf: 0 - amountToMove ]
]

{ #category : #initialization }
MoonWalkSquare >> initializeWith: n [

	amountToMove := n
]
