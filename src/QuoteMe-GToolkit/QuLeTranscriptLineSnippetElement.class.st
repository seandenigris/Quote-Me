Class {
	#name : #QuLeTranscriptLineSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'snippetToolbar',
		'sourceLabel',
		'speakerLabel',
		'speakerChooser',
		'positionLabel'
	],
	#category : #'QuoteMe-GToolkit-Transcripts-Lepiter'
}

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> initialize [

	super initialize.
	
	snippetToolbar := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.
		
	sourceLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		beSmallSize;
		addEventHandlerOn: BlClickEvent
			do: [ :evt | 
				self snippetViewModel snippetModel source 
					ifNotNil: [ :src | evt target phlow spawnObject: src ] ];
		text: ''.
		
	snippetToolbar
		addChild: (BrEditor new
		aptitude: BrGlamorousEditorAptitude new;
			text: 'Source:');
		addChild: sourceLabel;
		addChild: self newSearchButton
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> newSearchButton [

	^ GtSpotterDropdownButtonStencil new
		valuable: [ self snippetViewModel snippetModel page type model participants ];
		icon: BrGlamorousVectorIcons search;
		spotterModelDo: [ :sm |
			sm announcer
				when: GtSpotterActOn
				do: [ :evt | 
					self snippetViewModel snippetModel line speaker: evt element.
					self onSnippetViewModelChanged.
					evt actedUpon: true.
					self editorElement requestFocus ] ];
		create
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> onSnippetViewModelChanged [
	"self onSourceChanged."
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
QuLeTranscriptLineSnippetElement >> snippetContent [
	| result |
	result := BrHorizontalPane new
		hMatchParent;
		padding: (BlInsets top: 4 bottom: 4);
		alignCenterLeft;
		cellSpacing: 5;
		vFitContent.
		
	positionLabel := BrLabel new
		aptitude: BrGlamorousLabelAptitude new;
		yourself.
	
	speakerChooser := self newSearchButton
		"addShortcut: Character space asShortcut;"
		yourself.
		
	speakerLabel := BrEditor new 
		aptitude: BrGlamorousEditorAptitude new;
		hFitContent;
		vFitContent.
	
	^ result
		addChild: positionLabel;
		addChild: speakerChooser;
		addChild: speakerLabel;
		addChild: self editorElement;
		yourself
]

{ #category : #accessing }
QuLeTranscriptLineSnippetElement >> snippetToolbar [

	^ nil
]
