Class {
	#name : #LeaderboardRecord,
	#superclass : #Object,
	#instVars : [
		'ship',
		'square'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LeaderboardRecord class >> withShip: aSpaceship atSquare: squareNumber [ 

	^self new initializeWithShip: aSpaceship atSquare: squareNumber.
]

{ #category : #initialization }
LeaderboardRecord >> initializeWithShip: aSpaceship atSquare: anInteger [ 
	
	ship := aSpaceship.
	square := anInteger.
]

{ #category : #accessing }
LeaderboardRecord >> ship [
	^ ship.
]

{ #category : #accessing }
LeaderboardRecord >> square [
	^ square.
]
