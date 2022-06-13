Class {
	#name : #DrawCardSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
DrawCardSquare class >> createAtRandom [

	^ self new.
]

{ #category : #comparing }
DrawCardSquare >> = anotherDrawCardSquare [

	^(self className match: anotherDrawCardSquare className)
]

{ #category : #'executing effects' }
DrawCardSquare >> applyEffectTo: spaceship from: game [

	game take: 1 andAssignTo: spaceship.
	game add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #comparing }
DrawCardSquare >> hash [ 

	^ self className hash
]
