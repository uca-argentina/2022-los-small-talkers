Class {
	#name : #OnHandCardStack,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
OnHandCardStack >> cards [

	^ cards
]

{ #category : #'assigning card to player' }
OnHandCardStack >> give: aCardType toHandsOf: aSpaceship [

	cards add: (aCardType ownedBy: aSpaceship)
]

{ #category : #initialization }
OnHandCardStack >> initialize [ 

	super initialize.
	cards := OrderedCollection new.
]

{ #category : #'removing card from player' }
OnHandCardStack >> take: cardType fromHandsOf: spaceship [

	cards
		remove: (cardType ownedBy: spaceship)
		ifAbsent: [ Error signal: 'Player does not own the selected card' ]
]
