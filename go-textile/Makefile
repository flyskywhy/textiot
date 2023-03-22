setup:
	go mod download
	go install github.com/ahmetb/govvv

test:
	./test_compile

format:
	goimports -w -l `find . -type f -name '*.go' -not -path './vendor/*'`

lint:
	echo 'Linting with prettier...'
	npx prettier --check "./**" 2> /dev/null || true
	echo 'Linting with golint...'
	golint `go list ./... | grep -v /vendor/`

textile:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	go build -ldflags "-extldflags -static -w $(FLAGS)" github.com/textileio/go-textile/cmd/textile

textile-win:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	CGO_ENABLED=1 GOOS=windows CC=x86_64-w64-mingw32-gcc go build -ldflags "-extldflags -static -w $(FLAGS)" github.com/textileio/go-textile/cmd/textile

textile-mac:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	go build -ldflags "-w $(FLAGS)" -o textile-mac github.com/textileio/go-textile/cmd/textile

# [osxcross](https://github.com/tpoechtrager/osxcross) can be installed step by step ref to
# https://enigma-dev.org/docs/wiki/index.php?title=CrossCompileLinuxOSX
textile-mac-osxcross:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	CGO_ENABLED=1 GOOS=darwin CC=o64-clang go build -ldflags "-w $(FLAGS)" -o textile-mac-osxcross github.com/textileio/go-textile/cmd/textile

textile-arm:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	CGO_ENABLED=1 GOOS=linux GOARCH=arm GOARM=7 CC=arm-linux-gnueabihf-gcc go build -ldflags "-extldflags -static -w $(FLAGS)" -i -o textile-arm cmd/textile/main.go

textile-riscv:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	CGO_ENABLED=1 GOOS=linux GOARCH=riscv64 CC=riscv64-unknown-linux-gnu-gcc go build -ldflags "-extldflags -static -w $(FLAGS)" -i -o textile-riscv cmd/textile/main.go

ios:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	gomobile bind -ldflags "-w $(FLAGS)" -v -target=ios github.com/textileio/go-textile/mobile github.com/textileio/go-textile/core
	mkdir -p mobile/dist/ios/ && cp -r Mobile.framework mobile/dist/ios/
	rm -rf Mobile.framework

android:
	$(eval FLAGS := $$(shell govvv -flags | sed 's/main/github.com\/textileio\/go-textile\/common/g'))
	gomobile bind -ldflags "-w $(FLAGS)" -v -target=android -o mobile.aar github.com/textileio/go-textile/mobile github.com/textileio/go-textile/core
	mkdir -p mobile/dist/android/ && mv mobile.aar mobile/dist/android/

protos:
	$(eval P_TIMESTAMP := Mgoogle/protobuf/timestamp.proto=github.com/golang/protobuf/ptypes/timestamp)
	$(eval P_ANY := Mgoogle/protobuf/any.proto=github.com/golang/protobuf/ptypes/any)
	$(eval PKGMAP := $$(P_TIMESTAMP),$$(P_ANY))
	cd pb/protos; protoc --go_out=$(PKGMAP):../../.. *.proto

.PHONY: docs
docs:
	go get github.com/swaggo/swag/cmd/swag
	swag init --generalInfo=api/api.go --output=api/docs
	npm i -g swagger-markdown
	swagger-markdown -i api/docs/swagger.yaml -o api/docs/swagger.md

docker:
	$(eval VERSION := $$(shell ggrep -oP 'const Version = "\K[^"]+' common/version.go))
	docker build -t go-textile:$(VERSION) .

docker_cafe:
	$(eval VERSION := $$(shell ggrep -oP 'const Version = "\K[^"]+' common/version.go))
	docker build -t go-textile:$(VERSION)-cafe -f Dockerfile.cafe .
