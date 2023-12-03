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
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #accessing }
DrawCardSquare >> effect [
	^0
]

{ #category : #comparing }
DrawCardSquare >> hash [ 

	^ self className hash
]
