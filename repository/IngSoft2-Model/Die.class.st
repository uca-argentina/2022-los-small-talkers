Class {
	#name : #Die,
	#superclass : #Object,
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

{ #category : #initialization }
Die >> initializeWith: aNumberOfSides [

	numberOfSides := aNumberOfSides
]

{ #category : #accessing }
Die >> numberOfSides [

	^numberOfSides
]

{ #category : #rolling }
Die >> roll [

	^ numberOfSides atRandom
]
