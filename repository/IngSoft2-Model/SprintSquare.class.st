Class {
	#name : #SprintSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
SprintSquare >> = anotherSprintSquare [

	^ (self className match: anotherSprintSquare className)
]

{ #category : #'executing effects' }
SprintSquare >> applyEffectTo: spaceship from: game [

	| forwardSquares |
	forwardSquares := game amountOfCardsOf: spaceship.
	
	game move: spaceship anAmountOf: forwardSquares.
]

{ #category : #comparing }
SprintSquare >> hash [ 

	^ self className hash
]
