#!/bin/sh

sed -i 's/..\/Boxes\/windows_2016_libvirt.box/windows_2016_libvirt/g' Vagrant/Vagrantfile
sed -i 's/..\/Boxes\/windows_10_libvirt.box/windows_10_libvirt/g' Vagrant/Vagrantfile
sed -i 's/"headless": false/"headless": true/g' Packer/windows_10.json
sed -i 's/"headless": false/"headless": true/g' Packer/windows_2016.json
