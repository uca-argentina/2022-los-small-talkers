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

{ #category : #accessing }
CancellationCard >> a: spaceship playsCardIn: game aimingAt: aPlayedPermanentCard [

	game playedCardStack remove: aPlayedPermanentCard.
	game history add: (PlayCardEvent
			 using: (CancellationCard ownedBy: spaceship)
			 aimedAt: aPlayedPermanentCard)
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
