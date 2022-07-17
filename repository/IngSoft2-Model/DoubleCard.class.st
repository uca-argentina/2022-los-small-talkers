Class {
	#name : #DoubleCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DoubleCard class >> ownedBy: spaceship [

	^ self new initializeOwnedBy: spaceship.
	
]

{ #category : #comparing }
DoubleCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
DoubleCard >> hash [

	^ self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
DoubleCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship
]

{ #category : #accessing }
DoubleCard >> isPlayedIn: game [

	game turnHandler repeatTurn.
	^ PlayCardEvent using: self aimedAt: game turnHandler currentSpaceshipTurn
]

{ #category : #accessing }
DoubleCard >> owner [

	^ owner
]
