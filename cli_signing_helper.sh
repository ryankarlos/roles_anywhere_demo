#! /bin/bash

./aws_signing_helper credential-process --certificate cert.pem --private-key decrypted-private-key.pem \
--profile-arn  <profile-arn> \
--role-arn <role-arn> \
--trust-anchor-arn <trust-anchor-arn> \