Class {
	#name : #Die,
	#superclass : #RollableObject,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Die class >> assertValid: aNumberOfSides [

	aNumberOfSides > 2 ifFalse: [ 
		Error signal: 'Number of sides must be greater than 2' ]
]

{ #category : #initialization }
Die class >> with: aNumberOfSides [

	self assertValid: aNumberOfSides.

	^ self new initializeWith: aNumberOfSides
]

{ #category : #arithmetic }
Die >> + anotherRollableObject [

	^ DiceCup withAll: { self. anotherRollableObject }.
]

{ #category : #initialization }
Die >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #accessing }
Die >> maxResult [

	^ numberOfSides
]

{ #category : #rolling }
Die >> roll [

	^ numberOfSides atRandom
]
