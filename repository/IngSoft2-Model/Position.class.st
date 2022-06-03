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
Position class >> of: aSpaceship at: square after: lap [

	^ self new initializeOf: aSpaceship at: square after: lap
]

{ #category : #comparing }
Position >> < anotherPosition [

	(self lap > anotherPosition lap) ifTrue:
	[ ^ false ].

	(self lap = anotherPosition lap) ifTrue: [ 
		^(self square < anotherPosition square)
	].

	^(self lap < anotherPosition lap).
]

{ #category : #comparing }
Position >> = anotherPosition [

	^ (self className = anotherPosition className) and: [ 
		  lap = anotherPosition lap and: [ 
			  ship = anotherPosition ship and: [ 
				  square = anotherPosition square ] ] ]
]

{ #category : #comparing }
Position >> > anotherPosition [

	(self lap < anotherPosition lap) ifTrue:
	[ ^ false ].

	(self lap = anotherPosition lap) ifTrue: [ 
		^(self square > anotherPosition square)
	].

	^(self lap > anotherPosition lap).
]

{ #category : #comparing }
Position >> hash [ 
	
	^( (lap hash) bitXor: ( ship hash bitXor: ( square hash )))
]

{ #category : #initialization }
Position >> initializeOf: aSpaceship at: aSquare after: lapNumber [

	ship := aSpaceship.
	square := aSquare.
	lap := lapNumber
]

{ #category : #accessing }
Position >> lap [

	^lap.
]

{ #category : #accessing }
Position >> ship [

	^ ship
]

{ #category : #accessing }
Position >> square [

	^ square
]
