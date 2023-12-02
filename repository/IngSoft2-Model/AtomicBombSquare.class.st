Class {
	#name : #AtomicBombSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
AtomicBombSquare >> = anotherAtomicBombSquare [

	^ (self className match: anotherAtomicBombSquare className)
]

{ #category : #'executing effects' }
AtomicBombSquare >> applyEffectTo: spaceship from: game [

	game moveAllSpaceshipToSquareOne.
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self).
]

{ #category : #'executing effects' }
AtomicBombSquare >> applyReverseEffectTo: spaceship from: game [

	game moveAllSpaceshipToSquareOne.
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self).
]

{ #category : #'as yet unclassified' }
AtomicBombSquare >> effect [
	^0
]

{ #category : #comparing }
AtomicBombSquare >> hash [ 

	^ self className hash
]
