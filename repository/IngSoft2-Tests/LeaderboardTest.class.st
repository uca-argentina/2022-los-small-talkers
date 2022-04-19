Class {
	#name : #LeaderboardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
LeaderboardTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^self 
		should: aBlock 
		raise: anErrorType  
		whoseDescriptionIncludes: anErrorMessage  
		description: 'Test did not fail for expected reason'
]

{ #category : #'tests - LeaderboardRecord' }
LeaderboardTest >> testAskingForShipOnRecordReturnsSameShip [

	|aShip record|
	aShip := Spaceship named: 'Enterprise'.
	record := LeaderboardRecord withShip: aShip atSquare: 4.
	self assert: record ship equals: aShip.
]

{ #category : #'tests - LeaderboardRecord' }
LeaderboardTest >> testAskingForSquareOnRecordReturnsSquare [

	|aShip record|
	aShip := Spaceship named: 'Enterprise'.
	record := LeaderboardRecord withShip: aShip atSquare: 4.
	self assert: record square equals: 4.
]

{ #category : #'tests - LeaderboardRecord' }
LeaderboardTest >> testCreatingALeaderboardRecordWithAPositivePositionAndShipIsValid [

	|record aShip|
	aShip := Spaceship named: 'Enterprise'.
	record := LeaderboardRecord withShip: aShip atSquare: 4.
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testCreatingALeaderboardWithASingleShipIsValid [

	|leaderboard aShip|
	aShip := Spaceship named: 'Enterprise'.
	leaderboard := Leaderboard withShip: aShip.
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testCreatingALeaderboardWithMultipleShipsIsValid [

	|leaderboard aFirstShip aSecondShip|
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := Leaderboard withSpaceships: {aFirstShip. aSecondShip}.
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testDeletingARecordOfANonExistingShipIsInvalid [

	|aSpaceship anotherSpaceship leaderboard|
	aSpaceship := Spaceship named: 'Enterprise'.
	anotherSpaceship := Spaceship named: 'PlanetExpress'.
	leaderboard := Leaderboard withShip: aSpaceship.
	
	self 
		should: [leaderboard deleteRecordOf: anotherSpaceship.]
		raise: Error 
		withMessage: 'Cannot delete record of unknown ship'.
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testMovingAShipForwardSquaresUpdatesRankings [

	|leaderboard aSpaceship|
	aSpaceship := Spaceship named: 'Enterprise'.
	leaderboard := Leaderboard withShip: aSpaceship.
	
	self assert: (leaderboard ranking) equals: (Dictionary newFromKeys: {aSpaceship} andValues: {1}).
	
	leaderboard move: aSpaceship forwardSquares: 5 then: [].
	
	self assert: (leaderboard ranking) equals: (Dictionary newFromKeys: {aSpaceship} andValues: {6}).
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testMovingAnUnknownShipForwardSquaresIsInvalid [

	|leaderboard aSpaceship anotherSpaceship|
	aSpaceship := Spaceship named: 'Enterprise'.
	anotherSpaceship := Spaceship named: 'PlanetExpress'.
	leaderboard := Leaderboard withShip: aSpaceship.
	
	self 
		should: [leaderboard move: anotherSpaceship forwardSquares: 5 then: [].]
		raise: Error 
		withMessage: 'Cannot move an unregistered ship'.
	
	
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testObtainingAllSpaceshipsFromTheLeaderboardReturnsCollectionWithShips [

	|aFirstShip aSecondShip leaderboard|
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := Leaderboard withSpaceships: { aFirstShip . aSecondShip }.
	
	self assert: (leaderboard players) equals: (OrderedCollection withAll: { aFirstShip . aSecondShip }).
]

{ #category : #'tests - Leaderboard' }
LeaderboardTest >> testObtainingRankingsFromLeaderboardReturnsDictionaryWithNamesOfShipsAndTheirPositions [

	|aFirstShip aSecondShip leaderboard|
	aFirstShip := Spaceship named: 'Enterprise'.
	aSecondShip := Spaceship named: 'PlanetExpress'.
	leaderboard := Leaderboard withSpaceships: { aFirstShip . aSecondShip }.
	
	self assert: (leaderboard ranking) equals: (Dictionary newFromKeys: { aFirstShip . aSecondShip } andValues: { 1 . 1 }).
]
