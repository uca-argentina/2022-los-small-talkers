Class {
	#name : #GameBoardSlotTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameBoardSlotTest >> testBlankSlotHasNoEffect [

	|aGame spaceship dice board|
	dice := LoadedDie with: 5.
	board := CustomBoard sized: 10 from: (Dictionary newFromPairs: {6. BlankSlot new}).
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance withParticipating: { spaceship } rolling: dice on: board endLap: 1.
	
	aGame playNextTurn.
	
	self assert: (aGame squareOf: spaceship) equals: 6.
	self assert: (aGame lapOf: spaceship) equals: 1.
]

{ #category : #tests }
GameBoardSlotTest >> testWormHoleSlotBackTracksFourSquares [

	|aGame spaceship dice board|
	dice := LoadedDie with: 8.
	board := CustomBoard sized: 10 from: (Dictionary newFromPairs: {9. WormHoleSlot new}).
	spaceship := Spaceship named: 'Enterprise'.
	aGame := TrenchRunGameInstance withParticipating: { spaceship } rolling: dice on: board endLap: 1.
	
	aGame playNextTurn.
	
	self assert: (aGame squareOf: spaceship) equals: 5.
	self assert: (aGame lapOf: spaceship) equals: 1.
]
