Class {
	#name : #LightYear,
	#superclass : #TrenchRunDistanceUnit,
	#instVars : [
		'totalAmount'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
LightYear class >> amounting: someLightYears [

	self assertValid: someLightYears.
	^ self new initializeAmounting: someLightYears
]

{ #category : #asserting }
LightYear class >> assertValid: anAmountOfLightYears [

	anAmountOfLightYears < 0 ifTrue: [ Error signal: 'LightYears cannot amount to a negative number' ]
]

{ #category : #comparing }
LightYear >> = anotherDistanceUnit [

	^ (self inLightYears = anotherDistanceUnit inLightYears)
]

{ #category : #comparing }
LightYear >> > anotherDistanceUnit [

	^ (self inLightYears > anotherDistanceUnit inLightYears)
]

{ #category : #comparing }
LightYear >> hash [ 

	^ self inLightYears hash
]

{ #category : #accessing }
LightYear >> inLightYears [

	^ totalAmount
]

{ #category : #accessing }
LightYear >> inParsecs [

	^ totalAmount / 3
]

{ #category : #initialization }
LightYear >> initializeAmounting: someLightYears [

	totalAmount := someLightYears.
]

{ #category : #testing }
LightYear >> isZero [ 

	^ totalAmount = 0
]
