# 1 choose a compiler OS
FROM golang:alpine AS dev
# 2 (optional) label the compiler image
LABEL stage=dev
# 3 (optional) install any compiler-only dependencies
RUN apk add --no-cache gcc libc-dev
WORKDIR /go/src/app
# 4 copy all the source files
COPY . .
# 5 build the GO program
RUN CGO_ENABLED=0 GOOS=linux go build main.go
# 6 choose a runtime OS
FROM alpine AS prod
# 7 
ARG ENV
WORKDIR /
# 8 copy from dev the GO executable file
COPY --from=dev /go/src/app/main .
# 9 execute the program upon start 
CMD [ "./main" ]
