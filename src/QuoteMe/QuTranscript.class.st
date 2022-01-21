Class {
	#name : #QuTranscript,
	#superclass : #Object,
	#instVars : [
		'lines',
		'pageID'
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
QuTranscript >> pageID [

	^ pageID
]

{ #category : #accessing }
QuTranscript >> pageID: anObject [

	pageID := anObject
]
