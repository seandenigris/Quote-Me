Extension { #name : #QuTranscript }

{ #category : #'*QuoteMe-GToolkit' }
QuTranscript >> lepiterPage [

	self pageID ifNil: [ 
		| result |
		result := LeDatabasesRegistry defaultPrimaryDatabase addPage: self newLepiterPage.
		self pageID: result uid.
		^ result ].

	LeDatabasesRegistry defaultPrimaryDatabase pageWithID: self pageID ifPresent: [ :s | ^ s ] ifAbsent: [ ].
	
	"Should never get here during normal use, but useful for e.g. testing"
	LeDatabase allSubInstances do: [ :db |
		db pageWithID: self pageID ifPresent: [  :s | ^ s ] ifAbsent: [ ]  ].
		
	^ nil
]

{ #category : #'*QuoteMe-GToolkit' }
QuTranscript >> newLepiterPage [
	^ LePage quTranscriptOwner: self model
]
