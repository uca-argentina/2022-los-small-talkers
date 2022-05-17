Class {
	#name : #SequenceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
SequenceTest >> testSequenceHoldsACorrectfullyOrderedCollectionOfSpaceships [
	| aFirstShip aSecondShip sequence |
	aFirstShip := Spaceship named: 'Planet Express'.
	aSecondShip := Spaceship named: 'Enterprise'.
	
	sequence := TrenchRunSequence withAll: { aFirstShip. aSecondShip }.
	
	self assert: [ sequence nextInSequence == aFirstShip and: [ sequence nextInSequence == aSecondShip  ] ].
]

{ #category : #tests }
SequenceTest >> testSequenceResetsWhenGoesOverAllElements [
	
	|sequence|
	sequence := TrenchRunSequence withAll: { 1 . 2 }.
	
	self assert: sequence nextInSequence equals: 1.
	self assert: sequence nextInSequence equals: 2.
	self assert: sequence nextInSequence equals: 1.
]
