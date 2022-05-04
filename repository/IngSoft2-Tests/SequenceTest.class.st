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
	
	sequence := TrenchRunSpaceshipSequence withAll: { aFirstShip. aSecondShip }.
	
	self assert: [ sequence nextInSequence == aFirstShip and: [ sequence nextInSequence == aSecondShip  ] ].
]
