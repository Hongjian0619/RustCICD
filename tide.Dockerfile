FROM ekidd/rust-musl-builder:nightly-2020-11-19 as builder
COPY . /home/rust/src
RUN sudo chown -R rust:rust /home/rust/src /home/rust/src/target; \
    cargo build --release

FROM alpine:latest
WORKDIR /usr/src/app
COPY --from=builder /home/rust/src/target/x86_64-unknown-linux-musl/release/tide-server .  
EXPOSE 8080

CMD ["./tide-server"]

