Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'records'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> with: aSpaceship [ 
	^self new initializeWithAll: { aSpaceship }.
]

{ #category : #'instance creation' }
PositionTracker class >> withAll: spaceships [

	^ self new initializeWithAll: spaceships
]

{ #category : #initialization }
PositionTracker >> initializeWithAll: spaceships [

	records := OrderedCollection withAll:
		           (spaceships collect: [ :ship | 
			            Position of: ship at: 1 ])
]

{ #category : #moving }
PositionTracker >> move: aSpaceship forward: aNumberOfSquares [

	| shipRecord currentPosition nextPosition |
	shipRecord := self
		              positionOf: aSpaceship
		              ifAbsent: [ 
		              Error signal: 'Cannot move an unregistered ship' ].

	currentPosition := shipRecord square.

	nextPosition := currentPosition + aNumberOfSquares.

	self move: aSpaceship to: nextPosition
]

{ #category : #moving }
PositionTracker >> move: aSpaceship to: nextPosition [

	self removePositionOf: aSpaceship.
	
	records add: (Position of: aSpaceship at: nextPosition).
	
	
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
