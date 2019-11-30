TAG := $(shell tar -cf - . | md5sum | cut -f 1 -d " ")
PROJECT := flashcards
IMAGE := charlieegan3/$(PROJECT):$(TAG)

build:
	docker build -t $(IMAGE) .

push: build
	docker push $(IMAGE)

server: build
	docker run -it -p 3000:3000 -v $$(pwd):/app $(IMAGE)

# for rails new, rails generate etc
shell: build
	docker run -it -v $$(pwd):/app $(IMAGE) bash
