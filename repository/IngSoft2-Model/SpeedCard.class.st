Class {
	#name : #SpeedCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SpeedCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
SpeedCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
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

{ #category : #'playing card' }
SpeedCard >> playCardIn: game aimingAt: target [

	game onHandCardStack take: self class fromHandsOf: owner.
	game playedCardStack add: self aimingAt: target.
]
