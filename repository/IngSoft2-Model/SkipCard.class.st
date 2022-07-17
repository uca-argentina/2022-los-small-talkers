Class {
	#name : #SkipCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SkipCard class >> ownedBy: spaceship [

	^ self new initializeOwnedBy: spaceship
]

{ #category : #comparing }
SkipCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
SkipCard >> hash [

	^ self className hash bitXor: self owner hash
]

{ #category : #initialization }
SkipCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship
]

{ #category : #accessing }
SkipCard >> isPlayedIn: game [

	|spaceshipSkipped|
	spaceshipSkipped := game turnHandler currentSpaceshipTurn.
	game playNextTurn.
	^ PlayCardEvent using: self aimedAt: spaceshipSkipped
]

{ #category : #accessing }
SkipCard >> owner [

	^ owner
]
