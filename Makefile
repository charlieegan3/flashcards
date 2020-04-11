TAG := $(shell tar -cf - . | md5sum | cut -f 1 -d " ")
PROJECT := flashcards
IMAGE := charlieegan3/$(PROJECT)

%-build:
	docker build -t $(IMAGE)-$*:$(TAG) $*

%-shell:
	make $*-build
	docker run -it -v $(PWD)/$*:/app $(IMAGE)-$*:$(TAG) bash

%-server:
	make $*-build
	docker run -it --network="host" -v $(PWD)/$*:/app $(IMAGE)-$*:$(TAG)

build_frontend_dist:
	docker build -t $(IMAGE):prod .
	container=$$(docker create $(IMAGE):prod) && \
		docker cp $$container:/build/dist app/public
