Class {
	#name : #EffectStack,
	#superclass : #Object,
	#instVars : [
		'stack'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
EffectStack class >> create [

	^ self new initialization
]

{ #category : #'adding - removing effects' }
EffectStack >> addEffectPlayedBy: aSpaceship itShouldSum: anAmount to: targets [

	stack add: (CardEffect playedBy: aSpaceship itShouldSum: anAmount to: targets)
]

{ #category : #'calculating composed effects' }
EffectStack >> calculateComposedEffectFor: aSpaceship startingWith: aDiceRollResult [

	| allEffectsAimedAtTarget composedEffectResult |
	composedEffectResult := aDiceRollResult.
	allEffectsAimedAtTarget := stack select: [ :effect | effect target includes: aSpaceship ].
	allEffectsAimedAtTarget do: [ :effectAimedAtTarget | composedEffectResult := effectAimedAtTarget payload + composedEffectResult ].
	^ composedEffectResult.
]

{ #category : #initialization }
EffectStack >> initialization [

	stack := OrderedCollection new.
]

{ #category : #'adding - removing effects' }
EffectStack >> removeEffectPlayedBy: aSpaceship itShouldSum: anAmount to: targets [

	|selectedEffects|
	selectedEffects := stack select: [ :effect | effect owner = aSpaceship and: [ effect payload = anAmount and: [ effect target = targets ] ] ] .
	selectedEffects ifEmpty: [ Error signal: 'Cannot remove a nonexistent effect'].
	stack remove: (selectedEffects at: 1).
]
