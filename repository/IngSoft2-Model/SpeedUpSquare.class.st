Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
SpeedUpSquare class >> createAtRandom [ 

	^self new
]

{ #category : #comparing }
SpeedUpSquare >> = anotherSpeedUpSquare [

	^(self className match: anotherSpeedUpSquare className)
]

{ #category : #'executing effects' }
SpeedUpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 4.
	game add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #comparing }
SpeedUpSquare >> hash [ 

	^ self className hash
]
