Extension { #name : 'LeTextSnippet' }

{ #category : '*QuoteMe-GToolkit' }
LeTextSnippet >> citeLinesOnPage: aPage [
	"Create a cited snippet for each of the receiver's transcript line snippet descendents"

	| lines |
	lines := self withAllChildrenBreadthFirst select: [ :chld | chld isKindOf: QuLeTranscriptLineSnippet ].
	lines do: [ :line | 
		| citedSnippet |
		citedSnippet := QuLeCitedTextSnippet empty
			source: line;
			yourself.
		aPage addSnippet: citedSnippet ].
]
