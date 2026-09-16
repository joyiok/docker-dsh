FROM node:24-bookworm-slim

ARG DSH_VERSION=0.1.5-rc.1

RUN npm install --global "@deepseek-ai/dsh@${DSH_VERSION}" \
    && mkdir -p /home/node/.dsh /workspace \
    && chown -R node:node /home/node/.dsh /workspace

COPY public.cordis.patch.yml /app/public.cordis.patch.yml

USER node
WORKDIR /workspace

ENV DSH_HOME=/home/node/.dsh
ENV PORT=8080

EXPOSE 8080

CMD ["dsh", "web", "--patch", "/app/public.cordis.patch.yml", "--no-open"]
