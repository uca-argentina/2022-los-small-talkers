Class {
	#name : #AccelerationCard,
	#superclass : #PermanentCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
AccelerationCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
AccelerationCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ owner = anotherCard owner ].
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

{ #category : #'playing card' }
AccelerationCard >> playCardIn: game aimingAt: target [

	game onHandCardStack take: self class fromHandsOf: owner.
	game playedCardStack add: self aimingAt: target.
]
