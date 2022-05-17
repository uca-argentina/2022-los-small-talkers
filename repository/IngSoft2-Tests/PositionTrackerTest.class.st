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

	| aShip record |
	aShip := Spaceship named: 'Enterprise'.
	record := Position of: aShip at: 4 lap: 1.
	self assert: record lap equals: 1
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForShipOnRecordReturnsSameShip [

	| aShip record |
	aShip := Spaceship named: 'Enterprise'.
	record := Position of: aShip at: 4 lap: 1.
	self assert: record ship equals: aShip
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForSquareOnRecordReturnsSquare [

	| aShip record |
	aShip := Spaceship named: 'Enterprise'.
	record := Position of: aShip at: 4 lap: 1.
	self assert: record square equals: 4
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testDeletingARecordOfANonExistingShipIsInvalid [

	| aSpaceship anotherSpaceship leaderboard |
	aSpaceship := Spaceship named: 'Enterprise'.
	anotherSpaceship := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withAll: { aSpaceship }.

	self
		should: [ leaderboard removePositionOf: anotherSpaceship ]
		raise: Error
		withMessage: 'Cannot delete record of unknown ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAShipForwardSquaresUpdatesRankings [

	| leaderboard aSpaceship |
	aSpaceship := Spaceship named: 'Enterprise'.
	leaderboard := PositionTracker withAll: { aSpaceship }.

	self
		assert: leaderboard positions
		equals:
		(OrderedCollection newFrom:
			 { (Position of: aSpaceship at: 1 lap: 1) }).

	leaderboard move: aSpaceship to: 6 lap: 1.

	self
		assert: leaderboard positions
		equals:
		(OrderedCollection newFrom:
			 { (Position of: aSpaceship at: 6 lap: 1) })
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAnUnknownShipForwardSquaresIsInvalid [

	| leaderboard aSpaceship anotherSpaceship |
	aSpaceship := Spaceship named: 'Enterprise'.
	anotherSpaceship := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withAll: { aSpaceship }.

	self
		should: [ leaderboard move: anotherSpaceship to: 5 lap: 1 ]
		raise: Error
		withMessage: 'Cannot move an unregistered ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingAllSpaceshipsFromPositionTrackerReturnsCollectionWithShips [

	| aFirstShip aSecondShip leaderboard |
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withAll: { 
			               aFirstShip.
			               aSecondShip }.

	self
		assert: leaderboard spaceships
		equals: (OrderedCollection withAll: { 
					 aFirstShip.
					 aSecondShip })
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingPositionsFromLeaderboardReturnsDictionaryWithNamesOfShipsAndTheirPositions [

	| aFirstShip aSecondShip leaderboard |
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withAll: { 
			               aFirstShip.
			               aSecondShip }.

	self
		assert: (leaderboard positions at: 1)
		equals: (Position of: aFirstShip at: 1 lap: 1).

	self
		assert: (leaderboard positions at: 2)
		equals: (Position of: aSecondShip at: 1 lap: 1)
]
