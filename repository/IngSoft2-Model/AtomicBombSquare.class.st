Class {
	#name : #AtomicBombSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
AtomicBombSquare class >> createAtRandom [

	^self new
]

{ #category : #'executing effects' }
AtomicBombSquare >> applyEffectTo: spaceship from: game [

	game moveAllSpaceshipToSquareOne.
]
