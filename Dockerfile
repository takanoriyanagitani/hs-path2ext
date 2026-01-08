FROM haskell:9.12.2-slim-bookworm AS builder
RUN echo cabal update date: 2026-01-05
RUN cabal update --verbose=2

WORKDIR /hs-path2ext
COPY --link ./hs-path2ext.cabal ./
RUN cabal update --verbose=2
RUN cabal build --only-dependencies
COPY --link ./app/ ./app/
COPY --link ./src/ ./src/
RUN cabal build
RUN cp $( cabal list-bin hs-path2ext | fgrep --max-count=1 hs-path2ext ) /usr/local/bin/
RUN which hs-path2ext
RUN find . -type f | hs-path2ext | sort -u

FROM debian:bookworm-slim
COPY --link --from=builder /usr/local/bin/hs-path2ext /usr/local/bin/

CMD ["/usr/local/bin/hs-path2ext"]
