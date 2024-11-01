install:
	cd Scripts && bun install

build: install
	swift run blog ./

deploy: install
	./deploy.sh
