Class {
	#name : #Square,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #operations }
Square class >> createAtRandom [

	self subclassResponsibility 
]

{ #category : #comparing }
Square >> = anotherSquare [

	self subclassResponsibility
]

{ #category : #'executing effects' }
Square >> applyEffectTo: spaceship from: game [

	self subclassResponsibility
]

{ #category : #comparing }
Square >> hash [

	self subclassResponsibility
]
