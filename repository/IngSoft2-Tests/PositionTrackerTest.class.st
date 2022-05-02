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
PositionTrackerTest >> testAskingForShipOnRecordReturnsSameShip [

	|aShip record|
	aShip := Spaceship named: 'Enterprise'.
	record := Position of: aShip atSquare: 4.
	self assert: record ship equals: aShip.
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testAskingForSquareOnRecordReturnsSquare [

	|aShip record|
	aShip := Spaceship named: 'Enterprise'.
	record := Position of: aShip atSquare: 4.
	self assert: record square equals: 4.
]

{ #category : #'tests - LeaderboardRecord' }
PositionTrackerTest >> testCreatingALeaderboardRecordWithAPositivePositionAndShipIsValid [

	|record aShip|
	aShip := Spaceship named: 'Enterprise'.
	record := Position of: aShip atSquare: 4.
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testCreatingALeaderboardWithASingleShipIsValid [

	|leaderboard aShip|
	aShip := Spaceship named: 'Enterprise'.
	leaderboard := PositionTracker withShip: aShip.
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testCreatingALeaderboardWithMultipleShipsIsValid [

	|leaderboard aFirstShip aSecondShip|
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withSpaceships: {aFirstShip. aSecondShip}.
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testDeletingARecordOfANonExistingShipIsInvalid [

	| aSpaceship anotherSpaceship leaderboard |
	aSpaceship := Spaceship named: 'Enterprise'.
	anotherSpaceship := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withShip: aSpaceship.

	self
		should: [ leaderboard removePositionOf: anotherSpaceship ]
		raise: Error
		withMessage: 'Cannot delete record of unknown ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAShipForwardSquaresUpdatesRankings [

	| leaderboard aSpaceship |
	aSpaceship := Spaceship named: 'Enterprise'.
	leaderboard := PositionTracker withShip: aSpaceship.

	self
		assert: leaderboard positions
		equals: (Dictionary newFromKeys: { aSpaceship } andValues: { 1 }).

	leaderboard move: aSpaceship forward: 5.

	self
		assert: leaderboard positions
		equals: (Dictionary newFromKeys: { aSpaceship } andValues: { 6 })
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testMovingAnUnknownShipForwardSquaresIsInvalid [

	| leaderboard aSpaceship anotherSpaceship |
	aSpaceship := Spaceship named: 'Enterprise'.
	anotherSpaceship := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withShip: aSpaceship.

	self
		should: [ leaderboard move: anotherSpaceship forward: 5]
		raise: Error
		withMessage: 'Cannot move an unregistered ship'
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingAllSpaceshipsFromTheLeaderboardReturnsCollectionWithShips [

	|aFirstShip aSecondShip leaderboard|
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withSpaceships: { aFirstShip . aSecondShip }.
	
	self assert: (leaderboard spaceships) equals: (OrderedCollection withAll: { aFirstShip . aSecondShip }).
]

{ #category : #'tests - Leaderboard' }
PositionTrackerTest >> testObtainingRankingsFromLeaderboardReturnsDictionaryWithNamesOfShipsAndTheirPositions [

	|aFirstShip aSecondShip leaderboard|
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := PositionTracker withSpaceships: { aFirstShip . aSecondShip }.
	
	self assert: (leaderboard positions) equals: (Dictionary newFromKeys: { aFirstShip . aSecondShip } andValues: { 1 . 1 }).
]
