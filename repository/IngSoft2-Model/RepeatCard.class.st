Class {
	#name : #RepeatCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RepeatCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
RepeatCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
RepeatCard >> hash [

	^ self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
RepeatCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
RepeatCard >> owner [ 

	^ owner
]

{ #category : #accessing }
RepeatCard >> playedBy: spaceship playedIn: game aimingAt: target [

	game lastLandsOnSquareEvent applyEffectTo: target from: game.
	game history add: (Event_CardIsPlayed using: (RepeatCard ownedBy: spaceship) aimedAt: target)
]
