Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#instVars : [
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
WormHoleSquare >> = anotherWormHoleSquare [

	^( self className match: anotherWormHoleSquare className)
]

{ #category : #'Reverse Polarity Card handling' }
WormHoleSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
WormHoleSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4
]

{ #category : #'executing effects' }
WormHoleSquare >> applyReverseEffectTo: spaceship from: game [

game moveAllSpaceshipsAnAmountOf: -4 exceptFor: spaceship.
]

{ #category : #comparing }
WormHoleSquare >> hash [ 

	^ self className hash
]

{ #category : #'Reverse Polarity Card handling' }
WormHoleSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [ ^ 0 ]
		ifNotNil: [ ^ playedReversePolarityCardCount ]
]
