Class {
	#name : #AtomicBombSlot,
	#superclass : #SuperclassSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'executing effects' }
AtomicBombSlot >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 1 - (game squareOf: spaceship)
]
