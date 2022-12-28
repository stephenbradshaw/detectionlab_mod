GRANT_HOME=/storage/vagrant_home/.vagrant.d/


Rebuild vagrant images 

Refresh Detectionlab
Run change.sh script to update packer
Change to packer dir 
Need local copy of virtio-win.iso
Did some sort of magic to get the eval isos into the local packer cache (?)

env TMPDIR=/storage/tmp/ PACKER_LOG=1 PACKER_LOG_PATH="packer_build_2016.log" packer build --only=qemu windows_2016.json
env TMPDIR=/storage/tmp/ PACKER_LOG=1 PACKER_LOG_PATH="packer_build.log" packer build --only=qemu windows_10.json



Rebuild env 

cd to vagrant dir 
vagrant destroy -f dc
vagrant destroy -f wef
vagrant destroy -f win10
vagrant destroy -f logger

vagrant box remove windows_10_libvirt
vagrant box remove windows_2016_libvirt

cd to packer dir with box files
vagrant box add windows_10_libvirt.box --name windows_10_libvirt
vagrant box add windows_2016_libvirt.box --name windows_2016_libvirt

cd back to vagrant dir
Run change.sh script to update Vagrantfile
vagrant up
