Class {
	#name : #DrawCardSquare,
	#superclass : #Square,
	#instVars : [
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
DrawCardSquare >> = anotherDrawCardSquare [

	^(self className match: anotherDrawCardSquare className)
]

{ #category : #'Reverse Polarity Card handling' }
DrawCardSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
DrawCardSquare >> applyEffectTo: spaceship from: game [

	game take: 1 andGiveToHandsOf: spaceship
]

{ #category : #'executing effects' }
DrawCardSquare >> applyReverseEffectTo: spaceship from: game [

		| target |
	target := game spaceships.
	{ spaceship } do: [ :ship | target remove: ship ].

	target do: [ :ship | game take: 1 andGiveToHandsOf: ship].
]

{ #category : #comparing }
DrawCardSquare >> hash [ 

	^ self className hash
]

{ #category : #'Reverse Polarity Card handling' }
DrawCardSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [ ^ 0 ]
		ifNotNil: [ ^ playedReversePolarityCardCount ]
]
