Class {
	#name : #HyperJumpSlot,
	#superclass : #Object,
	#instVars : [
		'jumpSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
HyperJumpSlot class >> with: someJumps [
	someJumps ifEmpty: [ Error signal: 'Cannot initialize HyperJumpSlot with empty jump parameters' ].
	^self new initializeWith: someJumps.
]

{ #category : #'executing effects' }
HyperJumpSlot >> applyEffectTo: spaceship from: game [
	|amountToMove|
	amountToMove := (game board squaresPerParsec * (jumpSequence nextInSequence)) floor.
	game move: spaceship anAmountOf: amountToMove.
]

{ #category : #initialization }
HyperJumpSlot >> initializeWith: someJumps [
	
	jumpSequence := TrenchRunSequence withAll: (someJumps sorted: [ :x :y | x > y ]).
]
