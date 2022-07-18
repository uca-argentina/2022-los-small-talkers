Class {
	#name : #Parsec,
	#superclass : #TrenchRunDistanceUnit,
	#instVars : [
		'totalAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Parsec class >> amounting: someParsecs [

	self assertValid: someParsecs.
	^ self new initializeAmounting: someParsecs
]

{ #category : #asserting }
Parsec class >> assertValid: anAmountOfParsecs [

	anAmountOfParsecs < 0 ifTrue: [ 
		Error signal: 'Parsecs cannot amount to a negative number' ]
]

{ #category : #comparing }
Parsec >> = anotherDistanceUnit [

	^ (self inLightYears = anotherDistanceUnit inLightYears)
]

{ #category : #comparing }
Parsec >> > anotherDistanceUnit [

	^ (self inLightYears > anotherDistanceUnit inLightYears)
]

{ #category : #comparing }
Parsec >> hash [ 

	^ self inLightYears hash
]

{ #category : #accessing }
Parsec >> inLightYears [

	^ totalAmount * 3
]

{ #category : #accessing }
Parsec >> inParsecs [ 

	^ totalAmount
]

{ #category : #initialization }
Parsec >> initializeAmounting: someParsecs [

	totalAmount := someParsecs.
]

{ #category : #testing }
Parsec >> isZero [ 

	^ totalAmount = 0
]
