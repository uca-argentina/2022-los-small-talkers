Class {
	#name : #CardTracker,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CardTracker class >> tracking: spaceships [

	^ self new initializeTracking: spaceships
]

{ #category : #accessing }
CardTracker >> cards [

	^ cards
]

{ #category : #initialization }
CardTracker >> initializeTracking: spaceships [

	cards := OrderedCollection new.
]

{ #category : #removing }
CardTracker >> play: cardType ownedBy: spaceship [

	cards
		remove: (TrackedCard of: cardType ownedBy: spaceship)
		ifAbsent: [ Error signal: 'Player does not own the selected card' ]
]

{ #category : #'assigning cards' }
CardTracker >> take: aNumberOfCards from: aDeck andAssignTo: spaceship [

	cards addAll: ((aDeck take: aNumberOfCards) collect: [ :cardType | TrackedCard of: cardType ownedBy: spaceship ]).
	
]
