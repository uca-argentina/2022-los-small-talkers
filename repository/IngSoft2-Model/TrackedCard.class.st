Class {
	#name : #TrackedCard,
	#superclass : #Object,
	#instVars : [
		'type',
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrackedCard class >> of: cardType ownedBy: aSpaceship [

	^ self new initializeOf: cardType ownedBy: aSpaceship.
]

{ #category : #comparing }
TrackedCard >> = anotherTrackedCard [

	^ (anotherTrackedCard className match: 'TrackedCard')
	  and: [anotherTrackedCard owner = (self owner)
	  and: [ anotherTrackedCard type = (self type)]]
]

{ #category : #comparing }
TrackedCard >> hash [ 
	
	^ (self owner hash bitXor: [ self type hash]).
]

{ #category : #initialization }
TrackedCard >> initializeOf: cardType ownedBy: aSpaceship [

	type := cardType.
	owner := aSpaceship.
]

{ #category : #accessing }
TrackedCard >> owner [ 

	^ owner
]

{ #category : #accessing }
TrackedCard >> type [

	^ type
]
