Class {
	#name : #RepeatCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RepeatCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
RepeatCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
RepeatCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
RepeatCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
RepeatCard >> owner [ 

	^ owner
]
