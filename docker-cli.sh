#!/usr/bin/env bash
# Script created following the Ubuntu Server install documentation.
#   Read more here: https://docs.docker.com/engine/install/ubuntu/

function module {

    function banner {
        # Helper function to pretty print banner messages in build log
        printf " > \n > ${1}\n > \n"
    }

    case "${1}" in
        "install")
            shift;
            local version="${1}"

            # --------------------------------------------------------------------------------
            # Install Docker CLI components
            #

            # Update the apt package index and install packages to allow apt to use a repository over HTTPS
            banner "Installing initial OS packages"
            apt-get update
            apt-get install -yq --no-install-recommends\
                ca-certificates \
                curl \
                gnupg \
                lsb-release \

            # Add Docker’s official GPG key
            banner "Adding Docker’s official GPG key"
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

            # Set up the Docker stable repository
            banner "Set up the Docker stable repository"
            echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

            # Update apt against the Docker stable repo
            apt-get update
            if [[ -n "${version}" ]]; then
                # Specific version was provided we'll install that ...
                banner "Installing Docker CE CLI, version=${version}"
                apt-get install -yq --no-install-recommends docker-ce-cli="${version}"
            else
                # ... otherwise we'll default to the latest version
                banner "Installing Docker CE CLI, version=latest"
                apt-get install -yq --no-install-recommends docker-ce-cli
            fi

            # --------------------------------------------------------------------------------
            # Post Install user setup
            #
            banner "Setting up docker group"
            groupadd docker
            newgrp docker 
            ;;
        *)
            echo "No task name provide. Nothing to do."
            ;;
    esac
}
module "$@"
