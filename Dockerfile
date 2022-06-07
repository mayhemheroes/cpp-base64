# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y clang

## Add source code to the build stage.
ADD . /cpp-base64
WORKDIR /cpp-base64

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN clang fuzz-encode-decode.cpp base64.cpp -o fuzz-encode-decode -fsanitize=fuzzer

# Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /cpp-base64/fuzz-encode-decode /

