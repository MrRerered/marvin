FROM erlang:20-slim
LABEL maintainer="Denis Fakhrtdinov <me@shizz.ru>"

# Installing required tools
RUN apt-get update -y && apt-get install -y bash make gcc g++ git curl lsof netcat nano
RUN mkdir -p /tmp

# Running build
COPY . src
RUN rm -rf src/_build src/log/*
RUN cd src && make get-deps release-prod

# Copying release
RUN mkdir -p /opt/
RUN mkdir -p /tmp/erl_pipes/
RUN cp -R src/_build/prod/rel/marvin /opt/.
RUN mkdir -p /var/log/marvin/

# Cleanup
RUN rm -rf src

# Environment
ENV PATH="/opt/marvin/bin:$PATH"
ENV RELX_REPLACE_OS_VARS=true
# VMARGS
ENV MARVIN_VMARGS_SNAME=marvin
ENV MARVIN_VMARGS_COOKIE=marvin-cookie
ENV MARVIN_VMARGS_LIMIT_ETS=1024
ENV MARVIN_VMARGS_LIMIT_PROCESSES=64535
ENV MARVIN_VMARGS_LIMIT_PORTS=1024
ENV MARVIN_VMARGS_LIMIT_ATOMS=1048576
ENV MARVIN_VMARGS_ASYNC_THREADS=8
ENV MARVIN_VMARGS_KERNEL_POLL=true
ENV MARVIN_VMARGS_SMP=auto
# APP
ENV MARVIN_APP_ACCESS_TOKEN=NOTOKEN
ENV MARVIN_APP_API_HOST=discordapp.com
ENV MARVIN_APP_API_PORT=443
ENV MARVIN_APP_API_ROOT_URL=/api
ENV MARVIN_APP_API_GATEWAY_URL=/gateway/bot
ENV MARVIN_APP_GATEWAY_PORT=443
ENV MARVIN_APP_GATEWAY_PROTOVER=6
ENV MARVIN_APP_GATEWAY_COMPRESS=false
ENV MARVIN_APP_GATEWAY_LARGE_THRESHOLD=50
ENV MARVIN_APP_SYSINFO_LIBRARY_NAME=Marvin
ENV MARVIN_APP_SYSINFO_LIBRARY_WEB=http://shizzard.github.io/marvin
ENV MARVIN_APP_LAGER_LOG_ROOT=/var/log/marvin/
# GUILD
ENV MARVIN_APP_GUILD_CONFIG_ROOT=/tmp/
ENV MARVIN_APP_GUILD_CONFIG_FILENAME_TEMPLATE=guild_{{guild_id}}_config.json
ENV MARVIN_APP_PLUGIN_CONFIG_ROOT=/tmp/
ENV MARVIN_APP_PLUGIN_CONFIG_FILENAME_TEMPLATE=plugin_{{plugin_id}}_{{guild_id}}_config.json

# Runtime
EXPOSE 8080
HEALTHCHECK --interval=10s --timeout=5s --start-period=1m --retries=5 CMD ["marvin", "ping"]
ENTRYPOINT ["marvin"]
CMD ["foreground"]
