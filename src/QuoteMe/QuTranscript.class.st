Class {
	#name : #QuTranscript,
	#superclass : #Object,
	#instVars : [
		'lines',
		'pageID',
		'model'
	],
	#category : #'QuoteMe-Transcripts'
}

{ #category : #accessing }
QuTranscript >> gtViewLinesFor: aView [
	<gtView>
	
	^ aView list
		title: 'Lines';
		priority: 25;
		items: [ self lines ]
]

{ #category : #accessing }
QuTranscript >> lepiterPage [

	self pageID ifNil: [ ^ nil ].

	LeDatabasesRegistry defaultPrimaryDatabase blockWithUID: self pageID ifPresent: [ :s | ^ s ] ifAbsent: [ ].
	
	"Should never get here during normal use, but useful for e.g. testing"
	LeDatabase allSubInstances do: [ :db |
		db blockWithUID: self pageID ifPresent: [  :s | ^ s ] ifAbsent: [ ]  ].
		
	LeDatabasesRegistry defaultPrimaryDatabase addPage: self newLepiterPage.
	
]

{ #category : #accessing }
QuTranscript >> lines [

	^ lines ifNil: [ lines := SortedCollection sortUsing: #position ascending undefinedFirst ]
]

{ #category : #accessing }
QuTranscript >> lines: anObject [

	lines := anObject
]

{ #category : #accessing }
QuTranscript >> model [
	^ model
]

{ #category : #accessing }
QuTranscript >> model: anObject [
	model := anObject
]

{ #category : #accessing }
QuTranscript >> newLepiterPage [
	^ LePage quTranscriptOwner: self model
]

{ #category : #accessing }
QuTranscript >> pageID [

	^ pageID
]

{ #category : #accessing }
QuTranscript >> pageID: anObject [

	pageID := anObject
]
