Class {
	#name : #QuTranscriptLine,
	#superclass : #Object,
	#instVars : [
		'position',
		'speaker',
		'contentSnippetID'
	],
	#category : #'QuoteMe-Transcripts'
}

{ #category : #accessing }
QuTranscriptLine >> contentSnippetID [

	^ contentSnippetID
]

{ #category : #accessing }
QuTranscriptLine >> contentSnippetID: aUUID [

	contentSnippetID := aUUID
]

{ #category : #accessing }
QuTranscriptLine >> lepiterDatabase [
	^ LeDatabasesRegistry defaultPrimaryDatabase
]

{ #category : #accessing }
QuTranscriptLine >> position [

	^ position
]

{ #category : #accessing }
QuTranscriptLine >> position: anObject [

	position := anObject
]

{ #category : #accessing }
QuTranscriptLine >> printOn: aStream [
	position ifNotNil: [ :obj | aStream print: obj; space ].
	speaker ifNotNil: [ :obj | aStream print: obj; space ].
	contentSnippetID ifNotNil: [ 
		| cStr |
		cStr := [ self snippet contentAsString ] on: Error do: [ '???' ]. 
		aStream print: cStr ].
]

{ #category : #accessing }
QuTranscriptLine >> snippet [

	^ self lepiterDatabase blockWithUID: self contentSnippetID
]

{ #category : #accessing }
QuTranscriptLine >> speaker [

	^ speaker
]

{ #category : #accessing }
QuTranscriptLine >> speaker: anObject [

	speaker := anObject
]
