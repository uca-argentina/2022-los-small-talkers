Class {
	#name : #SequenceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceTest >> testSequenceHoldsACorrectfullyOrderedCollectionOfSpaceships [

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
SequenceTest >> testSequenceResetsWhenGoesOverAllElements [

	| sequence |
	sequence := TrenchRunSequence withAll: { 1. 2 }.

	self assert: sequence next equals: 1.
	self assert: sequence next equals: 2.
	self assert: sequence next equals: 1
]
