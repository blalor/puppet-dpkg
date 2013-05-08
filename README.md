# puppet-dpkg

Dead-simple module for managing dpkg.  

Ok, "managing dpkg" is overstating it a bit.  A lot.  I've got some repositories
that don't have multiple architectures, but Ubuntu Precise is brain-dead
("imprecise", as it were) and insists on looking for architectures my hosts
don't support.  So now you can turn that behavior off.

## usage

    class {'dpkg':
        disable_multiarch => true,
    }

Or better, do the hiera thing.

## references

* [MultiArch](https://help.ubuntu.com/community/MultiArch)
* [Why does my 64-bit system look for 32-bit repos?](http://askubuntu.com/questions/238006/why-does-my-64-bit-system-look-for-32-bit-repos/238043#238043)
