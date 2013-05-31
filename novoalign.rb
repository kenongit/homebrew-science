require 'formula'

class Novoalign < Formula
  homepage 'http://www.novocraft.com/main/page.php?s=novoalign'
  url 'http://www.novocraft.com/main/download.php?filename=V3.00.05/novocraftV3.00.05.MacOSX.tar.gz'
  version '3.00.05'
  sha1 'fde9f3e0d5aeb0fd6b7ac81e61c4a0163c19b2d7'

  def install
    bin.install %w[isnovoindex novo2maq novo2paf novoalign novobarcode
      novoindex novomethyl novope2bed.pl novorun.pl novosort novoutil]
    # Conflicts with samtools
    #bin.install 'novo2sam.pl'
    doc.install %w[NovoBarcode.pdf NovoCraftV3.00.pdf
      ReleaseNotesV3.00.pdf readme.txt readme_novomethyl.txt]
  end

  test do
    system 'novoalign --version 2>&1 |grep -q Novoalign'
  end
end
