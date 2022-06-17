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

{ #category : #comparing }
Spaceship >> = anotherSpaceship [

	^ name match: anotherSpaceship name.
]

{ #category : #comparing }
Spaceship >> hash [ 

	^ name hash.
]

{ #category : #initialization }
Spaceship >> initializeNamed: aName [

	name := aName.
]

{ #category : #initialization }
Spaceship >> name [

	^ name
]
