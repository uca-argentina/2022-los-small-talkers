Class {
	#name : #Square,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Square >> = anotherSquare [

	self subclassResponsibility
]

{ #category : #comparing }
Square >> addReversePolarityCard: aReversePolarityCard [

	self subclassResponsibility
]

{ #category : #'executing effects' }
Square >> applyEffectTo: spaceship from: game [

	self subclassResponsibility
]

{ #category : #'executing effects' }
Square >> applyReverseEffectTo: spaceship from: game [
	self subclassResponsibility 
]

{ #category : #comparing }
Square >> hash [

	self subclassResponsibility
]

{ #category : #'executing effects' }
Square >> playedReversePolarityCardCount [

	self subclassResponsibility
]
