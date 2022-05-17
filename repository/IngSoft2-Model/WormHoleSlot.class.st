Class {
	#name : #WormHoleSlot,
	#superclass : #BlankSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'executing effects' }
WormHoleSlot >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4
]
