Class {
	#name : #'Stack_OnHandCardStack',
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Stack_OnHandCardStack >> cards [

	^ cards
]

{ #category : #'assigning card to player' }
Stack_OnHandCardStack >> give: aCardType toHandsOf: aSpaceship [

	cards add: (aCardType ownedBy: aSpaceship)
]

{ #category : #initialization }
Stack_OnHandCardStack >> initialize [ 

	super initialize.
	cards := OrderedCollection new.
]

{ #category : #'removing card from player' }
Stack_OnHandCardStack >> take: cardType fromHandsOf: spaceship [

	cards
		remove: (cardType ownedBy: spaceship)
		ifAbsent: [ Error signal: 'Player does not own the selected card' ]
]
