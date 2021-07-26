Class {
	#name : #BaselineOfQuoteMe,
	#superclass : #BaselineOf,
	#category : #BaselineOfQuoteMe
}

{ #category : #baseline }
BaselineOfQuoteMe >> baseline: spec [
	<baseline>

	spec for: #'common' do: [
		spec 
			baseline: 'LivingLibrary' with: [
				spec repository: 'github://seandenigris/Living-Library' ];
			baseline: 'Mocketry' with: [
				spec repository: 'github://dionisiydk/Mocketry' ];
			baseline: 'PharoEnhancements' with: [
				spec repository: 'github://seandenigris/Pharo-Enhancements' ];
			baseline: 'SimplePersistence' with: [
				spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: 'QuoteMe' with: [
				spec requires: #('LivingLibrary' 'Mocketry' 'PharoEnhancements' 'SimplePersistence'). ]. ].

]
