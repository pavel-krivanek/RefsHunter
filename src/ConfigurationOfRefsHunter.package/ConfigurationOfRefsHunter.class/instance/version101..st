versions
version101: spec
	<version: '1.0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 1.0.1'.
		spec author: 'PavelKrivanek'.
		spec timestamp: '4/13/2016 10:39'.
		spec 
			package: 'RefsHunter-Core' with: 'RefsHunter-Core-PavelKrivanek.2';
			package: 'RefsHunter-Test' with: 'RefsHunter-Test-PavelKrivanek.2'. ].
