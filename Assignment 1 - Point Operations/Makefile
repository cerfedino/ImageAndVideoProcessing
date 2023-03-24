FILES := src/tonemapping.m src/colorcorrection.m

main: src/out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(FILES),run('$(file)');)$(if $(filter 1,$(quit)),quit;)"

src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/