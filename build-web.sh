#!/usr/bin/env bash

set -euo pipefail

## js-http-client
## The `tsc` in `npm run build` will failed if there is some parent `node_modules/` as
## described in https://github.com/microsoft/TypeScript/issues/29808#issuecomment-604190036
## And refer to js-ipfs, maybe we should develop in pure javascript directly?
(
    cd js-http-client
    npm install
    npm run build
    rm -fr node_modules
)
