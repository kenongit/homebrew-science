require 'formula'

class UcscGenomeBrowser < Formula
  homepage 'http://genome.ucsc.edu'
  url 'http://hgdownload.cse.ucsc.edu/admin/jksrc.v277.zip'
  sha1 'bc4a1bb85f835e728f2f47daaf604f05ea62fbe0'
  head 'git://genome-source.cse.ucsc.edu/kent.git'

  keg_only <<-EOF.undent
    The UCSC Genome Browser installs many commands, and some conflict
    with other packages.
  EOF

  depends_on :libpng
  depends_on :mysql

  def install
    ENV.j1
    machtype = `uname -m`.chomp
    user = `whoami`.chomp
    mkdir prefix/"cgi-bin-#{user}"
    mkdir prefix/"htdocs-#{user}"
    cd 'src/lib' do
      system 'make', "MACHTYPE=#{machtype}"
    end
    cd 'src/jkOwnLib' do
      system 'make', "MACHTYPE=#{machtype}"
    end
    cd 'src' do
      system 'make',
        "MACHTYPE=#{machtype}",
        "BINDIR=#{bin}",
        "SCRIPTS=#{bin}/scripts",
        "CGI_BIN=#{prefix}/cgi-bin",
        "DOCUMENTROOT=#{prefix}/htdocs",
        "PNGLIB=-L#{HOMEBREW_PREFIX}/lib -lpng",
        "MYSQLLIBS=-lmysqlclient -lz",
        "MYSQLINC=#{HOMEBREW_PREFIX}/include"
    end
    mv "#{prefix}/cgi-bin-#{user}", prefix/'cgi-bin'
    mv "#{prefix}/htdocs-#{user}", prefix/'htdocs'
  end

  def caveats; <<-EOF
To complete the installation of the UCSC Genome Browser, follow
these instructions:
  http://genomewiki.ucsc.edu/index.php/Browser_Installation

To complete a minimal installation, follow these directions:

# Configure the Apache web server.
# Warning! This command will overwrite your existing web site.
rsync -avzP rsync://hgdownload.cse.ucsc.edu/htdocs/ /Library/WebServer/Documents/
sudo cp -a #{prefix}/cgi-bin/* /Library/WebServer/CGI-Executables/
sudo mkdir /Library/WebServer/CGI-Executables/trash
sudo wget https://gist.github.com/raw/4626128 -O /Library/WebServer/CGI-Executables/hg.conf
mkdir /usr/local/apache
ln -s /Library/WebServer/Documents /usr/local/apache/htdocs
sudo apachectl start

# Configure the MySQL database.
cd #{HOMEBREW_PREFIX}/opt/mysql && mysqld_safe &
mysql -uroot -proot -e "create user 'hguser'@'localhost' identified by 'hguser';"
rsync -avzP rsync://hgdownload.cse.ucsc.edu/mysql/hgcentral/ #{HOMEBREW_PREFIX}/var/mysql/hgcentral/
mysql -uroot -proot -e "grant all privileges on hgcentral.* to 'hguser'@'localhost'"
mysql -uroot -proot -e "create database hgFixed"
mysql -uroot -proot -e "grant select on hgFixed.* to 'hguser'@'localhost'"

Point your browser to http://localhost/cgi-bin/hgGateway
EOF
  end
end
