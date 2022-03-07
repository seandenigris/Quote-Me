Class {
	#name : #QuTranscriptLine,
	#superclass : #Object,
	#instVars : [
		'position',
		'speaker',
		'contentSnippetID',
		'type'
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

	self contentSnippetID ifNil: [ ^ nil ].

	LeDatabasesRegistry defaultPrimaryDatabase blockWithUID: self contentSnippetID ifPresent: [ :s | ^ s ] ifAbsent: [ ].
	
	"Should never get here during normal use, but useful for e.g. testing"
	LeDatabase allSubInstances do: [ :db |
		db blockWithUID: self contentSnippetID ifPresent: [  :s | ^ s ] ifAbsent: [ ]  ].
		
	^ nil
]

{ #category : #accessing }
QuTranscriptLine >> speaker [

	^ speaker
]

{ #category : #accessing }
QuTranscriptLine >> speaker: anObject [

	speaker := anObject
]

{ #category : #accessing }
QuTranscriptLine >> type [

	^ type ifNil: [ type := self maLazyInstVarUsing: self typeDescription ]
]

{ #category : #accessing }
QuTranscriptLine >> type: anObject [

	type := anObject
]

{ #category : #'as yet unclassified' }
QuTranscriptLine >> typeDescription [
	<magritteDescription>
	
	^ MASingleOptionDescription new
		accessor: #type;
		options: QuQuoteLevel allSubclasses; 
		default: QuParaphrase;
		yourself
]
