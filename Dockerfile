# openshift-hyperledger-job-add-certificates
# Maintainers: Cristian Bermudez (bermudezcristian on GitHub)
# GitRepo: https://github.com/bermudezcristian/openshift-hyperledger-job-add-certificates

# Base OS layer: latest CentOS 7
FROM centos:7

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="bermudezcristian/openshift-hyperledger-job-add-certificates" \
      vendor="Cristian Bermudez" \
      version="1.0" \
      release="1" \
      summary="openshift-hyperledger-job-add-certificates" \
      description="openshift-hyperledger-job-add-certificates" \
### Required labels above - recommended below
      url="https://github.com/bermudezcristian/openshift-hyperledger-job-add-certificates" \
      run='docker run --name ${NAME} \
        -p 1433:1433 \
        -d ${IMAGE}' \
      io.k8s.description="openshift-hyperledger-job-add-certificates" \
      io.k8s.display-name="openshift-hyperledger-job-add-certificates"

COPY cryptogen /opt/bin/cryptogen
COPY configtxgen /opt/bin/configtxgen

ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin

### Containers should not run as root as a good practice
USER 10001

VOLUME /opt/volumes/ca-persistentvolumeclaim
VOLUME /opt/volumes/orderer-1-persistentvolumeclaim
VOLUME /opt/volumes/orderer-2-persistentvolumeclaim
VOLUME /opt/volumes/orderer-3-persistentvolumeclaim
VOLUME /opt/volumes/peer-1-persistentvolumeclaim
VOLUME /opt/volumes/peer-2-persistentvolumeclaim
VOLUME /opt/volumes/peer-3-persistentvolumeclaim
VOLUME /opt/volumes/peer-4-persistentvolumeclaim
