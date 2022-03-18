Class {
	#name : #QuLeTranscriptLineSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> linePosition [
	^ self snippetModel line ifNotNil: #position
]

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> lineSpeaker [
	^ self snippetModel line ifNotNil: #speaker
]

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> positionDisplayText [
	^ self linePosition
		ifNotNil: [ :obj | obj quTranscriptPositionGtDisplayText ]
		ifNil: [ '' asRopedText ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> snippetElementClass [
	^ QuLeTranscriptLineSnippetElement 
]

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> speakerDisplayText [
	^ self lineSpeaker
		ifNotNil: [ :spkr | spkr gtDisplayText ]
		ifNil: [ '' asRopedText ]
]
