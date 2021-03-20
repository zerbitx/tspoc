FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y curl gpg && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.gpg | apt-key add - && \
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/focal.list | tee /etc/apt/sources.list.d/tailscale.list && \
    apt-get update -y && \
    apt-get install -y tailscale

COPY tailscale-entrypoint.sh .
RUN chmod +x tailscale-entrypoint.sh
RUN ls

CMD ["./tailscale-entrypoint.sh"]
