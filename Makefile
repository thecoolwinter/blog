install:
	cd Scripts && bun install

build: install
	swift run --configuration release blog ./

deploy: install
	./deploy.sh
