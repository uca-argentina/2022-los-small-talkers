Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpeedUpSquare class >> createAtRandom [ 

	^self new
]

{ #category : #'executing effects' }
SpeedUpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 4
]
