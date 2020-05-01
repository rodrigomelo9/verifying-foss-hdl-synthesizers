#!/usr/bin/make

DOCKER_CMD = docker run --rm -it \
-v /opt:/opt \
-v /$(CURDIR)://wrk \
-w //wrk \
verifying-foss-hdl-synthesizers

prepare:
	docker build -t verifying-foss-hdl-synthesizers -f Dockerfile .
