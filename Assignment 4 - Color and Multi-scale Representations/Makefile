.PHONY: $(MAKECMDGOALS)
FILES := src/ex1.m src/ex2.m src/ex3.m src/ex4.m src/ex6.m

QUIT=$(if $(filter 1,$(quit)),quit;)

all: src/out/
	matlab -nosplash -nodesktop -sd ./src -r "$(foreach file,$(FILES),close all;clear all;run('../$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


$(MAKECMDGOALS): src/out/
	matlab -nosplash -nodesktop -sd ./src -r "$(foreach file,$(MAKECMDGOALS),close all;clear all;run('../$(file)');disp('Done. Press any key to continue ...'); pause;)$(QUIT)"


src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/