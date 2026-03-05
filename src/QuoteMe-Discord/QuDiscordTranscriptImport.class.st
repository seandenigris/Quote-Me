Class {
	#name : 'QuDiscordTranscriptImport',
	#superclass : 'Object',
	#instVars : [
		'client',
		'channel',
		'work'
	],
	#category : 'QuoteMe-Discord',
	#package : 'QuoteMe-Discord'
}

{ #category : 'accessing' }
QuDiscordTranscriptImport >> channel [
	^ channel
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> channel: anObject [
	channel := anObject
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> channelDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #channel;
		gtSearchSource: (MessageSend receiver: self client selector: #channels);
		classes: DSChannel allSubclasses;
		yourself
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> client [
	^ client
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> client: anObject [
	client := anObject
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> connectWithDataPackage: aFileReference [ 
	"aFileReference - root folder of unzipped Data Package"

	client := DSDataPackageClient new
		dataPackageFolder: aFileReference;
		yourself.
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> execute [

	| page |
	page := self work transcript lepiterPage.
	self channel messages do: [ :msg |
		| snip |
		snip := QuLeTranscriptLineSnippet string: msg printFullMessage asString trimmed.
		page addSnippet: snip.
		snip speaker: self work author. ]
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> library [

	^LlLibrary uniqueInstance
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> work [
	^ work
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> work: anObject [
	work := anObject
]

{ #category : 'accessing' }
QuDiscordTranscriptImport >> workDescription [
	<magritteDescription>
	
	^ MAToOneRelationDescription new
		accessor: #work;
		gtSearchSource: "(MessageSend receiver:" self library "selector: #works)";
		classes: LlAuthoredWork withAllSubclasses;
		yourself
]
