Class {
	#name : #RandomDie,
	#superclass : #Object,
	#instVars : [
		'numberOfSides'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomDie class >> assertValid: aNumberOfSides [

	aNumberOfSides > 2 ifFalse: [ 
		Error signal: 'Number of sides must be greater than 2' ]
]

{ #category : #initialization }
RandomDie class >> with: aNumberOfSides [

	self assertValid: aNumberOfSides.

	^ self new initializeWith: aNumberOfSides
]

{ #category : #initialization }
RandomDie >> initializeWith: aNumberOfSides [ 
	numberOfSides := aNumberOfSides.
]

{ #category : #rolling }
RandomDie >> roll [
	^ numberOfSides atRandom.
]
