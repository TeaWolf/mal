deps:
	lein deps

step0_repl: step0_repl.jar
	cat <(echo -e '#!/bin/sh\nexec java -jar "$$0" "$$@"') $@.jar > $@
	chmod +x $@

step0_repl.jar:
	lein uberjar

