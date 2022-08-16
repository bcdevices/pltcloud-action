#
# Copyright (c) 2019-2022 Blue Clover Devices
#
# SPDX-License-Identifier: Apache-2.0
#
FROM ubuntu:22.04

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    musl=1.2.2-4 \
    wget=1.21.2-2ubuntu1 \
    ca-certificates=20211016 \
    uuid-runtime=2.37.2-4ubuntu3 \
    && rm -rf rm -rf /var/lib/apt/lists/* 

RUN wget --progress=dot:giga https://download.pltcloud.com/cli/pltcloud_0.4.3_amd64.deb \
    && dpkg -i pltcloud_0.4.3_amd64.deb

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
