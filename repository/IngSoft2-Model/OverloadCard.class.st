Class {
	#name : #OverloadCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OverloadCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
OverloadCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #'applying effects' }
OverloadCard >> applyEffectsUsing: anInitialValue [

	^ anInitialValue - 2
]

{ #category : #comparing }
OverloadCard >> hash [

	^ self className hash bitXor: self owner hash
]

{ #category : #initialization }
OverloadCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
OverloadCard >> isPlayedIn: game aimingAt: target [

	game turnHandler currentSpaceshipTurn = owner ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].
	game cardHandler playedCardStack add: self aimingAt: target.
	^ PlayCardEvent using: self aimedAt: target
]

{ #category : #accessing }
OverloadCard >> owner [ 

	^ owner
]
