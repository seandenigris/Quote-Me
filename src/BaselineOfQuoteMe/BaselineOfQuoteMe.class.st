Class {
	#name : #BaselineOfQuoteMe,
	#superclass : #BaselineOf,
	#category : #BaselineOfQuoteMe
}

{ #category : #testing }
BaselineOfQuoteMe class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfQuoteMe >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'QuoteMe' with: [
				spec requires: #('Mocketry' 'PharoEnhancements' 'SimplePersistence'). ]. ].

]
