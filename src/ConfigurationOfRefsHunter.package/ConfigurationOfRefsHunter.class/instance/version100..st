versions
version100: spec
	<version: '1.0.0' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.0'.
		spec author: 'PavelKrivanek'.
		spec timestamp: '4/7/2016 13:42'.
		spec 
			package: 'RefsHunter-Core' with: 'RefsHunter-Core-PavelKrivanek.1';
			package: 'RefsHunter-Test' with: 'RefsHunter-Test-PavelKrivanek.2'. ].
