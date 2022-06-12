Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardGenerator'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
Deck class >> handingOver: someCards [

	^self new initializeHandingOver: someCards.
]

{ #category : #initialization }
Deck >> initializeHandingOver: someCards [

	cardGenerator := RandomObjectGenerator of: someCards.
	
]

{ #category : #'as yet unclassified' }
Deck >> takeCard [

	^ cardGenerator next.
]
