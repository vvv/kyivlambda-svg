ELMFLAGS =

index.html: src/Main.elm elm.json
	elm make $(ELMFLAGS) $<

mostlyclean:
	rm -rfv elm-stuff

clean: mostlyclean
	rm -fv index.html
