Class {
	#name : #QuSecondaryCitation,
	#superclass : #QuCitation,
	#instVars : [
		'primarySource'
	],
	#category : #'QuoteMe-Core'
}

{ #category : #magritte }
QuSecondaryCitation >> descriptionPrimarySource [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #primarySource;
		label: 'Primary Source';
		priority: 200;
		classes: QuCitation withAllSubclasses; 
		comment: 'Primary source is itself a citation because it has its own location';
		yourself
]

{ #category : #accessing }
QuSecondaryCitation >> primarySource [
	^ primarySource
]

{ #category : #accessing }
QuSecondaryCitation >> primarySource: anObject [
	primarySource := anObject
]

{ #category : #accessing }
QuSecondaryCitation >> printOn: aStream [

	aStream
		print: primarySource;
		nextPutAll: ' via ';
		print: source
]

{ #category : #accessing }
QuSecondaryCitation >> sources [
	^ { self source. self primarySource }
]
