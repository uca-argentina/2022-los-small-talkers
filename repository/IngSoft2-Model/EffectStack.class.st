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

{ #category : #initialization }
EffectStack >> initialization [

	stack := OrderedCollection new.
]
