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

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForLapOnRecordReturnsLap [

	| enterprise record |
	enterprise := Spaceship named: 'Enterprise'.
	record := Position of: enterprise at: 4 lap: 1.
	self assert: record lap equals: 1
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForShipOnRecordReturnsSameShip [

	| enterprise record |
	enterprise := Spaceship named: 'Enterprise'.
	record := Position of: enterprise at: 4 lap: 1.
	self assert: record ship equals: enterprise
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForSquareOnRecordReturnsSquare [

	| enterprise record |
	enterprise := Spaceship named: 'Enterprise'.
	record := Position of: enterprise at: 4 lap: 1.
	self assert: record square equals: 4
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testDeletingARecordOfANonExistingShipIsInvalid [

	| enterprise starfighter leaderboard |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker withAll: { enterprise }.

	self
		should: [ leaderboard removePositionOf: starfighter ]
		raise: Error
		withMessage: 'Cannot delete record of unknown ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAShipForwardSquaresUpdatesRankings [

	| leaderboard enterprise |
	enterprise := Spaceship named: 'Enterprise'.
	leaderboard := PositionTracker withAll: { enterprise }.

	self
		assert: leaderboard positions
		equals:
		(OrderedCollection newFrom:
			 { (Position of: enterprise at: 1 lap: 1) }).

	leaderboard move: enterprise to: 6 lap: 1.

	self
		assert: leaderboard positions
		equals:
		(OrderedCollection newFrom:
			 { (Position of: enterprise at: 6 lap: 1) })
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAnUnknownShipForwardSquaresIsInvalid [

	| leaderboard enterprise starfighter |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker withAll: { enterprise }.

	self
		should: [ leaderboard move: starfighter to: 5 lap: 1 ]
		raise: Error
		withMessage: 'Cannot move an unregistered ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingAllSpaceshipsFromPositionTrackerReturnsCollectionWithShips [

	| enterprise starfighter leaderboard |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker withAll: { 
			               enterprise.
			               starfighter }.

	self
		assert: leaderboard spaceships
		equals: (OrderedCollection withAll: { 
					 enterprise.
					 starfighter })
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingPositionsFromLeaderboardReturnsDictionaryWithNamesOfShipsAndTheirPositions [

	| enterprise starfighter leaderboard |
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	leaderboard := PositionTracker withAll: { 
			               enterprise.
			               starfighter }.

	self
		assert: (leaderboard positions at: 1)
		equals: (Position of: enterprise at: 1 lap: 1).

	self
		assert: (leaderboard positions at: 2)
		equals: (Position of: starfighter at: 1 lap: 1)
]
