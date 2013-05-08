# Class: dpkg
#
# This class manages various aspects (well, one) of dpkg.
#
# Parameters:
#   disable_multiarch - Accepts true or false. Defaults to false. If set
#     to true, Puppet will remove /etc/dpkg/dpkg.cfg.d/multiarch
#
# Notes:
#  https://help.ubuntu.com/community/MultiArch
#  http://askubuntu.com/questions/238006/why-does-my-64-bit-system-look-for-32-bit-repos/238043#238043
#
# Actions:
#
# Requires:
#   puppetlabs/stdlib
#
# Sample Usage:
#
#  include dpkg
class dpkg (
    $disable_multiarch = false
) {
    $dpkg_conf_d = '/etc/dpkg/dpkg.cfg.d'

    validate_bool($disable_multiarch)

    $multiarch_file = "${dpkg_conf_d}/multiarch"

    if $disable_multiarch == true {
        file {'multiarch':
            ensure => absent,
            path   => $multiarch_file,
        }
    } else {
        $foreign_arch = $::architecture ? {
            'amd64' => 'i386',
            default => '',
        }

        if $foreign_arch == '' {
            fail("unsupported local architecture ${::architecture}")
        }

        file {'multiarch':
            ensure  => present,
            content => "foreign-architecture ${foreign_arch}\n",
            path    => $multiarch_file,
        }
    }
}
