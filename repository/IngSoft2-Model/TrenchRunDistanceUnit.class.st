Class {
	#name : #TrenchRunDistanceUnit,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TrenchRunDistanceUnit class >> amounting: someDistance [

	self subclassResponsibility
]

{ #category : #accessing }
TrenchRunDistanceUnit >> inLightYears [

	self subclassResponsibility
]

{ #category : #accessing }
TrenchRunDistanceUnit >> inParsecs [

	self subclassResponsibility
]

{ #category : #initialization }
TrenchRunDistanceUnit >> initializeAmounting: someDistance [

	self subclassResponsibility
]

{ #category : #testing }
TrenchRunDistanceUnit >> isZero [

	self subclassResponsibility
]
