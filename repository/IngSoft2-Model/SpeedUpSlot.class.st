Class {
	#name : #SpeedUpSlot,
	#superclass : #BlankSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'executing effects' }
SpeedUpSlot >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 4
]
