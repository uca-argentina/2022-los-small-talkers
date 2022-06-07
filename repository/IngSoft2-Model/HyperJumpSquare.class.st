Class {
	#name : #HyperJumpSquare,
	#superclass : #Square,
	#instVars : [
		'parsecSequence'
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
HyperJumpSquare class >> with: aNumberOfJumps [

	^self new initializeWith: aNumberOfJumps 
]

{ #category : #'executing effects' }
HyperJumpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship by: parsecSequence nextInSequence.
]

{ #category : #initialization }
HyperJumpSquare >> initializeWith: someJumps [

	parsecSequence := TrenchRunSequence withAll:
		                (someJumps sorted: [ :jumpA :jumpB | jumpA > jumpB ])
]
