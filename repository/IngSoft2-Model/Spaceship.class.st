Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'cards'
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
	cards := OrderedCollection new.
]

{ #category : #initialization }
Spaceship >> name [

	^ name
]

{ #category : #'taking cards' }
Spaceship >> take: anAmountOfCards from: aDeck [

	cards addAll: (aDeck take: anAmountOfCards).
]
