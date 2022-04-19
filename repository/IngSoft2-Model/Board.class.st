Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'length',
		'leaderboard',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assertValid: aLength [
	aLength > 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'instance creation' }
Board class >> sized: aLength [ 
	self assertValid: aLength.
	^ self new initializeWith: aLength.
]

{ #category : #initialization }
Board >> associateToGame: aGameInstance [ 
	game := aGameInstance.
]

{ #category : #initialization }
Board >> initializeWith: aLength [ 
	length := aLength.
	leaderboard := Dictionary new.
]

{ #category : #'accessing - attributes' }
Board >> length [
  ^length.
]
