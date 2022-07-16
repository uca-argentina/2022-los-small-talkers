Class {
	#name : #Board,
	#superclass : #Object,
	#instVars : [
		'squares',
		'totalSquares',
		'totalDistance'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'input validation' }
Board class >> assertMinimumOf: aLength [

	aLength isZero ifTrue: [ 
		Error signal: 'Board distance cannot be zero' ]
]

{ #category : #'instance creation' }
Board class >> madeUpBy: someSquares stretchedInto: anAmountOfDistance [

	self assertMinimumOf: anAmountOfDistance.
	self validateSizeOf: someSquares.
	^ self new
		  initializeMadeUpBy: someSquares
		  stretchedInto: anAmountOfDistance
]

{ #category : #'input validation' }
Board class >> validateSizeOf: someSquares [

	someSquares ifEmpty: [ 
		Error signal: 'Boards needs at least one square' ]
]

{ #category : #'executing effects' }
Board >> applyEffectAt: aSquare to: aSpaceship on: aGame [

	^ (squares at: aSquare) applyEffectTo: aSpaceship from: aGame
]

{ #category : #accessing }
Board >> distanceInLightYears [

	^ totalDistance inLightYears
]

{ #category : #accessing }
Board >> distanceInParsecs [

	^ totalDistance inParsecs
]

{ #category : #initialization }
Board >> initializeMadeUpBy: someSquares stretchedInto: anAmountOfDistance [

	squares := someSquares.
	totalDistance := anAmountOfDistance.
	totalSquares := squares size
]

{ #category : #'accessing - attributes' }
Board >> length [

	^ totalSquares
]

{ #category : #accessing }
Board >> lightYearsPerSquare [

	^ totalDistance inLightYears / squares size
]

{ #category : #accessing }
Board >> parsecsPerSquare [

	^ totalDistance inParsecs / totalSquares
]
