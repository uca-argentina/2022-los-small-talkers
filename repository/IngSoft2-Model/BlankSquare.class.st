Class {
	#name : #BlankSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
BlankSquare class >> createAtRandom [

	^self new
]

{ #category : #comparing }
BlankSquare >> = anotherBlankSquare [

	^(self className match: anotherBlankSquare className).
]

{ #category : #'executing effects' }
BlankSquare >> applyEffectTo: spaceship from: game [

	game add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #comparing }
BlankSquare >> hash [ 

	self className hash
]
