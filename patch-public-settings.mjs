import { readFileSync, writeFileSync } from 'node:fs'

const file = '/usr/local/lib/node_modules/@deepseek-ai/dsh/node_modules/@deepseek-ai/dsh-client-connection/lib/client.js'
const authority = process.env.PUBLIC_HOST
if (!authority) throw new Error('PUBLIC_HOST is required at build time')

const hostname = new URL(`http://${authority}`).hostname
const needle = 'isLoopback: transport?.ownsHost === true || pageLocation === void 0 || isLoopbackHostname(pageLocation.hostname),'
const replacement = `isLoopback: transport?.ownsHost === true || pageLocation === void 0 || isLoopbackHostname(pageLocation.hostname) || pageLocation.hostname === ${JSON.stringify(hostname)},`
const source = readFileSync(file, 'utf8')

if (source.split(needle).length !== 2) throw new Error('unexpected dsh client connection build')
writeFileSync(file, source.replace(needle, replacement))
