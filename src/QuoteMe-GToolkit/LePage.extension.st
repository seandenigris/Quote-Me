Extension { #name : #LePage }

{ #category : #'*QuoteMe-GToolkit' }
LePage class >> quTranscriptOwner: anObject [
	| result type |
	result := self new.
	type := QuLeTranscriptPageType subjectModel: anObject page: result.
	^ result
		type: type;
		yourself
]
