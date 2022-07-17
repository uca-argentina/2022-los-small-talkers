Class {
	#name : #ReverseCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReverseCard class >> ownedBy: spaceship [

	^ self new initializeOwnedBy: spaceship
]

{ #category : #comparing }
ReverseCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
ReverseCard >> hash [

	^ self className hash bitXor: self owner hash
]

{ #category : #initialization }
ReverseCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship
]

{ #category : #testing }
ReverseCard >> isPlayedIn: game [

	game turnHandler reverseOrderOfTurns.
	^ PlayCardEvent using: self aimedAt: {  }
]

{ #category : #accessing }
ReverseCard >> owner [

	^ owner
]
