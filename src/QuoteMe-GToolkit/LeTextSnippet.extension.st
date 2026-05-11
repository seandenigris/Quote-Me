Extension { #name : 'LeTextSnippet' }

{ #category : '*QuoteMe-GToolkit' }
LeTextSnippet >> citeLinesOnPage: aPage [
	"Create a cited snippet for each of the receiver's transcript line snippet descendents"

	| lines |
	lines := self withAllChildrenBreadthFirst select: [ :chld | chld isKindOf: QuLeTranscriptLineSnippet ].
	
	QuLeCiteOnPage new
		sourceSnippets: lines;
		skipIfExists: true;
		targetPage: aPage;
		execute
]
