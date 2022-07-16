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

	^ self className hash bitXor: self owner hash
]

{ #category : #initialization }
AccelerationCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
AccelerationCard >> isPlayedIn: game aimingAt: target [

	game turnHandler currentSpaceshipTurn = owner ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].

	game cardHandler playedCardStack add: self aimingAt: game spaceships.
	^ PlayCardEvent using: self aimedAt: game spaceships
]

{ #category : #accessing }
AccelerationCard >> owner [ 

	^ owner
]
