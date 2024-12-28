#
# Copyright (c) 2019-2024 Blue Clover Devices
#
# SPDX-License-Identifier: Apache-2.0
#
FROM ubuntu:22.04

RUN set -xe \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  musl=1.2.2-4 \
  wget=1.21.2-2ubuntu1.1 \
  ca-certificates=20240203~22.04.1 \
  uuid-runtime=2.37.2-4ubuntu3.4 \
  && rm -rf rm -rf /var/lib/apt/lists/* 

ARG PLTCLOUD_CI_UPLOADER_VERSION="0.5.1"

RUN wget --progress=dot:giga https://download.pltcloud.com/cli/pltcloud_${PLTCLOUD_CI_UPLOADER_VERSION}_amd64.deb \
  && dpkg -i pltcloud_${PLTCLOUD_CI_UPLOADER_VERSION}_amd64.deb

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
