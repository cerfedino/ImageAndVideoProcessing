

main: src/out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(FILES),run('$(file)');)quit;"

src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/