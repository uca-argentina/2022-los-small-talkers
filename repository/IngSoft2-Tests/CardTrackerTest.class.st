Class {
	#name : #CardTrackerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTrackerTest >> testGrabbingTenCardFromACancellationCardOnlyDeckAddsTenCancellationCards [

	| cardTracker enterprise deck |
	deck := Deck handingOver: { CancellationCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10
]

{ #category : #tests }
CardTrackerTest >> testGrabbingTenCardFromARedoCardOnlyDeckAddsTenRedoCards [

	| cardTracker enterprise deck |
	deck := Deck handingOver: { RedoCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10
]

{ #category : #tests }
CardTrackerTest >> testGrabbingTenCardFromARepeatCardOnlyDeckAddsTenRepeatCards [

	| cardTracker enterprise deck |
	deck := Deck handingOver: { RepeatCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10
]

{ #category : #tests }
CardTrackerTest >> testGrabbingTenCardFromASpeedCardOnlyDeckAddsTenSpeedCards [

	| cardTracker enterprise deck |
	deck := Deck handingOver: { SpeedCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10
]

{ #category : #tests }
CardTrackerTest >> testGrabbingTenCardFromAnAccelerationCardOnlyDeckAddsTenAccelerationCards [

	| cardTracker enterprise deck |
	deck := Deck handingOver: { AccelerationCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10
]

{ #category : #tests }
CardTrackerTest >> testGrabbingTenCardFromAnOverloadCardOnlyDeckAddsTenOverloadCards [

	| cardTracker enterprise deck |
	deck := Deck handingOver: { OverloadCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10.
]

{ #category : #tests }
CardTrackerTest >> testPlayingACancellationCardFromAHandOfManyOnlyRemovesOneFromList [

	| cardTracker enterprise deck|
	deck := Deck handingOver: { CancellationCard }.
	enterprise := Spaceship named: 'Enterprise'.
	cardTracker := OnHandCardStack tracking: { enterprise }.
	cardTracker take: 10 from: deck andAssignTo: enterprise.
	self assert: cardTracker cards size equals: 10.
	cardTracker play: CancellationCard ownedBy: enterprise.
	self assert: cardTracker cards size equals: 9.
]
