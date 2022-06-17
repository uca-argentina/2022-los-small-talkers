Class {
	#name : #LandsOnSquareEvent,
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'square'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LandsOnSquareEvent class >> from: spaceship landsOn: square [

	^ self new initializeFrom: spaceship landsOn: square.
]

{ #category : #comparing }
LandsOnSquareEvent >> = anotherLandsOnSquareEvent [

	^ (square = anotherLandsOnSquareEvent square) and: [ 
		  spaceship = anotherLandsOnSquareEvent spaceship ]
]

{ #category : #comparing }
LandsOnSquareEvent >> hash [ 

	^ square hash bitXor: ( spaceship hash )
]

{ #category : #initialization }
LandsOnSquareEvent >> initializeFrom: aSpaceship landsOn: aSquare [

	spaceship := aSpaceship.
	square := aSquare.
]

{ #category : #accessing }
LandsOnSquareEvent >> spaceship [

	^ spaceship
]

{ #category : #accessing }
LandsOnSquareEvent >> square [

	^ square
]
