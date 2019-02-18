FROM 589401011586.dkr.ecr.eu-central-1.amazonaws.com/base-elixir-1.6:1.6.3-1

RUN mix local.hex --force && \
	mix local.rebar --force && \
	mix hex.info

WORKDIR /app

COPY mix.* ./
RUN mix deps.get && \
	mix deps.compile && \
	mix compile && \
	MIX_ENV=test mix compile

COPY lib ./lib
COPY spec ./spec
COPY config ./config

RUN mix compile && \
	MIX_ENV=test mix compile

RUN MIX_ENV=test mix espec --trace
