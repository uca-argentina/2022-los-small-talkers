Class {
	#name : #FreedomCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
FreedomCard class >> ownedBy: spaceship [

	^ self new initializeOwnedBy: spaceship
	
]

{ #category : #comparing }
FreedomCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
FreedomCard >> hash [

	^ self className hash bitXor: self owner hash
]

{ #category : #initialization }
FreedomCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship
]

{ #category : #accessing }
FreedomCard >> isPlayedIn: game [

	game jail free: owner.
	^ PlayCardEvent using: self aimedAt: owner
]

{ #category : #accessing }
FreedomCard >> owner [

	^ owner
]
