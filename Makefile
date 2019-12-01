TAG := $(shell tar -cf - . | md5sum | cut -f 1 -d " ")
PROJECT := flashcards
IMAGE := charlieegan3/$(PROJECT)

build_%:
	docker build -t $(IMAGE)-$*:$(TAG) $*

push_%:
	make build_$*
	docker push $(IMAGE)-$*:$(TAG)

server_%:
	make build_$*
	docker run -it -p 3000:3000 $(IMAGE)-$*:$(TAG)
