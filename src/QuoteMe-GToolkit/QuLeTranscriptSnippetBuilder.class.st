Class {
	#name : 'QuLeTranscriptSnippetBuilder',
	#superclass : 'LeParentSnippetBuilder',
	#category : 'QuoteMe-GToolkit-Transcripts-Lepiter',
	#package : 'QuoteMe-GToolkit',
	#tag : 'Transcripts-Lepiter'
}

{ #category : 'accessing' }
QuLeTranscriptSnippetBuilder >> empty [
	^ self ensureSnippetOfClass: QuLeTranscriptLineSnippet
]
