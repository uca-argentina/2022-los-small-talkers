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

	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #'executing effects' }
BlankSquare >> applyReverseEffectTo: spaceship from: game [

	game history add: (LandsOnSquareEvent from: spaceship landsOn: self)
]

{ #category : #'as yet unclassified' }
BlankSquare >> effect [
	^0
]

{ #category : #comparing }
BlankSquare >> hash [ 

	self className hash
]
