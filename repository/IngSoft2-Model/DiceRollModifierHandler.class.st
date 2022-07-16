Class {
	#name : #DiceRollModifierHandler,
	#superclass : #Object,
	#instVars : [
		'rollableObject',
		'rollModifierDictionary'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DiceRollModifierHandler class >> with: aRollableObject assignedTo: spaceships [

	^ self new initializeWith: aRollableObject assignedTo: spaceships
]

{ #category : #initialization }
DiceRollModifierHandler >> initializeWith: aRollableObject assignedTo: spaceships [

	rollableObject := aRollableObject.
	rollModifierDictionary := Dictionary newFromKeys: spaceships andValues: (spaceships collect: [ :spaceship | NoDiceRollModifier new ]).
]
