Class {
	#name : #HyperJumpSquare,
	#superclass : #Square,
	#instVars : [
		'jumpSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
HyperJumpSquare class >> createAtRandom [

	^self new initializeWith: self randomizeParsecSequence
]

{ #category : #'parameter randomization' }
HyperJumpSquare class >> randomizeParsecSequence [

	^((1 to: 3 atRandom by: 1) collect: [:aNumber | 20 atRandom ])
]

{ #category : #'instance creation' }
HyperJumpSquare class >> with: aParsecSequence [

	^self new initializeWith: aParsecSequence 
]

{ #category : #'executing effects' }
HyperJumpSquare >> applyEffectTo: spaceship from: game [

	| amountToMove |
	amountToMove := (jumpSequence nextInSequence
	                 / (game board parsecsPerSquare)) floor.
	game move: spaceship anAmountOf: amountToMove
]

{ #category : #initialization }
HyperJumpSquare >> initializeWith: someJumps [

	jumpSequence := TrenchRunSequence withAll:
		                (someJumps sorted: [ :jumpA :jumpB | jumpA > jumpB ])
]
