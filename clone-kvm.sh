#!/bin/bash

#TODO ajuster le kvm_dir par l'endroit ou ce trouve le votre dossiers KVM
kvm_dir="/home/jim/Documents/KVM"
os=$1
prefix=$2
first=$3
last=$4

function ListVM
{
 virsh list --all
}

function GetTemplate
{
    case $os in 
    deb|debian)
        template="0-debian"
        ;;
    roc|rocky)
        template="0-rocky"
        ;;
    ubu|ubuntu)
        template="0-ubuntu"
        ;;
    alp|alpine)
        template="0-alpine"
        ;;
    doc|docker)
        template="0-docker"
        ;;
    *)
        echo "Usage: debian|rocky|ubuntu|alpine|docker name numberfirst numberlast"
        exit 777
esac
}

function CloneVM
{
    for suffix in $(seq $first $last)
    do
    clone_name=$prefix$suffix
    virt-clone --original $template --name $clone_name --file=$kvm_dir/$clone_name.qcow2
    if [$template="doc" || $template="docker"];
    then 
    cd Bureau/Script/script-bash
    ./kvm-manage.sh start $prefix $suffix $suffix
    clone_name > /etc/hostname
    fi
    done
}


####    MAIN CODE    ####
ListVM
GetTemplate
CloneVM
sleep 3
ListVM



