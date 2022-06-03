Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'totalParsecs',
		'totalSquares'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Board class >> assert: aNumberOfSquares coincidesWith: actualSquareAmount [

	(aNumberOfSquares = actualSquareAmount) ifFalse: [ 
		Error signal:
			'Number of squares declared does not coincide with actual square amount' ]
]

{ #category : #asserting }
Board class >> assertValid: aLength [
	aLength > 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'instance creation' }
Board class >> sized: aNumberOfSquares dividedIn: aNumberOfParsecs from: someSquares [

	self assertValid: aNumberOfParsecs.
	self assertValid: aNumberOfSquares.
		self
		assert: aNumberOfSquares
		coincidesWith: someSquares size.
	^ self new
		  initializeSized: aNumberOfSquares
		  dividedIn: aNumberOfParsecs
		  from: someSquares
]

{ #category : #'executing effects' }
Board >> applyEffectAt: aSquare to: aSpaceship on: aGame [

	(squares at: aSquare) applyEffectTo: aSpaceship from: aGame
]

{ #category : #initialization }
Board >> initializeSized: aNumberOfSquares dividedIn: aNumberOfParsecs from: someSquares [

	totalSquares := aNumberOfSquares.
	totalParsecs := aNumberOfParsecs.
	squares := someSquares.
]

{ #category : #'accessing - attributes' }
Board >> length [

	^ totalSquares
]

{ #category : #accessing }
Board >> parsecsPerSquare [

	^ totalParsecs / totalSquares
]
