Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AccelerationCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
AccelerationCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ owner = anotherCard owner ].
]

{ #category : #'applying effects' }
AccelerationCard >> applyEffectsUsing: anInitialValue [

	^ anInitialValue + 1
]

{ #category : #comparing }
AccelerationCard >> hash [

	self className hash bitXor: ( self owner hash )
]

{ #category : #initialization }
AccelerationCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
AccelerationCard >> owner [ 

	^ owner
]

{ #category : #accessing }
AccelerationCard >> playedBy: spaceship playedIn: game aimingAt: target [

	game currentPlayer = spaceship ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].
	game playedCardStack add: (AccelerationCard ownedBy: spaceship) aimingAt: target.
	game history add: (Event_CardIsPlayed using: (AccelerationCard ownedBy: spaceship) aimedAt: target)
]
