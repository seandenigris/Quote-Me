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

	^ self source authors
]

{ #category : #accessing }
QuCitation >> location [
	^ location
]

{ #category : #accessing }
QuCitation >> location: aLocation [
	location := aLocation
]

{ #category : #viewing }
QuCitation >> present [
	self source present.
]

{ #category : #accessing }
QuCitation >> presentDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons playinspect;
		action: #present;
		yourself
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

{ #category : #accessing }
QuCitation >> sourceDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #source;
		label: 'Source';
		priority: 100;
		yourself
]

{ #category : #accessing }
QuCitation >> sources [
	^ { self source }
]
