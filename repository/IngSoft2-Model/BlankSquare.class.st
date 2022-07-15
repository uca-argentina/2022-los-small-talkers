Class {
	#name : #BlankSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
BlankSquare >> = anotherBlankSquare [

	^(self className match: anotherBlankSquare className).
]

{ #category : #'executing effects' }
BlankSquare >> applyEffectTo: spaceship from: game [

	^ LandsOnSquareEvent from: spaceship landsOn: self
]

{ #category : #comparing }
BlankSquare >> hash [ 

	self className hash
]
