Extension { #name : #DateAndTime }

{ #category : #'*QuoteMe-GToolkit' }
DateAndTime >> quTranscriptPositionGtDisplayText [
	^ self asTime print24 gtDisplayText
]
