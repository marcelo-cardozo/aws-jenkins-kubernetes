#!/bin/bash

aws eks update-kubeconfig --name EKS-CheloKube --kubeconfig config.yml --dry-run | yq r -j - > kubeconfig.json
