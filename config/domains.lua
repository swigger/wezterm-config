local platform = require('utils.platform')

local options = {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ssh_domains = {},

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {},
}

if platform.is_win then
   options.default_ssh_auth_sock = "\\\\.\\pipe\\openssh-ssh-agent"
   options.ssh_backend = "LibSsh"
   options.ssh_domains = {
      {
         name = 'ssh:wsl',
         remote_address = '127.0.0.1:2222',
         multiplexing = 'None',
         default_prog = { 'fish', '-l' },
         assume_shell = 'Posix',
         ssh_option = {
            forwardagent = "yes",
         },
      },
	  {
		  name='major',
		  remote_address='192.168.1.2:2222',
		  multiplexing = 'None',
		  assume_shell = 'Posix',
		  ssh_option = {
			 forwardagent = "yes",
		  },
	  },
	  {
		  name='ssh:202',
		  remote_address='192.168.1.202',
		  multiplexing = 'None',
		  assume_shell = 'Posix',
		  ssh_option = {
			 forwardagent = "yes",
		  },
	  }
   }
   options.wsl_domains = {
      {
         name = 'wsl:default',
         distribution = 'Ubuntu-22.04',
         default_cwd = '/home/xungeng',
      },
      {
         name = 'wsl:ubuntu-bash',
         distribution = 'Ubuntu-22.04',
         default_cwd = '/home/xungeng',
         default_prog = { 'bash', '-l' },
      },
   }
end

return options
