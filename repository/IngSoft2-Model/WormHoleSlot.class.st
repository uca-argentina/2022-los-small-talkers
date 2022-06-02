Class {
	#name : #WormHoleSlot,
	#superclass : #SuperclassSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'executing effects' }
WormHoleSlot >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4
]
