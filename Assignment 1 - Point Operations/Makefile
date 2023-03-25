.PHONY: $(MAKECMDGOALS)
FILES := src/tonemapping.m src/colorcorrection.m src/histograms.m

QUIT=$(if $(filter 1,$(quit)),quit;)

all: src/out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(FILES),run('$(file)');)$(QUIT)"


$(MAKECMDGOALS): src/out/
	matlab -nosplash -nodesktop -sd ./ -r "$(foreach file,$(MAKECMDGOALS),run('$(file)');)$(QUIT)"


src/out/:
	mkdir -p src/out/

clean:
	rm -r src/out/