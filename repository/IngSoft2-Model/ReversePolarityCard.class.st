Class {
	#name : #ReversePolarityCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
ReversePolarityCard class >> ownedBy: aSpaceship [

	^self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
ReversePolarityCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner]
]

{ #category : #accessing }
ReversePolarityCard >> a: spaceship playsCardIn: game aimingAt: aSquare [

	game currentPlayer = spaceship ifFalse: [ 
		Error signal:
			'Cannot play permanent card when not in the spaceships turn' ].

	aSquare addReversePolarityCard: (self class ownedBy: spaceship)
]

{ #category : #comparing }
ReversePolarityCard >> hash [
	self subclassResponsibility
]

{ #category : #initialization }
ReversePolarityCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship 
]

{ #category : #accessing }
ReversePolarityCard >> owner [

	^ owner
]
