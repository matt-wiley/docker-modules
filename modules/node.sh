#!/usr/bin/env bash

# TODO: Setup version handling for Node JS Module

function module {

    function banner {
        # Helper function to pretty print banner messages in build log
        printf " > \n > ${1}\n > \n"
    }

    case "${1}" in
        "install")
            # Update the apt package index and install packages to allow apt to use a repository over HTTPS
            banner "Installing Node OS Package ad Yarn"
            
            apt-get update && \
            curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && \
            apt-get install -yq nodejs build-essential --no-install-recommends && \
            npm install --global yarn

            banner "Setting up 'node' group and adjust permission on global node_modules."
            groupadd node && \
            chown -R root:node /usr/lib/node_modules && \
            chmod -R 775 /usr/lib/node_modules

            ;;
        *)
            echo "No task name provide. Nothing to do."
            ;;
    esac
}
module "$@"
