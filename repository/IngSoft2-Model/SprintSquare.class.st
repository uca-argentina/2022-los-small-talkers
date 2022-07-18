Class {
	#name : #SprintSquare,
	#superclass : #Square,
	#instVars : [
		'playedReversePolarityCardCount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SprintSquare >> = anotherSprintSquare [

	^ (self className match: anotherSprintSquare className)
]

{ #category : #'Reverse Polarity Card handling' }
SprintSquare >> addReversePolarityCard: aReversePolarityCard [

	playedReversePolarityCardCount
		ifNil: [ playedReversePolarityCardCount := 1 ]
		ifNotNil: [ playedReversePolarityCardCount := 0 ]
]

{ #category : #'executing effects' }
SprintSquare >> applyEffectTo: spaceship from: game [

	| forwardSquares |
	forwardSquares := game amountOfCardsOf: spaceship.

	game move: spaceship anAmountOf: forwardSquares
]

{ #category : #'executing effects' }
SprintSquare >> applyReverseEffectTo: spaceship from: game [

	| forwardSquares|
	forwardSquares := game amountOfCardsOf: spaceship.
	
	game moveAllSpaceshipsAnAmountOf: forwardSquares  exceptFor: spaceship.
	
]

{ #category : #comparing }
SprintSquare >> hash [ 

	^ self className hash
]

{ #category : #'Reverse Polarity Card handling' }
SprintSquare >> playedReversePolarityCardCount [

	playedReversePolarityCardCount
		ifNil: [ ^ 0 ]
		ifNotNil: [ ^ playedReversePolarityCardCount ]
]
