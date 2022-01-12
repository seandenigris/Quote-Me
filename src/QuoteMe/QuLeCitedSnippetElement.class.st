Class {
	#name : #QuLeCitedSnippetElement,
	#superclass : #LeTextCoderSnippetElement,
	#instVars : [
		'snippetToolbar',
		'sourceLabel'
	],
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuLeCitedSnippetElement >> initialize [

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
		addChild: (BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			beSmallSize;
			text: 'Source:');
		addChild: sourceLabel;
		addChild: self newSearchButton
]

{ #category : #accessing }
QuLeCitedSnippetElement >> newSearchButton [

	| buttonAptitude |
	
	buttonAptitude := BrGlamorousWithDropdownAptitude
		stencil: [ | aSpotterElement aSpotterModel handleButton aptitude |
			aSpotterElement := GtSpotterElement new.
			aSpotterModel := self snippetViewModel snippetModel sourceSpotter.
			handleButton := BrButton new
				aptitude: BrGlamorousButtonWithIconAptitude 
					- BrGlamorousButtonWithLabelTooltipAptitude
						- BrGlamorousButtonExteriorAptitude;
				icon: BrGlamorousVectorIcons search;
				yourself.
				
			aSpotterModel announcer
				when: GtSpotterActOn
				do: [ :evt | 
					self snippetViewModel snippetModel sourceID: evt element ensureUUID.
					self onSourceChanged.
					evt actedUpon: true.
					(#(buttonClick singleClick doubleClick keyPressed) includes: evt eventType)
						ifTrue: [ buttonAptitude hide ].
					"aStep exit from #gtSpotterActDefault:from:" ].
					
			aptitude := BrGlamorousDropdownAptitude new
				handle: handleButton;
				content:
					(aSpotterElement
						spotterModel: aSpotterModel;
						constraintsDo: [ :c | 
							c horizontal exact: 600.
							c vertical exact: 400 ];
						yourself);
				yourself.
			
			BlElement new
				aptitude: aptitude;
				background: BrGlamorousColors secondaryHeaderBackgroundColor;
				yourself ].
								
	^ BrButton new
		aptitude:
			BrGlamorousButtonWithIconAptitude
				+ buttonAptitude;
		icon: BrGlamorousVectorIcons search;
		yourself
		
	"Adapted from GtSpotterElementExamples>>#elementOnSpotterInDropdown"
]

{ #category : #accessing }
QuLeCitedSnippetElement >> onSnippetViewModelChanged [
	self onSourceChanged.
	super onSnippetViewModelChanged.
]

{ #category : #accessing }
QuLeCitedSnippetElement >> onSourceChanged [
	sourceLabel text: self snippetViewModel sourceDisplayText.
]

{ #category : #accessing }
QuLeCitedSnippetElement >> snippetToolbar [

	^ snippetToolbar
]
