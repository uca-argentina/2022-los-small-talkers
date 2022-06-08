Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
WormHoleSquare class >> createAtRandom [

	^self new
]

{ #category : #'executing effects' }
WormHoleSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4
]
