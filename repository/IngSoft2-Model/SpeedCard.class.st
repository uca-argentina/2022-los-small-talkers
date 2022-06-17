Class {
	#name : #SpeedCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
SpeedCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #'applying effects' }
SpeedCard >> applyEffectsUsing: anInitialValue [

	^ anInitialValue + 1
]

{ #category : #comparing }
SpeedCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
SpeedCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
SpeedCard >> owner [ 

	^ owner
]

{ #category : #accessing }
SpeedCard >> playedBy: spaceship playedIn: game aimingAt: target [

	game currentPlayer = spaceship ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].
	game playedCardStack
		add: (SpeedCard  ownedBy: spaceship)
		aimingAt: target.
	game history add: (Event_CardIsPlayed
			 using: (SpeedCard ownedBy: spaceship)
			 aimedAt: target)
]
