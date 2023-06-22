FROM golang:1.20 AS build
WORKDIR /usr/src/app

COPY go/go.* ./
RUN go mod download && go mod verify

COPY go/*.go ./
RUN go mod download

RUN go build -v -o /usr/local/bin/hello-fullcycle

FROM scratch

COPY --from=build /usr/local/bin .

CMD ["/hello-fullcycle"]