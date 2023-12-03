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

{ #category : #'input validation' }
Board class >> assertValid: aLength [
	aLength >= 1 ifFalse: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'instance creation' }
Board class >> madeUpBy: someSquares stretchedIntoLightYears: anAmountOfLightYears [

	self assertValid: anAmountOfLightYears.
	self validateSizeOf: someSquares.
	^ self new
		  initializeMadeUpBy: someSquares
		  stretchedInto: anAmountOfLightYears / 3
]

{ #category : #'instance creation' }
Board class >> madeUpBy: someSquares stretchedIntoParsecs: anAmountOfParsecs [

	self assertValid: anAmountOfParsecs.
	self validateSizeOf: someSquares.
	^ self new
		  initializeMadeUpBy: someSquares
		  stretchedInto: anAmountOfParsecs
]

{ #category : #'input validation' }
Board class >> validateSizeOf: someSquares [

		someSquares ifEmpty: [ 
		Error signal: 'Boards need a minimum length of 1' ].
]

{ #category : #'executing effects' }
Board >> applyEffectAt: aSquare to: aSpaceship on: aGame [

	(squares at: aSquare) applyEffectTo: aSpaceship from: aGame
]

{ #category : #'executing effects' }
Board >> applyReverseEffectAt: aSquare to: aSpaceship on: aGame [

	"(squares at: aSquare) applyReverseEffectTo: aSpaceship from: aGame"
]

{ #category : #initialization }
Board >> initializeMadeUpBy: someSquares stretchedInto: anAmountOfParsecs [

	squares := someSquares.
	totalParsecs := anAmountOfParsecs.
	totalLightYears := anAmountOfParsecs * 3.
	totalSquares := squares size.
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
