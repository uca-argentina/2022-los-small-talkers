Class {
	#name : #PenalizedSpaceshipsStackTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PenalizedSpaceshipsStackTest >> testSpaceshipAfterLosingTurnIsRemovedFromPenalizationStack [

	| game enterprise die board squares starship penalizedShips |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: starship.
	
	penalizedShips := game penalizedSpaceshipsStack.
	penalizedShips canPlayAgain: starship.
	
	self deny: (penalizedShips includes: starship).
]

{ #category : #tests }
PenalizedSpaceshipsStackTest >> testSpaceshipPlayingOutOfTurnIsAddedToPenalizationStack [

	| game enterprise die board squares starship penalizedShips |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: starship.
	
	penalizedShips := game penalizedSpaceshipsStack.
	
	self assert: (penalizedShips includes: starship).
]

{ #category : #tests }
PenalizedSpaceshipsStackTest >> testSpaceshipThatLosesTurnIsAddedToPenalizationStack [

	| game enterprise die board squares starship penalizedShips |
	enterprise := 'Enterprise'.
	starship := 'Starship'.
	die := LoadedDie with: 3.
	squares := SquareGenerator
		           creating: 20
		           of: { BlankSquare }
		           with: { 1 }.
	board := Board madeUpBy: squares stretchedIntoLightYears: 20.
	game := TrenchRunGame
		        withParticipating: { enterprise. starship }
		        rolling: die
		        on: board
		        until: 1
		        using: (Deck handingOver: { SpeedCard }).
	
	penalizedShips := game penalizedSpaceshipsStack.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	game playOwnTurn: enterprise.
	game playOwnTurn: starship.
	
	penalizedShips losesNextTurn: starship.
	
	self assert: (penalizedShips includes: starship).
]
