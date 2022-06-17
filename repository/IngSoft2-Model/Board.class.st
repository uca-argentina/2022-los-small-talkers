Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'totalParsecs',
		'totalSquares',
		'totalLightYears'
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
	aLength >= 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'instance creation' }
Board class >> sized: aNumberOfSquares dividedInLightYears: amount from: someSquares [

	self assertValid: amount.
	self assertValid: aNumberOfSquares.
	self assert: aNumberOfSquares coincidesWith: someSquares size.
	^ self new
		  initializeSized: aNumberOfSquares
		  dividedIn: amount / 3
		  from: someSquares
]

{ #category : #'instance creation' }
Board class >> sized: aNumberOfSquares dividedInParsecs: amount from: someSquares [

	self assertValid: amount.
	self assertValid: aNumberOfSquares.
	self assert: aNumberOfSquares coincidesWith: someSquares size.
	^ self new
		  initializeSized: aNumberOfSquares
		  dividedIn: amount
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
	totalLightYears := totalParsecs *3.
	squares := someSquares
]

{ #category : #'accessing - attributes' }
Board >> length [

	^ totalSquares
]

{ #category : #accessing }
Board >> lightYearsPerSquare [

	^ totalLightYears / squares size
]

{ #category : #accessing }
Board >> parsecsPerSquare [

	^ totalParsecs / totalSquares
]
