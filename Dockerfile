FROM dory.pressrelations.de:5000/base-elixir-1.4:1.4.2-2

RUN mix local.hex --force && \
	mix local.rebar --force && \
	mix hex.info

WORKDIR /app

COPY mix.* ./
RUN mix deps.get && \
	mix deps.compile && \
	mix compile

COPY lib ./lib
COPY spec ./spec
COPY config ./config

RUN mix compile && \
	MIX_ENV=test mix compile

RUN MIX_ENV=test mix espec --trace