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
	^ self new initializeNamed: aName.
]

{ #category : #initialization }
Spaceship >> initializeNamed: aName [
	name := aName.
]

{ #category : #initialization }
Spaceship >> name [

	^ name
]
