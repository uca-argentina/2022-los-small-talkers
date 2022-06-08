Class {
	#name : #SequenceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceTest >> testSequenceHoldsACorrectfullyOrderedCollectionOfSpaceships [

	| enterprise starfighter sequence |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.

	sequence := TrenchRunSequence withAll: { 
			            enterprise.
			            starfighter }.

	self assert: [ 
		sequence nextInSequence == enterprise and: [ 
			sequence nextInSequence == starfighter ] ]
]

{ #category : #tests }
SequenceTest >> testSequenceResetsWhenGoesOverAllElements [

	| sequence |
	sequence := TrenchRunSequence withAll: { 1. 2 }.

	self assert: sequence nextInSequence equals: 1.
	self assert: sequence nextInSequence equals: 2.
	self assert: sequence nextInSequence equals: 1
]
