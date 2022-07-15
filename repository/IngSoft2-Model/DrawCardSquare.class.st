Class {
	#name : #DrawCardSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
DrawCardSquare >> = anotherDrawCardSquare [

	^(self className match: anotherDrawCardSquare className)
]

{ #category : #'executing effects' }
DrawCardSquare >> applyEffectTo: spaceship from: game [

	game take: 1 andGiveToHandsOf: spaceship.
	^ LandsOnSquareEvent from: spaceship landsOn: self
]

{ #category : #comparing }
DrawCardSquare >> hash [ 

	^ self className hash
]
