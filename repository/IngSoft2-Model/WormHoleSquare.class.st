Class {
	#name : #WormHoleSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
WormHoleSquare >> = anotherWormHoleSquare [

	^( self className match: anotherWormHoleSquare className)
]

{ #category : #'executing effects' }
WormHoleSquare >> applyEffectTo: spaceship from: game [

	game move: spaceship anAmountOf: -4.
	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #comparing }
WormHoleSquare >> hash [ 

	^ self className hash
]
