[:scoreA :scoreB |	(scoreA > scoreB ) 		ifTrue: [ Transcript show: 'Player A won' ; cr]		ifFalse: [		(scoreA < scoreB ) 			ifTrue: [ Transcript show: 'Player B won' ; cr ] 			ifFalse: [ Transcript show: 'Match is declared as draw' ; cr]				]] value:65 value:48