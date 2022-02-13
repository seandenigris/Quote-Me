Class {
	#name : #QuLeTranscriptPageElement,
	#superclass : #PeLePageElement,
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #testing }
QuLeTranscriptPageElement class >> isClassFor: anLePageToolContentElement [

	^ anLePageToolContentElement headerElement 
		childNamed: self playerElementName
		ifFound: [ :playerElement | true ]
		ifNone: [ false ]
]

{ #category : #accessing }
QuLeTranscriptPageElement class >> playerElementName [
	^ #quTranscriptPlayer
]

{ #category : #accessing }
QuLeTranscriptPageElement >> install [
	| playerWidget |
	playerWidget := LlMediaPlayerElement on: self contentElement pageViewModel player.
	self contentElement headerElement addChild: playerWidget as: self class playerElementName.
			
	self contentElement
		when: QuLeTranscriptPlayerRequest 
		do: [ :anEvent | anEvent answer: playerWidget player ]
]

{ #category : #accessing }
QuLeTranscriptPageElement >> reset [
	self contentElement headerElement 
		childNamed: self class playerElementName
		ifFound: [ :playerElement |
			playerElement player quit.
			playerElement player: self pageType newPlayer ]
]

{ #category : #accessing }
QuLeTranscriptPageElement >> uninstall [
	| header |
	self contentElement removeEventHandlersSuchThat: [ :evt | evt eventClass = QuLeTranscriptPlayerRequest ].
	header := self contentElement headerElement.
	header removeChildNamed: self class playerElementName
]
