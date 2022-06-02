Class {
	#name : #SpeedUpSlot,
	#superclass : #SuperclassSlot,
	#category : #'IngSoft2-Model'
}

{ #category : #'executing effects' }
SpeedUpSlot >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 4
]
