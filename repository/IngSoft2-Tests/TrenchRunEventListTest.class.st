Class {
	#name : #TrenchRunEventListTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #asserting }
TrenchRunEventListTest >> should: aBlock raise: anErrorType withMessage: anErrorMessage [

	^ self
		  should: aBlock
		  raise: anErrorType
		  whoseDescriptionIncludes: anErrorMessage
		  description: 'Test did not fail for expected reason'
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastCardEventInACardOnlyEventListReturnsTheLastCardEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (PlayCardEvent
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (PlayCardEvent
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (PlayCardEvent
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastPlayCardEvent
		equals: (PlayCardEvent
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }).
	
	self 
		assert: trenchRunEventList lastPlayCardEvent hash
		equals: (PlayCardEvent
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastCardEventInALandsOnSquareOnlyEventListThrowsError [

	| trenchRunEventList enterprise planetExpress|
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new).
	
	self 
		should: [ trenchRunEventList lastPlayCardEvent ]
		raise: Error 
		withMessage: 'Trying to access last played card event when none ever happened'.
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastCardEventInAMixedEventListReturnsTheLastCardEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (PlayCardEvent
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (PlayCardEvent
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (PlayCardEvent
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new).

	self
		assert: trenchRunEventList lastPlayCardEvent
		equals: (PlayCardEvent
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastPlayCardEvent hash
		equals: (PlayCardEvent
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastEventInACardOnlyEventListReturnsTheLastCardEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (PlayCardEvent
			 using: (SpeedCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (CancellationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 SpeedCard }).
	trenchRunEventList add: (PlayCardEvent
			 using: (AccelerationCard ownedBy: enterprise)
			 aimedAt: { 
					 planetExpress.
					 enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (OverloadCard ownedBy: enterprise)
			 aimedAt: { planetExpress }).
	trenchRunEventList add: (PlayCardEvent
			 using: (RedoCard ownedBy: enterprise)
			 aimedAt: { enterprise }).
	trenchRunEventList add: (PlayCardEvent
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self assert: trenchRunEventList lastEvent equals: (PlayCardEvent
			 using: (RepeatCard ownedBy: enterprise)
			 aimedAt: { enterprise }).

	self
		assert: trenchRunEventList lastPlayCardEvent hash
		equals: (PlayCardEvent
				 using: (RepeatCard ownedBy: enterprise)
				 aimedAt: { enterprise }) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastEventInALandsOnSquareOnlyEventListReturnsTheLastLandsOnSquareEvent [

	| trenchRunEventList enterprise planetExpress |
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add:
		(LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new).

	self
		assert: trenchRunEventList lastEvent
		equals:
		(LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new).

self
		assert: trenchRunEventList lastEvent hash
		equals:
		(LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new) hash
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastLandsOnSquareEventInACardOnlyEventListThrowsError [

	| trenchRunEventList enterprise planetExpress|
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (PlayCardEvent using: (SpeedCard ownedBy: enterprise ) aimedAt: {enterprise}).
	trenchRunEventList add: (PlayCardEvent using: (CancellationCard ownedBy: enterprise ) aimedAt: {planetExpress. SpeedCard}).
	trenchRunEventList add: (PlayCardEvent using: (AccelerationCard ownedBy: enterprise ) aimedAt: {planetExpress. enterprise}).
	trenchRunEventList add: (PlayCardEvent using: (OverloadCard ownedBy: enterprise ) aimedAt: {planetExpress}).
	trenchRunEventList add: (PlayCardEvent using: (RedoCard ownedBy: enterprise ) aimedAt: {enterprise}).
	trenchRunEventList add: (PlayCardEvent using: (RepeatCard ownedBy: enterprise ) aimedAt: {enterprise}).
	
	self 
		should: [ trenchRunEventList lastLandsOnSquareEvent]
		raise: Error 
		withMessage: 'Trying to access last lands on square event when none ever happened'.
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastLandsOnSquareEventInALandsOnSquareOnlyEventListReturnsTheLastLandsOnSquareEvent [

	| trenchRunEventList enterprise planetExpress|
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new).
	
	self assert: trenchRunEventList lastEvent equals: (LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new)
]

{ #category : #tests }
TrenchRunEventListTest >> testFindingTheLastLandsOnSquareEventInAMixedEventListReturnsTheLastLandsOnSquareEvent [

	| trenchRunEventList enterprise planetExpress|
	enterprise := Spaceship named: 'Enterprise'.
	planetExpress := Spaceship named: 'Planet Express'.
	trenchRunEventList := TrenchRunEventList new.
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: BlankSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: DrawCardSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: AtomicBombSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: SpeedUpSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: HyperJumpSquare new).
	trenchRunEventList add: (LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new).
	trenchRunEventList add: (PlayCardEvent using: (SpeedCard ownedBy: enterprise ) aimedAt: {enterprise}).
	trenchRunEventList add: (PlayCardEvent using: (CancellationCard ownedBy: enterprise ) aimedAt: {planetExpress. SpeedCard}).
	trenchRunEventList add: (PlayCardEvent using: (AccelerationCard ownedBy: enterprise ) aimedAt: {planetExpress. enterprise}).
	trenchRunEventList add: (PlayCardEvent using: (OverloadCard ownedBy: enterprise ) aimedAt: {planetExpress}).
	trenchRunEventList add: (PlayCardEvent using: (RedoCard ownedBy: enterprise ) aimedAt: {enterprise}).
	trenchRunEventList add: (PlayCardEvent using: (RepeatCard ownedBy: enterprise ) aimedAt: {enterprise}).

	self assert: trenchRunEventList lastLandsOnSquareEvent equals: (LandsOnSquareEvent from: enterprise landsOn: WormHoleSquare new)
]
