Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'records'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> withShip: aSpaceship [ 
	^self new initializeWithSpaceships: { aSpaceship }.
]

{ #category : #'instance creation' }
PositionTracker class >> withSpaceships: aCollectionOfSpaceships [
	^self new initializeWithSpaceships: aCollectionOfSpaceships.
]

{ #category : #initialization }
PositionTracker >> initializeWithSpaceships: aCollectionOfSpaceships [
	
	records := OrderedCollection withAll: (aCollectionOfSpaceships collect: [ :ship |
		Position of: ship atSquare: 1.	
	]).
]

{ #category : #moving }
PositionTracker >> move: aSpaceship forward: aNumberOfSquares [

	self move: aSpaceship forward: aNumberOfSquares then: [  ]
]

{ #category : #moving }
PositionTracker >> move: aSpaceship forward: aNumberOfSquares then: aFinishingCleanupBlock [

	| shipRecord currentPosition nextPosition |
	shipRecord := self
		              positionOf: aSpaceship
		              ifAbsent: [ 
		              Error signal: 'Cannot move an unregistered ship' ].

	currentPosition := shipRecord square.

	nextPosition := currentPosition + aNumberOfSquares.

	self move: aSpaceship to: nextPosition then: aFinishingCleanupBlock
]

{ #category : #moving }
PositionTracker >> move: aSpaceship to: nextPosition [

	self move: aSpaceship to: nextPosition then: [  ]
]

{ #category : #moving }
PositionTracker >> move: aSpaceship to: nextPosition then: aFinishingCleanupBlock [

	self removePositionOf: aSpaceship.
	
	records add: (Position of: aSpaceship atSquare: nextPosition).
	
	aFinishingCleanupBlock argumentCount = 1 ifTrue: [ 
		aFinishingCleanupBlock value: nextPosition ].
	
	
]

{ #category : #accessing }
PositionTracker >> positionOf: aSpaceship ifAbsent: aFullBlockClosure [ 
	|matchingResults|
	
	matchingResults := records select: [ :record |
		record ship = aSpaceship.
	].

	(matchingResults isEmpty) ifTrue: [ aFullBlockClosure value. ] ifFalse: [ ^matchingResults at: 1 ].
]

{ #category : #accessing }
PositionTracker >> positions [

	|spaceships  squares|
	spaceships := self spaceships .

	squares := records collect: [ :record | record square ].

	^ Dictionary newFromKeys: spaceships andValues: squares
]

{ #category : #private }
PositionTracker >> removePositionOf: aSpaceship [ 
	|foundRecord|
	foundRecord := self positionOf: aSpaceship  ifAbsent: [ Error signal: 'Cannot delete record of unknown ship'. ].
	
	records remove: foundRecord ifAbsent: [].
]

{ #category : #accessing }
PositionTracker >> spaceships [
	
	^ records collect: [ :record | 
		record ship.
	]
]
