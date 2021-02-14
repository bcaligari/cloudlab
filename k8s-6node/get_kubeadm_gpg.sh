#!/bin/bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | \
	gpg --keyid-format long --import --import-options show-only --with-fingerprint -
