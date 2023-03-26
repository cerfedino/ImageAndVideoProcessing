.PHONY: $(MAKECMDGOALS)
FILES := src/tonemapping.m src/colorcorrection.m src/histograms.m src/chromakey.m

QUIT=$(if $(filter 1,$(quit)),quit;)

all: src/out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(FILES),run('$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


$(MAKECMDGOALS): src/out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(MAKECMDGOALS),run('$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/