Class {
	#name : #PositionTrackerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
PositionTrackerTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #tests }
PositionTrackerTest >> testAPositionIsEqualToAnotherEvenThoughItsNotTheSameInstance [

	| instanceA instanceB |
	instanceA := Position
		             of: (Spaceship named: 'Enterprise')
		             at: 1
		             after: 2.
	instanceB := Position
		             of: (Spaceship named: 'Enterprise')
		             at: 1
		             after: 2.
	self assert: instanceA equals: instanceB.
	self assert: instanceA hash equals: instanceB hash
]

{ #category : #tests }
PositionTrackerTest >> testAPositionIsGreaterThanAnotherWhenIsALapAhead [

	|positionA positionB|
	positionA := Position of: (Spaceship new) at: 2 after: 1.
	positionB := Position of: (Spaceship new) at: 1 after: 2.
	
	self assert: ((positionA < positionB) and: [positionB > positionA]).
	
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForLapOnRecordReturnsLap [

	| enterprise record |
	enterprise := Spaceship named: 'Enterprise'.
	record := Position of: enterprise at: 4 after: 1.
	self assert: record lap equals: 1
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForShipOnRecordReturnsSameShip [

	| enterprise record |
	enterprise := Spaceship named: 'Enterprise'.
	record := Position of: enterprise at: 4 after: 1.
	self assert: record ship equals: enterprise
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForSquareOnRecordReturnsSquare [

	| enterprise record |
	enterprise := Spaceship named: 'Enterprise'.
	record := Position of: enterprise at: 4 after: 1.
	self assert: record square equals: 4
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testDeletingARecordOfANonExistingShipIsInvalid [

	| enterprise starfighter leaderboard |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker tracking: { enterprise }.

	self
		should: [ leaderboard removePositionOf: starfighter ]
		raise: Error
		withMessage: 'Cannot delete record of unknown ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAShipForwardSquaresUpdatesRankings [

	| leaderboard enterprise |
	enterprise := Spaceship named: 'Enterprise'.
	leaderboard := PositionTracker tracking: { enterprise }.

	self
		assert: (leaderboard positions at: 1)
		equals: (Position of: enterprise at: 1 after: 1).

	leaderboard move: enterprise at: 6 after: 1.

	self
		assert: (leaderboard positions at: 1)
		equals: (Position of: enterprise at: 6 after: 1)
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAnUnknownShipForwardSquaresIsInvalid [

	| leaderboard enterprise starfighter |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker tracking: { enterprise }.

	self
		should: [ leaderboard move: starfighter at: 5 after: 1 ]
		raise: Error
		withMessage: 'Cannot move an unregistered ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingAllSpaceshipsFromPositionTrackerReturnsCollectionWithShips [

	| enterprise starfighter leaderboard |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker tracking: { 
			               enterprise.
			               starfighter }.

	self
		assert: leaderboard spaceships
		equals: (OrderedCollection withAll: { 
					 starfighter.
					 enterprise })
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingPositionsFromLeaderboardReturnsDictionaryWithNamesOfShipsAndTheirPositions [

	| enterprise starfighter leaderboard |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker tracking: { 
			               enterprise.
			               starfighter }.

	self
		assert: (leaderboard positions at: 2)
		equals: (Position of: enterprise at: 1 after: 1).

	self
		assert: (leaderboard positions at: 1)
		equals: (Position of: starfighter at: 1 after: 1)
]
