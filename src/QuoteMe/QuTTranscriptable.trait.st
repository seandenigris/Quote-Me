Trait {
	#name : #QuTTranscriptable,
	#category : #'QuoteMe-Transcripts'
}

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
