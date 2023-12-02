Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SpeedUpSquare >> = anotherSpeedUpSquare [

	^(self className match: anotherSpeedUpSquare className)
]

{ #category : #'executing effects' }
SpeedUpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 4.
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #'executing effects' }
SpeedUpSquare >> applyReverseEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4.
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #'as yet unclassified' }
SpeedUpSquare >> effect [
	^4
]

{ #category : #comparing }
SpeedUpSquare >> hash [ 

	^ self className hash
]
