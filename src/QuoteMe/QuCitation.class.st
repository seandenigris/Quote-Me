"
""A reference to a published or unpublished source (not always the original source)"" - *Wikipedia>https://en.wikipedia.org/wiki/Citation*
"
Class {
	#name : #QuCitation,
	#superclass : #Object,
	#instVars : [
		'source',
		'location'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #accessing }
QuCitation >> authors [

	^ self source authors.
]

{ #category : #accessing }
QuCitation >> location [
	^ location
]

{ #category : #accessing }
QuCitation >> location: aLocation [
	location := aLocation
]

{ #category : #accessing }
QuCitation >> printOn: aStream [

	source ifNotNil: [ aStream print: source ].
	location ifNotNil: [ 
		aStream
			space;
			print: location ].
]

{ #category : #accessing }
QuCitation >> source [
	^ source
]

{ #category : #accessing }
QuCitation >> source: anObject [
	source := anObject
]

{ #category : #magritte }
QuCitation >> sourceDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #source;
		label: 'Source';
		priority: 100;
		classes: LlAuthoredWork withAllSubclasses; 
		yourself
]

{ #category : #accessing }
QuCitation >> sources [
	^ { self source }
]

{ #category : #viewing }
QuCitation >> view [
	self source view.
]

{ #category : #accessing }
QuCitation >> viewDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons playinspect;
		action: #view;
		yourself
]
