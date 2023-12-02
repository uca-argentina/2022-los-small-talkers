Class {
	#name : #OnHandCardStackTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromACancellationCardOnlyDeckAddsTenCancellationCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { CancellationCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromARedoCardOnlyDeckAddsTenRedoCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { RedoCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromARepeatCardOnlyDeckAddsTenRepeatCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { RepeatCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromAReversalCardOnlyDeckAddsTenReversalCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { ReversalCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromASpeedCardOnlyDeckAddsTenSpeedCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { SpeedCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromAnAccelerationCardOnlyDeckAddsTenAccelerationCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { AccelerationCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testGrabbingTenCardFromAnOverloadCardOnlyDeckAddsTenOverloadCards [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { OverloadCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10
]

{ #category : #tests }
OnHandCardStackTest >> testPlayingACancellationCardFromAHandOfManyOnlyRemovesOneFromList [

	| onHandCardStack enterprise deck cards |
	deck := Deck handingOver: { CancellationCard }.
	enterprise := 'Enterprise'.
	onHandCardStack := OnHandCardStack new.
	cards := deck take: 10.
	cards do: [ :card | onHandCardStack give: card toHandsOf: enterprise ].
	self assert: onHandCardStack cards size equals: 10.
	onHandCardStack take: CancellationCard fromHandsOf: enterprise.
	self assert: onHandCardStack cards size equals: 9
]
