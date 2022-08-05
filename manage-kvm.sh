#!/bin/bash

kvm_dir="/home/devops06/Documents/KVM"
os=$1
prefix=$2
first=$3
last=$4

function ListVM{
    virsh list --all
}

function GetTemplate
{
    case $os in
    deb|debian)
        template="0-template-debian"
        ;;
    roc|rocky)
        template="0-template-rocky"
        ;;
    ubu|ubuntu)
        template="0-template-ubuntu"
        ;;
    alp|alpine)
        template="0-alpine"
        ;;
    doc|docker)
        template="0-docker"
        ;;
    *)
        echo "Usage: debian|rocky|ubuntu|alpine|docker + name + numberfirst + numberlast"
        exit 777
esac
}

function CloneVM{
    for suffix in $(seq $first $last)
    do
    clone_name=$prefix$suffix
    virt-clone --original $template --name $clone_name --file=$kvm_dir/$clone_name.qcow2
    read clone_name < nom_des_vm.txt
    done
}

function RenameVM{

}

ListVM
GetTemplate
CloneVM
sleep 3
ListVM 