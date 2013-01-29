require 'formula'

class GmapGsnap < Formula
  homepage 'http://research-pub.gene.com/gmap'
  url 'http://research-pub.gene.com/gmap/src/gmap-gsnap-2013-01-23.tar.gz'
  sha1 '929a63dc63997024442a5d27413a12c93a65024b'
  version '2013-01-23'

  depends_on "samtools"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make check"
    system "make install"
  end

  def caveats; <<-EOF.undent
    You will need to either download or build indexed search databases.
    See the readme file for how to do this:
      http://research-pub.gene.com/gmap/src/README

    Databases will be installed to:
      #{share}
    EOF
  end

  def test
    system "#{bin}/gsnap", "--version"
  end
end
