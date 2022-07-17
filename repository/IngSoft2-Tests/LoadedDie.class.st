Class {
	#name : #LoadedDie,
	#superclass : #Object,
	#instVars : [
		'loadedSide'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #'instance creation' }
LoadedDie class >> assertValid: aLoadedSide [

	aLoadedSide <= 0 ifTrue: [ 
		Error signal: 'Loaded side cannot be negative nor zero' ]
]

{ #category : #'instance creation' }
LoadedDie class >> with: aLoadedSide [

	self assertValid: aLoadedSide.

	^ self new initializeWith: aLoadedSide
]

{ #category : #initialization }
LoadedDie >> initializeWith: aLoadedSide [
	loadedSide := aLoadedSide.
]

{ #category : #accessing }
LoadedDie >> maxResult [

	^ loadedSide

	
]

{ #category : #rolling }
LoadedDie >> roll [
	^ loadedSide.
]
