Class {
	#name : #JailSquare,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
JailSquare >> = anotherDrawCardSquare [

	^ self className match: anotherDrawCardSquare className
]

{ #category : #'executing effects' }
JailSquare >> applyEffectTo: spaceship from: game [

	game jail confine: spaceship.
	^ LandsOnSquareEvent from: spaceship landsOn: self
]

{ #category : #comparing }
JailSquare >> hash [

	^ self className hash
]
