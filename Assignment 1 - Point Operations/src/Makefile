.PHONY: $(MAKECMDGOALS)
FILES := tonemapping.m colorcorrection.m chromakey.m bonus.m histograms.m 

QUIT=$(if $(filter 1,$(quit)),quit;)

all: out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(FILES),run('$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


$(MAKECMDGOALS): out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(MAKECMDGOALS),run('$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


out/:
	mkdir -p out/

clean:
	rm -r out/