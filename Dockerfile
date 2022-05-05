#
# Copyright (c) 2019-2022 Blue Clover Devices
#
# SPDX-License-Identifier: Apache-2.0
#
FROM ubuntu:20.04

RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    musl=1.1.24-1 \
    wget=1.20.3-1ubuntu1 \
    ca-certificates=20210119~20.04.2 \
    uuid-runtime=2.34-0.1ubuntu9.3 \
    && rm -rf rm -rf /var/lib/apt/lists/* 

RUN wget --progress=dot:giga https://download.pltcloud.com/cli/pltcloud_0.4.2_amd64.deb \
    && dpkg -i pltcloud_0.4.2_amd64.deb

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
