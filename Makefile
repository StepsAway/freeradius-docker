NAME = stepsaway/baseimage
VERSION = 1.0.3

.PHONY: all build_all clean clean_images \
	build_freeradius30 \
	release test

all: build_all

build_all: \
	build_freeradius30

build_freeradius30:
	rm -rf freeradius30_image
	cp -pR image freeradius30_image
	echo freeradius30=1 >> freeradius30_image/buildconfig
	echo final=1 >> freeradius30_image/buildconfig
	sed -i -e "s/##TAG##/$(VERSION)/" freeradius30_image/Dockerfile
	docker build -t $(NAME)-freeradius3:0-$(VERSION) --rm freeradius30_image

clean:
	rm -rf freeradius30_image

clean_images:
	@if docker images $(NAME)-freeradius3:0-$(VERSION) | awk '{ print $2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME)-freeradius3:0-$(VERSION) || true; fi

release: test
	@if ! docker images $(NAME)-freeradius3:0-$(VERSION) | awk '{ print $2 }' | grep -q -F 0-$(VERSION); then echo "$(NAME)-freeradius3:0-$(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)-freeradius3:0-$(VERSION)
	@echo "*** Don't forget to create a tag. git tag $(VERSION) && git push origin $(VERSION)"

test:
	@if docker images $(NAME)-freeradius3:0-$(VERSION) | awk '{ print $$2 }' | grep -q -F $(VERSION); then env NAME=$(NAME)-freeradius3:0 FR='3.0.12' VERSION=$(VERSION) ./test/runner.sh; fi
