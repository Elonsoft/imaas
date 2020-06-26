FROM golang:alpine as build

RUN mkdir /app
ADD . /app/
WORKDIR /app
RUN go build -o main .

FROM scratch
COPY --from=build /app/main /bin/caas
