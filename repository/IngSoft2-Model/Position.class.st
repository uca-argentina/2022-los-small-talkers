Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'ship',
		'square',
		'lap'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> of: aSpaceship at: square lap: lapNumber [

	^ self new initializeOf: aSpaceship at: square lap: lapNumber.
]

{ #category : #comparing }
Position >> = anotherPosition [

	^ (self className = anotherPosition className) and: [ 
		  lap = anotherPosition lap and: [ 
			  ship = anotherPosition ship and: [ 
				  square = anotherPosition square ] ] ]
]

{ #category : #initialization }
Position >> initializeOf: aSpaceship at: aSquare lap: lapNumber [

	ship := aSpaceship.
	square := aSquare.
	lap := lapNumber.
]

{ #category : #accessing }
Position >> lap [

	^lap.
]

{ #category : #accessing }
Position >> ship [
	^ ship.
]

{ #category : #accessing }
Position >> square [
	^ square.
]
