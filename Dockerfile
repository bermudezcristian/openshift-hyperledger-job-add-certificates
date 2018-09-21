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

# Create the volumes
VOLUME /opt/volumes/ca-persistentvolumeclaim /opt/volumes/orderer-1-persistentvolumeclaim \
/opt/volumes/orderer-2-persistentvolumeclaim /opt/volumes/orderer-3-persistentvolumeclaim \
/opt/volumes/peer-1-persistentvolumeclaim /opt/volumes/peer-2-persistentvolumeclaim \
/opt/volumes/peer-3-persistentvolumeclaim /opt/volumes/peer-4-persistentvolumeclaim

# Install git
RUN yum install -y git && \
    yum clean all && \
    rm -rf /var/cache/yum

USER 10001

# Clone repo
WORKDIR /app
RUN git clone https://github.com/hyperledger/fabric-samples

# Run script to get the binary files
WORKDIR /app/fabric-samples
RUN sh scripts/bootstrap.sh

# Add the binary path to ENV
ENV PATH=${PATH}:/app/fabric-samples/bin

# Copy the script that moves the certificates to the volumes
COPY script.sh script.sh

# Add the Command to run the script automatically at startup ? WTF
CMD ["/app/fabric-samples/script.sh"]
