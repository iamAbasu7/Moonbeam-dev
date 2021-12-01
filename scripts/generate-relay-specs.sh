#!/bin/bash
set -e
source scripts/_init_var.sh

if [ -z "$POLKADOT_VERSION" ]; then
  POLKADOT_VERSION="sha-`egrep -o '/axia.*#([^\"]*)' Cargo.lock | \
    head -1 | sed 's/.*#//' |  cut -c1-8`"
fi

echo "Using Polkadot revision #${POLKADOT_VERSION}"

echo "=================== Rococo-Local ==================="
docker run -it -v $(pwd)/build:/build purestake/moonbase-relay-testnet:$POLKADOT_VERSION \
  /usr/local/bin/axia \
    build-spec \
      --chain rococo-local \
      -lerror \
      --disable-default-bootnode \
      --raw \
    > $ROCOCO_LOCAL_RAW_SPEC
echo $ROCOCO_LOCAL_RAW_SPEC generated