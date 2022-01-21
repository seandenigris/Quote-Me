Class {
	#name : #QuLeSourceProvider,
	#superclass : #Object,
	#instVars : [
		'model',
		'sourceCollectionGetter'
	],
	#category : #'QuoteMe-GToolkit-Citation-Lepiter'
}

{ #category : #accessing }
QuLeSourceProvider >> model [

	^ model
]

{ #category : #accessing }
QuLeSourceProvider >> model: anObject [

	model := anObject
]

{ #category : #accessing }
QuLeSourceProvider >> modelGtSpotterProcessorsFor: aSpotterStep [
	
	^ self model gtSpotterProcessorsFor: aSpotterStep
]

{ #category : #accessing }
QuLeSourceProvider >> sourceCollection [
	^ self model perform: self sourceCollectionGetter
]

{ #category : #accessing }
QuLeSourceProvider >> sourceCollectionGetter [

	^ sourceCollectionGetter
]

{ #category : #accessing }
QuLeSourceProvider >> sourceCollectionGetter: anObject [

	sourceCollectionGetter := anObject
]
