# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "airstrip"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "https://dl.dropbox.com/s/693uz0riijn60ia/ubuntu-precise-server-x64-airstrip.box?dl=1"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign custom vm settings according to your hardware capabilities.
  # You can change memory size (default is 1024MB) by exporting
  # VAGRANT_MEMORY_SIZE=x environment variable.
  config.vm.customize do |vm|
    mem_size = ENV['VAGRANT_MEMORY_SIZE'].to_i
    vm.memory_size = mem_size if mem_size > 0
  end

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :hostonly, "33.33.33.10"

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  config.vm.forward_port 5000, 5000 # development
  config.vm.forward_port 5001, 5001 # testing

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  config.vm.share_folder "v-root", "/home/vagrant/airstrip", "", :nfs => true
end
