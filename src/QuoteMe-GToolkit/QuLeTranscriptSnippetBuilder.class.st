Class {
	#name : #QuLeTranscriptSnippetBuilder,
	#superclass : #LeParentSnippetBuilder,
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #accessing }
QuLeTranscriptSnippetBuilder >> text [
	^ self ensureSnippetOfClass: QuLeTranscriptLineSnippet
]
