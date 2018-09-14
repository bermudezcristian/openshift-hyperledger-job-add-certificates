# mssql-server-centos7
# Maintainers: Cristian Bermudez (bermudezcristian on GitHub)
# GitRepo: https://github.com/bermudezcristian/mssql-server-rhel

# Base OS layer: latest CentOS 7
FROM centos:7

### Atomic/OpenShift Labels - https://github.com/projectatomic/ContainerApplicationGenericLabels
LABEL name="microsoft/mssql-server-linux" \
      vendor="Cristian Bermudez" \
      version="1.0" \
      release="1" \
      summary="MS SQL Server" \
      description="MS SQL Server is ....." \
### Required labels above - recommended below
      url="https://www.microsoft.com/en-us/sql-server/" \
      run='docker run --name ${NAME} \
        -e ACCEPT_EULA=Y -e SA_PASSWORD=yourStrong@Password \
        -p 1433:1433 \
        -d  ${IMAGE}' \
      io.k8s.description="MS SQL Server is ....." \
      io.k8s.display-name="MS SQL Server"

# For environment variables list, see https://docs.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables
# If you want to specify LCID, you may not set here. You should specify with running a docker. ``docker run -e "MSSQL_LCID=1041" <image>``
ARG SA_PASSWORD='StrongP@ssW0rd'
ARG TCP_PORT=1433

ARG PID=Developer

ENV ACCEPT_EULA=Y MSSQL_PID=$PID MSSQL_SA_PASSWORD=$SA_PASSWORD MSSQL_TCP_PORT=$TCP_PORT

# Install latest mssql-server package
RUN curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/7/mssql-server-2017.repo && \
    curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/7/prod.repo && \
    yum install -y mssql-server mssql-tools unixODBC-devel && \
    yum clean all && \
    rm -rf /var/cache/yum

COPY uid_entrypoint /opt/mssql-tools/bin/

ENV PATH=${PATH}:/opt/mssql/bin:/opt/mssql-tools/bin

RUN mkdir -p /var/opt/mssql/data && \
    chmod -R g=u /var/opt/mssql /etc/passwd

### Containers should not run as root as a good practice
USER 10001

# Default SQL Server TCP/Port
EXPOSE $TCP_PORT

VOLUME /var/opt/mssql/data

### user name recognition at runtime w/ an arbitrary uid - for OpenShift deployments
ENTRYPOINT [ "uid_entrypoint" ]

# Run SQL Server process
CMD sqlservr
