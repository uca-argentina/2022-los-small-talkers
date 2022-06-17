Class {
	#name : #RedoCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
RedoCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
RedoCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #accessing }
RedoCard >> a: spaceship playsCardIn: game aimingAt: target [

	game lastPlayedCard a: spaceship playsCardIn: game aimingAt: target
]

{ #category : #comparing }
RedoCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
RedoCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
RedoCard >> owner [ 

	^ owner
]
