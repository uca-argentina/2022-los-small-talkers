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

	^ self className hash bitXor: self owner hash
]

{ #category : #initialization }
CancellationCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
CancellationCard >> isPlayedIn: game aimingAt: aPlayedPermanentCard [

	game cardHandler cancelEffectOf: aPlayedPermanentCard.
	^ PlayCardEvent using: self aimedAt: aPlayedPermanentCard
]

{ #category : #accessing }
CancellationCard >> owner [ 

	^ owner
]
