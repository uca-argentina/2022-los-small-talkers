Class {
	#name : #EffectRemovingRule,
	#superclass : #CardRule,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect cancelling' }
EffectRemovingRule >> cancelEffect [

	self subclassResponsibility
]
