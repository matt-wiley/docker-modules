#!/usr/bin/env bash

function dockerModuleInstaller {

    function banner {
        # Helper function to pretty print banner messages in build log
        printf " # \n # ${1}\n # \n"
    }

    case "${1}" in 

        "download-scripts")
            shift;
            
            banner "Creating modules directory"
            mkdir -p modules
            cd modules

            banner "Downloading module scripts"
            for moduleName in "$@"; do 
                echo -n "Downloading module '${moduleName}' ... "
                curl -sSL "https://raw.githubusercontent.com/matt-wiley/docker-modules/main/modules/${moduleName}.sh"
                echo "done."
            done
            cd ../
            ;;

        "install")
            banner "Installing modules"
            for module in ./modules/*; do 
                banner "Running install for ${module}"
                "./${module}" install
            done 
            ;;
        *)  ;;

    esac 

}
dockerModuleInstaller "$@"