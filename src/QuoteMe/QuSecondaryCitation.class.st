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
		classes: LlAuthoredWork withAllSubclasses; 
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
QuSecondaryCitation >> sources [
	^ { self source. self primarySource }
]
