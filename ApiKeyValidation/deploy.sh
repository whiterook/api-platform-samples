#!/bin/bash

source setenv.sh

apiName=samples-apikey
basePath=/samples-apikey

##Cleanup
rm -rf apiproxy.zip
zip -r apiproxy apiproxy
sh cleanup.sh

##Create APIProduct
curl -u $credentials "$url/v1/organizations/$org/apiproducts" -T createAPIProduct.xml -H "Content-Type: application/xml" -X POST -k

##Create Developer:
curl -u $credentials "$url/v1/organizations/$org/developers" -T createDeveloper.xml -H "Content-Type: application/xml" -X POST -k

##Create Developer Apps:
curl -u $credentials "$url/v1/organizations/$org/developers/4gsample@apigee.com/apps" -T createDeveloperApp.xml -H "Content-Type: application/xml" -X POST -k

##Import and Deploy

$ ../tools/deploy.py -n contentrouting -u $credentials -o $org -e $environment -d ../apikey