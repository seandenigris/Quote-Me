Trait {
	#name : #QuTTranscriptable,
	#category : #'QuoteMe-Transcripts'
}

{ #category : #accessing }
QuTTranscriptable >> editTranscript [
	^ self transcript lepiterPage
]

{ #category : #accessing }
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

{ #category : #accessing }
QuTTranscriptable >> transcript [

	^ self 
		propertyAt: #transcript
		ifAbsentPut: [ 
			QuTranscript new
				subjectModel: self;
				yourself ]
]

{ #category : #accessing }
QuTTranscriptable >> transcript: aQuTranscript [
	self propertyAt: #transcript putRemovingNil: aQuTranscript
]
