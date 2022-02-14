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
QuTranscript >> pageID [

	^ pageID
]

{ #category : #accessing }
QuTranscript >> pageID: anObject [

	pageID := anObject
]

{ #category : #accessing }
QuTranscript >> title [
	^ self model displayString
]
