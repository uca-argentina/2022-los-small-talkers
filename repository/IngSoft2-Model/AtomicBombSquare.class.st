Class {
	#name : #AtomicBombSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AtomicBombSquare class >> createAtRandom [

	^self new
]

{ #category : #comparing }
AtomicBombSquare >> = anotherAtomicBombSquare [

	^ (self className match: anotherAtomicBombSquare className)
]

{ #category : #'executing effects' }
AtomicBombSquare >> applyEffectTo: spaceship from: game [

	game moveAllSpaceshipToSquareOne.
	game add: (LandsOnSquareEvent from: spaceship landsOn: self).
]

{ #category : #comparing }
AtomicBombSquare >> hash [ 

	^ self className hash
]
