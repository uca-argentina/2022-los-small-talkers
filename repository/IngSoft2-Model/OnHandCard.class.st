Class {
	#name : #OnHandCard,
	#superclass : #Object,
	#instVars : [
		'type',
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
OnHandCard class >> of: cardType ownedBy: aSpaceship [

	^ self new initializeOf: cardType ownedBy: aSpaceship.
]

{ #category : #comparing }
OnHandCard >> = anotherTrackedCard [

	^ (anotherTrackedCard className match: 'TrackedCard')
	  and: [anotherTrackedCard owner = (self owner)
	  and: [ anotherTrackedCard type = (self type)]]
]

{ #category : #comparing }
OnHandCard >> hash [ 
	
	^ (self owner hash bitXor: [ self type hash]).
]

{ #category : #initialization }
OnHandCard >> initializeOf: cardType ownedBy: aSpaceship [

	type := cardType.
	owner := aSpaceship.
]

{ #category : #accessing }
OnHandCard >> owner [ 

	^ owner
]

{ #category : #accessing }
OnHandCard >> type [

	^ type
]
