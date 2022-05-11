Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'length',
		'squares'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aLength [
	aLength > 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'as yet unclassified' }
Board class >> blankSized: aSize [
	self assertValid: aSize.
	^self new initializeBlankSized: aSize.
]

{ #category : #'instance creation' }
Board class >> sized: aLength [ 
	self assertValid: aLength.
	^ self new initializeSized: aLength.
]

{ #category : #'as yet unclassified' }
Board >> applyEffectTo: spaceship at: square from: game [

	(squares at: square) applyEffectTo: spaceship from: game.
]

{ #category : #initialization }
Board >> initializeBlankSized: aLength [

	length := aLength.
	squares := OrderedCollection new.
	(1 to: length by: 1) do: [:i | squares add: BlankSlot new ].
]

{ #category : #initialization }
Board >> initializeSized: aLength [

	length := aLength.
]

{ #category : #'accessing - attributes' }
Board >> length [
  ^length.
]
