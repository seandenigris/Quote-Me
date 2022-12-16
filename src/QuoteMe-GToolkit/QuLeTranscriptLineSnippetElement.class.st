Class {
	#name : #QuLeTranscriptLineSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'snippetToolbar',
		'speakerLabel',
		'positionLabel',
		'snippetContent'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> controlNames [
	^#(#speakerChooser #timeChooser)
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> firePlayerRequest: aBlock [
	self fireEvent: (QuLeTranscriptPlayerRequest action: aBlock)
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> hideControls [
	snippetContent ifNil: [ ^ self ].
	self controlNames do: [ :cName | (snippetContent childNamed: cName) visibility: BlVisibility gone ].
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> initialize [

	super initialize.
	
	self editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self onTextModified: anEvent ].
		
	self addAptitude: (BrStyleCommonAptitude new
		when: BlElementState focused | BlElementState hovered
			style: [ :aStyle |
				aStyle
					do: [ self showControls ]
					after: [ self hideControls ]]).
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> newSearchButton [
	^ GtSpotterDropdownButtonStencil new
		valuable: [ self snippet page type subjectModel participants ];
		icon: BrGlamorousVectorIcons search;
		spotterModelDo: [ :sm | 
			sm announcer
				when: GtSpotterActOn
				do: [ :evt | 
					GtTranscript default next putObject: evt.
					self snippet line speaker: evt rawObject.
					self onSnippetViewModelChanged.
					evt actedUpon: true.
					self editorElement requestFocus ] ];
		create
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> onPositionClicked: evt [
	self snippetViewModel linePosition ifNotNil: [ :pos | 
		self firePlayerRequest: [ :player | player currentPosition: pos ] ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> onSnippetViewModelChanged [
	
	super onSnippetViewModelChanged.
	positionLabel text: self snippetViewModel positionDisplayText.
	speakerLabel text: self snippetViewModel speakerDisplayText.
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> onSnippetViewModelFocused: aBoolean [

	aBoolean ifFalse: [ ^ self ].
	
	self flag: 'waiting for help on shortcut actions via Discord'.
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> onTextModified: anEvent [
	(anEvent text isNotEmpty and: [ self snippetViewModel linePosition isNil ])
		ifTrue: [ self syncPositionWithPlayer ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> showControls [
	snippetContent ifNil: [ ^ self ].
	self controlNames do: [ :cName | (snippetContent childNamed: cName) visibility: BlVisibility visible ]
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> snippetContent [
	| timeChooser speakerChooser |
	snippetContent := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.
		
	timeChooser := BrButton new 
		aptitude: BrGlamorousButtonWithIconAptitude; 
		icon: BrGlamorousVectorIcons performance; 
		"tooltip: 'Set position to current';" 
		action: [ self syncPositionWithPlayer ];
		yourself.
		
	positionLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		addEventHandlerOn: BlClickEvent
			do: [ :evt | self onPositionClicked: evt ];
		yourself.

	speakerChooser := self newSearchButton
		"addShortcut: Character space asShortcut;"
		yourself.
		
	speakerLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		addEventHandlerOn: BlClickEvent
			do: [ :evt | 
				self snippetViewModel lineSpeaker 
					ifNotNil: [ :src | evt target phlow spawnObject: src ] ];
		hFitContent;
		vFitContent.
	
	snippetContent
		addChild: timeChooser as: #timeChooser;
		addChild: positionLabel;
		addChild: speakerChooser as: #speakerChooser;
		addChild: speakerLabel;
		addChild: self editorElement.
		
	self hideControls.
	
	^ snippetContent
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> snippetToolbar [

	^ nil
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> syncPositionWithPlayer [
	
	self fireEvent: (QuLeTranscriptPlayerRequest action: [ :player | 
		self snippet line position: player currentPosition.
		self onSnippetViewModelChanged ])
]
