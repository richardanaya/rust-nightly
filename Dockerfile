FROM debian:jessie-slim
RUN apt-get -qq update -y && \
  apt-get -qq install -y --no-install-recommends curl ca-certificates \
  file sudo gcc libc-dev
RUN curl -s https://static.rust-lang.org/rustup.sh | sh -s -- \
  --channel=nightly --prefix=/usr
WORKDIR /src
ONBUILD COPY Cargo.toml Cargo.lock /src/
ONBUILD RUN mkdir src && touch src/lib.rs && cargo build --release --lib && rm -rf src
ONBUILD COPY src /src/src
ONBUILD RUN cargo build --release
