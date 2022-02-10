Class {
	#name : #QuLeTranscriptPlayerRequest,
	#superclass : #BlEvent,
	#instVars : [
		'action'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #'api - stream' }
QuLeTranscriptPlayerRequest class >> action: aBlock [
	
	^ self new
		action: aBlock;
		yourself
]

{ #category : #accessing }
QuLeTranscriptPlayerRequest >> action [

	^ action
]

{ #category : #accessing }
QuLeTranscriptPlayerRequest >> action: anObject [

	action := anObject
]

{ #category : #accessing }
QuLeTranscriptPlayerRequest >> answer: player [
	^ self action value: player
]
