Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'ship',
		'square'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> of: aSpaceship atSquare: squareNumber [ 

	^self new initializeOf: aSpaceship atSquare: squareNumber.
]

{ #category : #initialization }
Position >> initializeOf: aSpaceship atSquare: aSquare [ 
	
	ship := aSpaceship.
	square := aSquare.
]

{ #category : #accessing }
Position >> ship [
	^ ship.
]

{ #category : #accessing }
Position >> square [
	^ square.
]
