require 'formula'

class Ray < Formula
  homepage 'http://denovoassembler.sourceforge.net'
  url 'http://downloads.sourceforge.net/project/denovoassembler/Ray-v2.1.0.tar.bz2'
  sha1 '4c09f2731445852857af53b65aa47e444792eeb0'
  head 'https://github.com/sebhtml/ray.git'

  depends_on 'open-mpi'

  def install
    system "make PREFIX=#{prefix}"
    system "make install"
    system "mkdir -p #{bin}"
    mv prefix/'Ray', bin
  end

  def test
    system bin/'Ray', '--version'
  end
end
