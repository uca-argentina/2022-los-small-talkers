Class {
	#name : #TrenchRunSequenceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TrenchRunSequenceTest >> testSequenceHoldsACorrectfullyOrderedCollectionOfSpaceships [

	| enterprise starfighter sequence |
	enterprise := 'Enterprise'.
	starfighter := 'Starfighter'.

	sequence := TrenchRunSequence withAll: { 
			            enterprise.
			            starfighter }.

	self assert: [ 
		sequence next == enterprise and: [ sequence next == starfighter ] ]
]

{ #category : #tests }
TrenchRunSequenceTest >> testSequenceResetsWhenGoesOverAllElements [

	| sequence |
	sequence := TrenchRunSequence withAll: { 1. 2 }.

	self assert: sequence next equals: 1.
	self assert: sequence next equals: 2.
	self assert: sequence next equals: 1
]
