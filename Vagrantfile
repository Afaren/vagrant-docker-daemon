# specify os constants
module OS
  def OS.windows?
      (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
      (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
      !OS.windows?
  end

  def OS.linux?
      OS.unix? and not OS.mac?
  end
end

# create virtual machine
Vagrant.configure("2") do |config|
  config.vm.box_check_update = false

  # set virtual machine image
  config.vm.box = "ubuntu/bionic64"

  # set provider
  config.vm.provider "virtualbox" do |v|
    v.gui = false
    v.name = "Docker Daemon"
    v.memory = 1024*6
    v.cpus = 1
  end

  # set hostname
  config.vm.hostname = "docker"

  config.vm.network "private_network", ip: "10.0.0.91"

  # execute shell scripts in vm
  config.vm.provision "shell", path: "bootstrap/inputrc.sh", privileged: true
  config.vm.provision "shell", path: "bootstrap/bashrc.sh", privileged: false
  config.vm.provision "shell", path: "bootstrap/docker.sh", privileged: false
  config.vm.provision "shell", path: "bootstrap/daemon.sh", privileged: true, env: {"HOST_IS_WINDOWS" => OS.windows?}
  config.vm.provision "shell", path: "bootstrap/max_map_count.sh", privileged: true

end
