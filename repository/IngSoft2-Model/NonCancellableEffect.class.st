Class {
	#name : #NonCancellableEffect,
	#superclass : #EffectRemovingRule,
	#category : #'IngSoft2-Model'
}

{ #category : #'effect cancelling' }
NonCancellableEffect >> cancelEffect [

	Error signal: 'Cannot remove a non-cancellable effect'
]
