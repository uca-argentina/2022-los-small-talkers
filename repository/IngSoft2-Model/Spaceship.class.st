Class {
	#name : #Spaceship,
	#superclass : #Object,
	#instVars : [
		'name',
		'game'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Spaceship class >> named: aName [ 
	^ self new initializeWith: aName.
]

{ #category : #initialization }
Spaceship >> associateGame: aGameInstance [

	game := aGameInstance.
]

{ #category : #initialization }
Spaceship >> initializeWith: aName [
	name := #aName.
]

{ #category : #initialization }
Spaceship >> name [
	name isNotNil ifFalse: [ 
		name := (self hash) printString.
	].
	
	^name.
]

{ #category : #'turn starting' }
Spaceship >> startTurn [
	game startTurn: self.
]
