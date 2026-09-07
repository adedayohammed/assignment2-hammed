FROM alpine:3.18

# Install dependencies needed for diagnostics
RUN apk add --no-cache bash bind-tools iputils procps

# Establish structural workspace
WORKDIR /app

# Copy scripts directly into place
COPY app/ /app/

# Apply runtime execution privileges 
RUN chmod +x /app/diagnostic.sh /app/health-check.sh

# Link binary to system path for clean routing executions
RUN ln -s /app/diagnostic.sh /usr/local/bin/diagnostic

ENTRYPOINT ["diagnostic"]
CMD ["help"]
