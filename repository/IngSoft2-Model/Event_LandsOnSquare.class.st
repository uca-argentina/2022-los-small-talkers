Class {
	#name : #'Event_LandsOnSquare',
	#superclass : #Object,
	#instVars : [
		'spaceship',
		'square'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Event_LandsOnSquare class >> from: spaceship landsOn: square [

	^ self new initializeFrom: spaceship landsOn: square.
]

{ #category : #comparing }
Event_LandsOnSquare >> = anotherLandsOnSquareEvent [

	^ (square = anotherLandsOnSquareEvent square) and: [ 
		  spaceship = anotherLandsOnSquareEvent spaceship ]
]

{ #category : #comparing }
Event_LandsOnSquare >> hash [ 

	^ square hash bitXor: ( spaceship hash )
]

{ #category : #initialization }
Event_LandsOnSquare >> initializeFrom: aSpaceship landsOn: aSquare [

	spaceship := aSpaceship.
	square := aSquare.
]

{ #category : #accessing }
Event_LandsOnSquare >> spaceship [

	^ spaceship
]

{ #category : #accessing }
Event_LandsOnSquare >> square [

	^ square
]
