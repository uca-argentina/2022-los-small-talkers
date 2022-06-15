Class {
	#name : #RedoCard,
	#superclass : #InstantCard,
	#instVars : [
		'owner'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
RedoCard class >> ownedBy: aSpaceship [

	^ self new initializeOwnedBy: aSpaceship.
]

{ #category : #comparing }
RedoCard >> = anotherCard [

	^ (self className match: anotherCard className) and: [ 
		  owner = anotherCard owner ]
]

{ #category : #comparing }
RedoCard >> hash [

	self className hash bitXor:  self owner hash 
]

{ #category : #initialization }
RedoCard >> initializeOwnedBy: aSpaceship [

	owner := aSpaceship.
]

{ #category : #accessing }
RedoCard >> owner [ 

	^ owner
]
