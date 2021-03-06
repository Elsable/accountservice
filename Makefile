    GOCMD=go
    GOBUILD=$(GOCMD) build
    GOCLEAN=$(GOCMD) clean
    GOTEST=$(GOCMD) test
    GOGET=$(GOCMD) get
    BINARY_NAME=accountservice
    BINARY_UNIX=$(BINARY_NAME)-linux-amd64
    
    all: test build
    build: 
	$(GOBUILD) -o $(BINARY_NAME) -v
    test: 
	$(GOTEST) -v ./...
    clean: 
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	rm -f $(BINARY_UNIX)
    run:
	$(GOBUILD) -o $(BINARY_NAME) -v ./...
	./$(BINARY_NAME) 
    
    # Cross compilation
    build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_UNIX) -v
    docker-build:
	docker build -t someprefix/accountservice .
    docker-run:
        docker run --rm someprefix/accountservice:latest