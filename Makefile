TAG := $(shell tar -cf - . | md5sum | cut -f 1 -d " ")
PROJECT := flashcards
IMAGE := charlieegan3/$(PROJECT)

%-build:
	docker build -t $(IMAGE)-$*:$(TAG) $*

%-push:
	make $*-build
	docker push $(IMAGE)-$*:$(TAG)

%-shell:
	make $*-build
	docker run -it -v $(PWD)/$*:/app $(IMAGE)-$*:$(TAG) bash

%-server:
	make $*-build
	docker run -it -v $(PWD)/$*:/app -p 3000:3000 $(IMAGE)-$*:$(TAG)
