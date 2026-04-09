FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake git wget python3 python3-pip ca-certificates curl \
    zlib1g-dev libssl-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app

RUN cmake -B .build -DCMAKE_BUILD_TYPE=Release \
    && cmake --build .build -j$(nproc)

EXPOSE 8080

CMD ["./pocket-tts", "--server", "--port", "8080"]
