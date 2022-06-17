Class {
	#name : #CancellationCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CancellationCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
CancellationCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
CancellationCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
CancellationCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
CancellationCard >> owner [ 

	^ owner
]

{ #category : #accessing }
CancellationCard >> playedBy: spaceship playedIn: game aimingAt: aPlayedPermanentCard [

	game playedCardStack remove: aPlayedPermanentCard.
	game history add: (Event_CardIsPlayed
			 using: (CancellationCard ownedBy: spaceship)
			 aimedAt: aPlayedPermanentCard)
]
