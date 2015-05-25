main.exe: Makefile main.d inputh.d input.d functionh.d funct.d
	dmd -inline -release -O main inputh input functionh funct
