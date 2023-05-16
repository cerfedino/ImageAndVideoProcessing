.PHONY: $(MAKECMDGOALS)
FILES := src/ex5.m src/ex6.m src/ex7.m src/exBonus.m

QUIT=$(if $(filter 1,$(quit)),quit;)

all: src/out/
	matlab -nosplash -nodesktop -sd ./src -r "$(foreach file,$(FILES),clear all;run('../$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


$(MAKECMDGOALS): src/out/
	matlab -nosplash -nodesktop -sd ./src -r "$(foreach file,$(MAKECMDGOALS),clear all;run('../$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/