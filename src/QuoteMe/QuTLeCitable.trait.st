Trait {
	#name : #QuTLeCitable,
	#category : #'QuoteMe-GToolkit'
}

{ #category : #accessing }
QuTLeCitable >> ensureUUID [

	 ^ self 
	 	propertyAt: #uuid
	 	ifAbsentPut: [ UUIDGenerator next ]
]

{ #category : #accessing }
QuTLeCitable >> uuid [

	 ^ self propertyAt: #uuid ifAbsent: [ nil ]
]
