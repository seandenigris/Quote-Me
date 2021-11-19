"
""A reference to a published or unpublished source (not always the original source)"" - *Wikipedia>https://en.wikipedia.org/wiki/Citation*
"
Class {
	#name : #QuCitation,
	#superclass : #Object,
	#instVars : [
		'source'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #accessing }
QuCitation >> authors [

	^ self source authors.
]

{ #category : #magritte }
QuCitation >> descriptionSource [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #source;
		label: 'Source';
		priority: 100;
		classes: LlAuthoredWork withAllSubclasses; 
		yourself
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
QuCitation >> sources [
	^ { self source }
]

{ #category : #viewing }
QuCitation >> view [
	LlLibrary uniqueInstance view: self source.
]
