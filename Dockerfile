FROM ubuntu:latest
# Systemwide setup
RUN apt update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install --yes build-essential protobuf-compiler curl cmake golang libssl-dev

# Create the non-root user.
RUN useradd builder -m -b /
USER builder
RUN mkdir -p ~/build/src

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/builder/.cargo/bin:${PATH}"

# Fetch, then prebuild all deps
COPY Cargo.toml /builder/build/
RUN echo "fn main() {}" > /builder/build/src/main.rs
WORKDIR /builder/build
RUN cargo fetch
RUN cargo build --release
COPY src /builder/build/src
RUN rm -rf ./target/release/.fingerprint/hello-tikv-rust*

# Actually build the binary
RUN cargo build --release
ENTRYPOINT /builder/build/target/release/hello-tikv-rust
