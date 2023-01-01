FROM golang:1.18.3-buster@sha256:7acdbec4276ce3c8915ffa03148bd4b41dfb46a190fd1242e9df5b11061d282d as build

ADD . /pleco
WORKDIR /pleco
RUN go get && go build -o /pleco.bin main.go

FROM debian:buster-slim as run

RUN apt-get update && apt-get install -y ca-certificates && apt-get clean
COPY --from=build /pleco.bin /usr/bin/pleco
CMD ["pleco", "start"]
