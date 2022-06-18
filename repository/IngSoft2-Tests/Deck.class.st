Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cardGenerator'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
Deck class >> handingOver: someCards [

	^self new initializeHandingOver: someCards.
]

{ #category : #initialization }
Deck >> initializeHandingOver: someCards [

	cardGenerator := Gen_CardGenerator of: someCards
]

{ #category : #'taking cards' }
Deck >> take: anAmountOfCards [

	^ cardGenerator next: anAmountOfCards.
]
