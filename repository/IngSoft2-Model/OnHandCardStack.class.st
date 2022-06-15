Class {
	#name : #OnHandCardStack,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OnHandCardStack class >> tracking: spaceships [

	^ self new initializeTracking: spaceships
]

{ #category : #'as yet unclassified' }
OnHandCardStack >> assign: aCardType toOwner: aSpaceship [

	cards add: (OnHandCard of: aCardType ownedBy: aSpaceship)
]

{ #category : #accessing }
OnHandCardStack >> cards [

	^ cards
]

{ #category : #initialization }
OnHandCardStack >> initializeTracking: spaceships [

	cards := OrderedCollection new.
]

{ #category : #removing }
OnHandCardStack >> play: cardType ownedBy: spaceship [

	cards
		remove: (OnHandCard of: cardType ownedBy: spaceship)
		ifAbsent: [ Error signal: 'Player does not own the selected card' ]
]
