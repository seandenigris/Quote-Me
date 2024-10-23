Extension { #name : #QuTTranscriptable }

{ #category : #'*QuoteMe-GToolkit' }
QuTTranscriptable >> editTranscriptDescription [
	<magritteActionDescription>
	
	^ self 
		editLepiterPageDescriptionSpawning: [ self transcript lepiterPage ]
		icon: BrGlamorousVectorIcons clipboard
		deemphasizedUnless: [ :obj | obj hasTranscript ]
		tooltip: 'View transcript'
]
