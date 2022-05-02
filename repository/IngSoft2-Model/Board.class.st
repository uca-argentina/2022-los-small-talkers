Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'length'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aLength [
	aLength > 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'instance creation' }
Board class >> sized: aLength [ 
	self assertValid: aLength.
	^ self new initializeSized: aLength.
]

{ #category : #initialization }
Board >> initializeSized: aLength [

	length := aLength.
]

{ #category : #'accessing - attributes' }
Board >> length [
  ^length.
]
