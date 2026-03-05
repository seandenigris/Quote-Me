Extension { #name : 'DSDataPackageClient' }

{ #category : '*QuoteMe-Discord' }
DSDataPackageClient >> quTranscriptImport [

	^ QuDiscordTranscriptImport new
		client: self;
		yourself.
]
