#!/bin/bash

iso_dir="Chemin vers le dossier ou ce trouve l'iso (/home/jim/Documents/ISO)"

case $1 in
    deb|debian)
        virt-install \
        --virt-type=kvm \
        --name=0-debian \
        --ram=1024 \
        --vcpu=1 \
        --disk size=10 \
        --location $iso_dir/debian-11.1.0-amd-netinst.iso \   
        --initrd-inject=debian/preseed.cfg \
        --os-type generic \
        --graphics spice \
        --noautoconsole \
        --network=default 
    ;;
    roc|rocky)
        echo "TODO"

    ;;
    *)
        echo "TODO"
esac
