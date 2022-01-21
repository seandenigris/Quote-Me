Extension { #name : #LePage }

{ #category : #'*QuoteMe-GToolkit' }
LePage class >> quTranscriptOwnerID: aUID [
	| result type |
	result := self new.
	type := QuLeTransciptPageType new 
		modelID: aUID;
		page: result; 
		yourself.
	^ result
		type: type;
		yourself
]
