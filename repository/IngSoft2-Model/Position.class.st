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
Position class >> of: aSpaceship at: square [

	^ self new initializeOf: aSpaceship at: square
]

{ #category : #initialization }
Position >> initializeOf: aSpaceship at: aSquare [ 
	
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
