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

{ #category : #accessing }
OverloadCard >> a: spaceship playsCardIn: game aimingAt: target [

	game currentPlayer = spaceship ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].
	game playedCardStack
		add: (self class ownedBy: spaceship)
		aimingAt: target.
	game history add: (PlayCardEvent
			 using: (self class ownedBy: spaceship)
			 aimedAt: target)
]

{ #category : #'applying effects' }
OverloadCard >> applyEffectsUsing: anInitialValue [

	^ anInitialValue - 2
]

{ #category : #comparing }
OverloadCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
OverloadCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
OverloadCard >> owner [ 

	^ owner
]
