Class {
	#name : #HyperJumpSquare,
	#superclass : #Square,
	#instVars : [
		'jumpSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
HyperJumpSquare class >> new [

	^ super new initializeWith: self randomizeParsecSequence
]

{ #category : #'parameter randomization' }
HyperJumpSquare class >> randomizeParsecSequence [

	^((1 to: 3 atRandom by: 1) collect: [:aNumber | (Parsec amounting: (20 atRandom)) ])
]

{ #category : #'instance creation' }
HyperJumpSquare class >> with: aNumberOfDistanceJumps [

	^ self new initializeWith: aNumberOfDistanceJumps 
]

{ #category : #comparing }
HyperJumpSquare >> = anotherHyperJumpSquare [

	^(jumpSequence = anotherHyperJumpSquare jumpSequence and: [ anotherHyperJumpSquare className match: self className ])
]

{ #category : #'executing effects' }
HyperJumpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship by: jumpSequence next.
	^ LandsOnSquareEvent from: spaceship landsOn: self
]

{ #category : #comparing }
HyperJumpSquare >> hash [ 

	^( self className hash bitXor: ( jumpSequence hash ))
]

{ #category : #initialization }
HyperJumpSquare >> initializeWith: aNumberOfDistanceJumps [

	jumpSequence := TrenchRunSequence withAll:
		                  (aNumberOfDistanceJumps sorted: [ :jumpA :jumpB | 
			                   (jumpA > jumpB)  ])
]

{ #category : #initialization }
HyperJumpSquare >> jumpSequence [

	^ jumpSequence 
]
