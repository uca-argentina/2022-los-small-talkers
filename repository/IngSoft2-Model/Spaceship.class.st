Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Spaceship class >> named: aName [ 
	^ self new initializeWith: aName.
]

{ #category : #initialization }
Spaceship >> initializeWith: aName [
	name := aName.
]

{ #category : #initialization }
Spaceship >> name [
	name isNotNil ifFalse: [ 
		name := (self hash) printString.
	].
	
	^name.
]
