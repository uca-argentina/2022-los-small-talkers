Class {
	#name : #WormHoleSlot,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
WormHoleSlot >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4. 
]
