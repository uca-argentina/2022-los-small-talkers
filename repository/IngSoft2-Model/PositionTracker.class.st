Class {
	#name : #PositionTracker,
	#superclass : #Object,
	#instVars : [
		'positions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
PositionTracker class >> withAll: spaceships [

	^ self new initializeWithAll: spaceships.
]

{ #category : #initialization }
PositionTracker >> initializeWithAll: spaceships [

	positions := OrderedCollection newFrom:
		             (spaceships collect: [ :ship | 
			              Position of: ship at: 1 lap: 1 ])
]

{ #category : #moving }
PositionTracker >> move: aSpaceship to: nextPosition lap: nextLap [

	self
		positionOf: aSpaceship
		ifAbsent: [ Error signal: 'Cannot move an unregistered ship' ].

	self removePositionOf: aSpaceship.

	positions add:
		(Position of: aSpaceship at: nextPosition lap: nextLap)
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

	positions remove: foundRecord ifAbsent: [  ]
]

{ #category : #accessing }
PositionTracker >> spaceships [

	^ positions collect: [ :position | position ship ]
]
