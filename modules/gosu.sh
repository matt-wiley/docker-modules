#!/usr/bin/env bash\

function module {

    function banner {
        # Helper function to pretty print banner messages in build log
        printf " > \n > ${1}\n > \n"
    }

    case "${1}" in
        "install")
            # Update the apt package index and install packages to allow apt to use a repository over HTTPS
            banner "Installing Gosu OS Package"
            apt-get update
            apt-get install -yq --no-install-recommends gosu
            ;;
        *)
            echo "No task name provide. Nothing to do."
            ;;
    esac
}
module "$@"
