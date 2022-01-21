Class {
	#name : #QuLeTranscriptLineSnippetViewModel,
	#superclass : #LeTextCoderSnippetViewModel,
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> positionDisplayText [
	^ self snippetModel line position
		ifNotNil: [ :obj | obj asTime print24 gtDisplayText ]
		ifNil: [ '' asRopedText ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> snippetElementClass [
	^ QuLeTranscriptLineSnippetElement 
]

{ #category : #accessing }
QuLeTranscriptLineSnippetViewModel >> speakerDisplayText [
	^ self snippetModel line speaker
		ifNotNil: [ :spkr | spkr gtDisplayText ]
		ifNil: [ '' asRopedText ]
]
