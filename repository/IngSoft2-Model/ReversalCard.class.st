Class {
	#name : #ReversalCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReversalCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
ReversalCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #accessing }
ReversalCard >> a: spaceship playsCardIn: game aimingAt: target [
	
	game currentPlayer = spaceship ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].
	game playedCardStack
		add: (ReversalCard  ownedBy: spaceship)
		aimingAt: target.
	game history add: (PlayCardEvent
			 using: (ReversalCard ownedBy: spaceship)
			 aimedAt: target)
]

{ #category : #'applying effects' }
ReversalCard >> applyEffectsUsing: anInitialValue [

	^ anInitialValue + 5
]

{ #category : #comparing }
ReversalCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
ReversalCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
ReversalCard >> owner [ 

	^ owner
]
