Trait {
	#name : #QuTTranscriptable,
	#category : #'QuoteMe-Transcripts'
}

{ #category : #accessing }
QuTTranscriptable >> hasTranscript [

	^ self transcript hasLepiterPage
]

{ #category : #'as yet unclassified' }
QuTTranscriptable >> postCopyTranscriptable [
	"Send after super postCopy"
	
	self transcript: nil
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

{ #category : #spotter }
QuTTranscriptable >> transcriptSearchOn: aSearch [
	<gtSearch>
	
	^ self 
		propertyAt: #transcript
		ifPresent: [ :script | script snippetsSearchOn: aSearch ] 
		ifAbsent: [ aSearch empty ]
]
