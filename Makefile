# Disable all the default make stuff
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

## Display a list of the documented make targets
.PHONY: help
help:
	@echo Documented Make targets:
	@perl -e 'undef $$/; while (<>) { while ($$_ =~ /## (.*?)(?:\n# .*)*\n.PHONY:\s+(\S+).*/mg) { printf "\033[36m%-30s\033[0m %s\n", $$2, $$1 } }' $(MAKEFILE_LIST) | sort

.PHONY: .FORCE
.FORCE:

.score-compose/state.yaml:
	score-compose init \
		--no-sample \
		--provisioners https://raw.githubusercontent.com/score-spec/community-provisioners/refs/heads/main/service/score-compose/10-service.provisioners.yaml

compose.yaml: src/adservice/score.yaml src/cartservice/score.yaml src/checkoutservice/score.yaml src/currencyservice/score.yaml src/emailservice/score.yaml src/frontend/score.yaml src/loadgenerator/score.yaml src/paymentservice/score.yaml src/productcatalogservice/score.yaml src/recommendationservice/score.yaml src/shippingservice/score.yaml .score-compose/state.yaml Makefile
	score-compose generate \
		src/adservice/score.yaml \
		--build 'ad={"context":"src/adservice","tags":["ad:init"]}'
	score-compose generate \
		src/cartservice/score.yaml \
		--build 'cart={"context":"src/cartservice/src","tags":["cart:init"]}'
	score-compose generate \
		src/currencyservice/score.yaml \
		--build 'currency={"context":"src/currencyservice","tags":["currency:init"]}'
	score-compose generate \
		src/emailservice/score.yaml \
		--build 'email={"context":"src/emailservice","tags":["email:init"]}'
	score-compose generate \
		src/paymentservice/score.yaml \
		--build 'payment={"context":"src/paymentservice","tags":["payment:init"]}'
	score-compose generate \
		src/productcatalogservice/score.yaml \
		--build 'productcatalog={"context":"src/productcatalogservice","tags":["productcatalog:init"]}'
	score-compose generate \
		src/recommendationservice/score.yaml \
		--build 'recommendation={"context":"src/recommendationservice","tags":["recommendation:init"]}'
	score-compose generate \
		src/shippingservice/score.yaml \
		--build 'shipping={"context":"src/shippingservice","tags":["shipping:init"]}'
	score-compose generate \
		src/checkoutservice/score.yaml \
		--build 'checkout={"context":"src/checkoutservice","tags":["checkout:init"]}'
	score-compose generate \
		src/frontend/score.yaml \
		--build 'frontend={"context":"src/frontend","tags":["frontend:init"]}'
	score-compose generate \
		src/loadgenerator/score.yaml \
		--build 'loadgenerator={"context":"src/loadgenerator","tags":["loadgenerator:init"]}'

## Generate a compose.yaml file from the score specs and launch it.
.PHONY: compose-up
compose-up: compose.yaml
	docker compose up --build -d --remove-orphans --wait
	sleep 2

## Generate a compose.yaml file from the score spec, launch it and test (curl) the exposed container.
.PHONY: compose-test
compose-test: compose-up
	curl $$(score-compose resources get-outputs dns.default#frontend.dns --format '{{ .host }}:8080')

## Delete the containers running via compose down.
.PHONY: compose-down
compose-down:
	docker compose down -v --remove-orphans || true