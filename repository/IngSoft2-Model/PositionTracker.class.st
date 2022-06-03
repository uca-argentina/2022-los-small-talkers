Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> tracking: spaceships [

	^ self new initializeTracking: spaceships.
]

{ #category : #'accessing - positions' }
PositionTracker >> currentLeader [

	^ (positions at: 1) ship.
]

{ #category : #initialization }
PositionTracker >> initializeTracking: spaceships [

	positions := SortedCollection sortUsing: [ :positionOne :positionTwo | 
		             positionOne > positionTwo ].
	positions addAll: (spaceships collect: [ :spaceship | Position of: spaceship at: 1 after: 1]).
]

{ #category : #moving }
PositionTracker >> move: aSpaceship at: aSquare after: lap [

	self
		positionOf: aSpaceship
		ifAbsent: [ Error signal: 'Cannot move an unregistered ship' ].

	self removePositionOf: aSpaceship.

	positions add: (Position of: aSpaceship at: aSquare after: lap)
]

{ #category : #accessing }
PositionTracker >> positionOf: aSpaceship ifAbsent: aFullBlockClosure [

	| matchingResults |
	matchingResults := positions select: [ :position | 
		                   position ship = aSpaceship ].

	matchingResults isEmpty
		ifTrue: [ aFullBlockClosure value ]
		ifFalse: [ ^ matchingResults at: 1 ]
]

{ #category : #accessing }
PositionTracker >> positions [

	^ positions.
]

{ #category : #private }
PositionTracker >> removePositionOf: aSpaceship [

	| foundRecord |
	foundRecord := self
		               positionOf: aSpaceship
		               ifAbsent: [ 
		               Error signal: 'Cannot delete record of unknown ship' ].

	positions remove: foundRecord
]

{ #category : #accessing }
PositionTracker >> spaceships [

	^ positions collect: [ :position | position ship ]
]
