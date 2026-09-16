FROM node:24-bookworm-slim

ARG DSH_VERSION=0.1.5-rc.1
ARG PUBLIC_HOST

COPY patch-public-settings.mjs /app/patch-public-settings.mjs
RUN npm install --global "@deepseek-ai/dsh@${DSH_VERSION}" \
    && mkdir -p /home/node/.dsh /workspace \
    && chown -R node:node /home/node/.dsh /workspace \
    && PUBLIC_HOST="${PUBLIC_HOST}" node /app/patch-public-settings.mjs

COPY public.cordis.patch.yml /app/public.cordis.patch.yml

USER node
WORKDIR /workspace

ARG PORT=8080

ENV DSH_HOME=/home/node/.dsh
ENV PORT=${PORT}
ENV PUBLIC_HOST=${PUBLIC_HOST}

EXPOSE 8080

CMD ["dsh", "web", "--patch", "/app/public.cordis.patch.yml", "--no-open"]
