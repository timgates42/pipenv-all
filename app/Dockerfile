FROM ubuntu:18.04
ARG PYTHONVERS
COPY install.sh /build/install.sh
RUN /build/install.sh && \
  rm -r /build
