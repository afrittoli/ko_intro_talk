# Start by building the application.
FROM golang:1.8 as build

WORKDIR /go/src/github.com/afrittoli/go_helloworld
ADD . /go/src/github.com/afrittoli/go_helloworld

RUN go-wrapper download   # "go get -d -v ./..."
RUN go-wrapper install

# Now copy it into our base image.
FROM gcr.io/distroless/base
COPY --from=build /go/bin/go_helloworld /helloworld
CMD ["/helloworld"]
