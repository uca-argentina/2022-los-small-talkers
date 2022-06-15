Class {
	#name : #EffectStackTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
EffectStackTest >> testAddingOneMovementEffectToEmptyStackReturnsOneOfEffectOnAllShips [

	|effectStack enterprise starfighter|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	effectStack := PlayedCardStack create.
	effectStack addEffectPlayedBy: enterprise itShouldSum: 1 to: {starfighter. enterprise }.
	self assert: (effectStack calculateComposedEffectFor: starfighter startingWith: 1) equals: 2.
	self assert: (effectStack calculateComposedEffectFor: enterprise startingWith: 1) equals: 2.
]

{ #category : #tests }
EffectStackTest >> testAddingOneMovementEffectToExistingStackAugmentsTheEffectInOneOnAllShips [

	|effectStack enterprise starfighter|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	effectStack := PlayedCardStack create.
	effectStack addEffectPlayedBy: enterprise itShouldSum: 2 to: {enterprise}.
	effectStack addEffectPlayedBy: enterprise itShouldSum: 1 to: {starfighter. enterprise }.
	self assert: (effectStack calculateComposedEffectFor: starfighter startingWith: 1) equals: 2.
	self assert: (effectStack calculateComposedEffectFor: enterprise startingWith: 1) equals: 4.
]

{ #category : #tests }
EffectStackTest >> testCancellingAnEffectRemovesItFromTheCompoundEffectCalculation [

	|effectStack enterprise starfighter|
	enterprise := Spaceship named: 'Enterprise'.
	starfighter := Spaceship named: 'Starfighter'.
	effectStack := PlayedCardStack create.
	effectStack addEffectPlayedBy: enterprise itShouldSum: 1 to: {starfighter}.
	self assert: (effectStack calculateComposedEffectFor: starfighter startingWith: 1) equals: 2.
	self assert: (effectStack calculateComposedEffectFor: enterprise startingWith: 1) equals: 1.
	effectStack removeEffectPlayedBy: enterprise itShouldSum: 1 to: {starfighter}.
	self assert: (effectStack calculateComposedEffectFor: starfighter startingWith: 1) equals: 1.
	self assert: (effectStack calculateComposedEffectFor: enterprise startingWith: 1) equals: 1.
]
