.PHONY: $(MAKECMDGOALS)
FILES := src/unsharpmasking.m src/separateFilters.m src/anisotropicGaussian.m src/iterativeFiltering.m src/imageStylization.m

QUIT=$(if $(filter 1,$(quit)),quit;)

all: src/out/
	matlab -nosplash -nodesktop -sd ./src -r "$(foreach file,$(FILES),clear all;run('../$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


$(MAKECMDGOALS): src/out/
	matlab -nosplash -nodesktop -sd ./src -r "$(foreach file,$(MAKECMDGOALS),clear all;run('../$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/