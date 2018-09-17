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

# Install latest mssql-server package
RUN yum install -y  && \
    yum clean all && \
    rm -rf /var/cache/yum

### Containers should not run as root as a good practice
USER 10001
