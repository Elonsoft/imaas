FROM elixir:1.9.1-alpine as otprelease

RUN apk update && \
    apk upgrade && \
    apk add --no-cache alpine-sdk git openssh build-base && \
    rm -rf /var/cache/apk/*

ENV HOME /app
RUN mkdir $HOME
WORKDIR $HOME

ARG MIX_ENV
ENV MIX_ENV $MIX_ENV

RUN mix local.hex --force && \
    mix local.rebar --force

COPY . .

RUN mix deps.get --only $MIX_ENV && \
    mix compile && \
    mix release

FROM pentacent/alpine-erlang-base:latest

ARG MIX_ENV
ENV MIX_ENV $MIX_ENV

ENV PORT 4000

RUN apk update && \
    apk upgrade && \
    apk add --no-cache alpine-sdk imagemagick && \
    rm -rf /var/cache/apk/*

COPY --from=bitwalker/alpine-erlang:latest /usr/lib/libcrypto.so.1.1 /usr/lib/libcrypto.so.1.1
COPY --from=otprelease /app/_build/${MIX_ENV}/rel/imaas ./

EXPOSE 4000

CMD ./bin/imaas start
