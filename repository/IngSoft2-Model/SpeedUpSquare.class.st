Class {
	#name : #SpeedUpSquare,
	#superclass : #Square,
	#instVars : [
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SpeedUpSquare >> = anotherSpeedUpSquare [

	^(self className match: anotherSpeedUpSquare className)
]

{ #category : #'Reverse Polarity Card handling' }
SpeedUpSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
SpeedUpSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: 4
]

{ #category : #'executing effects' }
SpeedUpSquare >> applyReverseEffectTo: spaceship from: game [
	
	game moveAllSpaceshipsAnAmountOf: 4 exceptFor: spaceship.
]

{ #category : #comparing }
SpeedUpSquare >> hash [ 

	^ self className hash
]

{ #category : #'Reverse Polarity Card handling' }
SpeedUpSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [^0]
		ifNotNil: [^playedReversePolarityCardCount].
]
