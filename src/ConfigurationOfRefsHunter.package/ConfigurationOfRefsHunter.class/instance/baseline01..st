baselines
baseline01: spec
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/PavelKrivanek/RefsHunter/main/'.
		spec 
			package: 'RefsHunter-Core';
			package: 'RefsHunter-Test'. ].
