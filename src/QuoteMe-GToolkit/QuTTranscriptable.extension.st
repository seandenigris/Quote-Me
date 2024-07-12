Extension { #name : #QuTTranscriptable }

{ #category : #'*QuoteMe-GToolkit' }
QuTTranscriptable >> editTranscriptDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtAction: [ :action :desc |
			| button |
			button := action button
				icon: BrGlamorousVectorIcons clipboard;
				yourself.
			button action: [ :bElem |
					bElem phlow spawnObject: self editTranscript ].
			button ];
		comment: 'View transcript';
		yourself
]
