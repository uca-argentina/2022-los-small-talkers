Class {
	#name : #HyperJumpSquare,
	#superclass : #Square,
	#instVars : [
		'parsecSequence'
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

{ #category : #'executing effects' }
HyperJumpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship by: parsecSequence next.
	game history add: (Event_LandsOnSquare from: spaceship landsOn: self)
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
