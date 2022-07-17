Class {
	#name : #CardHandler,
	#superclass : #Object,
	#instVars : [
		'unplayedCards',
		'playedCards',
		'cardDeck'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardHandler class >> withAll: spaceships drawingFrom: aDeckOfCards [

	^ self new initializeWithAll: spaceships drawingFrom: aDeckOfCards.
]

{ #category : #'effect cancelling' }
CardHandler >> cancelEffectOf: aPlayedPermanentCard [

	playedCards cancel: aPlayedPermanentCard
]

{ #category : #'card playing' }
CardHandler >> give: cardType toHandsOf: spaceship [

	unplayedCards give: cardType toHandsOf: spaceship
]

{ #category : #initialization }
CardHandler >> initializeWithAll: spaceships drawingFrom: aDeckOfCards [

	unplayedCards := OnHandCardStack new.
	playedCards := PlayedPermanentCardStack new.
	cardDeck := aDeckOfCards.

	spaceships do: [ :spaceship | self take: 2 andGiveTo: spaceship ]
]

{ #category : #accessing }
CardHandler >> playedCardStack [

	^ playedCards
]

{ #category : #'drawing cards' }
CardHandler >> take: anAmountOfCards andGiveTo: spaceship [

	|drawnCards|
	drawnCards := cardDeck take: anAmountOfCards.
	drawnCards do: [ :singleDrawnCard | unplayedCards give: singleDrawnCard toHandsOf: spaceship ]
]

{ #category : #'removing card from player' }
CardHandler >> take: aCard fromHandsOf: aSpaceship [

	unplayedCards take: aCard fromHandsOf: aSpaceship
]
