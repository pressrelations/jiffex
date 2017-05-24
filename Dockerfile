FROM dory.pressrelations.de:5000/base-elixir-1.4:1.4.0-1

WORKDIR /app

COPY mix.* ./
RUN mix deps.get && \
	mix deps.compile && \
	mix compile && \
	MIX_ENV=prod mix compile

COPY lib ./lib
COPY spec ./spec
COPY config ./config

RUN mix compile && \
	MIX_ENV=prod mix compile

ENV PORT 4000
ENV READ_SECRETS_FROM_VAULT true
EXPOSE 4000
