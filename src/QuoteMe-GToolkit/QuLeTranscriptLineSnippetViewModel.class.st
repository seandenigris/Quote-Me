Class {
	#name : 'QuLeTranscriptLineSnippetViewModel',
	#superclass : 'LeTextCoderSnippetViewModel',
	#category : 'QuoteMe-GToolkit-Transcripts-Lepiter',
	#package : 'QuoteMe-GToolkit',
	#tag : 'Transcripts-Lepiter'
}

{ #category : 'as yet unclassified' }
QuLeTranscriptLineSnippetViewModel >> citeOnPageGtActionFor: anAction [
	<gtAction>

	^ anAction dropdown
		label: 'Cite on page';
		icon: BrGlamorousVectorIcons search;
		target: LeSnippetContextMenuActionTarget uniqueInstance;
		priority: 10;
		content: [ :anActionElement :aHostElement :anExplicitMenu |
			QuLeCiteOnPage new
				sourceSnippetsAdd: self snippetModel;
				magritteFormExecuting ]
]

{ #category : 'accessing' }
QuLeTranscriptLineSnippetViewModel >> linePosition [
	^ self snippetModel line ifNotNil: #position
]

{ #category : 'accessing' }
QuLeTranscriptLineSnippetViewModel >> lineSpeaker [
	^ self snippetModel line ifNotNil: #speaker
]

{ #category : 'accessing' }
QuLeTranscriptLineSnippetViewModel >> positionDisplayText [
	^ self linePosition
		ifNotNil: [ :obj | obj quTranscriptPositionGtDisplayText ]
		ifNil: [ '' asRopedText ]
]

{ #category : 'accessing' }
QuLeTranscriptLineSnippetViewModel >> snippetElementClass [
	^ QuLeTranscriptLineSnippetElement 
]

{ #category : 'accessing' }
QuLeTranscriptLineSnippetViewModel >> speakerDisplayText [
	^ self lineSpeaker
		ifNotNil: [ :spkr | spkr gtDisplayText ]
		ifNil: [ '' asRopedText ]
]
