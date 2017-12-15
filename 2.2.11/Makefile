NAME := "titpetric/sphinxsearch:2.2.11"

build:
	-docker rmi -f $(NAME)
	docker build -t $(NAME) --build-arg GITVERSION=${GITVERSION} .
	-docker-cleanup

.PHONY: build
